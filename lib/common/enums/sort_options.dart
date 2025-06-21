enum SortOption {
  time(label: 'Time'),
  name(label: 'Name'),
  team(label: 'Team');

  final String label;

  const SortOption({required this.label});
}
