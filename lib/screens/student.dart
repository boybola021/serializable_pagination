


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:serializable_pagination/model/students/students.dart';
import '../model/house/house.dart';
import '../model/staff/staff.dart';
import '../service/network.dart';
import 'detail_page.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  List<Students> students = [];
  int exit = 0;
  bool isLoading = false;
  int page = 0;
  int limit = 10;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    getAllData();
    controller.addListener(() {
      if(controller.position.pixels >= controller.position.maxScrollExtent
          && ((page + 1) * limit) == students.length){
        page++;
        getAllData(page: page);
      }
    });
  }

  void getAllData({int page = 0}) async {
    final String? response =
    await Network.getMethod(api: Network.apiStudents);
    limit *= page;
    if (response != null) {
      setState(() => isLoading = true);
      students.addAll(Network.parseStudentsList(response));
      setState(() => isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Students",style: TextStyle(fontSize: 25),),
      ),
      body: WillPopScope(
        onWillPop: ()async{
          Timer( const Duration(seconds: 1),(){
            exit = 0;
          });
          exit++;
          if(exit == 2){
            return true;
          }
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            students = [];
            getAllData();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: [
                GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: students.length,
                    itemBuilder: (context, i) {
                      final item = students[i];
                      return GestureDetector(
                        onDoubleTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  const DetailPage(enterApi: Network.apiStudents)));
                        },
                        child: Container(
                          height: 150,
                          width: 180,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Image.network(
                                  item.image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, _, __) {
                                    return const Center(
                                      child: Icon(Icons.no_accounts,size: 80,),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                child: Text(
                                  item.name,
                                  style:
                                  Theme.of(context).textTheme.headlineSmall?.copyWith(overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
