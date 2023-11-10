import 'package:flutter/cupertino.dart';

class DropdownTags extends StatefulWidget{
  final Color color;
  final String tag;

  const DropdownTags(
      {Key? key,
        required this.color,
        required this.tag,
      }) : super(key: key);

  @override
  _DropdownTagsState createState() => _DropdownTagsState();

}

class _DropdownTagsState extends State<DropdownTags> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(widget.tag),
        const SizedBox(width: 10,),
        Icon(
          CupertinoIcons.tag_fill,
          color: widget.color,
          size: 26,
        ),
      ],
    );
  }
}