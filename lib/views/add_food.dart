import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_food_log_app/models/Food.dart';
import 'package:intl/intl.dart';

import '../services/supabase_service.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
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

  void insertFood() async {
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
    // แพ็กข้อมูล
    Food food = Food(
      FoodMeal: FoodMeal,
      FoodName: FoodNameController.text,
      FoodPrice: double.parse(FoodPriceController.text),
      FoodPerson: int.parse(FoodPersonController.text),
      FoodDate: FoodDate!.toIso8601String(),
    );
    // บันทึกข้อมูลลง supabase ผ่าน services
    final Service = SupabaseService();
    await Service.insertFood(food);
    // แจ้งผลการทำงานกับผู้ใช้
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('บันทึกข้อมูลเรียบร้อย'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
    // กลับไปหน้า ShowAll
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: Text(
          'Log Food( Ad food )',
          style: TextStyle(color: Colors.green[900]),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.green[900],
          ),
        ),
      ),
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
                    insertFood();
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
                  child: Text("บันทึก",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
                SizedBox(height: 10),
                // ปุ่มยกเลิก
                ElevatedButton(
                  onPressed: () {
                    // Clear หน้าจอ และข้อมูล
                    setState(() {
                      FoodNameController.clear();
                      FoodPriceController.clear();
                      FoodPersonController.clear();
                      FoodDateController.clear();
                      FoodMeal = 'เช้า';
                    });
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
                    "ยกเลิก",
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
