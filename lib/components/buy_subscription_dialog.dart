
import 'package:ArtBot/components/subscription_plans.dart';
import 'package:flutter/material.dart';


class BuySubscriptionDialog extends StatelessWidget {
  const BuySubscriptionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title:Text(
        'Buy More Credits',
        textAlign: TextAlign.center,
      ),
      titleTextStyle:TextStyle(
        fontSize: 25,
      ),
      content:SingleChildScrollView(
        child: Column(
          children: [
            Text(
              '1 credit allows you to generate 1 artwork. You can look at our subscription plans to get discounted packages up to 50% off.',
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30,),
        
            SubcriptionPlan(
              title: '50 Credits', 
              subtitle: '150 Artworks Results', 
              amount: '9.99', 
              perCredit: '0.06/Credit'
            ),
        
            SizedBox(height: 30,),
        
            SubcriptionPlan(
              title: '100 Credits', 
              subtitle: '300 Artworks Results', 
              amount: '13.99', 
              perCredit: '0.05/Credit'
            ),
        
            SizedBox(height: 30,),
        
            SubcriptionPlan(
              title: '200 Credits', 
              subtitle: '600 Artworks Results', 
              amount: '19.99', 
              perCredit: '0.03/Credit'
            ),
        
            
            
          ],
        ),
      ) ,
    );
  }
}