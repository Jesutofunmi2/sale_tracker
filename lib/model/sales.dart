import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class Sales {
 const Sales({required this.kg, required this.name, required this.price, required this.today, required this.id});
  final String? id;
  final String? kg;
  final String? name;
  final String? price;
  final String? today;



}