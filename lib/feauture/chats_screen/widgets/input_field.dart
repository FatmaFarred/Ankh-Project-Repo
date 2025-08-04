import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final Function(String) onMessageSent;
  
  const InputField({super.key, required this.onMessageSent});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      widget.onMessageSent(message);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add,color: ColorManager.lightprimary,)),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xfff0f0f3),
              ),
              child: TextFormField(
                controller: _messageController,
                style: TextStyle(color: ColorManager.black),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Type a Message ...",
                  hintStyle: TextStyle(color: ColorManager.hintColor),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onFieldSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: _sendMessage,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorManager.lightprimary,
              ),
              child: Icon(Icons.send_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
