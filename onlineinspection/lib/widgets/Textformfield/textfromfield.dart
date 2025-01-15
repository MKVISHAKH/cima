import 'package:onlineinspection/core/hook/hook.dart';

class TextInputfield extends StatelessWidget {
  const TextInputfield(
      {Key? key,
      required this.label,
      required this.hint,
      required this.inputType,
      required this.inputAction,
      required this.cmncontroller,
      this.onSaved,
      this.validator,
      this.onChanged,
      this.inputFormatters // Add custom validator
      })
      : super(key: key);

  final String label;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController cmncontroller;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator; // For custom validation rules
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white60.withOpacity(0.3),
        ),
        child: Theme(
          data: MyTheme.googleFormTheme,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5),
              child: TextFormField(
                controller: cmncontroller,
                style: Theme.of(context).textTheme.headlineLarge,
                keyboardType: inputType,
                textInputAction: inputAction,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: Theme.of(context).textTheme.headlineLarge,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: hint,
                  hintStyle: Theme.of(context).textTheme.headlineLarge,
                ),
                validator: validator ??
                    (value) {
                      if (value == null || value.isEmpty) {
                        return "$label is required";
                      }
                      return null;
                    },
                onSaved: onSaved,
                onChanged: onChanged,
                inputFormatters: inputFormatters,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
