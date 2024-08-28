import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Feature/Screen/Library/Widget/LibraryCustomSliverList.dart';
import 'package:campuslink/Feature/Service/LibraryService.dart';
import 'package:campuslink/Model/LibraryData.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/Additional/Loader.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/Widget/CupertinoWidgets/CustomCupertinoModalpop.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List<dynamic> books = [];
  List<LibraryModel> _searchedBooks = [];
  final TextEditingController _searchController = TextEditingController();
  Future<void> fetchBooks()async{
    try{
      http.Response res = await http.get(
        Uri.parse('$uri/library/getAllBookData'),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );
      books = jsonDecode(res.body);
      setState(() {
        
      });
      //print(books);
    }catch(error){
      print(error);
    }
  }
  
  Future<void> _search() async {
    try {
      List<LibraryModel> searchedbooks =
          await LibraryService().searchLibraryByName(_searchController.text);
      setState(() {
        _searchedBooks = searchedbooks;
      });
    } catch (e) {
      print('Error fetching student data: $e');
    }
  }
  @override
  void initState() {
    _refresh();
    _searchController.addListener(_onSearchTextChanged);
    super.initState();
  }
  @override
  void didChangeDependencies() {
    _searchController.addListener(_onSearchTextChanged);
    super.didChangeDependencies();
  }
  void _onSearchTextChanged() {
    _search();
    setState(() {
    });
  }
  Future<void> _refresh()async{
    fetchBooks();
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body:books.isEmpty? Loader():CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
            title: Text(
              'Library.',
              style: GoogleFonts.luxuriousRoman(
                fontSize: 25
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(
                MediaQuery.of(context).size.width * 0.8, 
                MediaQuery.of(context).size.height * 0.05,
              ), 
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: TextField(
                      style: GoogleFonts.poppins(
                        color: Colors.black
                      ),
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey
                        ),
                        hintText: 'Search'
                      ),
                    ),
                  )),
              )
            ),
          ),
          SliverList.builder(
            itemCount: _searchedBooks.isEmpty?25:_searchedBooks.length,
            itemBuilder:(context, index) {
              return _searchedBooks.isEmpty?
              LibraryCustomSliverList(
                onTap: () {
                  CustomCupertinoModalPop(context: context, content: S.current.development);
                },
                image: books[index]['section_image'],
                access_no: books[index]['access_no'],
                no_of_authors: books[index]['authors'], 
                no_of_Books: books[index]['no_of_copies'], 
                subject: books[index]['book_title']
              )
              : LibraryCustomSliverList(
                onTap: () {
                  CustomCupertinoModalPop(context: context, content: S.current.development);
                },
                image: _searchedBooks[index].section_image,
                no_of_authors: _searchedBooks[index].authors, 
                access_no: _searchedBooks[index].access_no,
                no_of_Books: _searchedBooks[index].no_of_copies, 
                subject: _searchedBooks[index].book_title
              );
          },)
        ],
      ),
    );
  }
}