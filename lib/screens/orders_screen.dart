import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders.dart' show Orders;
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order';

  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (context, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapShot.error != null) {
                //error handling stuff
                return Center(
                  child: Text('Error'),
                );
              } else {
                return Consumer<Orders>(
                    builder: (context, orderData, child) => ListView.builder(
                          itemCount: orderData.orders.length,
                          itemBuilder: (context, index) {
                            return OrderItem(orderData.orders[index]);
                          },
                        ));
              }
            }
          },
        ));
  }
}
