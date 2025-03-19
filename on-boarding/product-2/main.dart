import 'dart:io';
import 'ProductManager.dart';

void main() {
  ProductManager productManager = ProductManager();

  while (true) {
    print("\n========= eCommerce Application =========");
    print("1. Add Product");
    print("2. View All Products");
    print("3. View Product Details");
    print("4. Edit Product");
    print("5. Delete Product");
    print("6. Exit");
    stdout.write("Enter your choice: ");

    var val = stdin.readLineSync();
    if (val == null) continue;

    try {
      switch (val) {
        case "1": //add product
          {
            stdout.write("Enter Product Name: ");
            var name = stdin.readLineSync();
            if (name == null) {
              print("name required");
              continue;
            }
            ;
            stdout.write("Enter Product Description: ");
            var description = stdin.readLineSync();
            if (description == null) {
              print("description required");
              continue;
            }
            ;
            stdout.write("Enter Product Price: ");
            var price = stdin.readLineSync();
            if (price == null) {
              print("price required");
              continue;
            }
            ;
            productManager.addProduct(name, description, double.parse(price));
          }
        case "2": //view all products
          {
            productManager.viewAllProducts();
          }
        case "3": //view specific product
          {
            stdout.write("Enter product index: ");
            var index = stdin.readLineSync();
            if (index == null) {
              print("index required");
              continue;
            } else {
              productManager.viewProduct(int.parse(index));
            }
          }
        case "4": //edit product
          {
            stdout.write("Enter product index: ");
            var index = stdin.readLineSync();
            if (index == null) {
              print("index required");
              continue;
            }
            stdout.write("Enter Product Name: ");
            var name = stdin.readLineSync();
            if (name == null) {
              print("name required");
              continue;
            }
            ;
            stdout.write("Enter Product Description: ");
            var description = stdin.readLineSync();
            if (description == null) {
              print("description required");
              continue;
            }
            ;
            stdout.write("Enter Product Price: ");
            var price = stdin.readLineSync();
            if (price == null) {
              print("price required");
              continue;
            }
            ;
            productManager.updateProduct(
              int.parse(index),
              name,
              description,
              double.parse(price),
            );
          }
        case "5": //delete product
          {
            stdout.write("Enter product index: ");
            var index = stdin.readLineSync();
            if (index == null) {
              print("index required");
              continue;
            } else {
              productManager.deleteProduct(int.parse(index));
            }
          }
        case "6": //exit
          {
            print("Exiting application...");
            return;
          }
        default:
          print("Invalid choice please try again.");
      }
    } catch (e) {
      print("Invalid input. Please try again.");
    }
  }
}
