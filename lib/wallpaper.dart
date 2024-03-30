import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpapperapp/fullscreen.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {

  List images =[];
  int page=1;

  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'), 
    headers: {'Authorization' : 'add your pexel-key from pexel website'})
    .then((value) {
       Map result = jsonDecode(value.body);
     setState(() {
       images = result['photos'];
     });
     print(images[0]);
    });
  }

  loadMore() async {
    setState(() {
      page = page + 1;
    });

    String url = 'https://api.pexels.com/v1/curated?per_page=80&page='+page.toString();

    await http.get(Uri.parse(url), 
    headers: {'Authorization' : '0mZe2CSUudDmdh49Q4cDoZcj4eoBfcFWhXhtborCDiCkPbEr8bvvAyrT'})
    .then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });

  }

  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container(
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 2,
                crossAxisCount: 3,
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 2),
                 itemBuilder: (context, index){
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c) => FullScreen(imageurl: images[index]['src']['large2x'].toString())));
                    },
                    child: Container(color: Colors.white,
                    child: Image.network(images[index]['src']['tiny'], fit: BoxFit.cover,),),
                  );
                 }),
          )),
          InkWell(
            onTap: () {
              loadMore();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child:  Text(
                  'Load More',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}