import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'milestone.dart';
class MilestoneContainer extends StatelessWidget{
  final String startdate;
  final String enddate;
  final String week;

    const MilestoneContainer({ Key? key,required this.startdate,required this.enddate,required this.week}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double devSize =MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(5.0),
        width: devSize/1.05,
        height: 85,
        constraints: BoxConstraints(minHeight: 80),
        margin: EdgeInsets.only(left: 16,top:16,bottom: 8,right: 16),
        decoration: BoxDecoration(

            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child:
        Column(
          children: <Widget>[
            weekRow(context, week),
            SizedBox(height: 20,),
            dateRow(context, startdate, enddate)
          ],
        )
    );
  }
  Widget weekRow(BuildContext context,String week){
    return(
        Padding(padding: EdgeInsets.only(left:20, right:20),child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
          Text('$week',style:  GoogleFonts.poppins(color:Colors.black,fontSize: 14 ,height: 2.5,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
          Image.asset("assets/icons/milsetone highlighted.png",width: 10,height: 10,)
      ],
    ),
        )
    );
  }
  Widget dateRow(BuildContext context,String startdate,String enddate){
    var startdateNum=int.parse(startdate);
    var endDateNum = int.parse(enddate);
    var sd;
    var ed;
    sd = DateTime.fromMillisecondsSinceEpoch(startdateNum* 1000);
    startdate = DateFormat('MM/dd/yyyy').format(sd);
    ed = DateTime.fromMillisecondsSinceEpoch(endDateNum* 1000);
    enddate = DateFormat('MM/dd/yyyy').format(ed);
    return(
    Padding(padding: EdgeInsets.only(left:20, right:20),child: Row(
      children: [
        Text("Start",style:  GoogleFonts.poppins(color:Color(0xff4750d5),fontSize: 14 ,height: 1,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
        Padding(padding: EdgeInsets.only(left:10),child:
        Text(startdate,style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 12),),
        ),
        Spacer(),
        Text("End",style:  GoogleFonts.poppins(color:Color(0xff4750d5),fontSize: 14 ,height: 1,fontWeight: FontWeight.w400),),
        Padding(padding: EdgeInsets.only(left:10), child:
        Text(enddate,style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 12),),
        ),
          ],
    )
    )
    );
  }

}