import 'package:flutter/cupertino.dart';
import 'package:myfinances/entities/tag.dart';

class DropdownTags extends StatefulWidget{
  final Tag tag;

  const DropdownTags(
      {Key? key,
        required this.tag,
      }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DropdownTagsState createState() => _DropdownTagsState();

}

class _DropdownTagsState extends State<DropdownTags> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.tag.name),
        const SizedBox(width: 10,),
        Icon(
          CupertinoIcons.tag_fill,
          color: Color(widget.tag.color),
          size: 26,
        ),
      ],
    );
  }
}