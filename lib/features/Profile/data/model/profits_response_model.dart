import 'package:driver_application/features/Profile/data/model/ratings_response_model.dart';

class ProfitsResponseModel {
  final String? status;
  final String? message;
  final ProfitsData? data;

  const ProfitsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProfitsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfitsResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null ? ProfitsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class ProfitsData {
  final List<ProfitModel>? profits;
  final PaginationModel? pagination;

  const ProfitsData({
    this.profits,
    this.pagination,
  });

  factory ProfitsData.fromJson(Map<String, dynamic> json) {
    return ProfitsData(
      profits: json['profits'] != null
          ? (json['profits'] as List).map((i) => ProfitModel.fromJson(i)).toList()
          : null,
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profits': profits?.map((e) => e.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}

class ProfitModel {
  final MerchantProfileModel? merchant;
  final String? shipmentId;
  final String? status;
  final String? totalPrice;
  final num? pureProfit;
  final num? appShare;
  final bool? processed;

  const ProfitModel({
    this.merchant,
    this.shipmentId,
    this.status,
    this.totalPrice,
    this.pureProfit,
    this.appShare,
    this.processed,
  });

  factory ProfitModel.fromJson(Map<String, dynamic> json) {
    return ProfitModel(
      merchant: json['merchant'] != null
          ? MerchantProfileModel.fromJson(json['merchant'])
          : null,
      shipmentId: json['shipment_id']?.toString(),
      status: json['status'] as String?,
      totalPrice: json['total_price']?.toString(),
      pureProfit: json['pure_profit'] as num?,
      appShare: json['app_share'] as num?,
      processed: json['processed'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'merchant': merchant?.toJson(),
      'shipment_id': shipmentId,
      'status': status,
      'total_price': totalPrice,
      'pure_profit': pureProfit,
      'app_share': appShare,
      'processed': processed,
    };
  }
}
