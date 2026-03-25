//คลาสนี้ใช้สำหรับทำงานร่วมกับตารางในฐานข้อมูลที่จะทำงานด้วย

// ignore_for_file: non_constant_identifier_names

class Food {
  String? id;
  String FoodDate;
  String FoodMeal;
  String FoodName;
  double FoodPrice;
  int FoodPerson;

  Food({
    this.id,
    required this.FoodDate,
    required this.FoodMeal,
    required this.FoodName,
    required this.FoodPrice,
    required this.FoodPerson,
  });

//แปลงข้อมูลที่รับมาจาก Supabase เพื่อมาใช้ในแอปฯ
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      FoodDate: json['FoodDate'],
      FoodMeal: json['FoodMeal'],
      FoodName: json['FoodName'],
      FoodPrice: (json['FoodPrice'] as num).toDouble(),
      FoodPerson: json['FoodPerson'],
    );
  }

//แปลงข้อมูลจากแอปฯ เพื่อส่งไปยัง Supabase
  Map<String, dynamic> toJson() {
    return {
      "FoodDate": FoodDate,
      "FoodMeal": FoodMeal,
      "FoodName": FoodName,
      "FoodPrice": FoodPrice,
      "FoodPerson": FoodPerson,
    };
  }
}
