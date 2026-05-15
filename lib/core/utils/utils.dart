class Utils{

  // Helper methods for formatting 
static String formatPhoneNumber(String phone) {
  if (phone.isEmpty) return 'N/A';
  
  // Remove any non-digit characters
  String digits = phone.replaceAll(RegExp(r'[^\d]'), '');
  
  // Format based on length
  if (digits.length == 11) {
    return '${digits.substring(0, 4)}-${digits.substring(4, 7)}-${digits.substring(7)}';
  } else if (digits.length == 10) {
    return '${digits.substring(0, 3)}-${digits.substring(3, 6)}-${digits.substring(6)}';
  }
  
  return phone;
}




static String formatCNIC(String cnic) {
  if (cnic.isEmpty) return 'N/A';
  
  // Remove any non-digit characters
  String digits = cnic.replaceAll(RegExp(r'[^\d]'), '');
  
  // Format: XXXXX-XXXXXXX-X
  if (digits.length == 13) {
    return '${digits.substring(0, 5)}-${digits.substring(5, 12)}-${digits.substring(12)}';
  }
  
  return cnic;
}

}