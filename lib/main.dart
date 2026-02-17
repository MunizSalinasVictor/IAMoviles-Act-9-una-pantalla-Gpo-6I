import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CrunchyrollScreen(),
  ),
);

class CrunchyrollScreen extends StatefulWidget {
  const CrunchyrollScreen({super.key});

  @override
  State<CrunchyrollScreen> createState() => _CrunchyrollScreenState();
}

class _CrunchyrollScreenState extends State<CrunchyrollScreen> {
  bool _isPlaying = false;
  bool _showControls = true;
  Duration _position = const Duration(minutes: 15, seconds: 30);
  final Duration _duration = const Duration(minutes: 24, seconds: 30);

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  void _simularCompartir(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              "Compartir episodio",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialIcon(Icons.message, "WhatsApp", Colors.green),
                _buildSocialIcon(Icons.camera_alt, "Instagram", Colors.pink),
                _buildSocialIcon(Icons.link, "Copiar", Colors.blue),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.file_present, color: Colors.white, size: 28),
            const SizedBox(width: 8),
            Text(
              'Crunchyroll Victor',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrangeAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 20, bottom: 10),
            child: Text(
              "Seguir Viendo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          // REPRODUCTOR ESTÁTICO (SOLO DISEÑO)
          Container(
            width: double.infinity,
            height: 220,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://raw.githubusercontent.com/MunizSalinasVictor/Video-App-Crunchyroll/refs/heads/main/satoru-gojo.jpg',
                ),
                fit: BoxFit.cover,
                opacity: 0.4,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GestureDetector(
                onTap: _toggleControls,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    
                    if (_showControls) ...[
                      Container(
                        color: Colors.black.withValues(alpha: 0.3),
                      ),
                      
                      Center(
                        child: IconButton(
                          iconSize: 70,
                          icon: Icon(
                            _isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            color: Colors.orange,
                          ),
                          onPressed: _togglePlayPause,
                        ),
                      ),
                      
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.7),
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                  overlayShape: SliderComponentShape.noOverlay,
                                  activeTrackColor: Colors.orange,
                                  inactiveTrackColor: Colors.white38,
                                  thumbColor: Colors.orange,
                                ),
                                child: Slider(
                                  value: _position.inSeconds.toDouble(),
                                  min: 0.0,
                                  max: _duration.inSeconds.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      _position = Duration(seconds: value.toInt());
                                    });
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDuration(_position),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    _formatDuration(_duration),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // INFORMACIÓN Y BOTONES
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Jujutsu Kaisen",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "T2 E9: El incidente de Shibuya - Apertura del portal • 24 min",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 25),

                // BOTONES
                Row(
                  children: [
                    _miniButton(Icons.add, "Mi lista", () {}),
                    const SizedBox(width: 15),
                    _miniButton(
                      Icons.share,
                      "Compartir",
                      () => _simularCompartir(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniButton(IconData icon, String label, VoidCallback action) {
    return InkWell(
      onTap: action,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF2B2B2B),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}