//class สำหรับทำงานร่วใกับตารางในฐานข้แมูล
// ignore_for_file: use_function_type_syntax_for_parameters, non_constant_identifier_names, unused_import

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Food {
  //  สร้างตัวแปรที่กับ colum ในตาราง
  String? id;
  DateTime? created_at;
  DateTime? FoodDate;
  String? FoodMeal;
  String? FoodName;
  double? FoodPrice;
  int? FoodPerson;

  Food(
      {this.id,
      this.created_at,
      this.FoodDate,
      this.FoodMeal,
      this.FoodName,
      this.FoodPrice,
      this.FoodPerson});

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': created_at,
        'FoodDate': FoodDate,
        'FoodMeal': FoodMeal,
        'FoodName': FoodName,
        'FoodPrice': FoodPrice,
        'FoodPerson': FoodPerson,
      };

  factory Food.FromMap(Map<String, dynamic> map) => Food(
        id: map['id'],
        created_at: map['created_at'],
        FoodDate: map['FoodDate'],
        FoodMeal: map['FoodMeal'],
        FoodName: map['FoodName'],
        FoodPrice: map['FoodPrice'],
        FoodPerson: map['FoodPerson'],
      );
}
