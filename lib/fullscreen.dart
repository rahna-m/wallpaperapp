import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String imageurl;
  const FullScreen({super.key, required this.imageurl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {

  DialogBox() {

    AlertDialog alertbox = AlertDialog(
      title: const Align(
        alignment: Alignment.center,
        child: Text("Set as Wallpaper")),
      // contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 10),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: (){
            setWallpaper();
            
          }, 
          child: const Text('Apply', style: TextStyle(color: Colors.white),)),

           ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: (){
          
            Navigator.pop(context);
          }, 
          child: const Text('Cancel', style: TextStyle(color: Colors.white),)),

          ],
        )
        


      ],
    );

    showDialog(context: context, 
    barrierDismissible: false,
    builder: (context){
      
 return PopScope(
      canPop:  false, 
      child: alertbox);
 
  
    });
  }




  Future<void> setWallpaper() async{
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
         children: [
          Expanded(child: Container(
            child: Image.network(widget.imageurl, fit: BoxFit.cover,),
          )),
          InkWell(
            onTap: () {
              DialogBox();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child:  Text(
                  'Set Wallpaper',
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
      ),
    );
  }
}