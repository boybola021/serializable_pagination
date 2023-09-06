import 'dart:async';
import 'package:flutter/material.dart';
import 'package:serializable_pagination/screens/detail_page.dart';

import '../model/characters/api_response.dart';
import '../service/network.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ApiResponse> characters = [];
  int exit = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getAllCharacters();
  }

  void getAllCharacters() async {
    final String? response =
        await Network.getMethod(api: Network.apiCharacters);
    if (response != null) {
      setState(() => isLoading = true);
      characters.addAll(Network.parseApiResponse(response));
      setState(() => isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Characters",style: TextStyle(fontSize: 25),),
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
            characters = [];
            getAllCharacters();
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
                    itemCount: characters.length,
                    itemBuilder: (context, i) {
                      final item = characters[i];
                      return GestureDetector(
                        onDoubleTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  DetailPage(id: item.id, enterApi: Network.apiCharacterId)));
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
