import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/constants.dart';

class AddUpdateScreen extends StatefulWidget {
  final Product? product;

  const AddUpdateScreen({
    super.key,
    this.product,
  });

  @override
  State<AddUpdateScreen> createState() => _AddUpdateScreenState();
}

class _AddUpdateScreenState extends State<AddUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.title;
      _categoryController.text = widget.product!.category;
      _priceController.text = widget.product!.price.toString();
      _descriptionController.text = widget.product!.description;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement save functionality
      Navigator.pop(context);
    }
  }

  void _handleDelete() {
    // TODO: Implement delete functionality
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildHeader(),
                  _buildForm(),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 42.5),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          widget.product == null ? 'Add Product' : 'Update Product',
          style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF3E3E3E),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          _buildImageUpload(),
          _buildNameField(),
          _buildCategoryField(),
          _buildPriceField(),
          _buildDescriptionField(),
        ],
      ),
    );
  }

  Widget _buildImageUpload() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image_outlined, size: 40),
          SizedBox(height: 14),
          const Text(
            'upload image',
            style: TextStyle(fontSize: 13, fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('name', style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
        SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
            ),
            style: const TextStyle(fontSize: 13),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('category', style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
        SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: _categoryController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
            ),
            style: const TextStyle(fontSize: 13),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a category';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPriceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('price', style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
        SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: Color(0xFF3E3E3E),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 15),
                child: const Text(
                  '\$',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF3E3E3E),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('description', style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
        SizedBox(height: 10),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
            ),
            style: const TextStyle(fontSize: 13),
            maxLines: null,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          _buildUpdateButton(),
          const SizedBox(height: 10),
          _buildDeleteButton(),
        ],
      ),
    );
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _handleSubmit,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          backgroundColor: AppConstants.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          widget.product == null ? 'Add' : 'Update',
          style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: _handleDelete,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          side: const BorderSide(width: 1, color: Colors.red),
        ),
        child: const Text(
          'Delete',
          style: TextStyle(
            color: Colors.red,
            fontFamily: 'Poppins',
          ),
        ),
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
