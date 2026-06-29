class Validators {

  static String? email(String? value) {

    if (value == null || value.isEmpty) {
      return "Email obligatoire";
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return "Email invalide";
    }

    return null;
  }

  static String? password(String? value) {

    if (value == null || value.isEmpty) {
      return "Mot de passe obligatoire";
    }

    if (value.length < 6) {
      return "Minimum 6 caractères";
    }

    return null;
  }

  static String? required(String? value, String fieldName) {

    if (value == null || value.isEmpty) {
      return "$fieldName obligatoire";
    }

    return null;
  }

  static String? phone(String? value) {

    if (value == null || value.isEmpty) {
      return "Numéro obligatoire";
    }

    final regex = RegExp(r'^[0-9]{8,15}$');

    if (!regex.hasMatch(value)) {
      return "Numéro invalide";
    }

    return null;
  }
}