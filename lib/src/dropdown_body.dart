part of '../magic_dropdown_search.dart';

class DropDownSearchBody extends StatefulWidget {
  final String? hintSearch;
  final String? initValue;
  final ValueChanged<String?>? onChanged;
  final double? dropdownHeight;
  final double? itemHeight;
  List<String> dropdownItems;
  final Future<List<String>> Function(String) onChangedSearch;

  DropDownSearchBody({
    super.key,
    this.initValue,
    this.hintSearch,
    this.onChanged,
    this.dropdownHeight,
    this.itemHeight,
    required this.dropdownItems,
    required this.onChangedSearch,
  });

  @override
  State<DropDownSearchBody> createState() => _DropDownSearchBodyState();
}

class _DropDownSearchBodyState extends State<DropDownSearchBody> {
  late bool isSelecting;
  late String? value;
  late TextEditingController _searchController;
  String searchQuery = '';
  bool isSearching = false;
  ValueNotifier<List<String>> searchItemsNotifier =
      ValueNotifier<List<String>>([]);

  @override
  void initState() {
    _initValue();
    _searchController = TextEditingController();
    onChangSearch('');
    super.initState();
  }

  void _initValue() {
    if (mounted) {
      isSelecting = widget.initValue != null;
      value = widget.initValue;
      searchItemsNotifier.value = widget.dropdownItems;
      setState(() {});
    }
  }

  void onChanged(String? v) {
    value = v;
    if (v == null) {
      isSelecting = false;
    } else {
      isSelecting = true;
    }
    widget.onChanged!(v);
    setState(() {});
  }

  Future<void> onChangSearch(String value) async {
    try {
      searchQuery = value;
      isSearching = true;
      setState(() {});
      searchItemsNotifier.value = await widget.onChangedSearch(value);
      isSearching = false;
      setState(() {});
    } catch (e, s) {
      debugPrint('Error on search: $e $s');
    }
  }

  Future<void> onClearSearch() async {
    try {
      searchQuery = '';
      isSearching = true;
      _searchController.clear();
      setState(() {});
      searchItemsNotifier.value = await widget.onChangedSearch('');
      isSearching = false;
      setState(() {});
    } catch (e, s) {
      debugPrint('Error on clear search: $e $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.dropdownHeight ?? 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //TODO: Search Bar
          _customSearchFormField(),
          const SizedBox(height: 10),
          //TODO: List of Items
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: searchItemsNotifier,
              builder: (context, items, child) {
                if (isSearching) return _loading();
                if (items.isEmpty) return _emptyList();
                return ListView.separated(
                  itemCount: items.length,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isSelected = item == value;
                    return InkWell(
                      onTap: () {
                        onChanged(isSelected ? null : item);
                        Navigator.pop(context, item);
                      },
                      child: _customListView(item, isSelected),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _customSearchFormField() {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      child: TextFormField(
        onChanged: onChangSearch,
        controller: _searchController,
        onTapOutside: (details) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          hintText: widget.hintSearch ?? 'Search',
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: const Color(0xffF4F4F4),
          hintStyle: const TextStyle(color: Color(0xff99999999)),
          prefixIcon:
              const Icon(Icons.search, color: Color(0xff99999999), size: 23),
          suffixIcon: AnimatedOpacity(
            opacity: searchQuery.isNotEmpty ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: IconButton(
              onPressed: onClearSearch,
              icon: const Icon(
                Icons.clear,
                size: 20,
                color: Color(0xff99999999),
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _customListView(String item, bool isSelected) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          if (isSelected) ...[
            const Icon(
              FontAwesomeIcons.check,
              size: 16,
              color: Color(0xff111111),
            ),
            const SizedBox(width: 7.5),
          ],
          Expanded(
            child: Text(
              item,
              maxLines: 3,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: const Color(0xff111111), fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyList() {
    return const Center(
      child: Text('No items found'),
    );
  }

  Widget _loading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        itemCount: 5,
        padding: const EdgeInsets.symmetric(vertical: 5),
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.centerLeft,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 50,
          );
        },
      ),
    );
  }
}
