// ignore_for_file: sort_child_properties_last

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_food_log_app/models/Food.dart';
import 'add_food.dart';
import 'package:flutter_food_log_app/services/supabase_service.dart';

class ShowAll extends StatefulWidget {
  const ShowAll({super.key});

  @override
  State<ShowAll> createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  List<Food> Foods = [];

  final Service = SupabaseService();

  void loadallFood() async {
    final data = await Service.getAllFood();
    setState(() {
      //เก็บข้อมูลที่ได้จากการดึงผ่าน supabaseservices ไว้ในตัวแปร Foods เพื่อใช้ใน body
      Foods = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadallFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: Text(
          'Log Food',
          style: TextStyle(color: Colors.green[900]),
        ),
        centerTitle: true,
      ),
      body: Center(
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
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  // จำนวนราบการที่จะแสดงใน LISTVIEW
                  itemCount: Foods.length,
                  // สร้างหน้าตาของแต่ละราบการ
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      child: ListTile(
                        onTap: () {},
                        leading: Image.asset(
                          'assets/images/food.png',
                        ),
                        trailing: Icon(
                          Icons.info,
                          color: Colors.green[900],
                        ),
                        title: Text(
                          'กิน ${Foods[index].FoodName} แล้ว',
                        ),
                        subtitle: Text(
                          'วันที่ ${Foods[index].FoodDate} มื้อ ${Foods[index].FoodMeal}',
                        ),
                        tileColor:
                            index % 2 == 0 ? Colors.pink[100] : Colors.pink[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddFood(),
              )).then((value) => loadallFood());
        },
        child: Icon(Icons.add, color: Colors.green[900]),
        backgroundColor: Colors.pink[50],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
