import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/FontStyle/RobotoRegularFont.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup<void>(
                      context: context, 
                      builder:(context) {
                        return CupertinoAlertDialog(
                          title: Text('Innovator\'s Corner'),
                          content: Text('Special thanks to Sangeetha for their fantastic idea that made Campus~Link even better for everyone!'),
                        );
                      },
                    );
                  },
                  child: Icon(Icons.info_outlined,color: Colors.black)
                )
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              RobotoBoldFont(
                text: 'Emergency Help\nNeeded?',
                size: 25,
                textAlign: TextAlign.center,
              ),
              Lottie.asset(
                'asset/lottie/sos.json',
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.5,
              ),
              Gap(MediaQuery.of(context).size.height * 0.035),
              RobotoRegularFont(
                text: 'Please click the button below to redirect the KCG Ambulance',
                size: 16.5,
                textAlign: TextAlign.center,
              ),
              Gap(MediaQuery.of(context).size.height * 0.055),
              AvatarGlow(
                //glowRadiusFactor: 1.5,
                glowColor: Colors.red,
                child: InkWell(
                  onTap: () async{
                    final Uri uri = Uri(
                      scheme: 'tel',
                      path: '044 – 28389001',
                    );
                    if(await canLaunchUrl(uri)){
                      await launchUrl(uri);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      shape: BoxShape.circle
                    ),
                    child:RobotoBoldFont(text: 'SOS',textColor: Colors.white,),
                  ),
                )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10
        ),
        child: Text(
          'Repeatedly clicking the SOS button unnecessarily may result in the storage of your data. SOS is intended for emergency use only.',
          textAlign: TextAlign.center,
          style: GoogleFonts.lora(),
        ),
      ),
    );
  }
}