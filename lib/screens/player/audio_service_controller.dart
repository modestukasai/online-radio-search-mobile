import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:onlineradiosearchmobile/screens/player/player_item.dart';
import 'package:onlineradiosearchmobile/screens/player/audio_player_task.dart';

class AudioServiceController {
  static void start(PlayerItem playerItem) {
    if (AudioService.running) {
      return;
    }
    AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Online Radio Search',
      // Enable this if you want the Android service to exit the foreground state on pause.
      //androidStopForegroundOnPause: true,
      androidNotificationColor: 0x3273dc,
      androidNotificationIcon: 'mipmap/ic_launcher',
      params: {'radioStation': playerItem.toJson()},
      androidEnableQueue: true,
    );
  }

  static void changeStation(PlayerItem playerItem) {
    AudioService.stop().whenComplete(() {
      if (AudioService.playbackStateStream == null || !AudioService.running) {
        start(playerItem);
        return;
      }
      var subscription;
      subscription = AudioService.playbackStateStream.listen((state) {
        if (!AudioService.running) {
          subscription.cancel();
          start(playerItem);
        }
      });
    });
//    AudioService.customAction(
//      AudioServiceActions.changeStation.toString(),
//      playerItem.toJson(),
//    );
  }
}

enum AudioServiceActions { changeStation }

// NOTE: Your entrypoint MUST be a top-level function.
void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
