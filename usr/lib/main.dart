import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const GGPredictorApp());
}

class GGPredictorApp extends StatelessWidget {
  const GGPredictorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soccer GG Predictor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PredictorScreen(),
      },
    );
  }
}

class PredictorScreen extends StatefulWidget {
  const PredictorScreen({super.key});

  @override
  State<PredictorScreen> createState() => _PredictorScreenState();
}

class _PredictorScreenState extends State<PredictorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _homeTeamController = TextEditingController();
  final _awayTeamController = TextEditingController();

  double _homeAttackRating = 5.0;
  double _homeDefenseRating = 5.0;
  double _awayAttackRating = 5.0;
  double _awayDefenseRating = 5.0;

  double? _predictionResult;
  String? _predictionMessage;

  @override
  void dispose() {
    _homeTeamController.dispose();
    _awayTeamController.dispose();
    super.dispose();
  }

  void _calculatePrediction() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // A simple mock algorithm to calculate "Goal Goal" (both teams score) probability
    // Higher attack vs lower defense increases chances.
    
    // Home team chance to score
    double homeScoreChance = (_homeAttackRating * 1.5) - (_awayDefenseRating * 0.8);
    // Away team chance to score
    double awayScoreChance = (_awayAttackRating * 1.5) - (_homeDefenseRating * 0.8);
    
    // Normalize chances between 0 and 1
    double normHome = max(0.1, min(homeScoreChance / 10.0, 0.95));
    double normAway = max(0.1, min(awayScoreChance / 10.0, 0.95));

    // Probability of BOTH scoring (independent events for this simple model)
    double ggProbability = normHome * normAway;
    
    // Add a little randomness to make it feel more "predictive"
    double randomFactor = (Random().nextDouble() * 0.1) - 0.05;
    ggProbability = max(0.01, min(ggProbability + randomFactor, 0.99));

    setState(() {
      _predictionResult = ggProbability * 100;
      if (_predictionResult! > 75) {
        _predictionMessage = "Highly Likely! Both teams have strong attacks and shaky defenses.";
      } else if (_predictionResult! > 55) {
        _predictionMessage = "Probable. A competitive match with good chances at both ends.";
      } else if (_predictionResult! > 35) {
        _predictionMessage = "Unlikely. Defenses might dominate or one team might struggle to score.";
      } else {
        _predictionMessage = "Highly Unlikely. Expect a tight, low-scoring game.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GG Predictor'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Predict if Both Teams Will Score (GG)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                
                // Home Team Section
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Home Team', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _homeTeamController,
                          decoration: const InputDecoration(
                            labelText: 'Team Name',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.home),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter home team name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text('Attack Rating (1-10)'),
                        Slider(
                          value: _homeAttackRating,
                          min: 1,
                          max: 10,
                          divisions: 9,
                          label: _homeAttackRating.round().toString(),
                          onChanged: (value) => setState(() => _homeAttackRating = value),
                        ),
                        const Text('Defense Rating (1-10)'),
                        Slider(
                          value: _homeDefenseRating,
                          min: 1,
                          max: 10,
                          divisions: 9,
                          label: _homeDefenseRating.round().toString(),
                          onChanged: (value) => setState(() => _homeDefenseRating = value),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Away Team Section
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Away Team', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _awayTeamController,
                          decoration: const InputDecoration(
                            labelText: 'Team Name',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.flight_takeoff),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter away team name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text('Attack Rating (1-10)'),
                        Slider(
                          value: _awayAttackRating,
                          min: 1,
                          max: 10,
                          divisions: 9,
                          label: _awayAttackRating.round().toString(),
                          onChanged: (value) => setState(() => _awayAttackRating = value),
                        ),
                        const Text('Defense Rating (1-10)'),
                        Slider(
                          value: _awayDefenseRating,
                          min: 1,
                          max: 10,
                          divisions: 9,
                          label: _awayDefenseRating.round().toString(),
                          onChanged: (value) => setState(() => _awayDefenseRating = value),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                FilledButton.icon(
                  onPressed: _calculatePrediction,
                  icon: const Icon(Icons.analytics),
                  label: const Text('Calculate GG Probability', style: TextStyle(fontSize: 16)),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                if (_predictionResult != null)
                  Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text(
                            '${_homeTeamController.text} vs ${_awayTeamController.text}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Goal Goal (GG) Probability:',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${_predictionResult!.toStringAsFixed(1)}%',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _predictionMessage ?? '',
                            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
