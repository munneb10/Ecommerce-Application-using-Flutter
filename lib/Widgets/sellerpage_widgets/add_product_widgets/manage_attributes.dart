import 'dart:io';

class Attributes {
  bool isInitialized = false;
  late Attribute root;
  String attrName = "";
  List<String> attrValues = [];
  bool isSet = false;
  int inputNumber() {
    int quantity = 0;
    try {
      quantity = int.parse(stdin.readLineSync() as String);
    } catch (e) {
      print("Please enter the number only");
    }
    return quantity;
  }

  // Initialize for adding the attributes
  void initialize(int qua) {
    if (isInitialized) {
      root.quantity = qua;
      return;
    }
    root = Attribute();
    root.name = "total";
    isInitialized = true;
    root.quantity = qua;
  }

  void setAttrFirstTime(Attribute node, String tillAttr) {
    print("Enter the attribute name");
    attrName = stdin.readLineSync() as String;
    node.childName = attrName;
    print("Enter the number of $attrName");
    int no = inputNumber();
    int stillQuan = 0;
    for (var i = 1; i <= no; i++) {
      print("Enter the name of $attrName");
      String val = stdin.readLineSync() as String;
      attrValues.add(val);
      Attribute newAttribute = Attribute();
      newAttribute.name = val;
      print("Enter the $tillAttr->$val quantity");
      int qua = inputNumber();
      if ((stillQuan + qua) > node.quantity) {
        print(
            "Please enter the valid quantity( Your quantity is greater than total quantity)");
        i--;
        continue;
      }
      stillQuan = stillQuan + qua;
      newAttribute.quantity = qua;
      node.children.add(newAttribute);
    }
    isSet = true;
  }

  void addNodeAtLeaf(Attribute node, String tillAttr) {
    if (isSet) {
      int stillQuan = 0;
      for (var i = 0; i < attrValues.length; i++) {
        Attribute newAttribute = Attribute();
        newAttribute.name = attrValues[i];
        print("Enter the ${tillAttr}->${newAttribute.name} quantity");
        int qua = inputNumber();
        if ((stillQuan + qua) > node.quantity) {
          print(
              "Please enter the valid quantity( Your quantity is greater than total quantity)");
          i--;
          continue;
        }
        stillQuan = stillQuan + qua;
        newAttribute.quantity = qua;
        node.children.add(newAttribute);
      }
    } else {
      setAttrFirstTime(node, tillAttr);
    }
  }

  void printAttr() {
    List<Attribute> queue = [];
    queue.add(root);
    while (queue.isNotEmpty) {
      queue.first.childName.isNotEmpty ? print(queue.first.childName) : null;
      for (Attribute child in queue.first.children) {
        print("   ${child.name}");
        queue.add(child);
      }
      if (queue.isNotEmpty) queue.removeAt(0);
    }
  }

  void addAtLeaf(Attribute node, String name) {
    if (node.childLength() == 0) {
      addNodeAtLeaf(node, name);
      return;
    }
    for (Attribute child in node.children) {
      addAtLeaf(child, name + "->" + child.name);
    }
  }
}

class Attribute {
  String name = "";
  int quantity = 0;
  String childName = "";
  String id = "";
  Attribute() {
    id = DateTime.now().toString();
    id + "settingidtrreddhskdsgdjsdetail";
  }
  List<Attribute> children = [];
  int childLength() {
    return children.length;
  }
}
