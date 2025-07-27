import 'dart:ui';

import 'package:ankh_project/domain/entities/all_marketers_entity.dart';

import '../../../../core/constants/color_manager.dart';


enum AccountStatus { Pending, Accepted, Rejected, Suspended }
Color getAccountStatusColor(AccountStatus status) {
  switch (status) {
    case AccountStatus.Pending:
      return ColorManager.lightYellow;
    case AccountStatus.Accepted:
      return ColorManager.lightGreen;
    case AccountStatus.Suspended:
      return ColorManager.lightOrange;
    case AccountStatus.Rejected:
      return ColorManager.lightRed;
     }
}
Color getAccountTextStatusColor(AccountStatus status) {
  switch (status) {
    case AccountStatus.Pending:
      return ColorManager.darkYellow;
    case AccountStatus.Accepted:
      return ColorManager.darkGreen;
    case AccountStatus.Suspended:
      return ColorManager.darkOrange;
    case AccountStatus.Rejected:
      return ColorManager.darkRed;
  }
}

String getAccountStatusLabel(AccountStatus status) {
  switch (status) {
    case AccountStatus.Pending:
      return 'Pending';
    case AccountStatus.Accepted:
      return 'Accepted';
    case AccountStatus.Suspended:
      return 'Suspended';
    case AccountStatus.Rejected:
      return 'Rejected';
  }

}

AccountStatus? getAccountRequestStatusFromString(String? status) {
  switch (status) {
    case 'Pending':
      return AccountStatus.Pending;
    case 'Accepted':
      return AccountStatus.Accepted;
    case 'Suspended':
      return AccountStatus.Suspended;
    case 'Rejected':
      return AccountStatus.Rejected;
    default:
      return null;
  }
}

