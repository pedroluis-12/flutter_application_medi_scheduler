String capitalizeWords(String input) {
  if (input.isEmpty) return input;
  
  return input
      .split(' ') 
      .map((word) => word.isNotEmpty 
          ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' 
          : '') 
      .join(' ');
}