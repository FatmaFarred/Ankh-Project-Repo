import '../../domain/entities/marketer_leader_codes_entity.dart';

/// inviteCode : "INV-MK-7c172f9a94"
/// isUsed : true
/// linkedUserId : "fc2d12ae-d551-473f-8239-7a41dbff5a62"

class MarketerLeaderCodesDm extends MarketerLeaderCodesEntity {
  MarketerLeaderCodesDm({
      super.inviteCode,
      super.isUsed,
      super.linkedUserId,
  });

  MarketerLeaderCodesDm.fromJson(dynamic json) {
    inviteCode = json['inviteCode'];
    isUsed = json['isUsed'];
    linkedUserId = json['linkedUserId'];
  }
  String? inviteCode;
  bool? isUsed;
  String? linkedUserId;


}