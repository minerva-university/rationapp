class BudgetItem {
  final String item;
  final double amount;

  BudgetItem({
    required this.item,
    required this.amount,
  });

  factory BudgetItem.fromJson(Map<String, dynamic> json) {
    return BudgetItem(
      item: json['item'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'amount': amount,
    };
  }
}

class Budget {
  final List<BudgetItem> incomeItems;
  final List<BudgetItem> expenseItems;

  Budget({
    required this.incomeItems,
    required this.expenseItems,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      incomeItems: (json['incomeItems'] as List)
          .map((item) => BudgetItem.fromJson(item))
          .toList(),
      expenseItems: (json['expenseItems'] as List)
          .map((item) => BudgetItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'incomeItems': incomeItems.map((item) => item.toJson()).toList(),
      'expenseItems': expenseItems.map((item) => item.toJson()).toList(),
    };
  }
}
