import '../../domain/entities/balance_response_entity.dart';

/// userType : "معاين"
/// totalPoints : 50
/// perPointValue : 1000.00
/// availableBalance : 50000.00
/// transactions : [{"description":"jll","points":200,"status":"Pending","amount":200000.0000,"createdAt":"2025-07-30T04:11:21.3426303"},{"description":"مستعجل","points":2,"status":"Rejected","amount":2000.0000,"createdAt":"2025-07-30T00:02:48.4450172"},{"description":"مستعجل","points":189,"status":"Rejected","amount":189000.0000,"createdAt":"2025-07-30T00:02:38.1665541"},{"description":"مستعجل","points":100,"status":"Rejected","amount":100000.0000,"createdAt":"2025-07-30T00:02:31.5781503"},{"description":"مستعجل","points":50,"status":"Approved","amount":50000.0000,"createdAt":"2025-07-30T00:02:18.5479757"}]

class BalanceResponseDm extends BalanceResponseEntity {
  BalanceResponseDm({
      super.userType,
      super.totalPoints,
      super.perPointValue,
      super.availableBalance,
    super.transactions,});

  BalanceResponseDm.fromJson(dynamic json) {
    userType = json['userType'];
    totalPoints = json['totalPoints'];
    perPointValue = json['perPointValue'];
    availableBalance = json['availableBalance'];
    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions?.add(TransactionsDm.fromJson(v));
      });
    }
  }



}

/// description : "jll"
/// points : 200
/// status : "Pending"
/// amount : 200000.0000
/// createdAt : "2025-07-30T04:11:21.3426303"

class TransactionsDm extends TransactionsEntity {
  TransactionsDm({
      super.description,
    super.points,
    super.status,
    super.amount,
    super.createdAt,});

  TransactionsDm.fromJson(dynamic json) {
    description = json['description'];
    points = json['points'];
    status = json['status'];
    amount = json['amount'];
    createdAt = json['createdAt'];
  }


}