import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/theme.dart';

Widget cudiAllCheckBox({bool? value, void Function(bool?)? onChange, bool? sized20}) {
  return Checkbox(
    value: value,
    onChanged: onChange,
    side: MaterialStateBorderSide.resolveWith(
          (states) => BorderSide(
        color: states.contains(MaterialState.selected) ? primary : grayEA,
        width: sized20 == null ? 1 : 2,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    checkColor: white,
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3.0),
    ),
    fillColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected) ? primary : white,
    ),
  );
}

Widget cudiWhiteFillCheckBox(bool? value, void Function(bool?)? onChange){
  return Checkbox(value: value, onChanged: onChange,
    side: const BorderSide(color: grayEA),
    checkColor: white,
    fillColor: MaterialStateProperty.resolveWith ((Set  states) {
      if (states.contains(MaterialState.selected)) {
        return primary.withOpacity(.82);
      }
      return white;
    }),
  );
}

Widget cudiTransparentCheckBox(bool? value, void Function(bool?)? onChange){
  return Checkbox(value: value, onChanged: onChange,
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    side: BorderSide.none,
    checkColor: primary,
    fillColor: const MaterialStatePropertyAll(Colors.transparent),
  );
}

Widget primarySwitch({
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  final MaterialStateProperty<Color?> trackColor =
  MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return primary;
      }
      return gray3D;
    },
  );
  final MaterialStateProperty<Color?> thumbColor =
  MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return white;
      }
      return gray79;
    },
  );
  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      return const Icon(null);
    },
  );
  return Switch(
    value: value,
    onChanged: onChanged,
    trackColor: trackColor,
    thumbColor: thumbColor,
    thumbIcon: thumbIcon,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}

Widget checkRow(String text) {
  return Padding(
    padding: pd24T,
    child: Row(
      children: [
        cudiAllCheckBox(value: true, onChange: (bool) {}),
        SizedBox(width: 8.w),
        Text(text, style: w500),
      ],
    ),
  );
}