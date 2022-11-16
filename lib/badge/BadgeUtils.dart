import '../db/owner_database_provider.dart';
import '../event/EventBus.dart';
import '../event/EventKey.dart';

class BadgeUtils {

  BadgeUtils._();

  static final BadgeUtils instance = BadgeUtils._();

  ///更新小红点
  refreshBadge() {
    OwnDatabaseProvider.db.queryOwnerSongsCount().then((value) => {
      bus.emit(REFRESH_BADGE, value),
    });
  }
}