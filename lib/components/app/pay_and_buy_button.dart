import 'package:flutter/material.dart';
import 'package:store/constants/colors.dart';

SizedBox payAndBuyButton(String text, VoidCallback onClick) {
  return SizedBox(
    height: 50,
    child: FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      onPressed: onClick,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: appMainGradient,
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
