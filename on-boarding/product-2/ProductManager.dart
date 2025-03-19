import 'Product.dart';

class ProductManager {
  List<Product> products = [];
  // add product
  void addProduct(String name, String description, double price) {
    products.add(Product(name, description, price));
    print("Product added successfully");
  }

  //view all products
  void viewAllProducts() {
    if (products.isEmpty) {
      print("There are no products to display");
    } else {
      for (var i = 0; i < products.length; i++) {
        print("${i + 1} - ${products[i].name} - ${products[i].price}");
      }
    }
  }

  // view specific product
  void viewProduct(int index) {
    if (index < 0 || index >= products.length) {
      print(
        "Invalid product index. choose in the range between 0 and ${products.length - 1}",
      );
    } else {
      print("Product Name: ${products[index].name}");
      print("Description: ${products[index].description}");
      print("Price: \$${products[index].price.toStringAsFixed(2)}");
    }
  }

  //update Product
  void updateProduct(int index, String name, String description, double price) {
    if (index < 0 || index >= products.length) {
      print(
        "Invalid product index. choose in the range between 0 and ${products.length - 1}",
      );
    } else {
      products[index].name = name;
      products[index].description = description;
      products[index].price = price;
      print("Product updated successfully");
    }
  }

  //delete Product
  void deleteProduct(int index) {
    if (index < 0 || index >= products.length) {
      print(
        "Invalid product index. choose in the range between 0 and ${products.length - 1}",
      );
    } else {
      products.removeAt(index);
      print("Product at $index deleted successfully");
    }
  }
}
