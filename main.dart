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
    if (num !=0) {
      numbers[writeIndex] = num;
      writeIndex++;
    }
  }

  // 2. fill remaining positions with 0
  for (int i = writeIndex; i < numbers.length; i++) {
    numbers[i] = 0;
  }
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
  print(nums1); // [1, 3, 12, 0, 0]

  final nums2 = [0, 0, 1];
  moveZeros(nums2);
  print(nums2); // [1, 0, 0]

  final nums3 = [1, 2, 3];
  moveZeros(nums3);
  print(nums3); // [1, 2, 3]

  final nums4 = [0, 0, 0];
  moveZeros(nums4);
  print(nums4); // [0, 0, 0]
}
