import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initialised to begin with', () {
      expect(provider.isIntialised, false);
    });

    test('Cannot log out if not initialised', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitialializedException>()),
      );
    });

    test('Should be able to initalized', () async {
      await provider.initialize();
      expect(provider.isIntialised, true);
    });

    test('User should be null after initialization', () {
      expect(provider.currentUser, null);
    });

    test(
      'Should be able to initialize in less than 2 seconds',
      () async {
        await provider.initialize();
        expect(provider.isIntialised, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );
    test('Create user should delegate to logIn function', () async {
      final badEmailUser = provider.createUser(
          email: 'kalavakurivamsi19@gmail.com', password: 'anypassword');
      expect(badEmailUser,
          throwsA(const TypeMatcher<InvalidCredentialAuthException>()));
      final badPasswordUser = provider.createUser(
          email: 'v.kalavakuri@iitg.ac.in', password: 'password123');
      expect(badPasswordUser,
          throwsA(const TypeMatcher<InvalidCredentialAuthException>()));

      final user = await provider.createUser(
          email: 'v.kalavakuri@iitg.ac.in', password: 'Vamsi@19');
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });
    test('Logged in user should be able to get verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });
    test('should be able to logout and login again', () async {
      await provider.logOut();
      await provider.logIn(email: 'email@iitg.ac.in', password: 'password');
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitialializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isIntialised = false;
  bool get isIntialised => _isIntialised;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isIntialised) throw NotInitialializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isIntialised = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isIntialised) throw NotInitialializedException();
    if (!email.contains('@iitg.ac.in')) {
      throw InvalidCredentialAuthException();
    }
    if (password == 'password123') throw InvalidCredentialAuthException();
    const user = AuthUser(isEmailVerified: false, email: 'random@iitg.ac.in');
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isIntialised) throw NotInitialializedException();
    if (_user == null) throw UserNotloggenInAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isIntialised) throw NotInitialializedException();
    final user = _user;
    if (user == null) throw UserNotloggenInAuthException();
    const newUser = AuthUser(isEmailVerified: true, email: 'random@iitg.ac.in');
    _user = newUser;
  }
}
