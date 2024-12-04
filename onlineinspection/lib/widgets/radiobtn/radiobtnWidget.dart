import 'package:onlineinspection/core/hook/hook.dart';

ValueNotifier<String> selectedFormatNotifier = ValueNotifier<String>('');

class FormatRadioButton extends StatelessWidget {
  final String title;
  final String type; // Use String for activity option
  final TextStyle? txtstyl;
  final Color? color;

  const FormatRadioButton({
    required this.title,
    required this.type,
    required this.txtstyl,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedFormatNotifier,
          builder: (BuildContext ctx, String selectedType, Widget? _) {
            return Radio<String>(
              value: type,
              groupValue: selectedType,
              activeColor: color,
              onChanged: (value) {
                if (value != null) {
                  selectedFormatNotifier.value = value;
                }
              },
            );
          },
        ),
        Flexible(
          child: Text(
            title,
            maxLines: 2, // Or any number you want
            overflow: TextOverflow.visible,
            softWrap: true,
            style: txtstyl,
          ),
        ),
        // Text(
        //   title,
        //   style: txtstyl,
        // ),
      ],
    );
  }
}
