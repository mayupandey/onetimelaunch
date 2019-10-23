import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:flutter_upi/flutter_upi.dart';

import 'main.dart';

void main() => runApp(MyApp());

class pay extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<pay> {
  Future _initiateTransaction;
  GlobalKey<ScaffoldState> _key;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<ScaffoldState>();
    //_initiateTransaction = initTransaction();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<String> initTransaction(String app) async {
    String response = await FlutterUpi.initiateTransaction(
        app: app,
        pa: "mayupandey1999@oksbi",
        pn: "Mayank",
        tr: "TR1234",
        tn: "This is a test transaction",
        am: "1.00",
        cu: "INR",
        url: "https://www.google.com");
    print(response);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,

        key: _key,
        body: Center(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder(
                  future: _initiateTransaction,
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.data == null) {
                      return Text("Processing or Yet to start...");
                    } else {
                      switch (snapshot.data.toString()) {
                        case 'app_not_installed':
                          return Text("Application not installed.");
                          break;
                        case 'invalid_params':
                          return Text("Request parameters are wrong");
                          break;
                        case 'user_canceled':
                          return Text("User canceled the flow");
                          break;
                        case 'null_response':
                          return Text("No data received");
                          break;
                        default:
                          {
                            FlutterUpiResponse flutterUpiResponse =
                            FlutterUpiResponse(snapshot.data);
                            print(flutterUpiResponse.txnId);
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[

                                Center(
                                  child: FlutterTicketWidget(

                                    color: Colors.white,
                                    width: 350.0,
                                    height: 400.0,
                                    isCornerRounded: true,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 120.0,
                                                height: 25.0,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30.0),
                                                  border: Border.all(width: 1.0, color: Colors.green),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Payment Status',
                                                    style: TextStyle(color: Colors.green),

                                                  ),

                                                ),
                                              ),

                                            ],
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(top: 20.0),
                                            child: Text(
                                              'Payment Refrence',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(top: 25.0),
                                            child: Column(
                                              children: <Widget>[
                                                ticketDetailsWidget(
                                                    'TransactionId', flutterUpiResponse.txnId),

                                                Padding(
                                                  padding: const EdgeInsets.only(top: 12.0, right: 40.0),
                                                  child: ticketDetailsWidget(
                                                      'Transcation Status',flutterUpiResponse.Status ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(top: 12.0, right: 40.0),
                                                  child: ticketDetailsWidget(
                                                      'Refrence',flutterUpiResponse.txnRef),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(top: 12.0, right: 40.0),
                                                  child: ticketDetailsWidget(
                                                      'Transcation Approval',flutterUpiResponse.ApprovalRefNo ??
                                                      ""),
                                                ),


                                                Padding(
                                                  padding: const EdgeInsets.only(top: 12.0, right: 40.0),
                                                  child: ticketDetailsWidget(
                                                    'Response Code',flutterUpiResponse.responseCode),
                                                ),

                                              ],
                                            ),
                                          ),



                                        ],
                                      ),
                                    ),
                                  ),
                                ),





                                //oldcode
                             /*   Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

                                    Expanded(
                                        flex: 2, child: Text("Transaction ID")),
                                    Expanded(
                                        flex: 3,
                                        child: Text(flutterUpiResponse.txnId)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 2,
                                        child: Text("Transaction Reference")),
                                    Expanded(
                                        flex: 3,
                                        child: Text(flutterUpiResponse.txnRef)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 2,
                                        child: Text("Transaction Status")),
                                    Expanded(
                                        flex: 3,
                                        child: Text(flutterUpiResponse.Status)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Text("Approval Reference Number"),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          flutterUpiResponse.ApprovalRefNo ??
                                              ""),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Text("Response Code"),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child:
                                      Text(flutterUpiResponse.responseCode),
                                    ),
                                  ],
                                ),*/
                              ],
                            );
                          }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                color: Colors.blue,
                child: Text(
                  "Pay Now with PayTM",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _initiateTransaction = initTransaction(FlutterUpiApps.PayTM);
                  setState(() {});
                },
              ),
              Divider(
                height: 1.0,
                color: Colors.white,
              ),
              FlatButton(
                color: Colors.blue,
                child: Text(
                  "Pay Now with BHIM UPI",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _initiateTransaction =
                      initTransaction(FlutterUpiApps.BHIMUPI);
                  setState(() {});
                },
              ),
              Divider(
                height: 1.0,
                color: Colors.white,
              ),
              FlatButton(
                color: Colors.blue,
                child: Text(
                  "Pay Now with Google Pay",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _initiateTransaction =
                      initTransaction(FlutterUpiApps.GooglePay);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ticketDetailsWidget(String firstTitle, String firstDesc,
     ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),

      ],
    );

  }
}
