import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:bleproject/controllers/user_controller.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart'; 

class MyBluetoothManager {
  static final MyBluetoothManager _instance = MyBluetoothManager._internal();
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  factory MyBluetoothManager() {
    return _instance;
  }

  MyBluetoothManager._internal() {
    flutterBlue = FlutterBlue.instance;
    _initializeNotifications(); 
    _updateTimer = Timer(Duration(milliseconds: 500), () {});
  }

  late FlutterBlue flutterBlue;
  BluetoothDevice? device;
  bool isScanning = false;
  bool isConnected = false;

  late BluetoothCharacteristic characteristic;
  late BluetoothCharacteristic resetCharacteristic;

  final StreamController<String> _receivedValueController =
      StreamController<String>.broadcast();
  Stream<String> get receivedValueStream => _receivedValueController.stream;

  late Timer _updateTimer;
  static int receivedValue = 0;
  List<int> _receivedValues = [];

  void _initializeNotifications() {
  final initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final initializationSettingsIOS = IOSInitializationSettings();
  final initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  _flutterLocalNotificationsPlugin.initialize(initializationSettings);


  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'step_channel_id', 
    'Step Count Notifications', 
    'Notifications for step counts', 
    importance: Importance.max,
  );


  _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'foreground_service',
      channelName: 'Foreground Service Notification',
      channelDescription: 'This notification appears when the foreground service is running.',
     
      
     
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: true,
      playSound: false,
    ),
    foregroundTaskOptions: const ForegroundTaskOptions(
      interval: 5000,
      isOnceEvent: false,
      autoRunOnBoot: true,
      allowWakeLock: true,
      allowWifiLock: true,
    ),
  );
}


  void startScanning() async {
    isScanning = true;
    print("Scanning started...");
    flutterBlue.startScan(timeout: const Duration(seconds: 50));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        print("Found device: ${result.device.name} (${result.device.id})");
        if (result.device.id.toString() == "62:D6:E5:13:81:96") {
          device = result.device;
          if (!isConnected) {
            connectToDevice();
          }
          break;
        }
      }
    });
  }

  void stopScanning() {
    isScanning = false;
    flutterBlue.stopScan();
  }

  void connectToDevice() async {
    if (device != null) {
      print("Connecting to device: ${device!.name} (${device!.id})");
      try {
        await device!.connect();
        isConnected = true;
        print("Connected to device");

        
        _flutterLocalNotificationsPlugin.show(
          0, 
          'Device Connected', 
          'Connected to ${device!.name}', 
          NotificationDetails(
            android: AndroidNotificationDetails(
              'step_channel_id',
              'Step Count Notifications',
              'Notifications for step counts',
              importance: Importance.max,
            ),
          ),
        );

        stopScanning();
        discoverServices();
        
      } catch (e) {
        print("Failed to connect to device: $e");
      }
    }
  }

  void discoverServices() async {
    print("Discovering services...");
    try {
      List<BluetoothService> services = await device!.discoverServices();
      for (var service in services) {
        print("Found service: ${service.uuid}");
        for (var characteristic in service.characteristics) {
          print("Found characteristic: ${characteristic.uuid}");
          if (characteristic.uuid.toString() ==
              "8dcd24f7-abe8-479e-b79f-24c6490f4c16") {
            this.characteristic = characteristic;
            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              _receivedValues.addAll(value);
              _updateTimer.cancel();
              _updateTimer = Timer(Duration(milliseconds: 500), () {
                if (_receivedValues.isNotEmpty) {
                  receivedValue = convertToInteger(_receivedValues);
                  print("Received characteristic value (int): $receivedValue");
                  _receivedValueController.add(receivedValue.toString());

                  UserController().setStepsToday(receivedValue);

                  _flutterLocalNotificationsPlugin.show(
                     0, 
                    'Step Count Reached', 
                    'You have reached $receivedValue steps!', 
                    NotificationDetails(
                      android: AndroidNotificationDetails(
                        'step_channel_id',
                        'Step Count Notifications',
                        'Notifications for step counts',
                        importance: Importance.max,
                      ),
                    ),
                  );

                  _receivedValues.clear();
                }
              });
            });
          } else if (characteristic.uuid.toString() ==
              "8dcd24f7-abe8-479e-b79f-24c6490f4c17") {
            resetCharacteristic = characteristic;
          }
        }
      }
    } catch (e) {
      print("Failed to discover services: $e");
    }
  }

  int convertToInteger(List<int> bytes) {
    int intValue = bytes[0] |
        (bytes[1] << 8) |
        (bytes[2] << 16) |
        (bytes[3] << 24);
    return intValue;
  }

  static void sendResetCommand() async {
    try {
      await _instance.resetCharacteristic.write([0x01], withoutResponse: false);
    } catch (e) {
      print("Failed to send reset command: $e");
    }
  }

  void dispose() {
    device?.disconnect();
    _receivedValueController.close();
  }
}
