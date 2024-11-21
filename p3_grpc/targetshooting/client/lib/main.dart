import 'package:flutter/material.dart';
import 'package:client_rpc/generated/google/protobuf/empty.pb.dart';
import 'package:client_rpc/generated/shooting.pbgrpc.dart';
import 'package:grpc/grpc.dart';

void main() {
  runApp(const ShootingApp());
}

class ShootingApp extends StatelessWidget {
  // Constructor con key
  const ShootingApp({super.key}); // Uso de super.key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Save Humanity - Cannon Shooter',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Roboto',
            ),
      ),
      home: const ShootingScreen(),
    );
  }
}

class ShootingScreen extends StatefulWidget {
  const ShootingScreen({super.key}); // Uso de super.key
  @override
  ShootingScreenState createState() => ShootingScreenState();
}

class ShootingScreenState extends State<ShootingScreen> {
  final ClientChannel channel = ClientChannel(
    '172.18.49.133',
    port: 50051,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );

  late ShootingClient stub;
  String log = 'Initializing connection...\n';
  String bestShot = '';

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _angleController = TextEditingController();
  final TextEditingController _speedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    stub = ShootingClient(channel);
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      final responseCentro = await stub.dimeCentroDiana(Empty());
      setState(() {
        log += 'Random Distance to Center: ${responseCentro.distance}\n';
      });
    } catch (e) {
      setState(() {
        log += 'Error fetching center: $e\n';
      });
    }
  }

  Future<void> _shootCannon() async {
    final username = _usernameController.text.trim();
    final angle = double.tryParse(_angleController.text.trim());
    final speed = double.tryParse(_speedController.text.trim());

    if (username.isEmpty || angle == null || speed == null) {
      setState(() {
        log += 'Error: Invalid input.\n';
      });
      return;
    }

    try {
      final response = await stub.disparaCannon(
        DisparaRequest(
            username: username, angle: angle.toInt(), speed: speed.toInt()),
      );
      setState(() {
        log +=
            'Shot by $username | Angle: $angle° | Speed: $speed | Distance: ${response.shootDistance.toStringAsFixed(2)}\n';
      });
    } catch (e) {
      setState(() {
        log += 'Error: $e\n';
      });
    }
  }

  Future<void> _fetchBestShot() async {
    try {
      final response = await stub.mejorDisparo(Empty());
      setState(() {
        bestShot = 'Best Shot: ${response.username}';
      });
    } catch (e) {
      setState(() {
        bestShot = 'Error fetching best shot: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cannon Shooter'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello Humanity 🗿',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _angleController,
              decoration: const InputDecoration(
                labelText: 'Angle (°)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _speedController,
              decoration: const InputDecoration(
                labelText: 'Speed',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _shootCannon,
                    child: const Text('Shoot Cannon'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _fetchBestShot,
                    child: const Text('Best Shot'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              bestShot,
              style: const TextStyle(fontSize: 18, color: Colors.tealAccent),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  log,
                  style:
                      const TextStyle(fontFamily: 'RobotoMono', fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _angleController.dispose();
    _speedController.dispose();
    channel.shutdown();
    super.dispose();
  }
}
