
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_candlesticks_chart/flutter_candlesticks_chart.dart';
// import 'package:scouting/models/todo.dart';

// import 'http_service.dart';



// class ChartPage extends StatefulWidget {

//   ChartPage({
//     @required this.dtstart,
//     @required this.dtend,
//     @required this.stockname,
//   });

//   final DateTime dtstart;
//   final DateTime dtend;
//   final String stockname;

//   @override
//   _ChartPageState createState() => _ChartPageState(dtstart:dtstart,dtend: dtend, stockname: stockname);
// }

// class _ChartPageState extends State<ChartPage> {
//    DateTime dtstart;
//    DateTime dtend;
//    String stockname;

//   _ChartPageState({
//     @required this.dtstart,
//     @required this.dtend,
//     @required this.stockname,
//   });

//    HttpService httpService = HttpService();
//    String url;

//     void initState() { 
//       super.initState();
//       url = HttpService.getUrl(dtstart,dtend,stockname);
//   }

   
//   double roundDouble(double value, int places){ 
//    double mod = pow(10.0, places); 
//    return ((value * mod).round().toDouble() / mod); 
// }

//   bool _darkMode = true;
//   Offset _cursorPosition = Offset(-1, -1);

//   final List<ChartEvent> chartEvents = List<ChartEvent>();

//   List<CandleStickChartData> generateData(List<Stock> stocks) {

//   List<CandleStickChartData> variacaopositiva;

//      try { 
//        //Filtro para pegar os valores de cada ano 2010,2011,2012 etc...
//       List<Stock> filtered = stocks.where((e) => e.datetime.year == dtstart.year).toList();
//       //Pegar primeiro dia do ano e o ultimo, fazer uma subtraçao para pegar a variaçao nominal e dps dividir pela quantidade de dias
//       Stock  lastclose = filtered.last;
//       double variacaonominal = lastclose.close - filtered[0].close;
//       double mediavariacaonominal = roundDouble((variacaonominal / filtered.length), 2 );
//       double basemedia = mediavariacaonominal;


//       List<CandleStickChartData> candles = filtered
//           .map((Stock stock){

//               double open;
//               double high;
//               double low;
//               double close;
//               CandleStickChartData candle;

//               //Condicional para retirar as minimas e maximas e depois subtrair pela base media da variaçao nominal

//               if(stock.close > stock.open){
//                   high = stock.close - roundDouble((basemedia), 2 );
//                   close = stock.close - roundDouble((basemedia), 2 );
//                   low = stock.open - roundDouble((basemedia), 2 );
//                   open = stock.open - roundDouble((basemedia), 2 );
//               }else{
//                   high = stock.open - roundDouble((basemedia), 2 );
//                   close = stock.close - roundDouble((basemedia), 2 );
//                   low = stock.close - roundDouble((basemedia), 2 );
//                   open = stock.open - roundDouble((basemedia), 2 );
//               }

//               //Condicional para verificar depois da subtraçao nominal se ele variou mais ou menos 
             
//                 candle = CandleStickChartData(
//                     open: open,
//                     high: high,
//                     low: low,
//                     close: close,
//                     volume: stock.volume,
//                     dateTime: stock.datetime,
//                   );
              
  

               

//               //a cada iteraçao adiciona na media para subtraçao a cada fechamento
//               basemedia += mediavariacaonominal;

//               return candle;
//             }

            
//           )
//           .toList();
//       return candles;
//     } catch (e) { 
//       print(e);
//       throw Exception("Error on server");
//     }

// }

//   void setCursorPosition(Offset newPosition) {
//     setState(() {
//       this._cursorPosition = newPosition;
//     });
//   }

//   void clearCursor() {
//     setState(() {
//       this._cursorPosition = Offset(-1, -1);
//     });
//   }







//   @override
//   Widget build(BuildContext context) {
    

//     String buttonText;
//     ChartInfoBoxStyle infoBoxStyle;
//     Color backgroundColor, cursorColor;
//     if (this._darkMode) {
//       buttonText = "Light Mode";
//       infoBoxStyle = ChartInfoBoxThemes.getDarkTheme();
//       backgroundColor = Colors.black;
//       cursorColor = Colors.white;
//     } else {
//       buttonText = "Dark Mode";
//       infoBoxStyle = ChartInfoBoxThemes.getLightTheme();
//       backgroundColor = Colors.white;
//       cursorColor = Colors.black;
//     }

//     infoBoxStyle.dateFormatStr = 'dd/MM/yyyy';
//     infoBoxStyle.chartI18N = CandleChartI18N(
//       open: "Abertura",
//       close: "Fecha",
//       high: "Máxima",
//       low: "Mínima",
//     );

//     return FutureBuilder(
//         future: httpService.getSazonalidade(url),
//         builder: (BuildContext context, AsyncSnapshot<List<Stock>> snapshot) {
//           if (snapshot.hasData) {
            
//             List<CandleStickChartData> data = generateData(snapshot.data) ;
//             return OrientationBuilder(
//               builder: (context, orientation) {
//                 return Container(
//                   color: backgroundColor,
//                   padding: EdgeInsets.only(bottom: 3),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.max,
//                     children: <Widget>[
//                       Container(
//                         width: 150,
//                         margin: EdgeInsets.only(
//                           top: 5,
//                           bottom: 5,
//                         ),
//                         child: RaisedButton(
//                           child: Center(
//                             child: Text(
//                               buttonText,
//                             ),
//                           ),
//                           onPressed: () {
//                             this.setState(() {
//                               this._darkMode = !this._darkMode;
//                             });
//                           }
//                         ),
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onLongPressStart: (detail) {
//                             setCursorPosition(detail.localPosition);
//                           },
//                           onLongPressMoveUpdate: (detail) {
//                             setCursorPosition(detail.localPosition);
//                           },
//                           onTapDown: (detail) {
//                             setCursorPosition(detail.localPosition);
//                           },
//                           onHorizontalDragStart: (detail) {
//                             setCursorPosition(detail.localPosition);
//                           },
//                           onHorizontalDragUpdate: (detail) {
//                             setCursorPosition(detail.localPosition);
//                           },
//                           onVerticalDragStart: (detail) {
//                             setCursorPosition(detail.localPosition);
//                           },
//                           onVerticalDragUpdate: (detail) {
//                             setCursorPosition(detail.localPosition);
//                           },
//                           onTapUp: (detail) {
//                             clearCursor();
//                           },
//                           onVerticalDragEnd: (detail) {
//                             clearCursor();
//                           },
//                           onHorizontalDragEnd: (detail) {
//                             clearCursor();
//                           },
//                           onLongPressEnd: (detail) {
//                             clearCursor();
//                           },
//                           child: CandleStickChart(
//                             data: data,
//                             gridLineStyle: ChartGridLineStyle(
//                               gridLineAmount: 4,
//                               showXAxisLabels: true,
//                               xAxisLabelCount: 4,
//                               enableGridLines: true,
//                             ),
//                             candleSticksStyle: CandleSticksStyle(
//                               labelPrefix: ' R\$ ',
//                               valueLabelBoxType: ValueLabelBoxType.arrowTag,
//                             ),
//                             volumeProp: 0.0,
//                             formatValueLabelWithK: true,
//                             infoBoxStyle: infoBoxStyle,
//                             cursorStyle: CandleChartCursorStyle(
//                               cursorColor: cursorColor,
//                               showCursorCircle: false,
//                               cursorOffset: Offset(0, 50),
//                               cursorLabelBoxColor: Colors.green,
//                             ),
//                             cursorPosition: this._cursorPosition,

//                             chartEvents: chartEvents,
//                             chartEventStyle: ChartEventStyle(
//                               textStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               circleRadius: 13,
//                               circlePaint: Paint()
//                                 ..color = Colors.orange
//                                 ..style = PaintingStyle.fill,
//                               circleBorderPaint: Paint()
//                                 ..color = Colors.orange[50]
//                                 ..style = PaintingStyle.stroke,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       );
//   }
// }





