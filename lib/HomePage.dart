import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'Model/data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MaterialColor> _color = [
    Colors.brown,
    Colors.cyan,
    Colors.deepOrange,
    Colors.green,
    Colors.lightBlue,
    Colors.red
  ];

  Future<List<Data>> getData() async {
    var api = 'https://jsonplaceholder.typicode.com/photos';
    var data = await http.get(api);

    var jsonData = json.decode(data.body);

    List<Data> listOf = [];

    for (var i in jsonData) {
      Data data = new Data(i['id'], i['title'], i['url'], i['thumbnailUrl']);
      listOf.add(data);
    }

    return listOf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Json Parsing App'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => debugPrint('search'),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => debugPrint('add'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Yeshi'),
              accountEmail: Text('thebluediamond@gmail.com'),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),
            ListTile(
                title: Text('First Page'),
                leading: Icon(
                  Icons.search,
                  color: Colors.orange,
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text('Second Page'),
                leading: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text('Third Page'),
                leading: Icon(
                  Icons.title,
                  color: Colors.brown,
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text('Fourth Page'),
                leading: Icon(
                  Icons.list,
                  color: Colors.green,
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
            Divider(
              height: 5.0,
            ),
            ListTile(
                title: Text('Close'),
                leading: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250.0,
            margin: EdgeInsets.all(10.0),
            child: FutureBuilder(
              future: getData(),
              builder: (BuildContext c, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Text('Loading Data...'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext c, int index) {
                      MaterialColor mColor = _color[index % _color.length];
                      return Card(
                        elevation: 10.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                              snapshot.data[index].url,
                              height: 150.0,
                              width: 150.0,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Container(
                              margin: EdgeInsets.all(6.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: CircleAvatar(
                                      child: Text(
                                          snapshot.data[index].id.toString()),
                                      backgroundColor: mColor,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  Container(
                                    width: 80.0,
                                    child: Text(
                                      snapshot.data[index].title,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
