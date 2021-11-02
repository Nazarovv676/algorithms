class MenuItem {
  final String label;
  final void Function()? onSelect;

  const MenuItem({required this.label, this.onSelect});

  const MenuItem.exit({this.onSelect}) : label = 'Exit';
  const MenuItem.back({this.onSelect}) : label = 'Back';
}
