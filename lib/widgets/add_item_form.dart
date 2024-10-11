// lib/widgets/add_item_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../utils/constants.dart';

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
          mainAxisSize: MainAxisSize.min,
          children: [
            FormBuilderTextField(
              name: 'itemText',
              initialValue: initialItemText,
              decoration: InputDecoration(
                  labelText: Constants.itemText,
                  icon: const Icon(Icons.text_fields),
                  border: const OutlineInputBorder()),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              name: 'imageUrl',
              initialValue: initialImageUrl,
              decoration: InputDecoration(
                  labelText: Constants.imageUrl,
                  icon: const Icon(Icons.image),
                  border: const OutlineInputBorder()),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.url(),
              ]),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final itemText =
                        _formKey.currentState?.fields['itemText']?.value;
                    final imageUrl =
                        _formKey.currentState?.fields['imageUrl']?.value;
                    onSubmit(itemText ?? '', imageUrl ?? '');
                  }
                },
                child: const Text(Constants.saveVisionItem),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
