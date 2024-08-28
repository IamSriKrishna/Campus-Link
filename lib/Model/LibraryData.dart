import 'dart:convert';

class LibraryModel {
  final String id;
  final String book_title;
  final List<dynamic> access_no;
  final List<dynamic> authors;
  final String publisher;
  final String source_of_supply;
  final String no_of_copies;
  final List<dynamic> borrowers;
  final String subject;
  final String photo;
  final String section_image;
  LibraryModel({
    required this.id,
    required this.section_image,
    required this.subject,
    required this.book_title,
    required this.access_no,
    required this.no_of_copies,
    required this.authors,
    required this.publisher,
    required this.photo,
    required this.borrowers,
    required this.source_of_supply
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'book_title': book_title,
      'access_no':access_no,
      'no_of_copies':no_of_copies,
      'borrowers':borrowers,
      'authors': authors,
      'subject': subject,
      'publisher':publisher,
      'photo':photo,
      'section_image':section_image,
      'source_of_supply':source_of_supply,
    };
  }

  factory LibraryModel.fromMap(Map<String, dynamic> map) {
    return LibraryModel(
      id: map['_id'] ?? '',
      book_title: map['book_title'] ?? '',
      access_no:map['access_no']??[],
      authors:map['authors']??[],
      photo:map['photo']??'',
      borrowers:map['borrowers']??[],
      no_of_copies:map['no_of_copies']??'',
      section_image:map['section_image']??'',
      publisher:map['publisher']??'',
      subject:map['subject']??'',
      source_of_supply:map['source_of_supply']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory LibraryModel.fromJson(String source) => LibraryModel.fromMap(json.decode(source));

  LibraryModel copyWith({
    String? id,
    String? book_title,
    List<dynamic>? access_no,
    List<dynamic>? authors,
    String? section_image,
    List<dynamic>?  borrowers,
    String? photo,
    String? publisher,
    String? subject,
    String? source_of_supply,
    String? no_of_copies,
  }) {
    return LibraryModel(
      id: id ?? this.id,
      book_title: book_title ?? this.book_title,
      access_no: access_no??this.access_no,
      photo:photo??this.photo,
      section_image:section_image??this.section_image,
      subject:subject??this.subject,
      authors: authors??this.authors,
      borrowers:borrowers??this.borrowers,
      publisher:publisher??this.publisher,
      source_of_supply:source_of_supply??this.source_of_supply,
      no_of_copies:no_of_copies??this.no_of_copies,
    );
  }
}