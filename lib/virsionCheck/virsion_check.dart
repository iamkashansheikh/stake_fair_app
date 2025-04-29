import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import '../view/screens/home_screen.dart';
import 'package:http/http.dart' as http;

String? globalDownloadTaskId;
String? globalDownloadedApkPath;

class VersionCheck extends StatefulWidget {
  const VersionCheck({Key? key}) : super(key: key);
  @override
  _VersionCheckState createState() => _VersionCheckState();
}

class _VersionCheckState extends State<VersionCheck> {
  String _currentVersion = "";
  String _latestVersion = "";
  String _apkUrl = "";
  // Ye flag sirf update available hone par dialog show karne ke liye use hoga.
  bool _updateAvailable = false;
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    // HomeScreen ko bina kisi delay ke show karne ke liye build() me direct HomeScreen return kar rahe hain.
    _checkForUpdate();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      int statusInt = data[1];
      DownloadTaskStatus status = DownloadTaskStatus.values[statusInt];
      if (status == DownloadTaskStatus.complete) {
        debugPrint("Download complete for task $id");
        OpenFile.open(globalDownloadedApkPath!);
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    _port.close();
    super.dispose();
  }

  Future<void> _checkForUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _currentVersion = packageInfo.version;
    debugPrint("Current version: $_currentVersion");

    // Thoda delay de sakte hain jisse HomeScreen pahle load ho jaye.
    await Future.delayed(const Duration(seconds: 1));

    DatabaseReference updateRef = FirebaseDatabase.instance.ref('app_update');
    final snapshot = await updateRef.get();
    if (snapshot.exists) {
      Map data = snapshot.value as Map;
      _latestVersion = data['latest_version'];
      _apkUrl = data['apk_url'];
      if (_currentVersion != _latestVersion) {
        _updateAvailable = true;
        _showUpdateDialog();
      }
    }
  }

  // Update available hone par dialog show karta hai.
  void _showUpdateDialog() {
    Get.defaultDialog(
      title: "Update Available",
      middleText: "A new version ($_latestVersion) is available. Update now?",
      barrierDismissible: false, // User dialog ko tap kar ke dismiss na kar sake
      contentPadding: const EdgeInsets.all(16),
      textCancel: "Later",
      textConfirm: "Update Now",
      onCancel: () {
        // Agar user 'Later' pe click karta hai, to kuch nahi, app smoothly chalti rahegi.
      },
      onConfirm: () {
        Get.back(); // Dialog close karein
        downloadApk(_apkUrl, (progress) {
          print("Download progress: $progress%");
        });
      },
    );
  }

  Future<void> downloadApk(String apkUrl, Function(int) onProgressUpdate) async {
    try {
      final response = await http.get(Uri.parse(apkUrl));
      if (response.statusCode == 200) {
        final directory = await getExternalStorageDirectory();
        final filePath = '${directory?.path}/avr_agent.apk';
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        onProgressUpdate(100);
        print('Download successful: $filePath');
        installApk(filePath);
      } else {
        throw Exception('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      print('Download failed: $e');
    }
  }

  Future<void> installApk(String filePath) async {
    try {
      if (!(await Permission.requestInstallPackages.isGranted)) {
        print("Enable 'Install Unknown Apps' permission.");
        openAppSettings();
        return;
      }
      OpenFile.open(filePath);
    } catch (e) {
      print('Installation failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Yahan hum hamesha HomeScreen return kar rahe hain jisse app launch hote hi user ko direct HomeScreen dikh jaye.
    return HomeScreen();
  }
}

@pragma('vm:entry-point')
void downloadCallback(String id, int status, int progress) {
  final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
  send?.send([id, status, progress]);
}
