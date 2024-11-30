import 'package:flutter/material.dart';

import 'package:encaixado/domain/extensions/string_extension.dart';
import 'package:encaixado/presentation/helpers/helpers.dart';

class LetterTarget extends StatelessWidget {
  final String letter;
  final PathController controller;

  const LetterTarget(this.letter, {required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final path = controller.currentWord;
    final isSelected = letter.toLowerCase() == path.lastChar.toLowerCase();
    final isUsed =
        controller.currentSolution.join().contains(letter.toLowerCase());

    return Transform.translate(
      offset: controller.letterPositionAbsolute(letter),
      child: DragTarget<String>(
        // onWillAcceptWithDetails: (details) {
        //   print(details);
        //   print(letter);
        //   return true;
        // },
        onWillAcceptWithDetails: (_) {
          controller.onAcceptDrag(letter);
          return true;
        },
        builder: (_, __, ___) {
          return Draggable<String>(
            data: letter,
            onDragStarted: () => controller.onDragStart(letter),
            onDragUpdate: controller.onDragUpdate,
            onDragEnd: (_) => controller.onDragEnd(),
            feedback: const SizedBox(),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              // This is used to enlarge the sensibility area of the letter
              padding: EdgeInsets.all(controller.boxSize * 0.035),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: isSelected || !isUsed ? Colors.black : Colors.grey,
                    width: 2,
                  ),
                  boxShadow: !isSelected
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.pink,
                            spreadRadius: controller.boxSize * 0.02,
                            blurRadius: controller.boxSize * 0.02,
                          )
                        ],
                ),
                child: SizedBox(
                  height: controller.boxSize * .15,
                  width: controller.boxSize * .15,
                  child: Center(
                    child: Text(
                      letter.toUpperCase(),
                      style: TextStyle(
                        color:
                            isSelected || !isUsed ? Colors.black : Colors.grey,
                        fontWeight: isSelected ? FontWeight.w900 : null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
