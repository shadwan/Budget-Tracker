import 'package:budget_tracker/model/transaction_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  static const String transactionBoxKey = 'transactionBox';
  static const String balanceBoxKey = 'balanceBox';
  static const String budgetBoxKey = 'budgetBox';

  Future<void> initializeHive() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TransactionItemAdapter());
    }

    await Hive.openBox<double>(budgetBoxKey);
    await Hive.openBox<TransactionItem>(transactionBoxKey);
    await Hive.openBox<double>(balanceBoxKey);
  }

  List<TransactionItem> getAllTransactions() {
    return Hive.box<TransactionItem>(transactionBoxKey).values.toList();
  }

  Future<void> saveBalance(TransactionItem item) async {
    final balanceBox = Hive.box<double>(balanceBoxKey);
    final currentBalance = balanceBox.get("balance") ?? 0.0;
    if (item.isExpense) {
      balanceBox.put("balance", currentBalance + item.amount);
    } else {
      balanceBox.put("balance", currentBalance - item.amount);
    }
  }

  Future<void> saveBalanceOnDelete(TransactionItem item) async {
    final balanceBox = Hive.box<double>(balanceBoxKey);
    final currentBalance = balanceBox.get("balance") ?? 0.0;
    if (item.isExpense) {
      balanceBox.put("balance", currentBalance - item.amount);
    } else {
      balanceBox.put("balance", currentBalance + item.amount);
    }
  }

  double getBalance() {
    return Hive.box<double>(balanceBoxKey).get("balance") ?? 0.0;
  }

  double getBudget() {
    return Hive.box<double>(budgetBoxKey).get("budget") ?? 0.0;
  }

  Future<void> saveBudget(double budget) async {
    await Hive.box<double>(budgetBoxKey).put("budget", budget);
  }

  void saveTransactionItem(TransactionItem transcation) {
    Hive.box<TransactionItem>(transactionBoxKey).add(transcation);
    saveBalance(transcation);
  }

  void deleteTransactionItem(TransactionItem transaction) {
    final transactions = Hive.box<TransactionItem>(transactionBoxKey);

    final Map<dynamic, TransactionItem> map = transactions.toMap();

    dynamic desiredKey;

    map.forEach((key, value) {
      if (value.itemTitle == transaction.itemTitle &&
          value.amount == transaction.amount &&
          value.isExpense == transaction.isExpense) {
        desiredKey = key;
      }
    });

    transactions.delete(desiredKey);

    saveBalance(transaction);
  }
}
