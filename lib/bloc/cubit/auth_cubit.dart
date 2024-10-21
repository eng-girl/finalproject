import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; // Import jwt_decoder
import '../../data/models/user_model.dart';
import '../../data/repo/auth_repo.dart';
import '../state/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepo;
  User? currentUser;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  AuthCubit(this.authRepo) : super(AuthInitial()) {
    // checkAuthStatus(); // Check authentication status on initialization
  }

  // Future<void> checkAuthStatus() async {
  //   final token = await secureStorage.read(key: 'token');
  //   if (token != null) {
  //     final user = await getUserFromToken(token);
  //     emit(AuthLoggedIn(user));
  //   } else {
  //     emit(AuthLoggedOut());
  //   }
  // }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await authRepo.login(email, password);
      if (response != null) {
        User user = response['user'];
        currentUser = user;
        String token = response['token'];
        await secureStorage.write(key: 'token', value: token);
        print('respone is not null and successful ${user.email}');
        emit(AuthLoggedIn(user)); // Emit logged-in state with user info
      } else {
        emit(AuthError('Login failed'));
      }

      // Store token in secure storage

      // await secureStorage.write(key: 'token', value: response?['token']);
      // print("logged in ${response.data}");
    } catch (e) {
      print("Error logging in: $e");
      emit(AuthError(e.toString()));
    }
  }

  User? getUser() {
    return currentUser;
  }

  Future<void> logout() async {
    try {
      // Remove the token from secure storage
      await secureStorage.delete(key: 'token');

      // Emit the logged-out state
      emit(AuthLoggedOut());
    } catch (e) {
      print("Error logging out: $e");
      emit(AuthError('Failed to log out.'));
    }
  }

  Future<dynamic> getUserFromToken(String token) async {
    // Decode the token to extract user info
    if (JwtDecoder.isExpired(token)) {
      return null; // Token is expired, handle this accordingly
    }
    // Decode the token
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken; // Return the user data
  }
}
