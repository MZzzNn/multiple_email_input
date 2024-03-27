import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'multiple_email_controller.dart';

class MultipleEmailInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextStyle? hintStyle;
  final Color? borderColor;
  final bool showSubmitted;
  final Color? fillColor;
  final bool? filled;
  final bool? enableBorder;

  final Function(List<String>) onChangeEmails;
  final List<String> initEmails;

  const MultipleEmailInput({
    Key? key,
    this.label,
    this.hint,
    this.hintStyle,
    this.borderColor,
    this.showSubmitted = false,
    this.fillColor,
    this.filled,
    this.enableBorder,
    required this.onChangeEmails,
    required this.initEmails,
  }) : super(key: key);

  @override
  _MultipleEmailInputState createState() => _MultipleEmailInputState();
}

class _MultipleEmailInputState extends State<MultipleEmailInput> {
  final _controller = Get.put(MultipleEmailController());


  @override
  initState() {
    super.initState();
    _controller.emails = widget.initEmails;
  }

  @override
  void dispose() {
    _controller.dispose();
    Get.delete<MultipleEmailController>();
    super.dispose();
  }

  void onChangeEmail() {
    _controller.updateEmails();
    widget.onChangeEmails(_controller.emails);
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MultipleEmailController>(
      id: MultipleEmailController.updateEmailId,
      builder: (logic) {
        return Wrap(
          alignment: WrapAlignment.start,
          spacing: 5,
          runSpacing: 5,
          children: <Widget>[
            ..._controller.emails.map(
              (email) => Chip(
                labelPadding: EdgeInsets.zero,
                backgroundColor: const Color(0xffd3d4d5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Color(0xffd3d4d5)),
                ),
                label: Text(
                  email,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                deleteIcon: const Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 16,
                ),
                onDeleted: () {
                  _controller.removeEmail(email);
                  widget.onChangeEmails(_controller.emails);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: widget.fillColor,
                  filled: widget.filled,
                  hintText: widget.hint,
                  labelText: widget.label,
                  suffixIcon: Opacity(
                    opacity: widget.showSubmitted && _controller.emailController.text.isNotEmpty ? 1 : 0,
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: onChangeEmail,
                    ),
                  ),
                ),
                controller: _controller.emailController,
                focusNode: _controller.focus,
                onChanged: (String val) {
                  _controller.onChanged(val);
                  widget.onChangeEmails(_controller.emails);
                },
                onEditingComplete:onChangeEmail,
              ),
            )
          ],
        );
      },
    );
  }
}
