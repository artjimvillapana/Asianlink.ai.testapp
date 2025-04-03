import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_login/controller/providers/auth_provider.dart';
import 'package:test_login/utils/app_constant/app_constant.dart';

// Mock class for context
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('AuthNotifier Tests', () {
    late MockBuildContext context;
    late ProviderContainer container;

    setUp(() {
      context = MockBuildContext();
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Login validation - empty input', () {
      final authNotifier = container.read(authProvider.notifier);
      final result = authNotifier.login('', '', context);

      expect(result, 'Email/Phone and password cannot be empty');
    });

    test('Login validation - too many failed attempts', () {
      final authNotifier = container.read(authProvider.notifier);

      // Simulate 5 failed login attempts
      for (int i = 0; i < 5; i++) {
        authNotifier.login('wrongEmail@domain.com', 'wrongPassword', context);
      }

      final result = authNotifier.login('wrongEmail@domain.com', 'wrongPassword', context);

      expect(result, 'Too many failed attempts. Account locked.');
    });

    test('Login validation - invalid email/phone format', () {
      final authNotifier = container.read(authProvider.notifier);

      final result = authNotifier.login('invalidemail', 'password123', context);

      expect(result, 'Invalid email or phone number format');
    });

    test('Login validation - invalid password format', () {
      final authNotifier = container.read(authProvider.notifier);

      final result = authNotifier.login('testemail@domain.com', 'short', context);

      expect(result, 'Password must be at least 6 characters');
    });

    test('Login success - correct credentials', () {
      final authNotifier = container.read(authProvider.notifier);

      AppConstant.email;
      AppConstant.phone;
      AppConstant.password;

      final result = authNotifier.login('testemail@domain.com', 'password123', context);

      expect(result, null); // No error
    });

    test('OTP generation and validation', () {
      final authNotifier = container.read(authProvider.notifier);

      AppConstant.otp;
      authNotifier.generateOtp();

      expect(authNotifier.validateOtp('123456'), true);
      expect(authNotifier.validateOtp('wrongOtp'), false);
    });

    test('SignUp validation - empty input', () {
      final authNotifier = container.read(authProvider.notifier);

      final result = authNotifier.signUp('', '');

      expect(result, 'Email/Phone and password cannot be empty');
    });

    test('SignUp validation - invalid email/phone format', () {
      final authNotifier = container.read(authProvider.notifier);

      final result = authNotifier.signUp('invalidemail', 'password123');

      expect(result, 'Invalid email or phone number format');
    });

    test('SignUp validation - invalid password format', () {
      final authNotifier = container.read(authProvider.notifier);

      final result = authNotifier.signUp('testemail@domain.com', 'short');

      expect(result, 'Password must be at least 6 characters');
    });

    test('SignUp success', () {
      final authNotifier = container.read(authProvider.notifier);

      final result = authNotifier.signUp('testemail@domain.com', 'password123');

      expect(result, null); // No error
      expect(container.read(authProvider), true); // State should be true after successful signup
    });

    test('Logout functionality', () {
      final authNotifier = container.read(authProvider.notifier);

      // Ensure the user is logged in (state = true)
      authNotifier.signUp('testemail@domain.com', 'password123');
      expect(container.read(authProvider), true);

      // Logout
      authNotifier.logout();
      expect(container.read(authProvider), false); // State should be false after logout
    });
  });
}
