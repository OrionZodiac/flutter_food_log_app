//class ใช้สำหรับการเขียน Code เพื่อทำงานต่าง ๆ กับ Supabase

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  //สร้าง Object/instance/ตัวแทน  ที่จะใช้กับ supabase
  final supabase = Supabase.instance.client;
  //สวนของ Methon การทำงานต่าง ๆ กับ supabase
  //เช่น การแก้ไข,การลบ
}
