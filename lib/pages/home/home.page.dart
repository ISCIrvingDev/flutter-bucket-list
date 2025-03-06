import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> fetchedData = [];
  bool isLoading = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var res = await Dio().get(
        'https://bucket-list-c967f-default-rtdb.firebaseio.com/bucketlist.json',
      );

      print(res.statusCode);
      print(res.data);

      fetchedData = res.data;
    } catch (e) {
      print('Se suscito un error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => getData(),
                      child: ListView.builder(
                        itemCount: fetchedData.length,
                        itemBuilder:
                            (BuildContext context, int i) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                    fetchedData[i]['img'] ?? '',
                                  ),
                                ),
                                title: Text(fetchedData[i]['item'] ?? ''),
                                trailing: Text(
                                  fetchedData[i]['cost'].toString(),
                                ),
                              ),
                            ),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: getData,
                      child: Text('Get Data'),
                    ),
                  ),
                ],
              ),
    );
  }
}
