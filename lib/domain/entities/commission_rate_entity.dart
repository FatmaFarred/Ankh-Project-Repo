import 'package:equatable/equatable.dart';

abstract class CommissionRateEntity extends Equatable {
  final String? id;
  final String? roleName;
  final double? commissionRate;
  final String? updatedAt;
  final String? createdAt;

  const CommissionRateEntity({
    this.id,
    this.roleName,
    this.commissionRate,
    this.updatedAt,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, roleName, commissionRate, updatedAt, createdAt];
}
