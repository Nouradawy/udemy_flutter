import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter_1/Network/local/cache_helper.dart';
import 'package:udemy_flutter_1/modules/Shop_app/Login/ShopLoginScreen.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });

}


class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  int i=1;

  List<BoardingModel> boarding = [];

  getlist(){

    if(boarding.length<3)
    {
      boarding.add(
      BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'OnBoarding Title $i',
        body: 'OnBoarding Body $i',)) ;
      i++;
      getlist();
    }
  }

  bool IsLast =false;

  @override
  Widget build(BuildContext context) {
    getlist();
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            Submit(context);
          },
              child: Text('SKIP'))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index){
                    if (index == boarding.length - 1) {
                      setState(() {
                        IsLast = true;
                      });
                    } else {
                      setState(() {
                        IsLast = false;
                      });
                    }
                  },
                itemBuilder: (context , index) => builBoardingItem(boarding[index]),
                itemCount: boarding.length,),
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(controller: boardController, count: boarding.length, effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10.0,
                  expansionFactor: 4.0,
                  dotWidth: 10.0,
                  spacing: 5.0,
                ),),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(IsLast=true)
                  {Submit(context);}
                  else{
                    boardController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.bounceIn,);
                  }
                },
                child:Icon(Icons.arrow_forward_ios_rounded)),
              ],
            ),
          ],
        ),
      )
    );
  }

  void Submit(BuildContext context) {
    cacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) => ShopLoginScreen(),
          ),
              (Route<dynamic>route) => false,
        );
      }
    });

  }

  Widget builBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text('${model.title}',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),),
        SizedBox(
          height: 15.0,
        ),
        Text('${model.body}',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),),
        SizedBox(
          height: 15.0,
        ),
      ]
  );
}
