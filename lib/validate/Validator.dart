class Validator {
  String? validateEmail(String? value) {
    if (value!.length < 3) {
      return "Kullanıcı adı en az 3 karakter olmalıdır.";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.length < 4) {
      return "Şifre en az 4 karakter olmalıdır";
    }
    return null;
  }

  String? validateIl(String? value) {
    if (value!.isEmpty) {
      return "Bu alanı boş bırakamazsınız";
    }
    return null;
  }

  String? validateIlce(String? value) {
    if (value!.isEmpty) {
      return "Bu alanı boş bırakamazsınız";
    }
    return null;
  }

  String? validateMahalle(String? value) {
    if (value!.length < 5) {
      return "Mahalle en az 5 karakter olmalıdır";
    }
    return null;
  }

  String? validateSokak(String? value) {
    if (value!.length < 5) {
      return "Sokak en az 5 karakter olmalıdır";
    }
    return null;
  }

  String? validateAcikAdres(String? value) {
    if (value!.length < 10) {
      return "Açık adres en az 10 karakter olmalıdır";
    }
    return null;
  }
}
