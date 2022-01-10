// import 'dart:convert' show jsonDecode;


// import 'package:http/http.dart';
// import 'package:scouting/models/todo.dart';




// class HttpService {



//   static getUrl(stockname){
//     String getUrl = "https://scoutstock.000webhostapp.com/stocks.php?stock=$stockname";
//     return getUrl;
//   }


//   static getListUrl(){
//     String getUrl = "https://scoutstock.000webhostapp.com/stocks.php?list=all";
//     return getUrl;
//   }


//   Future<List<Stock>> getSazonalidade(getUrl) async {
    
//     Response res = await get(getUrl);

//     if (res.statusCode == 200) {
//     print("1 parsing stuff");
//     List<dynamic> body;
//     try { 
//       body = jsonDecode(res.body);
   
//       List<Stock> posts = body
//           .map(
//             (dynamic item){
//               return Stock.fromJson(item);
//             },
//           )
//           .toList();
//       return posts;
//     } catch (e) { 
//       print(e);
//       throw Exception("Error on server");
//     }
//     } else {
//       throw Exception("Can't get posts.");
//     }
    
//   }



//  Future<List<StockName>> getList(getListUrl) async {
    
//     Response res = await get(getListUrl);

//     if (res.statusCode == 200) {
      
//     print("1 parsing stuff");
//     List<dynamic> body;
//     try { 
//       body = jsonDecode(res.body);
   
//       List<StockName> posts = body
//           .map(
//             (dynamic item){
//               return StockName.fromJson(item);
//             },
//           )
//           .toList();
//       return posts;
//     } catch (e) { 
//       print(e);
//       throw Exception("Error on server");
//     }
//     } else {
//       throw Exception("Can't get posts.");
//     }
//   }

 
// }