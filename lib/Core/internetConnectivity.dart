import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// A global function that checks if the device is connected to the internet.
/// Returns `true` if connected, `false` if not.
Future<bool> isInternetConnectedGlobal() async {
  return await InternetConnectionChecker().hasConnection;
}

Future<String> getConnectionType() async {
  var connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult == ConnectivityResult.mobile) {
    // Connected to a mobile network.
    return 'Mobile';
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // Connected to a Wi-Fi network.
    return 'WiFi';
  } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
// Ethernet connection available.
    return 'Ethernet';
  } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
// Vpn connection active.
// Note for iOS and macOS:
// There is no separate network interface type for [vpn].
// It returns [other] on any device (also simulator)
    return 'VPN';
  } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
// Bluetooth connection available.
    return 'Bluetooth';
  } else if (connectivityResult.contains(ConnectivityResult.other)) {
// Connected to a network which is not in the above mentioned networks.
    return 'Other';
  } else if (connectivityResult.contains(ConnectivityResult.none)) {
// No available network types
    return 'None';
  } else {
    // Not connected to any network.
    return 'None';
  }
}
