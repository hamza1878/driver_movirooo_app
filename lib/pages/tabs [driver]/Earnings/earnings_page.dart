import 'package:flutter/material.dart';
import 'package:moviroo_driver_app/pages/tabs%20%5Bdriver%5D/Earnings/_TopBar.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../routing/router.dart';
import '../widgets/tab_bar.dart';

class EarningsPage extends StatefulWidget {
  const EarningsPage({super.key});

  @override
  State<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  @override
  Widget build(BuildContext context) {
   
   return Scaffold(
       backgroundColor:AppColors.bg(context),
       body: SafeArea(
        child:Column(
    children: [
      TopBar(),

 ]
)),

   
    







   );
  }
   
}