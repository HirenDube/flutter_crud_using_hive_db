import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'entries.g.dart';

@HiveType(typeId: 0)
class Entries extends HiveObject{
  @HiveField(0)
  late String email;
  @HiveField(1)
  late String password;
}
