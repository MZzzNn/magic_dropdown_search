part of '../magic_dropdown_search.dart';

final GlobalKey<FormFieldState<String>> dropdownGlobalKey =
    GlobalKey<FormFieldState<String>>();

@immutable
class MagicDropdownSearch extends StatefulWidget {
  final String label;
  final String? hint;
  final String? hintSearch;
  final String? initValue;
  final ValueChanged<String?>? onChanged;
  final double? buttonHeight, buttonWidth;
  final double? dropdownHeight;
  final double? itemHeight;
  final List<String> dropdownItems;
  final Future<List<String>> Function(String) onChangedSearch;
  final Widget? suffixIcon;
  final bool isCanNotSelect;
  final String notSelectedText;
  final Widget? empty;
  const MagicDropdownSearch({
    required this.label,
    required this.onChanged,
    required this.onChangedSearch,
    this.dropdownItems = const [],
    this.hint,
    this.hintSearch,
    this.initValue,
    this.buttonWidth,
    this.itemHeight,
    this.dropdownHeight,
    this.buttonHeight,
    this.suffixIcon,
    this.isCanNotSelect = false,
    this.notSelectedText = '--Bitte wählen--',
    this.empty,
    Key? key,
  }) : super(key: key);

  @override
  State<MagicDropdownSearch> createState() => _MagicDropdownSearchState();
}

class _MagicDropdownSearchState extends State<MagicDropdownSearch> {
  late bool isSelecting;
  late String? value;

  @override
  void initState() {
    _initValue();
    super.initState();
  }

  void _initValue() {
    if (mounted) {
      isSelecting = false;
      value = widget.initValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? v = await DropDownSearchDialog.show(
          context,
          DropDownSearchBody(
            onChanged: widget.onChanged,
            hintSearch: widget.hintSearch,
            onChangedSearch: widget.onChangedSearch,
            dropdownItems: widget.dropdownItems,
            itemHeight: widget.itemHeight,
            dropdownHeight: widget.dropdownHeight,
            initValue: value,
            isCanNotSelect: widget.isCanNotSelect,
            notSelectedText: widget.notSelectedText,
            empty: widget.empty,
          ),
        );
        if (v != null) {
          value = v;
          isSelecting = true;
        }
        if (value == null) {
          isSelecting = false;
        }
        setState(() {});
      },
      child: TextFormField(
        key: dropdownGlobalKey,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: isSelecting == true ? null : 11,
              color: isSelecting ? const Color(0xff111111) : const Color(0xff767676),
            ),
        controller: TextEditingController(text: value),
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          labelText: widget.label,
          hintText: widget.hint,
          enabled: false,
          isDense: true,
          hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: const Color(0xff767676), fontWeight: FontWeight.w400),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          constraints: BoxConstraints(
            // maxHeight: buttonHeight ?? double.infinity,
            minHeight: widget.buttonHeight ?? 45,
          ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: widget.buttonHeight ?? double.infinity,
            minHeight: widget.buttonHeight ?? 45,
          ),
          // prefixIconConstraints: BoxConstraints(
          //   maxHeight: buttonHeight ?? 70,
          //   maxWidth: buttonHeight ?? 70,
          // ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Color(0xffD2D5DA)),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: widget.suffixIcon ??
                const Icon(
                  FontAwesomeIcons.angleDown,
                  size: 17,
                  color: Color(0xff767676),
                ),
          ),
        ),
      ),
    );
  }
}
