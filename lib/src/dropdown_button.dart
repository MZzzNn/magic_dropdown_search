part of '../magic_dropdown_search.dart';

@immutable
class MagicDropdownSearch extends StatefulWidget {
  final String? hintSearch;
  final String? initValue;
  final ValueChanged<String?>? onChanged;
  final double? dropdownHeight;
  final double? itemHeight;
  final List<String> dropdownItems;
  final Future<List<String>> Function(String) onChangedSearch;
  final bool isCanNotSelect;
  final String notSelectedText;
  final Widget? empty;
  final InputDecoration? buttonDecoration;
  final InputDecoration? searchDecoration;

  const MagicDropdownSearch({
    required this.onChanged,
    required this.onChangedSearch,
    this.dropdownItems = const [],
    this.hintSearch,
    this.initValue,
    this.itemHeight,
    this.dropdownHeight,
    this.isCanNotSelect = false,
    this.notSelectedText = '--Bitte wählen--',
    this.empty,
    this.buttonDecoration,
    this.searchDecoration,
    super.key,
  });

  @override
  State<MagicDropdownSearch> createState() => _MagicDropdownSearchState();
}

class _MagicDropdownSearchState extends State<MagicDropdownSearch> {
  late bool isSelecting;
  late String? value;
  final GlobalKey<FormFieldState<String>> dropdownGlobalKey =
      GlobalKey<FormFieldState<String>>();

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
            onChangedSearch: widget.onChangedSearch,
            dropdownItems: widget.dropdownItems,
            itemHeight: widget.itemHeight,
            dropdownHeight: widget.dropdownHeight,
            initValue: value,
            isCanNotSelect: widget.isCanNotSelect,
            notSelectedText: widget.notSelectedText,
            empty: widget.empty,
            searchDecoration: widget.searchDecoration,
          ),
          dropdownGlobalKey, // Pass the key
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
              color: isSelecting
                  ? const Color(0xff111111)
                  : const Color(0xff767676),
            ),
        controller: TextEditingController(text: value),
        minLines: 1,
        maxLines: 5,
        decoration: decoration,
      ),
    );
  }

  InputDecoration get decoration {
    if (widget.buttonDecoration != null) {
      return widget.buttonDecoration!.copyWith(
        enabled: false,
        contentPadding: widget.buttonDecoration?.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        disabledBorder: widget.buttonDecoration?.disabledBorder ??
            const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xffD2D5DA)),
            ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: widget.buttonDecoration?.suffixIcon ??
              const Icon(
                FontAwesomeIcons.angleDown,
                size: 17,
                color: Color(0xff767676),
              ),
        ),
      );
    } else {
      return const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        enabled: false,
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        hintStyle:
            TextStyle(color: Color(0xff767676), fontWeight: FontWeight.w400),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        constraints: BoxConstraints(minHeight: 45),
        suffixIconConstraints: BoxConstraints(minHeight: 45),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xffD2D5DA)),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            FontAwesomeIcons.angleDown,
            size: 17,
            color: Color(0xff767676),
          ),
        ),
      );
    }
  }
}
