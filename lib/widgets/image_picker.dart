// import 'dart:io';
//
// import 'package:CUDI/utils/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// import '../config/theme.dart';
//
// class AddImage extends StatefulWidget {
//   const AddImage({super.key});
//
//   @override
//   State<AddImage> createState() => _AddImageState();
// }
//
// class _AddImageState extends State<AddImage> {
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     // 화면에 다시 나타날 때 pickedImage를 null로 만들기
//     Provider.of<UtilProvider>(context, listen: false).setPickImage();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UtilProvider>(
//       builder: (context, utilProvider, child) {
//         return GestureDetector(
//           child: Container(
//             width: 104.h,
//             height: 104.h,
//             decoration: BoxDecoration(
//                 color: gray1C,
//                 borderRadius: BorderRadius.circular(8)),
//             clipBehavior: Clip.hardEdge,
//             child: utilProvider.pickedImage != null
//                 ? Image.file(File((utilProvider.pickedImage?.path) ?? ""))
//                 : const Icon(Icons.add),
//           ),
//           onTap: () => utilProvider.getImage(ImageSource.gallery),
//         );
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:CUDI/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../config/theme.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UtilProvider>(
      builder: (context, utilProvider, child) {
        return GestureDetector(
          child: Container(
            width: 104.h,
            height: 104.h,
            decoration: BoxDecoration(
                color: gray1C,
                borderRadius: BorderRadius.circular(8)),
            clipBehavior: Clip.hardEdge,
            child: const Icon(Icons.add, color: gray79),
          ),
          // onTap: () => utilProvider.getImage(ImageSource.gallery),
          onTap: () => utilProvider.getMultiImage(),
        );
      },
    );
  }
}

// 불러온 이미지 gridView
Widget gridPhoto(BuildContext context) {
  UtilProvider utilProvider = Provider.of<UtilProvider>(context, listen: false);
  // return Expanded(
  //   child: utilProvider.pickedImages.isNotEmpty
  //       ? GridView(
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 3,
  //     ),
  //     children: utilProvider.pickedImages
  //         .where((element) => element != null)
  //         .map((e) => gridPhotoItem(e!))
  //         .toList(),
  //   )
  //       : const SizedBox(),
  // );
  return utilProvider.pickedImages != null ? Row(
      children: utilProvider.pickedImages
          .where((element) => element != null)
          .map((e) => selectdImageWidget(e!))
          .toList(),
  ) : SizedBox.shrink();
}

//
Widget selectdImageWidget(XFile? e) {
  return Padding(
    padding: pd16L,
    child: Container(
      width: 104.h,
      height: 104.h,
      decoration: BoxDecoration(
          color: gray1C,
          borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: Image.file(
        File(e?.path ?? ""),
        fit: BoxFit.cover,
      ),
    ),
  );
}

// 불러온 이미지
Widget selectdImagesWidget(BuildContext context) {
  UtilProvider utilProvider = Provider.of<UtilProvider>(context, listen: false);
  return Flexible(
    child: SizedBox(
      height: 104.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal, shrinkWrap: true, itemCount: utilProvider.pickedImages.length, itemBuilder: (context, index) {
       return selectdImageWidget(utilProvider.pickedImages[index]);
      }),
    ),
  );
}

Widget gridPhotoItem(XFile e) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Stack(
      children: [
        Positioned.fill(
          child: Image.file(
            File(e.path),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: GestureDetector(
            onTap: () {
              // setState(() {
              //   _pickedImages.remove(e);
              // });
              debugPrint('ㅈㄷㄱㄷㅈㄱ');
            },
            child: const Icon(
              Icons.cancel_rounded,
              color: Colors.black87,
            ),
          ),
        )
      ],
    ),
  );
}