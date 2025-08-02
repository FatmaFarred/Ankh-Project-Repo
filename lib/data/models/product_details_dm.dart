import 'package:ankh_project/domain/entities/product_details_entity.dart';

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

class ProductDetailsDm extends  ProductDetailsEntity {


ProductDetailsDm({
super.id,
super.productId,
super.title,
super.description,
super.make,
super.model,
super.category,
super.year,
super.mileage,
super.color,
super.isUsedVehicle,
super.status,
super.price,
super.rating,
super.views,
super.transmission,
super.fuelType,
super.driveType,
super.engineType,
super.horsepower,
super.batteryCapacity,
super.videoUrl,
super.imageUrls,
  super.image,
super.createdAt,
super.lastEditedAt,
super.usedDetails,
  super.code,
});

ProductDetailsDm.fromJson(dynamic json) {
    id = json['id'];
    productId = json['productId'];
    title = json['title'];
    description = json['description'];
    make = json['make'];
    model = json['model'];
    category = json['category'];
    year = json['year'];
    mileage = json['mileage'];
    color = json['color'];
    isUsedVehicle = json['isUsedVehicle'];
    status = json['status'];
    price = json['price'];
    rating = json['rating'];
    views = json['views'];
    transmission = json['transmission'];
    fuelType = json['fuelType'];
    driveType = json['driveType'];
    engineType = json['engineType'];
    horsepower = json['horsepower'];
    batteryCapacity = json['batteryCapacity'];
    videoUrl = json['videoUrl'] != null ? json['videoUrl'].cast<dynamic>() : [];
    imageUrls = json['imageUrls'] != null ? json['imageUrls'].cast<String>() : [];
    image = json['image'];
    code = json['code'];
    createdAt = json['createdAt'];
    lastEditedAt = json['lastEditedAt'];
    usedDetails = json['usedDetails'] != null ? UsedDetailsDm.fromJson(json['usedDetails']) : null;
  }



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

class UsedDetailsDm extends UsedDetailsEntity {
  UsedDetailsDm({
    super.ownerName,
    super.licenseImage,
    super.insuranceCardFront,
    super.insuranceCardBack,
    super.licenseExpiryDate,
    super.safetyReport,
    super.taxStatus,
    super.interiorCondition,
    super.exteriorCondition,
    super.additionalSpecs,
    super.additionalInfo,
    super.paymentMethod,
    super.inspectionResult,
    super.accidentHistory,
    super.testDriveAvailable,
    super.warrantyStatus,
    super.tireStatus,
    super.lightStatus,
    super.safetyStatus,
    super.licenseDuration,
    super.trafficViolations,
    super.insuranceStatus,
    super.numberOfKeys,
    super.seatCondition,
    super.gearCondition,
    super.driveSystemCondition,
    super.brakesCondition,
    super.tags,});

  UsedDetailsDm.fromJson(dynamic json) {
    ownerName = json['ownerName'];
    licenseImage = json['licenseImage'];
    insuranceCardFront = json['insuranceCardFront'];
    insuranceCardBack = json['insuranceCardBack'];
    licenseExpiryDate = json['licenseExpiryDate'];
    safetyReport = json['safetyReport'];
    taxStatus = json['taxStatus'];
    interiorCondition = json['interiorCondition'];
    exteriorCondition = json['exteriorCondition'];
    additionalSpecs = json['additionalSpecs'];
    additionalInfo = json['additionalInfo'];
    paymentMethod = json['paymentMethod'];
    inspectionResult = json['inspectionResult'];
    accidentHistory = json['accidentHistory'];
    testDriveAvailable = json['testDriveAvailable'];
    warrantyStatus = json['warrantyStatus'];
    tireStatus = json['tireStatus'];
    lightStatus = json['lightStatus'];
    safetyStatus = json['safetyStatus'];
    licenseDuration = json['licenseDuration'];
    trafficViolations = json['trafficViolations'];
    insuranceStatus = json['insuranceStatus'];
    numberOfKeys = json['numberOfKeys'];
    seatCondition = json['seatCondition'];
    gearCondition = json['gearCondition'];
    driveSystemCondition = json['driveSystemCondition'];
    brakesCondition = json['brakesCondition'];
    tags = json['tags'];
  }



}