import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test/core/network/network_info.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetworkInfo networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfo(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to InternetConnectionChecker.hasConnection',
        () async {
      final tHasInternetConnection = Future.value(true);
      //Arrange
      when(() => mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => tHasInternetConnection);

      //Act
      final result = await networkInfo.isConnected;

      //Assert
      verify(() => mockInternetConnectionChecker.hasConnection);
      expect(result, await tHasInternetConnection);
    });
  });
}
