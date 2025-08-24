import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(controller.isEditing ? Icons.save : Icons.edit),
              onPressed: () {
                if (controller.isEditing) {
                  // Save changes
                  controller.updateProfile();
                } else {
                  controller.toggleEditing();
                }
              },
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  controller.errorMessage,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.loadProfile,
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.profile == null) {
          return Center(
            child: Text('No profile data available'),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              SizedBox(height: 24),
              _buildProfileForm(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            child: controller.profile?.avatar != null
                ? ClipOval(
                    child: Image.network(
                      controller.profile!.avatar!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person, size: 50, color: Colors.grey);
                      },
                    ),
                  )
                : Icon(Icons.person, size: 50, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Text(
            controller.profile!.fullName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Member since ${_formatDate(controller.profile!.createdAt ?? DateTime.now())}',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        _buildFormField(
          label: 'First Name',
          value: controller.profile!.firstName ?? '',
          enabled: controller.isEditing,
          onChanged: (value) {
            // Handle first name change
          },
        ),
        SizedBox(height: 16),
        _buildFormField(
          label: 'Last Name',
          value: controller.profile!.lastName ?? '',
          enabled: controller.isEditing,
          onChanged: (value) {
            // Handle last name change
          },
        ),
        SizedBox(height: 16),
        _buildFormField(
          label: 'Phone',
          value: controller.profile!.phone ?? '',
          enabled: controller.isEditing,
          onChanged: (value) {
            // Handle phone change
          },
        ),
        SizedBox(height: 24),
        Text(
          'Address Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        _buildFormField(
          label: 'Address',
          value: controller.profile!.address ?? '',
          enabled: controller.isEditing,
          onChanged: (value) {
            // Handle address change
          },
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                label: 'City',
                value: controller.profile!.city ?? '',
                enabled: controller.isEditing,
                onChanged: (value) {
                  // Handle city change
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildFormField(
                label: 'State',
                value: controller.profile!.state ?? '',
                enabled: controller.isEditing,
                onChanged: (value) {
                  // Handle state change
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                label: 'ZIP Code',
                value: controller.profile!.zipCode ?? '',
                enabled: controller.isEditing,
                onChanged: (value) {
                  // Handle zip code change
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildFormField(
                label: 'Country',
                value: controller.profile!.country ?? '',
                enabled: controller.isEditing,
                onChanged: (value) {
                  // Handle country change
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required String value,
    required bool enabled,
    required Function(String) onChanged,
  }) {
    return TextField(
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      controller: TextEditingController(text: value),
      onChanged: onChanged,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.year}';
  }
}
