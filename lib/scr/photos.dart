import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_view/photo_view.dart';

class PhotosPage extends StatelessWidget {
  final List<String> imageAssets = [
    'assets/me.jpg',
    'assets/mm.jpg',
    'assets/ma.jpg',
    'assets/cc.jpg',
    'assets/kk.jpg',
    'assets/c1.jpg',
    'assets/b1.jpg',
    'assets/aaa.jpg',
    'assets/a8.jpg',
    'assets/a7.jpg',
    'assets/a6.jpg',
    'assets/a5.jpg',
    'assets/a4.jpg',
    'assets/a3.jpg',
    'assets/a2.jpg',
    'assets/a1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: imageAssets.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            // Open photo view on tap
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoViewPage(imagePath: imageAssets[index]),
              ),
            );
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.asset(
              imageAssets[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}

class PhotoViewPage extends StatelessWidget {
  final String imagePath;

  const PhotoViewPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo View'),
      ),
      body: Center(
        child: Container(
          child: PhotoView(
            imageProvider: AssetImage(imagePath),
          ),
        ),
      ),
    );
  }
}
