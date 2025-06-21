import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBox extends StatelessWidget {
  const CustomSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw ,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent)
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: SearchBar(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
          hintText: 'Search',
          onChanged: (value){},
          onTapOutside: (value){},
          onSubmitted: (value){},
          leading: Icon(Icons.search),
          trailing: [Padding(padding:EdgeInsets.zero, child:  Icon(Icons.send))],
        ),
      ),
    );
  }
}