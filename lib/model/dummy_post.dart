class DummyPost {
  int id;
  String posterImage;
  String posterName;
  String? media;
  String postText;
  String timeStamp;
  int watchCount;
  DummyPost(
    this.id,
    this.posterImage,
    this.posterName,
    this.media,
    this.postText,
    this.timeStamp,
    this.watchCount,
  );
}

List<DummyPost> dummyTestPost = [
  DummyPost(
    1,
    "assets/profile_placeholder.png",
    "Ust. Tomy",
    "assets/media_placeholder.png",
    "Lorem ipsum dolor sit amet consectetur. Et sed cursus velit porttitor dui lectus. Tincidunt mattis blandit gravida arcu nisl. Pharetra sit massa elementum rutrum phasellus eu mus pretium. Vestibulum est ac ac eget.",
    "12:38 | 21 Sep 2023",
    22,
  ),
  DummyPost(
    2,
    "assets/profile_placeholder.png",
    "Ust. Tomy",
    "",
    "Lorem ipsum dolor sit amet consectetur. Et sed cursus velit porttitor dui lectus. Tincidunt mattis blandit gravida arcu nisl. Pharetra sit massa elementum rutrum phasellus eu mus pretium. Vestibulum est ac ac eget.",
    "12:38 | 21 Sep 2023",
    22,
  ),
  DummyPost(
    3,
    "assets/profile_placeholder.png",
    "Ust. Tomy",
    "",
    "Lorem ipsum dolor sit amet consectetur. Et sed cursus velit porttitor dui lectus. Tincidunt mattis blandit gravida arcu nisl. Pharetra sit massa elementum rutrum phasellus eu mus pretium. Vestibulum est ac ac eget.",
    "12:38 | 21 Sep 2023",
    22,
  ),
  DummyPost(
    4,
    "assets/profile_placeholder.png",
    "Ust. Tomy",
    "",
    "Lorem ipsum dolor sit amet consectetur. Et sed cursus velit porttitor dui lectus. Tincidunt mattis blandit gravida arcu nisl. Pharetra sit massa elementum rutrum phasellus eu mus pretium. Vestibulum est ac ac eget.",
    "12:38 | 21 Sep 2023",
    22,
  ),
];
