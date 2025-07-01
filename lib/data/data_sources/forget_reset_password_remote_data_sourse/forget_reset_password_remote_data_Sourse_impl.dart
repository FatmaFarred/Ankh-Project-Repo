import 'package:ankh_project/api_service/api_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../api_service/api_constants.dart';
import '../../../api_service/end_points.dart';
import '../../../api_service/failure/error_handling.dart';
import '../../../domain/repositries_and_data_sources/data_sources/remote_data_source/forget_reset_password_remote_data_sourse.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgrtPasswordRemoteDataSource)
//
class ForgetResetPasswordRemoteDataSourseImpl implements ForgrtPasswordRemoteDataSource {
  ApiManager apiManager;

  ForgetResetPasswordRemoteDataSourseImpl(this.apiManager);
  @override
  Future<String?> forgetPassword(String email) async {

    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(endPoint: EndPoints.forgetPasswordEndPoint,
          url: ApiConstant.baseUrl,
          data: {
            "email": email,
          },);
        if (response.statusCode == 200) {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          print("${response.data['message']}sssssssssssssssssss");
          // Handle success response
          return(response.data['message'] ?? "Password reset email sent successfully.");
        } else {
          // Handle error response
         return("Failed to send password reset email: ${response.statusMessage}");
        }
      } else {
        return
          ( "No internet connection. Please try again later.");
      }
    }
    catch (e) {
      return  e.toString();
    }
  }

  /*@override
  Future<void> resetPassword(String newPassword, String code) async {
    // Implement the logic to reset the password using the code
    // This typically involves verifying the code and then updating the password
    try {
      // Example logic for resetting password
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw Exception("User not authenticated");
      }
    } catch (e) {
      throw Exception("Failed to reset password: $e");
    }
  }*/


}