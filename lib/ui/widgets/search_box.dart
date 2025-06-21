import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBox extends StatelessWidget {
  const CustomSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw * 0.85,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10.h),
        border: Border.all(color: Colors.transparent)
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: SearchBar(
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