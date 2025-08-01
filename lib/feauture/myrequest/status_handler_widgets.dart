import 'dart:ui';

import '../../core/constants/color_manager.dart';

enum RequestStatus { pending, approved,Postponed,ClientRejected,ReturnedToMarketer,ClientDidNotRespond,Completed,active,done }
Color getStatusColor(RequestStatus status) {
  switch (status) {
    case RequestStatus.pending:
      return ColorManager.lightYellow;
    case RequestStatus.Completed:
      return ColorManager.lightGreen;
    case RequestStatus.Postponed:
      return ColorManager.lightOrange;
    case RequestStatus.ClientDidNotRespond:
      return ColorManager.lightBlack;
    case RequestStatus.active:
      return ColorManager.lightGreen;
    case RequestStatus.approved:
      return ColorManager.lightGreen;
    case RequestStatus.ClientRejected:
      return ColorManager.lightRed;
    case RequestStatus.ReturnedToMarketer:
      return ColorManager.lightRed;
    case RequestStatus.done:
      return ColorManager.lightGreen;

  }
}
Color getTextStatusColor(RequestStatus status) {
  switch (status) {
    case RequestStatus.pending:
      return ColorManager.darkYellow;
    case RequestStatus.done:
      return ColorManager.darkGreen;
    case RequestStatus.Postponed:
      return ColorManager.darkOrange;
    case RequestStatus.ClientDidNotRespond:
      return ColorManager.darkBlack;
    case RequestStatus.active:
      return ColorManager.darkGreen;
    case RequestStatus.approved:
      return ColorManager.darkGreen;
    case RequestStatus.ClientRejected:
      return ColorManager.darkRed;
    case RequestStatus.ReturnedToMarketer:
      return ColorManager.darkRed;
    case RequestStatus.Completed:
      return ColorManager.darkGreen;


  }
}

String getStatusLabel(RequestStatus status) {
  switch (status) {
    case RequestStatus.pending:
      return 'Pending';
    case RequestStatus.done:
      return 'Done';
    case RequestStatus.Postponed:
      return 'Delayed';
    case RequestStatus.ClientDidNotRespond:
      return 'Not Responded';
    case RequestStatus.active:
      return 'Active';
    case RequestStatus.approved:
      return 'Approved';
    case RequestStatus.ClientRejected:
      return 'Rejected';
    case RequestStatus.ReturnedToMarketer:
      return 'Returned to Marketer';
    case RequestStatus.Completed:
      return 'Completed';

  }

}

RequestStatus? getRequestStatusFromString(String? status) {
  switch (status?.toLowerCase()) {
    case 'pending':
      return RequestStatus.pending;
    case 'done':
      return RequestStatus.done;
    case 'delayed':
      return RequestStatus.Postponed;
    case 'not responded':
      return RequestStatus.ClientDidNotRespond;
    case 'active':
      return RequestStatus.active;
    case 'approved':
      return RequestStatus.approved;
    case 'rejected':
      return RequestStatus.ClientRejected;
    case 'returned to marketer':
      return RequestStatus.ReturnedToMarketer;
    case 'completed':
      return RequestStatus.Completed;
    default:
      return null;
  }
}

