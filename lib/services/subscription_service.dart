import 'package:shared_preferences/shared_preferences.dart';

enum PlanType { free, silver, gold, business }

class SubscriptionService {
  static const _key = 'plan';
  PlanType _current = PlanType.free;

  PlanType get current => _current;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_key) ?? 'free';
    _current = PlanType.values.firstWhere(
      (p) => p.name == v,
      orElse: () => PlanType.free,
    );
  }

  Future<void> setPlan(PlanType plan) async {
    _current = plan;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, plan.name);
  }

  /// Simule un achat (mode démo pour l'APK de test).
  Future<bool> purchase(PlanType plan) async {
    await Future.delayed(const Duration(seconds: 1));
    await setPlan(plan);
    return true;
  }

  bool canAccessHistory(int days) {
    switch (_current) {
      case PlanType.free:
        return days <= 7;
      case PlanType.silver:
        return days <= 90;
      case PlanType.gold:
      case PlanType.business:
        return days <= 365;
    }
  }

  bool get showAds => _current == PlanType.free;
}
