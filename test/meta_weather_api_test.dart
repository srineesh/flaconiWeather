// // // ignore_for_file: prefer_const_constructors
// // import 'package:http/http.dart' as http;
// // import 'package:test/test.dart';

// // class MockHttpClient extends Mock implements http.Client {}

// // class MockResponse extends Mock implements http.Response {}
// import 'package:flaconi_weather/services/meta_weather_api.dart';
// import 'package:flaconi_weather/weather/models/location.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'meta_weather_api_test.mocks.dart';

// // Generate a MockClient using the Mockito package.
// // Create new instances of this class in each test.

// class MockHttpClient extends Mock implements http.Client {}

// class MockResponse extends Mock implements http.Response {}

// @GenerateMocks([http.Client])
// void main() {
//   group('fetchAlbum', () {
//     late MetaWeatherApiClient metaWeatherApiClient;
//     setUpAll(() {
//       metaWeatherApiClient = MetaWeatherApiClient();
//     });

//     test('returns an Album if the http call completes successfully', () async {
//       final client = MockClient();

//       // Use Mockito to return a successful response when it calls the
//       // provided http.Client.
//       when(client
//               .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
//           .thenAnswer((_) async =>
//               http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

//       expect(await metaWeatherApiClient.locationSearch(""), isA<Location>());
//     });

//     test('throws an exception if the http call completes with an error',
//         () async {
//       final client = MockClient();

//       // Use Mockito to return an unsuccessful response when it calls the
//       // provided http.Client.
//       when(client
//               .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
//           .thenAnswer((_) async => http.Response('Not Found', 404));

//       expect(await metaWeatherApiClient.locationSearch(""), throwsException);
//     });
//   });
// }
