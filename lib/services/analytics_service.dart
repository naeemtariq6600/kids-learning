import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  AnalyticsService._internal();
  static final AnalyticsService instance = AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalytics get analytics => _analytics;

  /// Route observer to automatically track named screen transitions.
  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  /// Log when the app is opened.
  Future<void> logAppOpen() async {
    try {
      await _analytics.logAppOpen();
      debugPrint('[Analytics] Logged app_open');
    } catch (e) {
      debugPrint('[Analytics] Error logging app_open: $e');
    }
  }

  /// Log manual screen views (especially for tabs and PageViews).
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass ?? screenName,
      );
      debugPrint('[Analytics] Logged screen_view: $screenName');
    } catch (e) {
      debugPrint('[Analytics] Error logging screen_view: $e');
    }
  }

  /// Log when a learning module or adventure card is clicked.
  Future<void> logModuleSelected({
    required String moduleName,
    String? category,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'select_module',
        parameters: {
          'module_name': moduleName,
          if (category != null) 'category': category,
        },
      );
      debugPrint('[Analytics] Logged select_module: $moduleName ($category)');
    } catch (e) {
      debugPrint('[Analytics] Error logging select_module: $e');
    }
  }

  /// Log quiz completion and user score.
  Future<void> logQuizCompleted({
    required int score,
    required int totalQuestions,
  }) async {
    try {
      final percentage = totalQuestions > 0 ? ((score / totalQuestions) * 100).round() : 0;
      await _analytics.logEvent(
        name: 'quiz_completed',
        parameters: {
          'score': score,
          'total_questions': totalQuestions,
          'percentage': percentage,
        },
      );
      debugPrint('[Analytics] Logged quiz_completed: $score/$totalQuestions ($percentage%)');
    } catch (e) {
      debugPrint('[Analytics] Error logging quiz_completed: $e');
    }
  }

  /// Log when user toggles or changes favorite items.
  Future<void> logFavoriteToggled({
    required String itemName,
    required bool isFavorite,
    String? category,
  }) async {
    try {
      await _analytics.logEvent(
        name: isFavorite ? 'add_to_favorites' : 'remove_from_favorites',
        parameters: {
          'item_name': itemName,
          if (category != null) 'category': category,
        },
      );
      debugPrint('[Analytics] Logged favorite toggled: $itemName, isFavorite: $isFavorite');
    } catch (e) {
      debugPrint('[Analytics] Error logging favorite toggled: $e');
    }
  }

  /// Log custom generic event.
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  }) async {
    try {
      // Firebase Analytics parameters: strings, numbers, or booleans
      final safeParams = parameters?.map((key, value) {
        if (value is String || value is num) {
          return MapEntry(key, value as Object);
        }
        return MapEntry(key, value.toString());
      });

      await _analytics.logEvent(
        name: name,
        parameters: safeParams,
      );
      debugPrint('[Analytics] Logged event $name with params: $safeParams');
    } catch (e) {
      debugPrint('[Analytics] Error logging event $name: $e');
    }
  }

  /// Set a user property (e.g. preferred theme, user level).
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
      debugPrint('[Analytics] Set user property $name: $value');
    } catch (e) {
      debugPrint('[Analytics] Error setting user property: $e');
    }
  }

  /// Set user ID if applicable.
  Future<void> setUserId(String? userId) async {
    try {
      await _analytics.setUserId(id: userId);
      debugPrint('[Analytics] Set user ID: $userId');
    } catch (e) {
      debugPrint('[Analytics] Error setting user ID: $e');
    }
  }
}

