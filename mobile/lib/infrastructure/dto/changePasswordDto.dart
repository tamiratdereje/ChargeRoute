class ChangePasswordDto {
  final String newPassword;
  final String oldPassword;

  ChangePasswordDto({required this.newPassword, required this.oldPassword});
  // to json
  Map<String, String> toJson() {
    return {
      "newPassword": newPassword,
      "oldPassword": oldPassword,
    };
  }
}
