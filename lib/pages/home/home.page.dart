import 'package:bucket_list/pages/add/add.page.dart';
import 'package:bucket_list/pages/details/details.page.dart';
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
  bool isError = false;

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

      isError = false;

      if (res.data is List) {
        fetchedData = res.data;
      }
    } catch (e) {
      print('Se suscito un error: $e');
      isError = true;
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
              : isError
              ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.warning),
                      SizedBox(width: 20),
                      Text('Cannot connoect to the server'),
                    ],
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: getData,
                      child: Text('Get Data'),
                    ),
                  ),
                ],
              )
              : fetchedData.isEmpty
              ? Center(child: Text('No data in the bucket list'))
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
                                onTap: () {
                                  // Named Routes
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   '/details',
                                  //   arguments: {"title": fetchedData[i]['item'] ?? '', "img": fetchedData[i]['img'] ?? ''},
                                  // );

                                  // Material Page Routes
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => DetailsPage(
                                            title: fetchedData[i]['item'] ?? '',
                                            img: fetchedData[i]['img'] ?? '',
                                          ),
                                    ),
                                  );
                                },
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
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          // Named Routes
          // Navigator.pushNamed(
          //   context,
          //   '/add',
          //   arguments: {"prop1": 'Un valor', "prop2": 'Otro valor'},
          // );

          // Material Page Routes
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
