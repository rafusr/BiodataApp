import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tog_technical_test/pages/add_data_page.dart';
import 'package:tog_technical_test/provider/db_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Consumer<DbProvider>(
        builder: (context, provider, child) {
          final datas = provider.datas;

          return ListView.builder(
              itemCount: datas.length,
              itemBuilder: (context, index) {
                final data = datas[index];
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(data.nama),
                      Text(data.alamat),
                      Text(data.tanggalLahir),
                      Text(data.tinggi),
                      Text(data.berat),
                    ],
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddData()));
        },
      ),
    );
  }
}
