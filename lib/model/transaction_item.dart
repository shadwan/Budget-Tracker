import 'package:hive/hive.dart';
part 'transaction_item.g.dart';

@HiveType(typeId: 1)
class TransactionItem {
  @HiveField(0)
  final String itemTitle;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final bool isExpense;

  TransactionItem({
    required this.itemTitle,
    required this.amount,
    required this.isExpense,
  });
}
