import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:serializable_pagination/model/characters/api_response.dart';
import 'package:serializable_pagination/model/spells/spells.dart';

import '../model/house/house.dart';
import '../model/staff/staff.dart';
import '../model/students/students.dart';
import '../service/network.dart';

class DetailPage extends StatelessWidget {
  final String? id;
  final String enterApi;

  const DetailPage({Key? key,  this.id, required this.enterApi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: Network.getMethod(api: enterApi, id: id),
      initialData: "No Data",
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(
                child: Text(
              "No Data",
              style: TextStyle(fontSize: 25),
            ));
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator.adaptive());
          done:
          case ConnectionState.done:
            if (snapshot.hasData) {
              String type = enterApi;
              log("====${snapshot.data}\n$type===");
              switch(type){
                case Network.apiCharacterId: return CharacterDetail(data: snapshot.data!);
                case Network.apiHouse: return HouseDetail(data: snapshot.data!);
                case Network.apiSpells: return SpellsDetail(data: snapshot.data!);
                case Network.apiStaff: return StaffDetail(data: snapshot.data!);
                case Network.apiStudents: return StudentsDetail(data: snapshot.data!);
                default: return CharacterDetail(data: snapshot.data!);
                }
              //return HouseDetail(data: snapshot.data!);
            } else {
              return const Center(
                  child: Text(
                      "Something error, Please check your internet connecting!",
                      style: TextStyle(fontSize: 25)));
            }
          case ConnectionState.active:
            continue done;
        }
      },
    );
  }
}


class CharacterDetail extends StatelessWidget {
  final String data;

  const CharacterDetail({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final y = MediaQuery.sizeOf(context).height;
    final List<ApiResponse> apiRespone = Network.parseApiResponse(data);
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: apiRespone.length,
          itemBuilder: (context, i) {
            final item = apiRespone[i];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (item.image.isNotEmpty)
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.center,
                        image: NetworkImage(
                          item.image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.70,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Icon(Icons.no_accounts,size: 100,),
                  ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Name:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.name,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                       RichText(
                         textAlign: TextAlign.start,
                         text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Birthday:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.dateOfBirth ?? "?",
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                       RichText(
                         textAlign: TextAlign.start,
                         text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Eye Color:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.eyeColour,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Hair Color:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.hairColour,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Gender:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.gender,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}


class HouseDetail extends StatelessWidget {
  final String data;
  const HouseDetail({Key? key, required this.data}) : super(key: key);
  void res(){
    log("====House Detail $data====");
  }
  @override
  Widget build(BuildContext context) {
    final y = MediaQuery.sizeOf(context).height;
    final List<House> house = Network.parseHouseList(data);
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: house.length,
          itemBuilder: (context, i) {
            final item = house[i];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (item.image.isNotEmpty)
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.center,
                        image: NetworkImage(
                          item.image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.70,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Icon(Icons.no_accounts,size: 100,),
                  ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "House:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.house.toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Name:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.name,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Birthday:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.dateOfBirth ?? "?",
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Eye Color:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.eyeColour,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Hair Color:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.hairColour,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Gender:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.gender,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}


class StudentsDetail extends StatelessWidget {
  final String data;
  const StudentsDetail({Key? key, required this.data}) : super(key: key);
  void res(){
  }
  @override
  Widget build(BuildContext context) {
    final y = MediaQuery.sizeOf(context).height;
    final List<Students> students = Network.parseStudentsList(data);
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, i) {
            final item = students[i];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (item.image.isNotEmpty)
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.center,
                        image: NetworkImage(
                          item.image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.70,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Icon(Icons.no_accounts,size: 100,),
                  ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Students:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: (item.hogwartsStudent == true ? "Hogwarts Students" : "?").toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Name:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.name,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Birthday:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.dateOfBirth ?? "?",
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Eye Color:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.eyeColour,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Hair Color:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.hairColour,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Gender:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.gender,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class StaffDetail extends StatelessWidget {
  final String data;
  const StaffDetail({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final y = MediaQuery.sizeOf(context).height;
    final List<Staff> staff = Network.parseStaffList(data);
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: staff.length,
          itemBuilder: (context, i) {
            final item = staff[i];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (item.image.isNotEmpty)
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.center,
                        image: NetworkImage(
                          item.image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.70,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Icon(Icons.no_accounts,size: 100,),
                  ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Staff:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: (item.hogwartsStudent == true ? "Hogwarts Staff" : "?").toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Name:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.name,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Birthday:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.dateOfBirth ?? "?",
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Eye Color:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.eyeColour,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Hair Color:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.hairColour,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Gender:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.gender,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class SpellsDetail extends StatelessWidget {
  final String data;
  const SpellsDetail({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final y = MediaQuery.sizeOf(context).height;
    final List<Spell> spell = Network.parseSpellsList(data);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: ListView.builder(
            itemCount: spell.length,
            itemBuilder: (_,i){
              final item = spell[i];
              return  Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Name:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.name,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Description:  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: item.description,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ),
    );
  }
}

