/// id : 14
/// title : "Toyota EX30\t"
/// description : "عربية ممتازة\t"
/// make : "Toyota"
/// model : "EX30"
/// category : "SUV"
/// year : 2023
/// mileage : 10000
/// color : "أحمر"
/// isUsedVehicle : true
/// status : "Available"
/// price : "1000000"
/// rating : 0
/// views : 0
/// transmission : "Automatic"
/// fuelType : "Gas"
/// driveType : "FrontWheel"
/// engineType : "V6"
/// horsepower : 320
/// batteryCapacity : "60kWh\t"
/// videoUrl : []
/// imageUrls : ["uploads/vehicles/f6b68b72-2390-44a5-b03b-3c373226fd30.jpg"]
/// createdAt : "2025-07-15T13:15:27.6034382"
/// lastEditedAt : "2025-07-15T13:15:27.6034817"
/// usedDetails : {"ownerName":"MO","licenseImage":"uploads/vehicles/7a2c1e69-20f4-4bb1-8953-5e761f4ecb30.jpg","insuranceCardFront":"uploads/vehicles/3cbc71b0-4abb-4cb2-afce-66863a7ae7fb.jpg","insuranceCardBack":"uploads/vehicles/d4ac4c5a-a068-4534-a8d5-f363d27f9d6a.jpg","licenseExpiryDate":"2026-07-15","safetyReport":"جيد جدًا\t","taxStatus":"ساري\t","interiorCondition":"ممتاز","exteriorCondition":"جيد","additionalSpecs":"كماليات إضافية\t","additionalInfo":"صيانة منتظمة\t","paymentMethod":"Cash\t","inspectionResult":"ناجح","accidentHistory":"بدون حوادث\t","testDriveAvailable":true,"warrantyStatus":"ساري","tireStatus":"جديد","lightStatus":"تعمل","safetyStatus":"سليم","licenseDuration":"سنة","trafficViolations":"لا يوجد\t","insuranceStatus":"ساري","numberOfKeys":"2","seatCondition":"ممتاز","gearCondition":"ممتاز","driveSystemCondition":"سليم","brakesCondition":"جيد","tags":null}

class ProductDetailsEntity {
  ProductDetailsEntity({
    this.id,
    this.title,
    this.description,
    this.make,
    this.model,
    this.category,
    this.year,
    this.mileage,
    this.color,
    this.isUsedVehicle,
    this.status,
    this.price,
    this.rating,
    this.views,
    this.transmission,
    this.fuelType,
    this.driveType,
    this.engineType,
    this.horsepower,
    this.batteryCapacity,
    this.videoUrl,
    this.imageUrls,
    this.createdAt,
    this.lastEditedAt,
    this.usedDetails,});

  num? id;
  String? title;
  String? description;
  String? make;
  String? model;
  String? category;
  num? year;
  num? mileage;
  String? color;
  bool? isUsedVehicle;
  String? status;
  String? price;
  num? rating;
  num? views;
  String? transmission;
  String? fuelType;
  String? driveType;
  String? engineType;
  num? horsepower;
  String? batteryCapacity;
  List<dynamic>? videoUrl;
  List<String>? imageUrls;
  String? createdAt;
  String? lastEditedAt;
  UsedDetailsEntity? usedDetails;


}

/// ownerName : "MO"
/// licenseImage : "uploads/vehicles/7a2c1e69-20f4-4bb1-8953-5e761f4ecb30.jpg"
/// insuranceCardFront : "uploads/vehicles/3cbc71b0-4abb-4cb2-afce-66863a7ae7fb.jpg"
/// insuranceCardBack : "uploads/vehicles/d4ac4c5a-a068-4534-a8d5-f363d27f9d6a.jpg"
/// licenseExpiryDate : "2026-07-15"
/// safetyReport : "جيد جدًا\t"
/// taxStatus : "ساري\t"
/// interiorCondition : "ممتاز"
/// exteriorCondition : "جيد"
/// additionalSpecs : "كماليات إضافية\t"
/// additionalInfo : "صيانة منتظمة\t"
/// paymentMethod : "Cash\t"
/// inspectionResult : "ناجح"
/// accidentHistory : "بدون حوادث\t"
/// testDriveAvailable : true
/// warrantyStatus : "ساري"
/// tireStatus : "جديد"
/// lightStatus : "تعمل"
/// safetyStatus : "سليم"
/// licenseDuration : "سنة"
/// trafficViolations : "لا يوجد\t"
/// insuranceStatus : "ساري"
/// numberOfKeys : "2"
/// seatCondition : "ممتاز"
/// gearCondition : "ممتاز"
/// driveSystemCondition : "سليم"
/// brakesCondition : "جيد"
/// tags : null

class UsedDetailsEntity {
  UsedDetailsEntity({
    this.ownerName,
    this.licenseImage,
    this.insuranceCardFront,
    this.insuranceCardBack,
    this.licenseExpiryDate,
    this.safetyReport,
    this.taxStatus,
    this.interiorCondition,
    this.exteriorCondition,
    this.additionalSpecs,
    this.additionalInfo,
    this.paymentMethod,
    this.inspectionResult,
    this.accidentHistory,
    this.testDriveAvailable,
    this.warrantyStatus,
    this.tireStatus,
    this.lightStatus,
    this.safetyStatus,
    this.licenseDuration,
    this.trafficViolations,
    this.insuranceStatus,
    this.numberOfKeys,
    this.seatCondition,
    this.gearCondition,
    this.driveSystemCondition,
    this.brakesCondition,
    this.tags,});

  String? ownerName;
  String? licenseImage;
  String? insuranceCardFront;
  String? insuranceCardBack;
  String? licenseExpiryDate;
  String? safetyReport;
  String? taxStatus;
  String? interiorCondition;
  String? exteriorCondition;
  String? additionalSpecs;
  String? additionalInfo;
  String? paymentMethod;
  String? inspectionResult;
  String? accidentHistory;
  bool? testDriveAvailable;
  String? warrantyStatus;
  String? tireStatus;
  String? lightStatus;
  String? safetyStatus;
  String? licenseDuration;
  String? trafficViolations;
  String? insuranceStatus;
  String? numberOfKeys;
  String? seatCondition;
  String? gearCondition;
  String? driveSystemCondition;
  String? brakesCondition;
  dynamic tags;


}