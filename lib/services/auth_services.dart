import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  Future<void> signUp(String email, String password) async {
    final supabase = Supabase.instance.client;

    log("email:$email , password: $password");
    try {
      await supabase.auth.signUp(email: email, password: password);
      log("Sign-up successful! Check your email for verification.");
    } catch (e) {
      log("Sign-up error: $e");
    }
  }

  Future<void> signIn(String email, String password) async {
    final supabase = Supabase.instance.client;

    log("email:$email , password: $password");
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      log("Login successful!");
    } catch (e) {
      log("Login error: $e");
    }
  }

  Future<void> verifyOTP(
    String email,
    String token,
  ) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.auth
          .verifyOTP(email: email, token: token, type: OtpType.signup);
      print("SUcccccessss");
    } catch (e) {
      print("Reset password error: $e");
    }
  }

  Future<void> resetPassword(String email) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.auth.resetPasswordForEmail(email);
      print("Password reset email sent!");
    } catch (e) {
      print("Reset password error: $e");
    }
  }

  Future<void> changePassword(String newPassword) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      print("Password changed successfully!");
    } catch (e) {
      print("Change password error: $e");
    }
  }

  Future<void> signOut() async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.auth.signOut();
      print("Logged out successfully!");
    } catch (e) {
      print("Logout error: $e");
    }
  }

  User? getCurrentUser() {
    return Supabase.instance.client.auth.currentUser;
  }
}
