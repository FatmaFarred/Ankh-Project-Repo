import 'package:flutter/material.dart';

class FullImageViewScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullImageViewScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullImageViewScreen> createState() => _FullImageViewScreenState();
}

class _FullImageViewScreenState extends State<FullImageViewScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final img = widget.images[index];
              return InteractiveViewer(
                child: Center(
                  child: Hero(
                    tag: img,
                    child: Image.network(
                      img,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
