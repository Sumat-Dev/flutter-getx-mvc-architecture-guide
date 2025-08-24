class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Phone is optional
    }
    
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  static String? validateZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return null; // ZIP code is optional
    }
    
    final zipRegex = RegExp(r'^\d{5}(-\d{4})?$');
    if (!zipRegex.hasMatch(value)) {
      return 'Please enter a valid ZIP code';
    }
    
    return null;
  }

  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
    
    final price = double.tryParse(value);
    if (price == null || price <= 0) {
      return 'Please enter a valid price';
    }
    
    return null;
  }

  static String? validateStock(String? value) {
    if (value == null || value.isEmpty) {
      return 'Stock is required';
    }
    
    final stock = int.tryParse(value);
    if (stock == null || stock < 0) {
      return 'Please enter a valid stock quantity';
    }
    
    return null;
  }
}
