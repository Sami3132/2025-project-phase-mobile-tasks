import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// A widget that displays a horizontal list of shoe sizes that can be selected.
class SizeSelector extends StatelessWidget {
  final int? selectedSize;
  final Function(int) onSizeSelected;
  final int minSize;
  final int maxSize;

  const SizeSelector({
    super.key,
    required this.selectedSize,
    required this.onSizeSelected,
    this.minSize = 39,
    this.maxSize = 47,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int size = minSize; size <= maxSize; size++)
            _buildSizeButton(size),
        ],
      ),
    );
  }

  Widget _buildSizeButton(int size) {
    final bool isSelected = selectedSize == size;
    
    return GestureDetector(
      onTap: () => onSizeSelected(size),
      child: Container(
        margin: const EdgeInsets.only(right: 12, bottom: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? AppConstants.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0.1,
                    blurRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Text(
          size.toString(),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
} 