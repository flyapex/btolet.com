import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/post/tolet widget/dropdown.dart';

Map<Category, List<String>> categoryData = {
  Category.bedrooms: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"],
  Category.bathrooms: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"],
  Category.dining: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"],
  Category.kitchen: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"],
  Category.floorno: [
    "1 st",
    "2 nd",
    "3 rd",
    "4 th",
    "5 th",
    "6 th",
    "7 th",
    "8 th",
    "9 th",
    "10 th",
  ],
  Category.facing: [
    "East",
    "North",
    "North-East",
    "North-West",
    "South",
    "South-East",
    "South-West",
    "West",
  ],
  Category.garage: [
    "Car",
    "Bike",
  ],
};

class FasalitisModel {
  final RxBool state;
  final IconData icon;

  FasalitisModel({required this.state, required this.icon});
}

//*------------------------------------------ProPerty

var priceType = [
  "Price",
  "Price On Call",
];

var category = [
  'House',
  'Flat/Appartment',
  'Land',
  'Plot',
];
var type = [
  "New",
  "Used",
  "Under Development",
];

var bed = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7+",
];

var bath = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7+",
];
var landType = [
  "Residential",
  "Commercial",
  "Agricultural",
];

var postedBy = [
  "Owner",
  "Agent",
  "Developer",
];

//drop down
enum CategoryPro {
  dining,
  kitchen,
  facing,
  area,
}

Map<CategoryPro, List<String>> categoryProData = {
  CategoryPro.dining: ["1", "2", "3", "4", "5", "6", "7+"],
  CategoryPro.kitchen: ["1", "2", "3", "4", "5", "6", "7+"],
  CategoryPro.facing: [
    "East",
    "North",
    "North-East",
    "North-West",
    "South",
    "South-East",
    "South-West",
    "West"
  ],
  CategoryPro.area: ["শতাংশ", "কাঠা", "বিঘা"],
};
