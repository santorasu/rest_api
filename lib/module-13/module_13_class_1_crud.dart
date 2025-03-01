import 'package:flutter/material.dart';
import 'package:restapi/module-13/product_controller.dart';

class Module13Class1Crud extends StatefulWidget {
  const Module13Class1Crud({super.key});

  @override
  State<Module13Class1Crud> createState() => _Module13Class1CrudState();
}

class _Module13Class1CrudState extends State<Module13Class1Crud> {
  final ProductController productController = ProductController();

  void productDialog(){

    TextEditingController productNameController = TextEditingController();
    TextEditingController productCodeController = TextEditingController();
    TextEditingController productQuantityController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text("Add Products"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: productNameController,
            decoration: InputDecoration(
              labelText: 'Product Name',
            ),
          ),
          TextField(
            controller: productCodeController,
            decoration: InputDecoration(
              labelText: 'Product Code',
            ),
          ),
          TextField(
            controller: productImageController,
            decoration: InputDecoration(
              labelText: 'Product Image',
            ),
          ),
          TextField(
            controller: productQuantityController,
            decoration: InputDecoration(
              labelText: 'Product Quantity',
            ),
          ),
          TextField(
            controller: productUnitPriceController,
            decoration: InputDecoration(
              labelText: 'Product Unit Price',
            ),
          ),
          TextField(
            controller: productTotalPriceController,
            decoration: InputDecoration(
              labelText: 'Total Price',
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Close')),
              SizedBox(width: 5,),
              ElevatedButton(onPressed: (){}, child: Text('Add Product')),
            ],
          )
        ],
      ),
    ));
  }
  Future<void>fetchData() async{
   await productController.fetchProducts();
   print(productController.products.length);
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
        ),
        body: ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (context,index){
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: ListTile(
                  leading: Image.network('data:image/jpeg;base64,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',width: 150,fit: BoxFit.contain,),
                  title: Text("IPhone 16",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text("Price: \$500 | Quantity: 20"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () => productDialog(), icon: Icon(Icons.edit)),
                      SizedBox(width: 10,),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,))
                    ],
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => productDialog(),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
