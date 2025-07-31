import 'package:flutter/material.dart';
import 'package:unimar_sab_19/mocks/list_users.dart';
import 'package:unimar_sab_19/views/homepage/widgets/appcard.dart';

import 'package:unimar_sab_19/globals.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        backgroundColor: Color(0xFFFF87AB),
      ),
      body: Container(
        color: const Color(0xFFFFF0F6),
        child: lastPet != null
            ? Card(
                color: Color(0xFFFF87AB),
                margin: EdgeInsets.all(24),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pet cadastrado:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12),
                      Text('Nome: 	${lastPet!['name']}'),
                      Text('Peso: 	${lastPet!['weight']}'),
                      Text('Cor:  	${lastPet!['color']}'),
                      Text('Idade:	${lastPet!['age']}'),
                    ],
                  ),
                ),
              )
            : Center(child: Text('Nenhum pet cadastrado ainda.', style: TextStyle(fontSize: 18))),
      ),
    );
  }
}
