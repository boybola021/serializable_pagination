
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/characters/api_response.dart';
import '../model/house/house.dart';
import '../service/network.dart';
import 'detail_page.dart';

class HousePage extends StatefulWidget {
  const HousePage({Key? key}) : super(key: key);

  @override
  State<HousePage> createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
  List<House> house = [];
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
          && ((page + 1) * limit) == house.length){
        page++;
        getAllData(page: page);
      }
    });
  }

  void getAllData({int page = 0}) async {
    final String? response =
    await Network.getMethod(api: Network.apiHouse);
    limit *= page;
    if (response != null) {
      setState(() => isLoading = true);
      house.addAll(Network.parseHouseList(response));
      setState(() => isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("House Graffindor",style: TextStyle(fontSize: 25),),
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
            house = [];
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
                    itemCount: house.length,
                    itemBuilder: (context, i) {
                      final item = house[i];
                      return GestureDetector(
                        onDoubleTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  const DetailPage(enterApi: Network.apiHouse)));
                          setState(() {});
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
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  errorBuilder: (context, _, __) {
                                    return const Center(
                                      child: Icon(Icons.no_accounts,size: 80,),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                child: Column(
                                  children: [
                                    Text(
                                      item.name,
                                      style:
                                      Theme.of(context).textTheme.headlineSmall?.copyWith(overflow: TextOverflow.ellipsis),
                                    ),
                                    Text(
                                      item.house.toString(),
                                      style:
                                      Theme.of(context).textTheme.headlineSmall?.copyWith(overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
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
