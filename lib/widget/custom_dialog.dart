import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String? message;
  final Function()? confirm;

  const CustomDialog(
      {super.key, required this.title, this.message, this.confirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            message != null ? Text(message!) : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: confirm!,
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
