import 'package:fintrack/screens/add_time_screen.dart';
import 'package:fintrack/screens/periods_screen.dart';
import 'package:fintrack/utils/responsive.dart';
import 'package:fintrack/widgets/add_time_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FTrack",
        style: TextTheme.of(context).titleMedium,),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.07,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddTimeScreen()));
              },
              child: AddTimeContainer()),
              SizedBox(height: context.screenHeight * 0.02),

              SizedBox(
                width: double.infinity,
                height: context.screenHeight * 0.13,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PeriodsScreen()));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_view_week_outlined, size: 40,),
                      Text('Periods Screen',
                  style: TextTheme.of(context).titleMedium!.copyWith(
                    color: Colors.white
                  )),
                    ],
                  )),
              ),
              ],
            ),
            
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  
                  child: Column(
                    children: [
                       Text("Powered By",
                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                
                        Transform.scale(
                         scale: 1.2,
                         child: Image.asset("assets/images/3D Logo - No Background.png"))
                    ],
                  ),
                ),
              )

             
          ],
        ),
      ),
    );
  }
}