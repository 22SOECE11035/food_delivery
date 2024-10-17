import 'package:flutter/material.dart';
import 'package:foddie_app/componets/signup.dart'; // Assuming SignUpScreen is in this file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfile()),
            );
          },
          child: Text('Go to Profile'),
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 20),
            _buildProfileDetails(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Center(
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.person, size: 50, color: Colors.grey[600]),
        ),
      ),
    );
  }

  Widget _buildProfileDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileField(
              label: 'Name', value: 'John Doe', icon: Icons.person_outline),
          ProfileField(
              label: 'Email',
              value: 'johndoe@email.com',
              icon: Icons.email_outlined),
          ProfileField(
              label: 'Delivery address',
              value: '123 Street Name, City, Country',
              icon: Icons.location_on_outlined),
          ProfileField(
              label: 'Password', value: '********', icon: Icons.lock_outline),
          SizedBox(height: 20),
          _buildNavigationRow(context, 'Payment Details',
              Icons.payment_outlined, PaymentDetailsPage()),
          SizedBox(height: 20),
          _buildNavigationRow(
              context, 'Order history', Icons.history, OrderHistoryPage()),
          SizedBox(height: 30),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildNavigationRow(
      BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 10),
          Text(title, style: TextStyle(color: Colors.white)),
          Spacer(),
          Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfilePage()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[800],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.white),
              SizedBox(width: 10),
              Text('Edit Profile'),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
              (route) => false, // Remove all previous routes (logout effect)
            );
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.red),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 10),
              Text('Log out', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const ProfileField(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 16)),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(icon, color: Colors.grey),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(value,
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PaymentDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment Details')),
      body: Center(child: Text('Payment details will be displayed here.')),
    );
  }
}

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order History')),
      body: Center(child: Text('Order history will be displayed here.')),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Simulate fetching profile data from a server or database
    _nameController.text = 'John Doe';
    _emailController.text = 'johndoe@email.com';
    _addressController.text = '123 Street Name, City, Country';
    _passwordController.text = 'password';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save profile changes (simulated here)
                print('Profile updated!');
                Navigator.pop(context); // Go back to profile screen
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: Text('You have been logged out.'),
      ),
    );
  }
}
