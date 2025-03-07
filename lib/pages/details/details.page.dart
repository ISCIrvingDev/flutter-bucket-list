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
      appBar: AppBar(centerTitle: true, title: Text(widget.title)),
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
