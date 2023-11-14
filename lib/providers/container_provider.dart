import 'package:flutter/material.dart';

class ContainerProvider extends StatefulWidget {
  final double horizontal;
  final double vertical;
  final Widget child;


  const ContainerProvider(
      {Key? key,
        required this.horizontal,
        required this.vertical,
        required this.child,
      }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContainerProviderState createState() => _ContainerProviderState();
}

class _ContainerProviderState extends State<ContainerProvider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: widget.horizontal, vertical: widget.vertical),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white70,
          ],
        ),
      ),
      child: widget.child,
    );
  }
}