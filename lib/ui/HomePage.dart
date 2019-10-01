 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/data/FirestoreService.dart';
import 'package:task/utils/Helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new Home();
  }
}

class Home extends State<HomePage>   {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("Home page "),
          centerTitle: true,
          backgroundColor: Colors.blue[700],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
//            Helper.uploadForm(context);
          },
          child: Icon(Icons.add),
        ),
        body: _myListView(context));
  }

  Widget _myListView(BuildContext context) {
    return Stack(
    children: <Widget>[
      StreamBuilder(
        stream: FirestoreService().getProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            print(snapshot.error.toString() + "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Product product = snapshot.data[index];

              return ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                    color: Colors.lightBlueAccent,
                    margin: EdgeInsets.all(5.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //change here don't //worked
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                           ClipRRect(
                            borderRadius: new BorderRadius.circular(50.0),
                            child: Image.network(
                              Helper.getImage(product.image).toString(),
                              // "https://picsum.photos/id/316/200/300",

                              height: 50.0,
                              width: 50.0,
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                product.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.bold),
                              ),
//                            Text(
//                              'Duration: ',
//                              style: TextStyle(
//                                  color: Colors.black, fontSize: 14.0),
//                            )
                            ],
                          ),
                          new Spacer(),
                          // I just added one line
                          IconButton(
                              icon: Icon(Icons.delete, color: Colors.white)),
                          IconButton(icon: Icon(Icons.edit, color: Colors.white)),

                          // This Icon
                        ],
                      ),
                     ),
                  ));
            },
          );
        },
      )
    ],
    );


  }


}
