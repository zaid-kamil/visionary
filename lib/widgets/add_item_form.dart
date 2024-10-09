// lib/widgets/add_item_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddItemForm extends StatelessWidget {
  final String initialItemText;
  final String initialImageUrl;
  final Function(String, String) onSubmit;

  const AddItemForm({
    Key? key,
    this.initialItemText = '',
    this.initialImageUrl = '',
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'itemText',
              initialValue: initialItemText,
              decoration: const InputDecoration(labelText: 'Vision Item Text'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            FormBuilderTextField(
              name: 'imageUrl',
              initialValue: initialImageUrl,
              decoration: const InputDecoration(labelText: 'Image URL'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.url(),
              ]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  final itemText =
                      _formKey.currentState?.fields['itemText']?.value;
                  final imageUrl =
                      _formKey.currentState?.fields['imageUrl']?.value;
                  onSubmit(itemText ?? '', imageUrl ?? '');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
