import 'package:flutter/material.dart';
import 'package:legal_tech/core/widgets/global_text.dart';

class MoreMenuItem {
  final IconData icon;
  final String label;
  final bool isLocked;
  final VoidCallback? onTap;

  const MoreMenuItem({
    required this.icon,
    required this.label,
    this.isLocked = false,
    this.onTap,
  });
}

void showMorePopup(BuildContext context, GlobalKey moreTabKey) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  final items = <MoreMenuItem>[
    MoreMenuItem(icon: Icons.bolt, label: 'Question Rush', onTap: () {}),
    MoreMenuItem(
      icon: Icons.help_outline_rounded,
      label: 'Questions',
      onTap: () {},
    ),
    const MoreMenuItem(
      icon: Icons.text_fields_rounded,
      label: 'Vocabulary',
      isLocked: true,
    ),
    MoreMenuItem(
      icon: Icons.emoji_events_rounded,
      label: 'Competitions',
      onTap: () {},
    ),
    const MoreMenuItem(
      icon: Icons.smart_toy_outlined,
      label: 'Support AI',
      isLocked: true,
    ),
    const MoreMenuItem(
      icon: Icons.people_outline_rounded,
      label: 'Mentors',
      isLocked: true,
    ),
    MoreMenuItem(
      icon: Icons.settings_outlined,
      label: 'Settings',
      onTap: () {},
    ),
    MoreMenuItem(icon: Icons.tune_rounded, label: 'Customize', onTap: () {}),
  ];

  entry = OverlayEntry(
    builder: (ctx) => _MorePopupOverlay(
      moreTabKey: moreTabKey,
      items: items,
      onDismiss: () => entry.remove(),
    ),
  );

  overlay.insert(entry);
}

class _MorePopupOverlay extends StatefulWidget {
  final GlobalKey moreTabKey;
  final List<MoreMenuItem> items;
  final VoidCallback onDismiss;

  const _MorePopupOverlay({
    required this.moreTabKey,
    required this.items,
    required this.onDismiss,
  });

  @override
  State<_MorePopupOverlay> createState() => _MorePopupOverlayState();
}

class _MorePopupOverlayState extends State<_MorePopupOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _fade;

  static const double _popupWidth = 260;
  static const double _popupRightPadding = 12;
  static const double _popupBottomPadding = 12;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack);
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  Future<void> _dismiss() async {
    await _ctrl.reverse();
    widget.onDismiss();
  }

  Rect? _getMoreTabRect() {
    final renderBox =
        widget.moreTabKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;
    final offset = renderBox.localToGlobal(Offset.zero);
    return offset & renderBox.size;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final tabRect = _getMoreTabRect();
    final double popupBottom = tabRect != null
        ? screen.height - tabRect.top + 8
        : 90;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _dismiss,
      child: Stack(
        children: [
          Positioned(
            right: _popupRightPadding,
            bottom: popupBottom + _popupBottomPadding,
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {},
                  child: _PopupCard(
                    width: _popupWidth,
                    items: widget.items,
                    onItemTap: (item) {
                      _dismiss();
                      item.onTap?.call();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PopupCard extends StatelessWidget {
  final double width;
  final List<MoreMenuItem> items;
  final void Function(MoreMenuItem) onItemTap;

  const _PopupCard({
    required this.width,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(20),
      color: Theme.of(context).cardColor,
      child: SizedBox(
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(items.length, (i) {
              final item = items[i];
              BorderRadius? borderRadius;
              if (i == 0) {
                borderRadius = const BorderRadius.vertical(
                  top: Radius.circular(20),
                );
              } else if (i == items.length - 1) {
                borderRadius = const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                );
              } else {
                borderRadius = BorderRadius.zero;
              }
              return _PopupItem(
                item: item,
                showDivider: i < items.length - 1,
                onTap: item.isLocked ? null : () => onItemTap(item),
                borderRadius: borderRadius,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _PopupItem extends StatelessWidget {
  final MoreMenuItem item;
  final bool showDivider;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  const _PopupItem({
    required this.item,
    required this.showDivider,
    this.onTap,
    this.borderRadius,
  });

  static const _lockedColor = Color(0xFFB0B8C1);
  static const _lockIconColor = Color(0xFFE57373);

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.onSurface;
    final color = item.isLocked ? _lockedColor : activeColor;

    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                Icon(item.icon, size: 22, color: color),
                const SizedBox(width: 14),
                Expanded(
                  child: GlobalText(
                    text: item.label,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
                if (item.isLocked)
                  const Icon(Icons.lock, size: 16, color: _lockIconColor),
              ],
            ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white10
                  : Colors.grey.shade100,
            ),
        ],
      ),
    );
  }
}
