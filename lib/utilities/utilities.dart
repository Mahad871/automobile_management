class Utilities {
  static int get usernameMaxLength => _usernameMaxLenght;
  static int get groupDescriptionMaxLength => _groupDescriptionMaxLength;
  static int get bioMaxLength => _bioMaxLength;

  static double get videoAspectRatio => _videoAspectRatio;
  static double get imageAspectRatio => _imageAspectRatio;

  static double get borderRadius => 24;

  static bool isVideo({required String extension}) {
    if (_listOfVideoExtensions.contains(extension.toLowerCase())) {
      return true;
    }
    return false;
  }

  static List<String> get videosAndImages => <String>[
        'heic',
        'jpeg',
        'jpg',
        'png',
        'pjp',
        'pjpeg',
        'jfif',
        'gif',
        'mp4',
        'mov',
        'mkv',
        'qt',
        'm4p',
        'm4v',
        'mpg',
        'mpeg',
        'mpv',
        'm2v',
        '3gp',
        '3g2',
        'svi',
      ];
  static final List<String> _listOfVideoExtensions = <String>[
    'gif',
    'mp4',
    'mov',
    'mkv',
    'qt',
    'm4p',
    'm4v',
    'mpg',
    'mpeg',
    'mpv',
    'm2v',
    '3gp',
    '3g2',
    'svi',
  ];

  static const int _usernameMaxLenght = 32;
  static const int _bioMaxLength = 160;
  static const int _groupDescriptionMaxLength = 160;

  static const double _videoAspectRatio = 4 / 3;
  static const double _imageAspectRatio = 4 / 3;

  static String get agoraID => 'dad9c77f168046f9b9c0397add34220c';
  static String get agoraToken => '499cccaf590c47008f154cf99bfe3829';
  static String get firebaseServerID =>
      'AAAA9MYSeK8:APA91bGnI05KPv8IhyfqvrMZR-pOVCBNQ0iTq_e3ZCfqheeU_vEbhb2LpkCkxRDVm1yKl5eXtI2_6Ad2GGgl5CiD6wS1VjhLlj_j2NEEK_m3_AgVQxvNRPLx47ZzCFE4S_qGuvnsuDiQ';
}
