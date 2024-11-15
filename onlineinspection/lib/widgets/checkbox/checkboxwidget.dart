import 'package:onlineinspection/core/hook/hook.dart';

ValueNotifier<Set<int>> selectedItems = ValueNotifier<Set<int>>({});

class FormatCheckbox extends StatelessWidget {
  final String title;
  final int type;
  final TextStyle? txtstyl;
  final Color? color;
  final ValueNotifier<Set<int>> selectedItems;

  const FormatCheckbox({
    required this.title,
    required this.type,
    required this.txtstyl,
    required this.color,
    required this.selectedItems,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedItems,
          builder: (BuildContext ctx, Set<int> selected, Widget? _) {
            return Checkbox(
              value: selected.contains(type),
              activeColor: color,
              onChanged: (bool? isChecked) {
                if (isChecked == true) {
                  selected.add(type);
                } else {
                  selected.remove(type);
                }
                selectedItems.notifyListeners();
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
      ],
    );
  }
}
