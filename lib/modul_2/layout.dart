import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("TI")),

      body: SingleChildScrollView(
        child: Column( // column (b)
          children: [

            // container (a)
            Container(
              height: 100,
              color: Colors.pink,
              child: Center(child: Text("Header Container")),
            ),
            SizedBox(height: 20),

            // row (b)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.home),
                Icon(Icons.person),
                Icon(Icons.settings),
              ],
            ),
            SizedBox(height: 20),

            // stack (c)
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200,
                  height: 100,
                  color: Colors.yellow,
                ),
                Text("Stack Text"),
              ],
            ),
            SizedBox(height: 20),

            // gridview (d)
            Container(
              height: 200,
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  Container(color: Colors.red),
                  Container(color: Colors.green),
                  Container(color: Colors.orange),
                  Container(color: Colors.purple),
                ],
              ),
            ),
            SizedBox(height: 20),

            // listview (d)
            Container(
              height: 140,
              child: ListView(
                children: [
                  ListTile(title: Text("Item 1")),
                  ListTile(title: Text("Item 2")),
                  ListTile(title: Text("Item 3")),
                ],
              ),
            ),
            SizedBox(height: 20),

            // container didalam column (e)
            Column(
              children: [

                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Container 1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Container 2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),

              ],
            ),

          ],
        ),
      ),
    );
  }
}