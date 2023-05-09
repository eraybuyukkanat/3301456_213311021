import 'dart:async';

import 'package:flutter/material.dart';

class customFormField extends StatelessWidget {
  const customFormField({
    Key? key,
    required StreamController<bool>? isPasswordVisibleController,
    required TextEditingController? newpasswdTextEditingController,
  })  : _isPasswordVisibleController = isPasswordVisibleController,
        _newpasswdTextEditingController = newpasswdTextEditingController,
        super(key: key);

  final StreamController<bool>? _isPasswordVisibleController;
  final TextEditingController? _newpasswdTextEditingController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: true,
        stream: _isPasswordVisibleController!.stream,
        builder: (context, isVisible) {
          return StreamBuilder<String?>(builder: (context, snapshot) {
            return TextFormField(
              controller: _newpasswdTextEditingController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: isVisible.data!,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorText: snapshot.data,
                suffixIcon: IconButton(
                  icon: isVisible.data!
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  onPressed: () {
                    _isPasswordVisibleController!.sink.add(!isVisible.data!);
                  },
                ),
              ),
            );
          });
        });
  }
}
