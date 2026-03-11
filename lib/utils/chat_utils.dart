String generateChatId(String uid1, String uid2) {
  List<String> ids = [uid1, uid2]..sort();
  return ids.join("_");
}