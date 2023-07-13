import 'package:flutter/material.dart';

toScreen(BuildContext context, page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

replaceScreen(BuildContext context, page) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page), (route) => false);
}

pop(BuildContext context) {
  Navigator.of(context).pop();
}
