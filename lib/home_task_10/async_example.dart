import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AsyncExample extends StatefulWidget {
  const AsyncExample({super.key});

  @override
  State<AsyncExample> createState() => _AsyncExampleState();
}

class _AsyncExampleState extends State<AsyncExample> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _chat = [];
  bool _isSending = false;

  Stream<int>? _stream;
  StreamSubscription<int>? _subscription;

  int? latestValue;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  Future<String> simulateChatResponse(String question) async {
    final q = question.toLowerCase();
    final delay = Duration(seconds: 2 + Random().nextInt(3));

    if (q.contains('погано')) {
      await Future.delayed(delay);
      throw Exception('Щось пішло не так! Спробуйте ще раз.');
    }

    if (q.contains('добре')) {
      await Future.delayed(delay);
      return 'Я радий, що вам подобається!';
    }

    if (q.contains('яка погода')) {
      await Future.delayed(Duration(seconds: 5));
      final temp = -10 + Random().nextInt(45);
      return 'Поточна температура: $temp\u00B0C';
    }

    await Future.delayed(delay);
    return 'Відповідь на ваше питання: "$question"';
  }

  Future<void> _sendQuestion() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _chat.add('Ви: $text');
      _isSending = true;
      _controller.clear();
    });

    try {
      final response = await simulateChatResponse(text);
      setState(() {
        _chat.add('Бот: $response');
      });
    } catch (e) {
      setState(() {
        _chat.add(
            'Бот (помилка): ${e.toString().replaceAll("Exception: ", "")}');
      });
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  Stream<int> countdownTimer({int from = 10}) async* {
    while (from >= 0) {
      await Future.delayed(Duration(seconds: 1));
      yield from;
      from--;
    }
    // await Future.delayed(Duration(seconds: 1));
    // yield 0;
  }

  Stream<int> generateRealTimeData() async* {
    final random = Random();

    while (true) {
      await Future.delayed(Duration(seconds: 2));

      int value = random.nextInt(100) + 1;

      if (value > 90) {
        throw Exception("Сталася помилка: значення > 90");
      }

      yield value;
    }
  }

  void startStream() {
    _stream = generateRealTimeData();

    _subscription = _stream!.listen(
      (data) {
        setState(() {
          latestValue = data;
          errorMessage = null;
        });
      },
      onError: (err) {
        setState(() {
          errorMessage = err.toString();
        });
      },
    );
  }

  void stopStream() {
    _subscription?.cancel();
    setState(() {
      latestValue = null;
      errorMessage = null;
    });
  }

  Future<String> fetchDataFromApi(
      {required void Function(String) onStatus}) async {
    final rnd = Random();

    onStatus('Етап 1: Ініціалізація...');
    await Future.delayed(Duration(seconds: 2));
    onStatus('Етап 1: Завершено');

    onStatus('Етап 2: Запит до API...');
    await Future.delayed(Duration(seconds: 1));
    if (rnd.nextInt(100) < 10) {
      onStatus('Етап 2: Помилка під час запиту');
      throw Exception('API помилка на етапі 2');
    }
    onStatus('Етап 2: Успіх');

    onStatus('Етап 3: Обробка результату...');
    await Future.delayed(Duration(seconds: 3));
    onStatus('Етап 3: Готово');

    return 'Результат API: {"value": ${rnd.nextInt(1000)}}';
  }

  bool _fetchInProgress = false;
  String _fetchLog = '';

  void _startFetch() async {
    setState(() {
      _fetchInProgress = true;
      _fetchLog = '';
    });
    try {
      final result = await fetchDataFromApi(onStatus: (s) {
        setState(() {
          _fetchLog += '$s\n';
        });
      });
      setState(() {
        _fetchLog += 'Успіх: $result\n';
      });
    } catch (e) {
      setState(() {
        _fetchLog += 'Помилка: ${e.toString().replaceAll('Exception: ', '')}\n';
      });
    } finally {
      setState(() {
        _fetchInProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Async Demo")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1. Чат-бот', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Container(
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: _chat.length,
                itemBuilder: (_, i) => Text(_chat[i]),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: _controller,
                      decoration:
                          InputDecoration(hintText: 'Напишіть питання...')),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _isSending ? null : _sendQuestion,
                  child: _isSending
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : Text('Відправити'),
                ),
              ],
            ),
            Divider(height: 32),
            Text('2. Асинхронний таймер',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            StreamBuilder<int>(
              stream: countdownTimer(from: 10),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Помилка таймера: ${snapshot.error}');
                }
                if (!snapshot.hasData) return Text('Готуємось...');
                final v = snapshot.data;
                if (v == 0) {
                  return Text(
                    'Таймер завершено!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  );
                }
                return Text(
                  'Залишилось: $v c',
                  style: TextStyle(fontSize: 18),
                );
              },
            ),
            Divider(height: 32),
            Text('3. Імітація потокової обробки даних (Real-Time Data)',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              latestValue != null
                  ? "Отримані дані: $latestValue"
                  : "Натисніть 'Почати'",
              style: TextStyle(fontSize: 22),
            ),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: startStream,
                  child: Text("Почати"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: stopStream,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
                  child: Text("Зупинити"),
                ),
              ],
            ),
            Divider(height: 32),
            Text('4. Імітація асинхронного API з багатьма етапами',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ElevatedButton(
                onPressed: _fetchInProgress ? null : _startFetch,
                child: Text('Запустити fetch')),
            SizedBox(height: 8),
            Container(
              height: 160,
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                  child: Text(_fetchLog.isEmpty ? 'Логи відсутні' : _fetchLog)),
            ),
          ],
        ),
      ),
    );
  }
}
