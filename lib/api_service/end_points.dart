abstract class EndPoints {
  static const String marketerRegisterEndPoint = "Auth/register-marketer";
  static const String inspectorRegisterEndPoint = "Auth/register-inspector";
  static const String loginEndPoint = "Auth/login";
  static const String forgetPasswordEndPoint = "Auth/forgot-password";
  static const String resetPasswordEndPoint = "Auth/reset-password";
  static const String getMarketerRequests = "Marketers/Requests-Sent-By-The-Marketer";
  static const String getMarketerRequestById = "RequestInspections";
  static const String getCsRoles = "Roles/all-roles-users";

  static const String getMarketerProductsById = "Marketers/marketer";
  static const String getProductDetailsById = "Product";
  static const String MarketerAddRequestIspection = "RequestInspections/add";
  static const String getHomeAllProducts = "Home/get-all";
  static const String marketerAssignProduct = "Marketers/assign";
  static const String searchHome = "Home/search";
  static const String inspectorGetAllInspection = "RequestInspections/all";
  static const String inspectorGetInspectionByS = "Inspections";
  static const String searchHomeInspection= "Inspections/search";
  static const String inspectorAssignInspection = "RequestInspections/assign-inspector";
  static const String getReportDetails = "Marketers/report-details";
  static const String getAllMarketers = "Marketers/get-all";
  static const String updateMarketerAccountStatus = "Marketers/update-status";
  static const String searchMarketer = "Marketers/search-marketer";
  static const String unAssignProduct = "Marketers/unassign-product-from-marketer";
  static const String blockUser = "Auth/lock-user";
  static const String unBlockUser = "Auth/unlock-user";
  static const String appointAsTeamLeader = "Marketers/change-role";
  static const String getAllInspectors = "Inspections/get-all";
  static const String searchAllInspectors = "Inspections/search/inspectors";
  static const String getAllOfMyInspectionsById = "Inspections/Request-Assigned-To-Inspector";






}