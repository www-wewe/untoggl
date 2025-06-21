enum FilterOption {
  all(label: 'All'),
  done(label: 'Done'),
  upcoming(label: 'Upcoming');

  final String label;

  const FilterOption({required this.label});
}
