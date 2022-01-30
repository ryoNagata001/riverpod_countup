import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_countup/data/count_data.dart';

class SoundLogic {
  static const SOUND_DATA_UP = 'sounds/Onoma-Flash07-1.mp3';
  static const SOUND_DATA_DOWN = 'sounds/Onoma-Flash08-1.mp3';
  static const SOUND_DATA_RESET = 'sounds/Onoma-Flash09-1.mp3';

  final AudioCache _cache = AudioCache(
    fixedPlayer: AudioPlayer(),
  );

  void load() {
    _cache.loadAll([SOUND_DATA_UP, SOUND_DATA_DOWN, SOUND_DATA_RESET]);
  }

  void valueChanged(CountData oldData, CountData newData) {
    if (newData.countUp == 0 && newData.countDown == 0 && newData.count == 0) {
      _playResetSound();
    } else if (oldData.countUp + 1 == newData.countUp) {
      _playUpSound();
    } else if (oldData.countDown + 1 == newData.countDown) {
      _playDownSound();
    }
  }

  void _playUpSound() {
    _cache.play(SOUND_DATA_UP);
  }

  void _playDownSound() {
    _cache.play(SOUND_DATA_DOWN);
  }

  void _playResetSound() {
    _cache.play(SOUND_DATA_RESET);
  }
}
