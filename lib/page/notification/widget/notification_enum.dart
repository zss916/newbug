enum NotificationEnum {
  visited(value: 0, titleType: 0, imageType: 0),
  message(value: 1, titleType: 1, imageType: 0),
  photo(value: 2, titleType: 1, imageType: 1),
  privatePhotos(value: 3, titleType: 1, imageType: 2),
  privateVideos(value: 4, titleType: 1, imageType: 3),
  videos(value: 5, titleType: 1, imageType: 4);

  final int value;
  final int titleType;
  //0 new visitor ,1 new message
  final int imageType;
  //0 none, 1 one photo, 2 private photo, 3 private video, 4 video

  const NotificationEnum({
    required this.value,
    required this.titleType,
    required this.imageType,
  });

  static int getTitleType(int index) =>
      NotificationEnum.values.firstWhere((e) => e.value == index).titleType;
}
