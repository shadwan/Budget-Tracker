import 'package:budget_tracker/model/transaction_item.dart';
import 'package:budget_tracker/services/local_storage_service.dart';
import 'package:flutter/material.dart';

class BudgetViewModel extends ChangeNotifier {
  double getBudget() => LocalStorageService().getBudget();
  double getBalance() => LocalStorageService().getBalance();
  List<TransactionItem> get items => LocalStorageService().getAllTransactions();

  set budget(double value) {
    LocalStorageService().saveBudget(value);
    notifyListeners();
  }

  void saveTransactionItem(TransactionItem transcation) {
    LocalStorageService().saveTransactionItem(transcation);
    notifyListeners();
  }

  void deleteItem(TransactionItem item) {
    LocalStorageService().deleteTransactionItem(item);
    notifyListeners();
  }
}
