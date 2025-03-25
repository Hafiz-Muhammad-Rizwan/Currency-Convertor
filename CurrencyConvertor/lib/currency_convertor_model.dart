/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

CurrencyConvertorModel currencyConvertorModelFromJson(String str) => CurrencyConvertorModel.fromJson(json.decode(str));

String currencyConvertorModelToJson(CurrencyConvertorModel data) => json.encode(data.toJson());

class CurrencyConvertorModel {
    CurrencyConvertorModel({
        required this.result,
        required this.timeNextUpdateUnix,
        required this.conversionRates,
        required this.timeNextUpdateUtc,
        required this.documentation,
        required this.timeLastUpdateUnix,
        required this.baseCode,
        required this.timeLastUpdateUtc,
        required this.termsOfUse,
    });

    String result;
    int timeNextUpdateUnix;
    Map<String, double> conversionRates;
    String timeNextUpdateUtc;
    String documentation;
    int timeLastUpdateUnix;
    String baseCode;
    String timeLastUpdateUtc;
    String termsOfUse;

    factory CurrencyConvertorModel.fromJson(Map<dynamic, dynamic> json) => CurrencyConvertorModel(
        result: json["result"],
        timeNextUpdateUnix: json["time_next_update_unix"],
        conversionRates: Map.from(json["conversion_rates"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
        timeNextUpdateUtc: json["time_next_update_utc"],
        documentation: json["documentation"],
        timeLastUpdateUnix: json["time_last_update_unix"],
        baseCode: json["base_code"],
        timeLastUpdateUtc: json["time_last_update_utc"],
        termsOfUse: json["terms_of_use"],
    );

    Map<dynamic, dynamic> toJson() => {
        "result": result,
        "time_next_update_unix": timeNextUpdateUnix,
        "conversion_rates": Map.from(conversionRates).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "time_next_update_utc": timeNextUpdateUtc,
        "documentation": documentation,
        "time_last_update_unix": timeLastUpdateUnix,
        "base_code": baseCode,
        "time_last_update_utc": timeLastUpdateUtc,
        "terms_of_use": termsOfUse,
    };
}
