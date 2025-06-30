import '../../domain/entities/login_response_entity.dart';

/// message : "تم تسجيل الدخول بنجاح"
/// token : {"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjA2Y2Q3ZjQ1LWFmMzUtNDRmMC04Yjk5LTE1MjlkZGExYWZmZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJmYXRtYWZhcnJlZDI2NyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImZhdG1hZmFycmVkMjY3QGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6Ik1hcmtldGVyIiwiZXhwIjoxNzUxMjQ2OTQwLCJpc3MiOiJBbmtoQXV0aFNlcnZlciIsImF1ZCI6IkFua2hBcGlVc2VycyJ9.1qEYzuqEYrOThC6EAhQz67Ecu5upX7mycwW-DMUGAtY","refreshToken":"NDjbEw1S6cjv0IpQr1uw/apumBmMYE4+bSKLd13Ck2xaYEzVBx0xf53pCNAg+5TuFMnU9Xol510ov6eftTCveg=="}

class LoginResponseDm extends LoginResponseEntity {
  LoginResponseDm({
      super.message,
      super.token,});

  LoginResponseDm.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'] != null ? TokenDm.fromJson(json['token']) : null;
  }



}

/// accessToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjA2Y2Q3ZjQ1LWFmMzUtNDRmMC04Yjk5LTE1MjlkZGExYWZmZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJmYXRtYWZhcnJlZDI2NyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImZhdG1hZmFycmVkMjY3QGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6Ik1hcmtldGVyIiwiZXhwIjoxNzUxMjQ2OTQwLCJpc3MiOiJBbmtoQXV0aFNlcnZlciIsImF1ZCI6IkFua2hBcGlVc2VycyJ9.1qEYzuqEYrOThC6EAhQz67Ecu5upX7mycwW-DMUGAtY"
/// refreshToken : "NDjbEw1S6cjv0IpQr1uw/apumBmMYE4+bSKLd13Ck2xaYEzVBx0xf53pCNAg+5TuFMnU9Xol510ov6eftTCveg=="

class TokenDm extends TokenEntity {
  TokenDm({
      super.accessToken,
      super.refreshToken,});

  TokenDm.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }



}