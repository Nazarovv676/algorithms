class MenuItem {
  final String label;
  final void Function()? onSelect;
  final bool reshowAfterCallback;

  const MenuItem({
    required this.label,
    this.onSelect,
    this.reshowAfterCallback = true,
  });

  const MenuItem.exit({
    this.onSelect,
    this.reshowAfterCallback = true,
  }) : label = 'Exit';
}
