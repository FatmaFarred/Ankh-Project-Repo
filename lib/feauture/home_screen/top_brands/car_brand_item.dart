import 'package:ankh_project/feauture/home_screen/top_brands/cars_by-brand_screen.dart';
import 'package:flutter/material.dart';

class CarBrandItem extends StatelessWidget {
  final String imageUrl;
  final int id;

  const CarBrandItem({super.key, required this.imageUrl, required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){return CarsBybrandScreen(id: id,);}));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFF131313).withOpacity(0.1),
            width: 0.9,
          ),
        ),
        child: Image.network(
          imageUrl,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => Icon(Icons.broken_image),
        ),
      ),
    );
  }
}
