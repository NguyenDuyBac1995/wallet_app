import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ItemManagement extends StatelessWidget {
  final String imagePath;
  final String name;
  final VoidCallback onClicked;
  final VoidCallback onClickedEdit;
  const ItemManagement(
      {super.key,
      this.imagePath =
          'https://ucarecdn.com/ecc5ff42-1dbd-4a5b-884f-2abb73446cb4/-/preview/3000x3000/',
      required this.onClicked,
      required this.name,
      required this.onClickedEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 48.0,
              height: 48.0,
              child: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.grey,
                  backgroundImage: NetworkImage(imagePath),
                ),
              )),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onClickedEdit,
                    child: Text(
                      name,
                      style: TextStyles.h1
                          .copyWith(fontSize: 15, letterSpacing: 0.75),
                    ),
                  ),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFE5E5E2)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: const BorderSide(color: Color(0xFFE5E5E2)),
                          ),
                        ),
                      ),
                      onPressed: onClicked,
                      child: Text(
                        "${context.l10n?.remove}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFF808080)),
                      ))
                ],
              ),
            ),
          )
        ]);
  }
}
