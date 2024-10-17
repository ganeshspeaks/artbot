import 'package:flutter/material.dart';

class SubcriptionPlan extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String perCredit;
  const SubcriptionPlan({super.key, required this.title, required this.subtitle, required this.amount, required this.perCredit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey.shade800,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color:Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          // title
          Text(
            title,
            style:const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[500]
            ),
          ),

          const SizedBox(height: 20,),

          Container(
            width: 150,
            color: Colors.grey.shade800,
            height: 1.0,
          ),

          const SizedBox(height: 10,),
          Text(
            '\$$amount',
            style:const TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
           '\$$perCredit',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[500]
            ),
          ),

          const SizedBox(height: 20,),

          Container(
            width: 150,
            color: Colors.grey.shade800,
            height: 1.0,
          ),

          const SizedBox(height: 20,),

          // purchase now button
          Container(
            // padding:const EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child:TextButton(
              onPressed: (){},
              child:const Text(
                '  Purchase Now  ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}