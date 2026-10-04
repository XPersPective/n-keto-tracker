# N Keto Tracker R8 keep kuralları (ORTAK_UYGULAMA_STANDARDI.md §1.4).
# T31'de release sertleştirme görevi kuralları Drift üretim koduna göre
# gözden geçirir.

# Drift: üretim sırasında üretilen veritabanı uygulama sınıflarının
# R8 tarafından silinmesi/üretilememesi engellenir.
-keep class * extends androidx.sqlite.db.SupportSQLiteOpenHelper
-keep @androidx.annotation.Keep class *
-keepclasseswithmembernames class * { native <methods>; }

# AdMob SDK'sı WorkManager'ı (Room) getirir: R8 üretilmiş WorkDatabase_Impl'i
# silerse açılışta WorkManagerInitializer çöker (release emülatör testinde görüldü).
-keep class * extends androidx.room.RoomDatabase { <init>(); }
-keep class androidx.work.impl.WorkDatabase_Impl { *; }
-keep class androidx.work.impl.WorkDatabase { *; }
