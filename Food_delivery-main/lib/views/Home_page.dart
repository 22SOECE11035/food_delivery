import 'package:flutter/material.dart';
import 'package:foddie_app/componets/food_items_list.dart';
import 'package:foddie_app/componets/userprofile.dart';
import '../componets/bottom_navigation_bar.dart';
import '../componets/food_grid.dart';
import '../componets/food_selection_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _searchQuery = ''; // To store search query
  List<Map<String, String>> _filteredFoodItems = []; // Filtered food items

  // Key to control the Scaffold and open the drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _filteredFoodItems = foodItems; // Initialize with full list
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Function to handle search logic
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredFoodItems = foodItems;
      } else {
        _filteredFoodItems = foodItems
            .where((item) => item['title']!
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  // Function to return the content for the selected tab
  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return Center(
            child: Text('Orders Page', style: TextStyle(fontSize: 24)));
      case 2:
        return Center(
            child: Text('Favorites Page', style: TextStyle(fontSize: 24)));
      case 3:
        return Center(
            child: Text('Settings Page', style: TextStyle(fontSize: 24)));
      default:
        return _buildHomeContent();
    }
  }

  // Home page content
  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 30),
              child: Text(
                'Delicious food ready to deliver for you',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // New search bar with search functionality
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for food...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: _onSearchChanged, // Listen to text input
            ),

            const SizedBox(height: 20),
            const FoodSelectionRow(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: Text(
                'Most Popular',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _filteredFoodItems.length,
              itemBuilder: (context, index) {
                return FoodCard(
                  imagePath: _filteredFoodItems[index]['imagePath']!,
                  title: _filteredFoodItems[index]['title']!,
                  subtitle: _filteredFoodItems[index]['subtitle']!,
                  price: _filteredFoodItems[index]['price']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to Scaffold
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu), // Menu icon
          onPressed: () {
            // Open the drawer using the scaffold key
            _scaffoldKey.currentState?.openDrawer();
          },
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: GestureDetector(
              onTap: () {
                // Navigate to UserProfile when profile picture is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/images/profile.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Close the drawer and stay on the home page
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigate to the User Profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle logout functionality
              },
            ),
          ],
        ),
      ),
      // Render the selected page
      body: _getSelectedPage(),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        onTap: _onItemTapped, // Handle tap on the bottom navigation
      ),
    );
  }
}
