import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Color(0xfff7f7f7),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("My Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor:
                    Color.fromARGB(255, 49, 17, 34).withOpacity(.2),
                backgroundImage: const NetworkImage(
                  'https://avatar.iran.liara.run/public/52',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Ife Oluwafemi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Ife.dev@gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 4),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF6422AA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(
                  //   color: const Color(0xFFFFD700).withOpacity(0.5),
                  //   width: 1,
                  // ),
                ),
                child: Text(
                  "Tier 1",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildInfoTile('First name', 'Ife'),
              _buildInfoTile('Last name', 'Oluwafemi'),
              _buildInfoTile('Email', 'Ife.dev@gmail.com', hasCheck: true),
              _buildInfoTile('Phone number', '+2349060785373', hasCheck: true),
              _buildInfoTile('Date of Birth', '1997-06-24'),
              _buildInfoTile('Street Address', '21 Opayemi Street'),
              _buildInfoTile('State', 'Lagos'),
              _buildInfoTile('Postal Code', '100001'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value, {bool hasCheck = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                if (hasCheck)
                  Icon(Icons.check_circle, color: Colors.green, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();
}
