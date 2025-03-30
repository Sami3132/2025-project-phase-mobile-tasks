import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/size_selector.dart';
import '../utils/constants.dart';
import 'add_update_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int? _selectedSize;

  void _navigateToEdit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUpdateScreen(
          product: widget.product,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildProductImage(),
                _buildProductInfo(),
                _buildSizeSelector(),
                _buildDescription(),
                _buildActionButtons(),
              ],
            ),
          ),
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Image.asset(
      widget.product.imageUrl,
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover,
    );
  }

  Widget _buildProductInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          _buildCategoryAndRating(),
          _buildTitleAndPrice(),
        ],
      ),
    );
  }

  Widget _buildCategoryAndRating() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        children: [
          Text(
            widget.product.category,
            style: AppConstants.subtitleStyle,
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(
                Icons.star,
                size: 20,
                color: AppConstants.starColor,
              ),
              Text(
                '(${widget.product.rating.toStringAsFixed(1)})',
                style: AppConstants.subtitleStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleAndPrice() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.product.title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Text(
            '\$${widget.product.price.toStringAsFixed(0)}',
            style: AppConstants.priceStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Size:',
              style: TextStyle(
                fontSize: 16,
                color: Color(0XFF3E3E3E),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30),
          child: SizeSelector(
            selectedSize: _selectedSize,
            onSizeSelected: (size) {
              setState(() {
                _selectedSize = size;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        widget.product.description,
        style: const TextStyle(
            fontSize: 12,
            color: AppConstants.secondaryColor,
            fontFamily: 'Poppins'),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDeleteButton(),
          _buildUpdateButton(),
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return OutlinedButton(
      onPressed: () {
        // TODO: Implement delete functionality
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        side: const BorderSide(width: 1, color: Colors.red),
      ),
      child: const Text(
        'Delete',
        style: TextStyle(color: Colors.red, fontFamily: 'Poppins'),
      ),
    );
  }

  Widget _buildUpdateButton() {
    return ElevatedButton(
      onPressed: _navigateToEdit,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        backgroundColor: AppConstants.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: const Text(
        'Update',
        style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 40,
      left: 20,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppConstants.backgroundColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            Icons.keyboard_arrow_left,
            color: AppConstants.primaryColor,
            size: AppConstants.defaultIconSize,
          ),
        ),
      ),
    );
  }
}
