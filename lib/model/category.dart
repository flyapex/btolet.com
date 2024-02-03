import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Category {
  balcony,
  drawing,
  dining,
  kitchen,
  floorno,
  facing,
  garage,
}

Map<Category, List<String>> categoryData = {
  Category.balcony: ['0', "1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"],
  Category.drawing: ['0', "1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"],
  Category.dining: ['0', "1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"],
  Category.kitchen: ['0', "1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"],
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
    "10 th+",
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
    "Garage",
    "Car",
    "Bike",
  ],
};
var bedtolet = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7+",
];

var bathtolet = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7+",
];

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
  'Flat',
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
var diningPro = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7+",
];
var drawingPro = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7+",
];

var emi = [
  "Yes",
  "No",
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
  balcony,
  kitchen,
  facing,
  area,
}

Map<CategoryPro, List<String>> categoryProData = {
  CategoryPro.balcony: ["1", "2", "3", "4", "5", "6", "7+"],
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
  CategoryPro.area: ["শতাংশ", "কাঠা", "বিঘা", 'বর্গফুট'],
};
