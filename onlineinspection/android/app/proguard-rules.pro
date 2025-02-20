# Flutter and Firebase default ProGuard settings
-keep class io.flutter.** { *; }
-keep class com.google.firebase.** { *; }
-keepattributes Signature
-dontwarn io.flutter.embedding.**
