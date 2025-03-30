import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/price_filter.dart';
import '../utils/constants.dart';
import 'add_update_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = false;
  bool _isFloatingActionButtonVisible = true;
  bool _isPriceFilterVisible = false;
  RangeValues _priceRange = const RangeValues(200, 800);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      _isFloatingActionButtonVisible = !_isSearchVisible;
      _isPriceFilterVisible = _isSearchVisible;
    });
  }

  void _handlePriceRangeChanged(RangeValues values) {
    setState(() {
      _priceRange = values;
    });
  }

  void _handleApplyFilter() {
    setState(() {
      _isPriceFilterVisible = false;
      _isSearchVisible = false;
      _isFloatingActionButtonVisible = true;
    });
    // TODO: Apply filters to product list
  }

  void _navigateToAddProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddUpdateScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMainContent(),
          if (_isPriceFilterVisible)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: PriceFilter(
                onPriceRangeChanged: _handlePriceRangeChanged,
                onApply: _handleApplyFilter,
                initialValues: _priceRange,
              ),
            ),
        ],
      ),
      floatingActionButton: _isFloatingActionButtonVisible
          ? FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 0.0,
              backgroundColor: AppConstants.primaryColor,
              onPressed: _navigateToAddProduct,
              child: const Icon(Icons.add_rounded, color: Colors.white, size: 40),
            )
          : null,
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          Expanded(
            child: _buildProductList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppConstants.shadowColor,
          borderRadius: BorderRadius.circular(11),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'July 14, 2023',
            style: TextStyle(fontSize: 9, fontFamily: 'Sora'),
          ),
          const Text(
            'Hello, Yohannes',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Sora'),
          ),
        ],
      ),
      trailing: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppConstants.shadowColor),
        ),
        padding: const EdgeInsets.all(9),
        child: const Icon(
          color: AppConstants.secondaryColor,
          Icons.notifications_active_outlined,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isSearchVisible
              ? SizedBox(
                  width: 300,
                  height: 35,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: AppConstants.shadowColor),
                      ),
                    ),
                  ),
                )
              : const Text(
                  'Available Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Color(0xFF3E3E3E)),
                ),
          const Spacer(),
          _buildSearchButton(),
        ],
      ),
    );
  }

  Widget _buildSearchButton() {
    return GestureDetector(
      onTap: _toggleSearch,
      child: Container(
        decoration: BoxDecoration(
          color: _isSearchVisible ? AppConstants.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppConstants.shadowColor),
        ),
        padding: const EdgeInsets.all(4),
        child: Icon(
          _isSearchVisible ? Icons.filter_list : Icons.search,
          size: 25,
          color: _isSearchVisible ? Colors.white : AppConstants.shadowColor,
        ),
      ),
    );
  }

  Widget _buildProductList() {
    // TODO: Replace with actual product data
    final List<Product> dummyProducts = List.generate(
      5,
      (index) => Product(
        id: 'product_$index',
        title: 'Derby Leather Shoes',
        imageUrl: 'assets/shoes.jpg',
        price: 120.0,
        category: "Men's shoe",
        rating: 4.0,
        description: 'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
      ),
    );

    return ListView.builder(
      itemCount: dummyProducts.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: dummyProducts[index],
          onTap: () {
            // TODO: Navigate to product detail screen
          },
        );
      },
    );
  }
} 