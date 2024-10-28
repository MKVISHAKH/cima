
import 'package:onlineinspection/core/hook/hook.dart';

class Screenhome extends StatefulWidget {
  const Screenhome({super.key});

  @override
  State<Screenhome> createState() => _ScreenhomeState();
}

class _ScreenhomeState extends State<Screenhome> {
  @override
  Widget build(BuildContext context) {
    return Material(
      
      child: SizedBox(
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
            children: [
              Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color:Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height/1.6,
                decoration: BoxDecoration(
                  color:Theme.of(context).colorScheme.primary,
                  
                  borderRadius:const BorderRadius.only(bottomRight: Radius.circular(70))
                ),
                child: Center(
                child:
                Lottie.asset(
                  'assets/animation/home/Animation - 1730091121508.json',
                  width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height/2
                ),
              ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height/2.66,
                decoration: BoxDecoration(
                  color:Theme.of(context).colorScheme.primary,
                  
                  //borderRadius:const BorderRadius.only(bottomRight: Radius.circular(70))
                ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height/2.66,
                padding:const EdgeInsets.only(top:40,bottom: 30),
                decoration: BoxDecoration(
                  color:Theme.of(context).colorScheme.tertiary,
                  borderRadius:const BorderRadius.only(
                    topLeft: Radius.circular(70))
                ),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15,),
                     Text("Quality is Everything",style:Theme.of(context).textTheme.titleLarge,),
                     const SizedBox(height: 15,),
                     Padding(padding: const EdgeInsets.symmetric(horizontal: 40),
                     child: Text("Excellence in Inspection: Ensuring Quality and Compliance Every Step of the Way",
                     style:Theme.of(context).textTheme.bodySmall,),),
                     SizedBox(height: MediaQuery.of(context).size.height/11,),
                     Container(
                       height: 45,
                       width: 200,
                       decoration: BoxDecoration(
                         gradient: LinearGradient(
                           begin: Alignment.topLeft,
                           end: Alignment.bottomRight,
                           colors: [
                             Theme.of(context).colorScheme.primary,
                             Theme.of(context).colorScheme.secondary
                           ],
                         ),
                         borderRadius: BorderRadius.circular(12.0),
                       ),
                       child: Theme(
                         data: MyTheme.buttonStyleTheme,
                         child: ElevatedButton(
                           onPressed: () async {
                            
                           },
                           child: Text(
                             'Get Started',
                             style: Theme.of(context).textTheme.titleMedium,
                           ),
                         ),
                       ),
                     ),
                  ],
                ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              IconButton(
                    icon: Icon(
                      Icons.menu, 
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 30,),
                    onPressed: () {
                      // Handle menu button press
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 25,),
                    
                    onPressed: () {
                      // Handle notification button press
                    },
                  ),
            ],),
          )
          ],         
        ),
      ),
    );
  }
}