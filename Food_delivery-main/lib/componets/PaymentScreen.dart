import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool saveCardDetails = false;
  int selectedPaymentMethod = 0;

  // Variables for order details
  double orderAmount = 500.0; // Example value in INR
  double taxes = 50.0; // Example taxes in INR
  double deliveryFee = 30.0; // Example delivery fee in INR

  // Conversion rate: 1 INR = 0.012 USD
  double conversionRate = 0.012;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildOrderSummary(),
            SizedBox(height: 24),
            Text(
              'Payment methods',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // You can add payment methods here if required
            SizedBox(height: 24),
            _buildSaveCardOption(),
            Spacer(),
            _buildTotalPrice(),
            SizedBox(height: 16),
            _buildPayNowButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order'),
            Text('₹${orderAmount.toStringAsFixed(2)}'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Taxes'),
            Text('₹${taxes.toStringAsFixed(2)}'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Delivery fees'),
            Text('₹${deliveryFee.toStringAsFixed(2)}'),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total (INR):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '₹${(orderAmount + taxes + deliveryFee).toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total (USD):',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            Text(
              '\$${((orderAmount + taxes + deliveryFee) * conversionRate).toStringAsFixed(2)}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Estimated delivery time: 15 - 30 mins',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSaveCardOption() {
    return Row(
      children: [
        Checkbox(
          value: saveCardDetails,
          onChanged: (bool? value) {
            setState(() {
              saveCardDetails = value!;
            });
          },
        ),
        Text('Save card details for future payments'),
      ],
    );
  }

  Widget _buildTotalPrice() {
    double totalInr = orderAmount + taxes + deliveryFee;
    double totalUsd = totalInr * conversionRate;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total price (INR)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '₹${totalInr.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total price (USD)',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            Text(
              '\$${totalUsd.toStringAsFixed(2)}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPayNowButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: () {
        _handlePayment();
      },
      child: Text('Pay Now'),
    );
  }

  void _handlePayment() {
    double totalInr = orderAmount + taxes + deliveryFee;
    double totalUsd = totalInr * conversionRate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Confirmation'),
          content: Text(
            'You are about to pay ₹${totalInr.toStringAsFixed(2)} '
            'or \$${totalUsd.toStringAsFixed(2)}. Do you want to proceed?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Simulate payment processing
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment successful!')),
                );
              },
              child: Text('Proceed'),
            ),
          ],
        );
      },
    );
  }
}
