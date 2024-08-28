import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:provider/provider.dart';

class LibraryExpand extends StatelessWidget {
  final String Screentitle;
  const LibraryExpand({
    super.key,
    required this.Screentitle
    });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
            title: Text(
              Screentitle,
              style: GoogleFonts.luxuriousRoman(
                fontSize: 25
              ),
            ),
            bottom:PreferredSize(
              preferredSize: Size(
                double.infinity, 
                MediaQuery.of(context).size.height * 0.05
                ), 
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white10,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search'
                      ),
                    ),
                  )
                ),
              )
            ),
          ),
          SliverGrid.builder(
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ), 
            itemBuilder:(context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0),
                child: Card(
                  color: theme.getDarkTheme?themeColor.darkTheme.withOpacity(0.15):themeColor.themeColor.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('https://c4.wallpaperflare.com/wallpaper/328/704/971/samurai-cyber-warrior-symbols-japan-hd-wallpaper-preview.jpg')
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0,top: 5),
                        child: Text('Advance java'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0,top: 5),
                        child: Text('Ravindranath M'),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}