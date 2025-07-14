// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../infrastructure/commons/repository_urls.dart';
//
// class SplashRepository {
//   Future<bool> checkConnection() async {
//     int? statusCode;
//     try {
//       final http.Response resultOrException = await http.get(
//         RepositoryUrls.checkConnection,
//       );
//       statusCode = resultOrException.statusCode;
//
//       return true;
//     } on SocketException {
//       if (kDebugMode) {
//         print('there is\'nt connect to the internet');
//       }
//     } on HttpException {
//       if (kDebugMode) {
//         print('error for send request to server');
//       }
//     } on FormatException {
//       if (kDebugMode) {
//         print('received invalid response from the internet');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(
//           'something went wrong status code: $statusCode , error-> ${e.toString()}',
//         );
//       }
//     }
//     return false;
//   }
// }
