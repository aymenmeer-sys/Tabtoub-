import 'package:flutter/material.dart';
import '../services/subscription_service.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});
  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final _svc = SubscriptionService();

  @override
  void initState() {
    super.initState();
    _svc.load().then((_) => setState(() {}));
  }

  Future<void> _buy(PlanType plan) async {
    final ok = await _svc.purchase(plan);
    if (!mounted) return;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? 'Abonnement ${plan.name} activé ✅' : 'Échec')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Abonnements')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _card('Silver', '3,99 €/mois ou 29,99 €/an',
              ['Sans pub', 'Historique 90j', 'Alertes avancées'], PlanType.silver),
          _card('Gold', '7,99 €/mois ou 59,99 €/an',
              ['Tout Silver', 'Historique 365j', 'Météo avancée', 'Vue 3D'], PlanType.gold),
          _card('Business', '499,99 €/an',
              ['Tout Gold', 'Suivi flotte', 'API', 'Support 24/7'], PlanType.business),
          const SizedBox(height: 16),
          Center(
            child: Text('Plan actuel : ${_svc.current.name.toUpperCase()}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _card(String title, String price, List<String> features, PlanType plan) {
    final active = _svc.current == plan;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(price, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            ...features.map((f) => Text('• $f')),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: active ? null : () => _buy(plan),
                child: Text(active ? 'Actif' : 'Choisir'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
