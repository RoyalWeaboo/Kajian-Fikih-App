class DummyNotification {
  int id;
  String notificationTitle;
  String notificationDescription;
  String timeStamp;
  bool status;
  DummyNotification(
    this.id,
    this.notificationTitle,
    this.notificationDescription,
    this.timeStamp,
    this.status,
  );
}

List<DummyNotification> dummyTestNotification = [
  DummyNotification(
    1,
    "Selamat Datang Di Kajian Fiqih.",
    "Syiarkan Agama lebih luas kepada semua umat dan semua makhluk di dunia.",
    "12:38 | 21 Sep 2023",
    false,
  ),
  DummyNotification(
    2,
    "Post Sudah Terupdate.",
    "Terima Kasih atas postingan syiar agama anda.",
    "12:38 | 21 Sep 2023",
    false,
  ),
  DummyNotification(
    3,
    "Jadwal Pengajian Offline Sudah Ditambahkan",
    "Pengajian offline sudah ditambahkan.",
    "12:38 | 21 Sep 2023",
    false,
  ),
];

List<DummyNotification> jamaahDummyTestNotification = [
  DummyNotification(
    1,
    "Selamat Datang Di Kajian Fiqih.",
    "Syiarkan Agama lebih luas kepada semua umat dan semua makhluk di dunia.",
    "12:38 | 21 Sep 2023",
    false,
  ),
  DummyNotification(
    2,
    "Ust.A mengadakan kajian offline.",
    "Ust. A yang anda ikuti akan mengadakan kajian offline pada tanggal 23 Sept 2023, cek sekarang untuk info lebih lanjut !",
    "12:38 | 21 Sep 2023",
    false,
  ),
  DummyNotification(
    3,
    "Ust.A membuat postingan baru.",
    "Isi postingan....",
    "12:38 | 21 Sep 2023",
    false,
  ),
];
