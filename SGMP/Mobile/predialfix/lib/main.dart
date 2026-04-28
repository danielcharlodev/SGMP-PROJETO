import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: PredialFix(), debugShowCheckedModeBanner: false));
}

class PredialFix extends StatefulWidget {
  @override
  _PredialFixState createState() => _PredialFixState();
}

class _PredialFixState extends State<PredialFix> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 155,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            height: 2,
            color: const Color.fromARGB(255, 255, 0, 0),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Center(
          child: Column(
            children: [
              Image.asset('assets/images/senai.png', height: 70),
              SizedBox(height: 8),
              Text('Sistema de Gestão', style: TextStyle(fontSize: 22)),
              Text('de Manutenção Predial', style: TextStyle(fontSize: 22)),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 120),
            Container(
              width: 300,
              height: 400,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 255, 255, 255)
              ),
              child: Column(
                children: [
                  Text('Conectar-se',style: TextStyle(fontSize: 20),),
                  SizedBox(height: 5),
                  Container(
                    width: 300,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Column(
//           children: [
          
//             Text('Conectar-se'),
//             SizedBox(height: 5,),
//             Container(
//               width: 150,
//               height: 3,
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.circular(5)
//               ),
//             ),
//           ],
//         ),