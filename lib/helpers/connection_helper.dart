import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatusSingleton {
  static final ConnectionStatusSingleton _singleton = ConnectionStatusSingleton._internal();
  ConnectionStatusSingleton._internal();

  static ConnectionStatusSingleton getInstance() => _singleton;

  bool hasConnection = false;

  StreamController connectionChangeController = StreamController.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  void initialize() async {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
  }

  Stream get connectionChange => connectionChangeController.stream;

  void dispose() {
    connectionChangeController.close();
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection(result);
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection(ConnectivityResult connectivityResult) async {
    // bool previousConnection = hasConnection;
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          hasConnection = true;
        } else {
          hasConnection = false;
        }
      } on SocketException catch (_) {
        hasConnection = false;
      }
    } else {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    // if (previousConnection != hasConnection) {
    //   connectionChangeController.add(hasConnection);
    // }

    return hasConnection;
  }

  Future<bool> getConnectionStatus() async {
    ConnectivityResult connectivityResult = await _connectivity.checkConnectivity();
    bool _hasConnection = await checkConnection(connectivityResult);
    return _hasConnection;
  }
}
