import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  final String img;
  const DetailsPage({super.key, required this.title, required this.img});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (val) {
              if (val == 0) {
                showDialog(
                  context: context,
                  builder:
                      (builder) => AlertDialog(
                        title: Text('Do you wanto to delete it?'),
                        actions: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          Text('Confirm'),
                        ],
                      ),
                );
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(value: 0, child: Text('Delete')),
                  PopupMenuItem(value: 1, child: Text('Mark as Done')),
                ],
          ),
        ],
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.img),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
