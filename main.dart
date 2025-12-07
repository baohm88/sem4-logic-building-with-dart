// I. string manipulation
String normalizeName(String input) {
  // 1. Trim leading & trailing spaces
  String cleaned = input.trim();

  // 2. Replace multiple spaces with a single one
  cleaned = cleaned.replaceAll(RegExp(r'\s+'), " ");

  // 3. Split into individual words
  List<String> words = cleaned.split(' ');

  // 4. Capitalize 1st letter of each word
  List<String> formattedWords = words.map((word) {
    if (word.isEmpty) return word;
    String firstChar = word[0].toUpperCase();
    String remaining = word.substring(1).toLowerCase();
    return firstChar + remaining;
  }).toList();

  // 5. Join individual words into a full name
  return formattedWords.join(' ');
}

// II. Validate passwords
bool validatePassword(String password) {
  final List<String> errors = [];

  // 1. Check length
  if (password.length < 8) {
    errors.add('Password must be at least 8 characters long.');
  }

  // 2. Check if at least 1 uppercase letter
  final hasUppercase = password.contains(RegExp(r'[A-z]'));
  if (!hasUppercase) {
    errors.add('Password must have at least 1 uppercase letter (A-Z).');
  }

  // 3. Check if at least 1 lowercase letter
  final hasLowercase = password.contains(RegExp(r'[a-z]'));
  if (!hasLowercase) {
    errors.add('Password must have at least 1 lowercase letter (a-z).');
  }

  // 4. Check if at least 1 digit
  final hasDigit = password.contains(RegExp(r'\d'));
  if (!hasDigit) {
    errors.add('Password must have at least 1 digit (0-9).');
  }

  // 5. Check if at least 1 special character
  final hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  if (!hasSpecialCharacters) {
    errors.add('Password must have at least 1 special character (e.g. !, @, #, &).');
  }

  // 6. If errors not empty -> print error & return false
  if (errors.isNotEmpty) {
    print("Invalid password:");
    for (var error in errors) {
      print('- $error');
    }
    return false;
  }

  // 7. Return true
  print('Valid password.');
  return true;
}

// III. Anagram
bool isAnagram(String s1, String s2) {
  // 1. Normalize (lowercase + remove spaces)
  s1 = s1.toLowerCase().replaceAll(' ', '');
  s2 = s2.toLowerCase().replaceAll(' ', '');

  // 2. Check if length equals
  if (s1.length != s2.length) return false;

  // 3. Count frequency of each char in s1
  final Map<String, int> counter = {};
  for (var char in s1.split('')) {
    counter[char] = (counter[char] ?? 0) + 1;
  }

  // 4. Check frequency of each char in s2
  for (var char in s2.split('')) {
    // check if counter contains char
    if (!counter.containsKey(char)) return false;
    // decrease frequency if contains key
    counter[char] = counter[char]! - 1;
    // remove key if counter = 0
    if (counter[char] == 0) {
      counter.remove(char);
    }
  }
  return counter.isEmpty;
}

// IV. find second largest
int? findSecondLargest(List<int> numbers) {
  if (numbers.length < 2) return null;

  int? max;
  int? secondMax;

  for (var num in numbers) {
    if (max == null || num > max) {
      secondMax = max;
      max = num;
    } else if (num < max && (secondMax == null || num > secondMax)) {
      secondMax = num;
    }
  }

  return secondMax;
}

// V. Move zeros
void moveZeros(List<int> numbers) {
  int writeIndex = 0;

  // 1. move non-zeros forward
  for (var num in numbers) {
    if (num != 0) {
      numbers[writeIndex] = num;
      writeIndex++;
    }
  }

  // 2. fill remaining positions with 0
  for (int i = writeIndex; i < numbers.length; i++) {
    numbers[i] = 0;
  }
}

// VI. Find missing num
int findMissingNumber(List<int> numbers) {
  // 1. calculate expected sum from 1 - n
  int n = numbers.length + 1;

  int expectedSum = n * (n + 1) ~/ 2;

  // 2. calculate actual sum
  int actualSum = 0;
  for (var num in numbers) {
    actualSum += num;
  }

  // 3. difference is the missing number
  return expectedSum - actualSum;
}

// VII. group products
class Product {
  String name;
  String category;
  double price;

  Product(this.name, this.category, [this.price = 0]);

  @override
  String toString() => name;
}

Map<String, List<Product>> groupByCategory(List<Product> products) {
  Map<String, List<Product>> grouped = {};

  for (var product in products) {
    var category = product.category;
    // if the key of category doesn't exist -> create an empty list
    if (!grouped.containsKey(category)) {
      grouped[category] = [];
    }

    // add product to the list
    grouped[category]!.add(product);
  }

  return grouped;
}

// VIII. Find intersection of 2 lists
List<int> findIntersection(List<int> list1, List<int> list2) {
  Set<int> set1 = list1.toSet();

  // 1. create empty set
  Set<int> resultSet = {};

  // 2. if set1 contains num -> add to resultSet
  for (var num in list2) {
    if (set1.contains(num)) {
      resultSet.add(num);
    }
  }
  // 3. convert resultSet back to list
  return resultSet.toList();
}

// IV. Count working days
int countWorkingDays(DateTime startDate, DateTime endDate) {
  if (endDate.isBefore(startDate)) return 0;

  int count = 0;
  DateTime current = startDate;

  while (!current.isAfter(endDate)) {
    var weekday = current.weekday;

    bool isWeekend = weekday == DateTime.saturday || weekday == DateTime.sunday;

    if (!isWeekend) {
      count++;
    }
    // move to next day
    current = current.add(Duration(days: 1));
  }

  return count;
}

void main(List<String> args) {
  // 1. Normalize name
  print('\n1. NORMALIZE NAMES:');
  print(normalizeName('   Nguyễn    Văn  A  '));

  // Validate password
  print('\n2. VALIDATE PASSWORDS:');
  validatePassword('abc');
  validatePassword('Abcdef12');
  validatePassword('Abcd@123');

  // Anagram
  print('\n3. CHECK ANAGRAM:');
  print(isAnagram('listen', 'silent'));
  print(isAnagram('hello', 'world'));
  print(isAnagram('Dormitory', 'Dirty room'));

  // 2nd largest
  print('\n4. FIND SECOND LARGEST:');
  print(findSecondLargest([10, 5, 20, 20, 4, 8]));
  print(findSecondLargest([5, 5, 5]));
  print(findSecondLargest([1, 2]));
  print(findSecondLargest([2]));
  print(findSecondLargest([-5, -2, -10, -1]));

  print('\n5. MOVE ZEROS:');
  final nums1 = [0, 1, 0, 3, 12];
  moveZeros(nums1);
  print(nums1);

  final nums2 = [0, 0, 1];
  moveZeros(nums2);
  print(nums2);

  final nums3 = [1, 2, 3];
  moveZeros(nums3);
  print(nums3);

  final nums4 = [0, 0, 0];
  moveZeros(nums4);
  print(nums4);

  // missing number
  print('\n6. FIND MISSING NUMBER:');
  print(findMissingNumber([1, 2, 4, 6, 3, 7, 8]));
  print(findMissingNumber([2, 3, 1, 5]));
  print(findMissingNumber([1]));

  // group products by category
  print('\n7. GROUP PRODUCTS BY CATEGORY:');
  final products = [
    Product('Laptop', 'Electronic'),
    Product('Ao thun', 'Fashion'),
    Product('Dien thoai', 'Electronic'),
    Product('Giay', 'Fashion'),
  ];

  final grouped = groupByCategory(products);

  grouped.forEach((category, items) {
    print('$category: $items');
  });

  // find intersection of 2 lists
  print('\n8. FIND INTERSECTION OF 2 LISTS:');
  print(findIntersection([1, 2, 2, 1], [2, 2]));
  print(findIntersection([4, 9, 5], [9, 4, 9, 8, 4]));

  // count working days
  print('\n9. COUNT WORKING DAYS:');
  print(countWorkingDays(DateTime(2025, 1, 10), DateTime(2025, 1, 13)));
  print(countWorkingDays(DateTime(2025, 1, 11), DateTime(2025, 1, 12)));
  print(countWorkingDays(DateTime(2025, 1, 13), DateTime(2025, 1, 17)));
  print(countWorkingDays(DateTime(2025, 1, 13), DateTime(2025, 1, 13)));
}

