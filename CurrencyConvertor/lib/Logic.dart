
import 'dart:convert';

import 'package:currencyconvertor/currency_convertor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HomeLogic extends ChangeNotifier
{
  @override


  List<String>DropDownValueFirst=["Dollar","Pkr","USD"];
  List<String>DropDownValueSecond=["USD","Euro","Indi"];
 String SelecteValueFirst ='';
 String SelectValueSecond='';
 double ConversionResult=0.0;



  HomeLogic()
  {
    if(DropDownValueFirst.isNotEmpty&&DropDownValueSecond.isNotEmpty)
      {
        SelecteValueFirst=DropDownValueFirst.first;
        SelectValueSecond=DropDownValueSecond.first;
      }
  }

  List<String> getDropDown()
  {
    return DropDownValueFirst;

  }
  void SetValue(String Value)
  {
    SelecteValueFirst=Value;
    notifyListeners();
  }

  String getValue()
  {
    return SelecteValueFirst;
  }

  List<String> getDropDownSecond()
  {
    return DropDownValueSecond;

  }
  void SetValueSecond(String Value)
  {
    SelectValueSecond=Value;
    notifyListeners();
  }

  String getValueSecond()
  {
    return SelectValueSecond;
  }

  Future <Map<String,dynamic>> getApi()async
  {
    Map<String,dynamic>CurrencyRate;
   final Response=await http.get(Uri.parse("https://v6.exchangerate-api.com/v6/562535d18fb2a347da115083/latest/USD"));
   var Data=jsonDecode(Response.body.toString());
   if(Response.statusCode==200)
     {
        CurrencyRate = Data['conversion_rates'];
        DropDownValueFirst=CurrencyRate.keys.toList();
        DropDownValueSecond=CurrencyRate.keys.toList();
        if (DropDownValueFirst.isNotEmpty) {
          SelecteValueFirst = DropDownValueFirst.first;
        }

        if(DropDownValueSecond.isNotEmpty)
        {
          SelectValueSecond=DropDownValueSecond.first;
        }
        return CurrencyRate;
     }else
       {
        throw Exception("Failed to Fetchh APUI");
       }
  }

  Future<double> ConvertCurrency(double InputValue,String FromCurrency,String ToCurrency)async
  {

    final Responce=await http.get(Uri.parse("https://v6.exchangerate-api.com/v6/562535d18fb2a347da115083/latest/USD"));
    var Data=jsonDecode(Responce.body.toString());
    Map<String,dynamic>CurrencyRate;
    if(Responce.statusCode==200)
    {
      CurrencyRate=Data["conversion_rates"];
      double FromRate=CurrencyRate[FromCurrency].toDouble();
      double ToRate=CurrencyRate[ToCurrency].toDouble();
      if(FromRate!=Null && ToRate!=Null)
      {
        ConversionResult=(InputValue/FromRate)*ToRate;
        notifyListeners();
        return ConversionResult;
      }else
      {
        notifyListeners();
        return ConversionResult;
      }
    }else
    {
      notifyListeners();
      return ConversionResult;
    }
  }

  Future<void> ExchnageCurrency(double InputValue,String FromCurrency,String ToCurrency)async
  {

    ConversionResult=await ConvertCurrency(InputValue, FromCurrency, ToCurrency);
    notifyListeners();
  }

  double getConversionResult()
  {
    notifyListeners();
    return ConversionResult;
  }

}

