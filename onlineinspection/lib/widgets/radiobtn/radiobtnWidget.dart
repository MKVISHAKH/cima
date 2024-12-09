import 'package:onlineinspection/core/hook/hook.dart';
import 'package:onlineinspection/model/query/questions/questionresp/additional_info.dart';
import 'package:onlineinspection/provider/additional_info/additional_info_provider.dart';

ValueNotifier<String> selectedFormatNotifier = ValueNotifier<String>('');

class FormatRadioButton extends StatelessWidget {
  final String title;
  final String type; // Use String for activity option
  final TextStyle? txtstyl;
  final Color? color;
  final List<AdditionalInfo> additionalInfo;

  const FormatRadioButton({
    required this.title,
    required this.type,
    required this.txtstyl,
    required this.color,
    required this.additionalInfo,
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

                  Provider.of<AdditionalInfoProvider>(context, listen: false)
                      .updateSelectedInfo(additionalInfo);
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
