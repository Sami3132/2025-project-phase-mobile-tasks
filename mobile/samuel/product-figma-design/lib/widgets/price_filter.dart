import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// A widget that allows users to filter products by price range using a RangeSlider.
class PriceFilter extends StatefulWidget {
  final Function(RangeValues) onPriceRangeChanged;
  final VoidCallback onApply;
  final RangeValues initialValues;

  const PriceFilter({
    super.key,
    required this.onPriceRangeChanged,
    required this.onApply,
    this.initialValues = const RangeValues(200, 800),
  });

  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  late RangeValues _values;

  @override
  void initState() {
    super.initState();
    _values = widget.initialValues;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.2,
            blurRadius: 3,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryField(),
          const SizedBox(height: 20),
          _buildPriceRange(),
          const SizedBox(height: 10),
          _buildApplyButton(),
        ],
      ),
    );
  }

  Widget _buildCategoryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Category'),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppConstants.shadowColor, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Price'),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 10,
          ),
          child: RangeSlider(
            values: _values,
            min: 0,
            max: 1000,
            divisions: 20,
            activeColor: AppConstants.primaryColor,
            inactiveColor: AppConstants.shadowColor,
            onChanged: (RangeValues newValues) {
              setState(() {
                _values = newValues;
              });
              widget.onPriceRangeChanged(newValues);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildApplyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onApply,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          backgroundColor: AppConstants.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'Apply',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
} 