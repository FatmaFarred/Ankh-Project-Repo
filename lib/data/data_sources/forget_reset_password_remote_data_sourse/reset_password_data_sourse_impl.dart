import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../api_service/api_constants.dart';
import '../../../api_service/api_manager.dart';
import '../../../api_service/end_points.dart';
import '../../../domain/repositries_and_data_sources/data_sources/remote_data_source/reset_password_remote_data_sourse.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
@Injectable(as: ResetPasswordRemoteDataSourse)
class ResetPasswordDataSourceImpl implements ResetPasswordRemoteDataSourse {
  ApiManager apiManager;
  ResetPasswordDataSourceImpl(this.apiManager);

  @override
  Future<String?> resetPassword(String email,String token,String password) async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(endPoint: EndPoints.resetPasswordEndPoint,
          url: ApiConstant.baseUrl,
          data: {
            "email": email,
            "token": token,
            "newPassword":password,
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


  }
