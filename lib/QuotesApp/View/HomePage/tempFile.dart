import 'package:db_minar/QuotesApp/Controller/quotesController.dart';
import 'package:db_minar/QuotesApp/Model/quotesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuotesController quotesController = Get.put(QuotesController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ))
          ],
          title: const Text(
            'Country Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder(
          future: quotesController.fetchApiData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<QuotesModel>? dataList = snapshot.data;
              return SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 10),
                  ...List.generate(
                    dataList!.length,
                        (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            dataList[index].quote,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(dataList[index].category),
                          subtitle: Text(dataList[index].author,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              )),
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            }
            else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            }
            else {
              return const Center(child: CircularProgressIndicator(color: Colors.blue,));
            }
          },
        ),
      ),
    );
  }
}
//backgroundColor: Colors.blue.shade50,
// appBar : Colors.blue.shade800,
// cardColor : Colors.white70,