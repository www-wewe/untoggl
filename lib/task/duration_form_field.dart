import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';

class DurationFormField extends FormField<Duration> {
  DurationFormField({
    super.key,
    required FormFieldSetter<Duration> onSaved,
    required FormFieldValidator<Duration> validator,
    required Duration initialValue,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<Duration> state) {
            return InkWell(
              onTap: () async {
                final Duration? picked = await showDurationPicker(
                  context: state.context,
                  initialTime: state.value!,
                );
                if (picked != null) {
                  state.didChange(picked);
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Duration',
                  errorText: state.errorText,
                  icon: const Icon(Icons.timer),
                ),
                child: Text('${state.value!.inMinutes} minutes'),
              ),
            );
          },
        );
}
