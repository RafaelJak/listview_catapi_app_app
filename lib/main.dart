import 'dart:async';
import 'dart:convert'; //it allows us to convert our json to a list

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
      home: new HomePage()
  ));

}



class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  String apiKey = "71d0adce-f599-42b4-a1cd-19ba4e5d983e";
  List dataList;
  List data;




  String breeds = "beng";
  void onPressBreeds(breeds) {

    getData(breeds);
    print("hallo");

  }



  @override
  void initState(){
    this.getDataList();
    this.getData("beng");
  }

  Future<String> getData(breed) async {
    //we have to wait to get the data so we use 'await'
    http.Response response = await http.get(
      //Uri.encodeFull removes all the dashes or extra characters present in our Uri
        Uri.encodeFull("https://api.thecatapi.com/v1/images/search?breed_id="+breed),

        headers: {
          //if your api require key then pass your key here as well e.g "key": "my-long-key"
          "Accept": "application/json"
        }

    );
    this.setState(() {
      data = jsonDecode(response.body);
    });
    //print(response.body);


    //print(data);
    print("HALLO!" + data[0]["url"]); // it will print => title: "qui est esse"
    return "Success!";
  }









  Future<String> getDataList() async {
    //we have to wait to get the data so we use 'await'
    http.Response response = await http.get(
      //Uri.encodeFull removes all the dashes or extra characters present in our Uri
        Uri.encodeFull("https://api.thecatapi.com/v1/breeds?api_key=" +apiKey),

        headers: {
          //if your api require key then pass your key here as well e.g "key": "my-long-key"
          "Accept": "application/json"
        }

    );
    this.setState(() {
      dataList = jsonDecode(response.body);
    });
    //print(response.body);

    // List data = JSON.decode();
    //print(data);
    print("HALLO!" + dataList[0]["name"]); // it will print => title: "qui est esse"
    return "Success!";
  }








  @override
  Widget build(BuildContext context){
    return new Scaffold(
      drawer: Container(
        color: Colors.white,
        width: 200.0,
        /*
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:30.0),
              child: Text("Katergorieren"),
            ),
          ],
        ),
         */
        child: ListView.builder(
          itemCount: dataList == null ? 0 : dataList.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: ElevatedButton(
                onPressed: (){ onPressBreeds(dataList[index]["id"]); },
                child: Column(
                  children: [
                    // Image.network(dataList[index]["name"], width: 200),
                    Text(dataList[index]["name"],),
                    //  Text(dataList[index]["description"]),
                  ],
                ),
              ),

            );
          },
        ),
      ),
        appBar: AppBar(title: new Text("CatApi!"), backgroundColor: Colors.greenAccent),
        body:
        GridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2, // wieviele Elemente in einer Reihe
          children: [
            Container(
              color: Colors.red,
              child:  RaisedButton(

                child: Text(data[0]["breeds"][0]["name"],style: new TextStyle(color: Colors.black, fontStyle: FontStyle.italic, fontSize: 20.0)),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Column(
                children: [

                Text(data[0]["breeds"][0]["description"],
                    style: new TextStyle(color: Colors.black, fontStyle: FontStyle.italic, fontSize: 15.0)),
                ],
              ),
            ),
            Container(
              width: 500,
              color: Colors.green,
              child: Center(
                child: Image.network(data[0]["url"], width: 300,height:300),
              ),
            ),
            Container(
              color: Colors.red,
              child:  RaisedButton(

                child: Text("Get a new cat!", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)),
                onPressed:() {getData(data[0]["breeds"][0]["id"]);},
              ),
            ),
          ],
        ),



      /*
        Column(
          children: [
            Container(
              height: 300,
              color: Colors.green,
              child: Row(

                children: [
                  //TODO Hier soll dann das Bild mit dem Text über die Katze random hin

                  Padding(

                    padding: const EdgeInsets.only(left: 0.0),
                    child: RaisedButton(

                        child: Text("Get a new cat!", style: new TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 20.0)),
                       //onPressed: getData(data[0]["breeds"][0]["name"]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        Text(data[0]["breeds"][0]["name"]),
                       Image.network(data[0]["url"], width: 100,height:100),

                        Container(
                          height:80,
                            width: 80,
                            child: Text(data[0]["breeds"][0]["description"],
                                style: new TextStyle(color: Colors.black, fontStyle: FontStyle.italic, fontSize: 10.0))),



                      ],
                    ),
                  ),
                ],
              ),
            ),
            //TODO Hier soll dan die ListView drunter mit allen Katzenbildern und Texten



/*
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Center(
                  child: Container(

                    width: 300,
                    height: 400,
                    color: Colors.green[80],

                    child: ListView.builder(
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (BuildContext context, int index){
                        return Card(
                          child: Column(
                            children: [
                              Image.network(data[index]["url"], width: 200),
                          //Text(dataList[index]["name"]),
                            //  Text(dataList[index]["description"]),
                            ],
                          ),

                        );
                      },
                    ),


                  ),
                ),
              ),
*/




            //Text(data[1]["title"]),
          ],
        ),
    */

    floatingActionButton: FloatingActionButton(

      onPressed: () {

        print("FAB pressed");
      },
      child: Icon(Icons.add_alert),
    ),


        );
  }
}

