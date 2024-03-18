import 'package:email_validator/email_validator.dart';

String? validateUsername(String value) {
  if (value.isEmpty) {
    return 'Username tidak boleh kosong';
  }
  if (value.length < 4) {
    return 'Panjang username harus lebih dari 4 karakter';
  }
  if (value.length > 255) {
    return 'Username tidak boleh lebih dari 255 karakter';
  }
  return null;
}

String? validateEmail(String value) {
  if (!EmailValidator.validate(value)) {
    return 'Email tidak valid';
  }
  return null;
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Kata sandi tidak boleh kosong';
  }
  if (value.length < 8) {
    return 'Kata sandi harus lebih dari 8 karakter';
  }
  if (value.length > 16) {
    return 'Kata sandi tidak boleh lebih dari 16 karakter';
  }
  return null;
}

String? validateConfirmPassword(String value, String pass) {
  if (value.isEmpty) {
    return 'Konfirmasi kata sandi tidak boleh kosong';
  }
  if (value != pass) {
    return 'Kata sandi tidak sesuai';
  }
  return null;
}

String? validateFullname(String value) {
  if (value.isEmpty) {
    return 'Nama lengkap tidak boleh kosong';
  }
  if (value.length <= 4) {
    return 'Nama lengkap harus lebih dari 4 karakter';
  }
  if (value.length > 255) {
    return 'Nama lengkap tidak boleh lebih dari 255 karakter';
  }
  return null;
}

String? validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return 'Nomor Handphone tidak boleh kosong';
  }
  if (value.length < 10) {
    return 'Panjang nomor handphone minimal 10 angka';
  }
  if (value.length > 13) {
    return 'Panjang nomor handphone tidak boleh lebih dari 13 karakter';
  }
  return null;
}

String? validateInput(String value) {
  if (value.isEmpty) {
    return 'Form tidak boleh kosong !';
  }
  return null;
}
