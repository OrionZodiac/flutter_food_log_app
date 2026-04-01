import 'package:flutter/material.dart';
import 'package:flutter_food_log_app/models/Food.dart';
import 'package:flutter_food_log_app/services/supabase_service.dart';
import 'package:intl/intl.dart';
class UpdateFood extends StatefulWidget {
  Food? food;
  UpdateFood({super.key, this.food});

  @override
  State<UpdateFood> createState() => _UpdateFoodState();
}

class _UpdateFoodState extends State<UpdateFood> {
  // สร้างตัวควบคุม textfield
  TextEditingController FoodNameController = TextEditingController();
  TextEditingController FoodPriceController = TextEditingController();
  TextEditingController FoodPersonController = TextEditingController();
  TextEditingController FoodDateController = TextEditingController();

  // สร้างตัวแปรเก็บมื้ออาหาร
  String FoodMeal = 'เช้า';

  // สร้างตัวแปรเก็บวันที่กิน
  DateTime? FoodDate;

  // สร้างตัวแปรที่กำหนดวันที่เลือกในตัวแปร FoodDateแล้วแสดงที่ textfield
  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        FoodDate = picked;

        FoodDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
  
  @override
  void initState() {
    super.initState();
    // กำหนดค่าเริ่มต้นให้กับ textfield และตัวแปรมื้ออาหาร
    FoodNameController.text = widget.food!.FoodName ;
    FoodPriceController.text = widget.food!.FoodPrice.toString();
    FoodPersonController.text = widget.food!.FoodPerson.toString();
    FoodDateController.text = widget.food!.FoodDate;
    FoodMeal = widget.food!.FoodMeal;
    // กำหนดค่าเริ่มต้นให้กับตัวแปรวันที่กิน
    FoodDate = DateTime.parse(widget.food!.FoodDate);
  }

// method สำหรับการแก้ไขข้อมูลอาหารในฐานข้อมูล Supabase
  void EditFoods() async {
    // Vaildate UI ตรวจสอบหน้าจอเบื้องต้น
    if (FoodNameController.text.isEmpty ||
        FoodPriceController.text.isEmpty ||
        FoodPersonController.text.isEmpty ||
        FoodDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('กรุณากรอกข้อมูลให้ครบ'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
      return;
    }
    //แพ็คข้อมูลที่ส่งไป supabase
    Food food = Food(
      FoodMeal: FoodMeal,
      FoodName: FoodNameController.text,
      FoodPrice: double.parse(FoodPriceController.text),
      FoodPerson: int.parse(FoodPersonController.text),
      FoodDate: FoodDate!.toIso8601String(),
    );
    //เรียกใช้ method updateFood ที่สร้างไว้ใน SupabaseService เพื่อส่งข้อมูลไปแก้ไขในฐานข้อมูล Supabase
    final Service = SupabaseService();
    await Service.updateFood(widget.food!.id!, food);
    //แจ้งผลการทำงาน
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('บันทึกข้อมูลเรียบร้อย'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
    //ย้อนกลับไปหน้าหลัก
    Navigator.pop(context);
  }
  // method สำหรับการลบข้อมูลอาหารในฐานข้อมูล Supabase
  Future<void> DeleteFoods() async {
    //แสดง Dialog เพื่อยืนยันการลบข้อมูลอาหาร
    await showDialog(
      context: context,
      builder:(context) => AlertDialog(
        //หัวข้อ Dialog
        title: Text('ยืนยันการลบข้อมูล'),
        //เนื้อหา Dialog
        content: Text('คุณต้องการลบข้อมูลนี้หรือไม่'),
        //ปุ่มยืนยันการลบข้อมูล
        actions: [
          //ปุ่มยกเลิกการลบข้อมูล
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
            child: Text(
              'ยกเลิก',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
          //ปุ่มยืนยันการลบข้อมูล
          ,ElevatedButton(
            onPressed: () async {
              final Service = SupabaseService();
              await Service.deleteFood(widget.food!.id!);
              //แจ้งผลการทำงาน
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('ลบข้อมูลเรียบร้อย'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ));
              //ย้อนกลับไปหน้าหลัก
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'ยืนยันการลบข้อมูล',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: Text(
          'Log Food( Edit food )',
          style: TextStyle(color: Colors.green[900]),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.green[900],
          ),
        ),
      ),
      // body
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0, bottom: 50.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                // ป้อนกินอะไร
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'กินอะไร',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),

                TextField(
                  controller: FoodNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'เช่น KFC, Pizza',
                  ),
                ),
                SizedBox(height: 20),
                // เลือกกินมื้อไหน
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'กินมื้อไหน',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          FoodMeal = 'เช้า';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            FoodMeal == 'เช้า' ? Colors.pink[500] : Colors.grey,
                      ),
                      child: Text(
                        'เช้า',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          FoodMeal = 'กลางวัน';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FoodMeal == 'กลางวัน'
                            ? Colors.pink[500]
                            : Colors.grey,
                      ),
                      child: Text(
                        'กลางวัน',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          FoodMeal = 'เย็น';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            FoodMeal == 'เย็น' ? Colors.pink[500] : Colors.grey,
                      ),
                      child: Text(
                        'เย็น',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          FoodMeal = 'ว่าง';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            FoodMeal == 'ว่าง' ? Colors.pink[500] : Colors.grey,
                      ),
                      child: Text(
                        'ว่าง',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // ป้อนกินไปเท่าไหร่
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'กินไปเท่าไหร่',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextField(
                  controller: FoodPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'เช่น 299.50',
                  ),
                ),
                SizedBox(height: 20),
                // ป้อนกินกันกี่คน
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'กินกันกี่คน',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextField(
                  controller: FoodPersonController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'เช่น 3',
                  ),
                ),
                SizedBox(height: 20),
                // เลือกกินไปวันไหน
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'กินไปวันไหน',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextField(
                  controller: FoodDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'เช่น 2020-01-31',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () {
                    // เปิดปฏิทินให้Userเลือกแล้วแสดงที่ TextField
                    pickDate();
                  },
                ),
                SizedBox(height: 20),
                // ปุ่มบันทึก
                ElevatedButton(
                  onPressed: () {
                    EditFoods();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                  ),
                  child: Text("บันทึกแก้ไข",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                SizedBox(height: 10),
                // ปุ่มยกเลิก
                ElevatedButton(
                  onPressed: () {
                    // ลบข้อมูลอาหารในฐานข้อมูล Supabase
                    DeleteFoods();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                  ),
                  child: Text(
                    "ลบข้อมูล",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
