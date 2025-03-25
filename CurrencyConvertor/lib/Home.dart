import 'package:currencyconvertor/Logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHome();
}

class _MyHome extends State<MyHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeLogic>(context, listen: false).getApi();
    });
  }

final TextEditingController Controller1=TextEditingController();
  final TextEditingController Controller2=TextEditingController();
  final ScrollController _scrollController=ScrollController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("Asset/Images/aaabeed1-d465-4edf-a9f3-7009d038dd0b.jpg"),fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0,left: 20,right: 20),
          child: Column(
            children: [
             Consumer<HomeLogic>(builder: (ctx,provider,__)
             {

               return Container();
             }
             ),
              Center(
                  child: Text("Currency Convertor",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(11)
                          ),
                          child: Center(
                            child: Consumer<HomeLogic>(builder: (ctx,provider,__)
                                {
                                  List<String> DrowpDownValue=provider.getDropDown();
                                  String SelectValue=provider.getValue();

                                  return DropdownButton<String>
                                    (
                                    items: DrowpDownValue.map<DropdownMenuItem<String>>((String value)
                                    {
                                      return DropdownMenuItem<String>(value:value ,child: Text(value));
                                    }).toList(),
                                    onChanged: (String? value)
                                    {
                                      provider.SetValue(value!);
                                      double inputValue =
                                          double.tryParse(Controller1.text) ?? 0.0;
                                      provider.ExchnageCurrency(
                                          inputValue,
                                          provider.getValue(),
                                          provider.getValueSecond());
                                    },
                                      value:SelectValue,
                                      dropdownColor: Colors.black,
                                      icon: Icon(Icons.arrow_drop_down,size: 40,color: Colors.white,),
                                      elevation: 16,
                                    style: TextStyle(color: Colors.white,fontSize: 30),
                                  );
                                }
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Icon(Icons.swap_vert,size: 40,color: Colors.white,),
                        SizedBox(height: 20,),
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius: BorderRadius.circular(11)
                          ),
                          child: Center(
                            child: Consumer<HomeLogic>(builder: (ctx,provider,__)
                            {
                              List<String> DrowpDownValue=provider.getDropDownSecond();
                              String SelectValue=provider.getValueSecond();

                              return DropdownButton<String>
                                (
                                items: DrowpDownValue.map<DropdownMenuItem<String>>((String value)
                                {
                                  return DropdownMenuItem<String>(value:value ,child: Text(value));
                                }).toList(),
                                onChanged: (String? value)
                                {
                                  provider.SetValueSecond(value!);
                                  double inputValue =
                                      double.tryParse(Controller1.text) ?? 0.0;
                                  provider.ExchnageCurrency(
                                      inputValue,
                                      provider.getValue(),
                                      provider.getValueSecond());
                                },
                                value:SelectValue,
                                dropdownColor: Colors.black,
                                icon: Icon(Icons.arrow_drop_down,size: 40,color: Colors.white,),
                                elevation: 16,
                                style: TextStyle(color: Colors.white,fontSize: 30),
                              );
                            }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                            Container(
                              height: 100,
                              width: 210,
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(11)
                              ),
                              child: Center(
                                child: Consumer<HomeLogic>(builder: (ctx,provider,__)
                                {
                                  return TextField(
                                    readOnly: true,
                                    scrollController: _scrollController,
                                    onChanged: (value)
                                    {
                                      double inputValue=double.tryParse(value)??0.0;
                                      provider.ExchnageCurrency(
                                          inputValue,
                                          provider.getValue(),
                                          provider.getValueSecond()
                                      );

                                    },
                                    controller: Controller1,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
                                    ],
                                    style:TextStyle(fontSize: 30,color: Colors.white),
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(),

                                        hintText: "Enter Amount",
                                        hintStyle: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)
                                    ),
                                  );
                                }
                                ),
                              ),
                            ),
                        SizedBox(height: 80,),
                        Container(
                          height: 100,
                          width: 210,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(11)
                          ),
                          child: Center(
                            child: Consumer<HomeLogic>(builder: (ctx,provider,__)
                            {

                              if(provider.ConversionResult.toString().length>11)
                                {
                                  Controller2.text=provider.ConversionResult.toStringAsExponential(5);

                                }else
                                  {
                                    Controller2.text=provider.ConversionResult.toStringAsFixed(2);
                                  }
                              return  TextField(

                                controller:Controller2,
                                enabled: false,
                                style:TextStyle(fontSize: 30,color: Colors.white),
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: "0.0",
                                    hintStyle: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)
                                ),
                              );
                            }
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 50,),
              Container(
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(11)
                ),
                child: Column(
                  children: <Widget>[


                    Row(
                      children: [
                        Expanded(child: makeButton("7")),
                        SizedBox(width: 10,),
                        Expanded(child: makeButton("8")),
                        SizedBox(width: 10,),
                        Expanded(child: makeButton("9")),
                        SizedBox(width: 10,),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(child: makeButton("4")),
                        SizedBox(width: 10,),
                        Expanded(child: makeButton("5")),
                        SizedBox(width: 10,),
                        Expanded(child: makeButton("6")),
                        SizedBox(width: 10,),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(child: makeButton("3")),
                        SizedBox(width: 10,),
                        Expanded(child: makeButton("2")),
                        SizedBox(width: 10,),
                        Expanded(child: makeButton("1")),
                        SizedBox(width: 10,),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(child: makeButton("C")),
                        SizedBox(width: 10,),
                        Expanded(child: makeButton("0")),
                        SizedBox(width: 10,),
                        Expanded(child: makeButton(".")),
                        SizedBox(width: 10,),
                      ],
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget makeButton(String Value)
  {
    return (
     Container(
       child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0
        ),
           onPressed: (){
          if(Value!="C")
            {
              Controller1.text +=Value;
              Controller1.selection = TextSelection.collapsed(offset: Controller1.text.length);
              _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent+50,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeOut

              );
            }else
              {
                if (Controller1 != null) { // Null check
                  Controller1.text = "";
                }
              }
          double inputValue = double.tryParse(Controller1.text) ?? 0.0;
          Provider.of<HomeLogic>(context, listen: false).ExchnageCurrency(
            inputValue,
            Provider.of<HomeLogic>(context, listen: false).getValue(),
            Provider.of<HomeLogic>(context, listen: false).getValueSecond(),
          );
           },
           child: Text("$Value",style: TextStyle(fontSize: 50),),
       ),
     )
    );
  }
}
