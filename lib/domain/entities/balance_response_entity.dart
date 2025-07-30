/// userType : "معاين"
/// totalPoints : 50
/// perPointValue : 1000.00
/// availableBalance : 50000.00
/// transactions : [{"description":"jll","points":200,"status":"Pending","amount":200000.0000,"createdAt":"2025-07-30T04:11:21.3426303"},{"description":"مستعجل","points":2,"status":"Rejected","amount":2000.0000,"createdAt":"2025-07-30T00:02:48.4450172"},{"description":"مستعجل","points":189,"status":"Rejected","amount":189000.0000,"createdAt":"2025-07-30T00:02:38.1665541"},{"description":"مستعجل","points":100,"status":"Rejected","amount":100000.0000,"createdAt":"2025-07-30T00:02:31.5781503"},{"description":"مستعجل","points":50,"status":"Approved","amount":50000.0000,"createdAt":"2025-07-30T00:02:18.5479757"}]

class BalanceResponseEntity {
  BalanceResponseEntity({
      this.userType, 
      this.totalPoints, 
      this.perPointValue, 
      this.availableBalance, 
      this.transactions,});

  String? userType;
  num? totalPoints;
  num? perPointValue;
  num? availableBalance;
  List<TransactionsEntity>? transactions;


}

/// description : "jll"
/// points : 200
/// status : "Pending"
/// amount : 200000.0000
/// createdAt : "2025-07-30T04:11:21.3426303"

class TransactionsEntity {
  TransactionsEntity({
      this.description, 
      this.points, 
      this.status, 
      this.amount, 
      this.createdAt,});

  String? description;
  num? points;
  String? status;
  num? amount;
  String? createdAt;


}