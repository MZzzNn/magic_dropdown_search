part of '../magic_dropdown_search.dart';

class DropDownSearchDialog extends StatefulWidget {
  final Widget body;
  final GlobalKey<FormFieldState<String>> dropdownKey; // Added this

  const DropDownSearchDialog({
    super.key,
    required this.body,
    required this.dropdownKey, // Added this
  });

  static Future<String?> show(
      BuildContext context,
      Widget body,
      GlobalKey<FormFieldState<String>> dropdownKey, // Added this
      ) async {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.05),
      builder: (context) {
        return DropDownSearchDialog(body: body, dropdownKey: dropdownKey); // Pass the key
      },
    );
  }

  @override
  State<DropDownSearchDialog> createState() => _DropDownSearchDialogState();
}

class _DropDownSearchDialogState extends State<DropDownSearchDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Offset _getPosition(BuildContext context) {
    RenderBox renderBox =
    widget.dropdownKey.currentContext!.findRenderObject() as RenderBox; // Use the key from the widget
    Offset position = renderBox.localToGlobal(Offset.zero);
    return position;
  }

  Size _getSize(BuildContext context) {
    RenderBox renderBox =
    widget.dropdownKey.currentContext!.findRenderObject() as RenderBox; // Use the key from the widget
    return renderBox.size;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _getPosition(context).dy + 35,
          left: _getPosition(context).dx,
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color.fromRGBO(42, 140, 255, 0.1)),
            ),
            child: FadeTransition(
              opacity: _animation,
              child: SizeTransition(
                sizeFactor: _animation,
                axisAlignment: 0.0,
                child: Container(
                  width: _getSize(context).width,
                  padding: const EdgeInsets.all(10),
                  child: widget.body,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
