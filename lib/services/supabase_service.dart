//class ใช้สำหรับการเขียน Code เพื่อทำงานต่าง ๆ กับ Supabase

import 'package:flutter_food_log_app/models/Food.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  //สร้าง Object/instance/ตัวแทน  ที่จะใช้กับ supabase
  final supabase = Supabase.instance.client;
  //สวนของ Methon การทำงานต่าง ๆ กับ supabase
  //เช่น การแก้ไข,การลบ
  // สร้าง methon ที่จะใช้กับ supabaseสำหรับการดึงข้อมูลจากฐานข้อมูล FoodTD in supabase

  Future<List<Food>> getAllFood() async {
    //ทำการดึงข้อมูลจากฐานข้อมูล FoodTD in supabase
    final data = await supabase
        .from("Food_TB")
        .select('*')
        .order('FoodDate', ascending: false);
    //แปลงข้อมูลที่ได้จาก Supabase แบบ Json มาใช้ใน App แล้วส่งผลกลับไป ณ จุดเรียกใช้ Methon
    return data.map<Food>((e) => Food.fromJson(e)).toList();
  }

  Future insertFood(Food food) async {
    await supabase.from("Food_TB").insert(food.toJson());
  }
}
