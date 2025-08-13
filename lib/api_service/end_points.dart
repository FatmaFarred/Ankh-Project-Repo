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
  static const String inspectorGetAllInspectionPending = "RequestInspections/all-pending";
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
  static const String getAllOfMyInspectionsByIdSearch = "Inspections/search/inspector-inspections";
  static const String getPointRequest = "Point/pending";
  static const String acceptPointRequest = "Point/approve";
  static const String rejectPointRequest = "Point/reject";
  static const String getAllPointPrices = "Point/point-prices";
  static const String editPointPrice = "Point/update-point-price";
  static const String addPointRequest = "Point/request";
  static const String getBalance = "Point/balance";
  static const String getProfile = "Profile/get-user";
  static const String editProfile = "Profile/edit-profile";
  static const String adjustUserPoints = "Point/adjust-points";
  static const String getAllUsers = "Customer/get-all-customers";
  static const String getUserFavourite = "Home/user-favorites";
  static const String searchUsers = "Customer/search-customers";
  static const String getAllInspections = "RequestInspections/all";
  static const String searchAllInspections = "RequestInspections/search-request";
  static const String rescheduleInspection = "RequestInspections/reschedule-inspection";
  static const String registerCustomer  = "Auth/register-customer";
  static const String addFavorite = "Home/add-favorites";
  static const String removeFavorite = "Home/remove";
  static const String addComment = "Product/add-comment";
  static const String generateTeamInvitationCode = "Marketers/create-multiple";
  static const String getTeamByLeaderId = "Marketers/get-team";
  static const String registerTeamMember = "Auth/register-team-marketer";
  static const String getAllInvitesCodeByLeaderId = "Marketers/my-invites";
  static const String postNotification = "Notifications/create";
  static const String getNotification = "Notifications/get-all";
  static const String rateUser = "Auth/rating-user";
  static const String emailVerification = "Auth/confirm";
  static const String resendEmailVerification = "Auth/resend-confirmation";
  static const String forgetPassword = "Auth/forgot-password";
  static const String resetPassword = "Auth/reset-password";
  static const String adjustCommissionForRoles = "Point/update-per-commission";
  static const String adjustCommissionForTeamLeader = "Point/update-teamleader-commission";














}