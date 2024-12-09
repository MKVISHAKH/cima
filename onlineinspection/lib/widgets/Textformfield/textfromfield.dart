import 'package:onlineinspection/core/hook/hook.dart';

class TextInputfield extends StatelessWidget {
  const TextInputfield({
    //add constructor by clicking bulb icon add formal paramaeters
    Key? key,
    required this.label,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    required this.cmncontroller,
   // required this.formkey,
  }) : super(key: key);

  // final IconData icon;
  final String label; // for hintext
  final String hint; // for hintext
  final TextInputType inputType; //for keyboard layout
  final TextInputAction inputAction;
  final TextEditingController cmncontroller;
  //final GlobalKey<FormState> formkey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white60.withOpacity(0.3),
          //borderRadius: BorderRadius.circular(16),
        ),
        child: Theme(
          data: MyTheme.googleFormTheme,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5),
              child: TextFormField(
                controller: cmncontroller,
                style: Theme.of(context).textTheme.headlineLarge,
                keyboardType: inputType,
                textInputAction: inputAction,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: Theme.of(context).textTheme.headlineLarge,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10),
                  //border: InputBorder.none,
                  hintText: hint,
                  hintStyle: Theme.of(context).textTheme.headlineLarge,
                  // prefixIcon: Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Icon(icon, color: Colors.white, size: 15),
                  // ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter $label";
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
