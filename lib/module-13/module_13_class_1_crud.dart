import 'package:flutter/material.dart';

class Module13Class1Crud extends StatefulWidget {
  const Module13Class1Crud({super.key});

  @override
  State<Module13Class1Crud> createState() => _Module13Class1CrudState();
}

class _Module13Class1CrudState extends State<Module13Class1Crud> {
  void productDialog(){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text("Add Products"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Product Name',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Product Code',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Product Image',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Product Quantity',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Product Unit Price',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Total Price',
            ),
          ),
          SizedBox(height: 10,),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){}, child: Text('Add Product')))
        ],
      ),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
        ),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context,index){
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: ListTile(
                  leading: Icon(Icons.image,size: 50,),
                  title: Text("IPhone 16",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text("Price: \$500 | Quantity: 20"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
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
