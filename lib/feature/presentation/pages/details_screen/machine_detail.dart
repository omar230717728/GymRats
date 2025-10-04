import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/utils/machine.dart';
import 'package:flutter_application_1/feature/cubit/favorite_state.dart';
import 'package:flutter_application_1/feature/cubit/favorites_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MachineDetailScreen extends StatefulWidget {
  final Machine machine;

  const MachineDetailScreen({Key? key, required this.machine})
    : super(key: key);

  @override
  _MachineDetailScreenState createState() => _MachineDetailScreenState();
}

class _MachineDetailScreenState extends State<MachineDetailScreen>
    with WidgetsBindingObserver {
  bool isLandscape = false;

  void _toggleFavorite(BuildContext context) {
    context.read<FavoritesCubit>().toggleFavorite(widget.machine);
  }

  bool _isFavorite(BuildContext context) {
    return context.read<FavoritesCubit>().isFavorite(widget.machine);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Always restore system UI when leaving the screen
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: SystemUiOverlay.values,
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final orientation = MediaQuery.of(context).orientation;
    setState(() {
      isLandscape = orientation == Orientation.landscape;
    });

    if (isLandscape) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  void _toggleFullScreen() {
    if (isLandscape) {
      // When exiting full-screen, show system UI
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
        overlays: SystemUiOverlay.values,
      );
    } else {
      // When entering full-screen, hide system UI
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final isFavorite = _isFavorite(context);
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: isLandscape ? _buildLandscapeView() : _buildPortraitView(context, isFavorite),
        );
      },
    );
  }

  Widget _buildPortraitView(BuildContext context, bool isFavorite) {
    return Column(
      children: [
        // Video Section
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: _toggleFullScreen,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  // Placeholder for video - replace with actual video player
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_circle_filled,
                          size: 60,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Tap to play video',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  // Fullscreen button
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      onPressed: _toggleFullScreen,
                      icon: Icon(Icons.fullscreen, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Content Section
        Expanded(flex: 3, child: _buildContent(context, isFavorite)),
      ],
    );
  }

  Widget _buildLandscapeView() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          'Video playing in landscape mode',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isFavorite) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.machine.name,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _toggleFavorite(context);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onBackground,
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Description',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.machine.description,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(
                context,
              ).colorScheme.onBackground.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Instructions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          SizedBox(height: 10),
          // Add instructions list here
          _buildInstructionStep('1. Adjust the machine to your body size'),
          _buildInstructionStep('2. Set the appropriate weight'),
          _buildInstructionStep('3. Maintain proper form throughout'),
          _buildInstructionStep('4. Complete 3 sets of 10-12 reps'),
          SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.fiber_manual_record,
            size: 8,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(
                  context,
                ).colorScheme.onBackground.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
