import 'dart:ui';

import '../../core/constants/color_manager.dart';

enum RequestStatus { pending, done, delayed, notResponded }
Color getStatusColor(RequestStatus status) {
  switch (status) {
    case RequestStatus.pending:
      return ColorManager.lightYellow;
    case RequestStatus.done:
      return ColorManager.lightGreen;
    case RequestStatus.delayed:
      return ColorManager.lightOrange;
    case RequestStatus.notResponded:
      return ColorManager.lightBlack;
  }
}
Color getTextStatusColor(RequestStatus status) {
  switch (status) {
    case RequestStatus.pending:
      return ColorManager.darkYellow;
    case RequestStatus.done:
      return ColorManager.darkGreen;
    case RequestStatus.delayed:
      return ColorManager.darkOrange;
    case RequestStatus.notResponded:
      return ColorManager.darkBlack;
  }
}

String getStatusLabel(RequestStatus status) {
  switch (status) {
    case RequestStatus.pending:
      return 'Pending';
    case RequestStatus.done:
      return 'Done';
    case RequestStatus.delayed:
      return 'Delayed';
    case RequestStatus.notResponded:
      return 'Not Responded';
  }
}

RequestStatus? getRequestStatusFromString(String? status) {
  switch (status?.toLowerCase()) {
    case 'pending':
      return RequestStatus.pending;
    case 'done':
      return RequestStatus.done;
    case 'delayed':
      return RequestStatus.delayed;
    case 'not responded':
      return RequestStatus.notResponded;
    default:
      return null;
  }
}

