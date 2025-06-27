import 'dart:async';

class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    if (value.length > 50) {
      return 'Password must be less than 50 characters';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one number
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Username validation
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    }

    if (value.length > 20) {
      return 'Username must be less than 20 characters';
    }

    // Check for valid characters (letters, numbers, underscores)
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }

    return null;
  }

  // Required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Minimum length validation
  static String? validateMinLength(
      String? value, int minLength, String fieldName) {
    if (value == null || value.length < minLength) {
      return '$fieldName must be at least $minLength characters long';
    }
    return null;
  }

  // Maximum length validation
  static String? validateMaxLength(
      String? value, int maxLength, String fieldName) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must be less than $maxLength characters';
    }
    return null;
  }

  // Phone number validation
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length < 10) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  // URL validation
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL is optional
    }

    try {
      final uri = Uri.parse(value);
      if (!uri.hasScheme || !uri.hasAuthority) {
        return 'Please enter a valid URL';
      }
    } catch (e) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  // Number validation
  static String? validateNumber(String? value, {double? min, double? max}) {
    if (value == null || value.isEmpty) {
      return 'Number is required';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }

    if (min != null && number < min) {
      return 'Number must be at least $min';
    }

    if (max != null && number > max) {
      return 'Number must be less than $max';
    }

    return null;
  }

  // Integer validation
  static String? validateInteger(String? value, {int? min, int? max}) {
    if (value == null || value.isEmpty) {
      return 'Integer is required';
    }

    final integer = int.tryParse(value);
    if (integer == null) {
      return 'Please enter a valid integer';
    }

    if (min != null && integer < min) {
      return 'Integer must be at least $min';
    }

    if (max != null && integer > max) {
      return 'Integer must be less than $max';
    }

    return null;
  }

  // Date validation
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }

    try {
      DateTime.parse(value);
    } catch (e) {
      return 'Please enter a valid date';
    }

    return null;
  }

  // Future date validation
  static String? validateFutureDate(String? value) {
    final dateError = validateDate(value);
    if (dateError != null) {
      return dateError;
    }

    final date = DateTime.parse(value!);
    final now = DateTime.now();

    if (date.isBefore(now)) {
      return 'Date must be in the future';
    }

    return null;
  }

  // Past date validation
  static String? validatePastDate(String? value) {
    final dateError = validateDate(value);
    if (dateError != null) {
      return dateError;
    }

    final date = DateTime.parse(value!);
    final now = DateTime.now();

    if (date.isAfter(now)) {
      return 'Date must be in the past';
    }

    return null;
  }

  // Recipe title validation
  static String? validateRecipeTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Recipe title is required';
    }

    if (value.length < 3) {
      return 'Recipe title must be at least 3 characters long';
    }

    if (value.length > 100) {
      return 'Recipe title must be less than 100 characters';
    }

    return null;
  }

  // Recipe description validation
  static String? validateRecipeDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Recipe description is required';
    }

    if (value.length < 10) {
      return 'Recipe description must be at least 10 characters long';
    }

    if (value.length > 500) {
      return 'Recipe description must be less than 500 characters';
    }

    return null;
  }

  // Cooking time validation
  static String? validateCookingTime(String? value) {
    final numberError =
        validateInteger(value, min: 1, max: 1440); // 24 hours max
    if (numberError != null) {
      return 'Please enter a valid cooking time (1-1440 minutes)';
    }
    return null;
  }

  // Servings validation
  static String? validateServings(String? value) {
    final numberError = validateInteger(value, min: 1, max: 50);
    if (numberError != null) {
      return 'Please enter a valid number of servings (1-50)';
    }
    return null;
  }
}

// Utility functions
class Utils {
  // Format duration in minutes to readable string
  static String formatDuration(int minutes) {
    if (minutes < 60) {
      return '${minutes}m';
    }

    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (remainingMinutes == 0) {
      return '${hours}h';
    }

    return '${hours}h ${remainingMinutes}m';
  }

  // Format date to readable string
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = difference.inDays ~/ 7;
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = difference.inDays ~/ 365;
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  // Capitalize first letter of each word
  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;

    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  // Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // Generate initials from name
  static String getInitials(String name) {
    if (name.isEmpty) return '';

    final words = name.trim().split(' ');
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    }

    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

  // Validate image URL
  static bool isValidImageUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final extension = uri.path.split('.').last.toLowerCase();
      return ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension);
    } catch (e) {
      return false;
    }
  }

  // Calculate average rating
  static double calculateAverageRating(List<double> ratings) {
    if (ratings.isEmpty) return 0.0;
    return ratings.reduce((a, b) => a + b) / ratings.length;
  }

  // Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // Debounce function
  static Function debounce(Function func, Duration wait) {
    Timer? timer;
    return (List<dynamic> args) {
      timer?.cancel();
      timer = Timer(wait, () => func(args));
    };
  }

  // Throttle function
  static Function throttle(Function func, Duration wait) {
    DateTime? lastRun;
    return (List<dynamic> args) {
      final now = DateTime.now();
      if (lastRun == null || now.difference(lastRun!) >= wait) {
        lastRun = now;
        func(args);
      }
    };
  }
}
