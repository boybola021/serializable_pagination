import 'dart:async';
import 'package:flutter/material.dart';
import '../model/spells/spells.dart';
import '../service/network.dart';
import 'detail_page.dart';


class SpellsPage extends StatefulWidget {
  const SpellsPage({Key? key}) : super(key: key);

  @override
  State<SpellsPage> createState() => _SpellsPageState();
}

class _SpellsPageState extends State<SpellsPage> {
  List<Spell> spell = [];
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
          && ((page + 1) * limit) == spell.length){
        page++;
        getAllData(page: page);
      }
    });
  }

  void getAllData({int page = 0}) async {
    final String? response =
    await Network.getMethod(api: Network.apiSpells);
    limit *= page;
    if (response != null) {
      setState(() => isLoading = true);
      spell.addAll(Network.parseSpellsList(response));
      setState(() => isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Spells",style: TextStyle(fontSize: 25),),
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
            spell = [];
            getAllData();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: spell.length,
                    itemBuilder: (context,i){
                      final item = spell[i];
                      return  GestureDetector(
                        onDoubleTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                   const DetailPage(enterApi: Network.apiSpells)));
                        },
                        child: Card(
                          elevation: 10,
                          child: ListTile(
                           leading: Container(
                             height: 60,
                             width: 60,
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                               color: Colors.primaries[i % Colors.primaries.length],
                               shape: BoxShape.circle
                             ),
                             child: Text("${i + 1}",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 25),),
                           ),
                            title: Text(item.name,style: Theme.of(context).textTheme.headlineMedium,),
                            subtitle: Text(item.description,style: Theme.of(context).textTheme.headlineMedium?.copyWith(overflow: TextOverflow.ellipsis),),
                          ),
                        ),
                      );
                    }
                ),
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
