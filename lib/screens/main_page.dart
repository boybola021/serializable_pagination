

import 'package:flutter/material.dart';
import 'package:serializable_pagination/screens/home_page.dart';
import 'package:serializable_pagination/screens/house.dart';
import 'package:serializable_pagination/screens/spells.dart';
import 'package:serializable_pagination/screens/staff.dart';
import 'package:serializable_pagination/screens/student.dart';

import '../model/staff/staff.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                },
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                elevation: 5,
                backgroundColor: Colors.cyan,
                fixedSize: const Size(200, 50),
              ),
                child: Text("Characters",style: Theme.of(context).textTheme.headlineSmall,),
            ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const HousePage()));
                },
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                elevation: 5,
                backgroundColor: Colors.cyan,
                fixedSize: const Size(200, 50),
              ),
                child: Text("House Page",style: Theme.of(context).textTheme.headlineSmall,),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentsPage()));
                },
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                elevation: 5,
                backgroundColor: Colors.cyan,
                fixedSize: const Size(200, 50),
              ),
                child: Text("Students",style: Theme.of(context).textTheme.headlineSmall,),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const StaffPage()));
                },
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                elevation: 5,
                backgroundColor: Colors.cyan,
                fixedSize: const Size(200, 50),
              ),
                child: Text("Staff",style: Theme.of(context).textTheme.headlineSmall,),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SpellsPage()));
              },
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                elevation: 5,
                backgroundColor: Colors.cyan,
                fixedSize: const Size(200, 50),
              ),
              child: Text("Spell Page",style: Theme.of(context).textTheme.headlineSmall,),
            ),
          ],
        ),
      ),
    );
  }
}
