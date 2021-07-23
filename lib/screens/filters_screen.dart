import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget _buildFilterSwitches(
      String title, String subtitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      onChanged: updateValue,
      value: currentValue,
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian
              };
              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your Meal! Make it your own.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildFilterSwitches(
                "Gluten-Free",
                "Meals that don't have any gluten containing products",
                _glutenFree,
                (newValue) => setState(() {
                  _glutenFree = newValue;
                }),
              ),
              _buildFilterSwitches(
                "Lactose-free",
                "Meals that don't have any dairy related products",
                _lactoseFree,
                (newValue) => setState(() {
                  _lactoseFree = newValue;
                }),
              ),
              _buildFilterSwitches(
                "Vegetarian",
                "Meals that are part of vegetarian diet",
                _vegetarian,
                (newValue) => setState(() {
                  _vegetarian = newValue;
                }),
              ),
              _buildFilterSwitches(
                "Vegan",
                "Melas that are completely derived from plants",
                _vegan,
                (newValue) => setState(() {
                  _vegan = newValue;
                }),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
