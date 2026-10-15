import 'ledger_transaction.dart';

class BalanceSummary {
  final int totalCreditInPaisa;
  final int totalPaymentInPaisa;
  final int outstandingBalanceInPaisa;
  final int transactionCount;

  const BalanceSummary({
    required this.totalCreditInPaisa,
    required this.totalPaymentInPaisa,
    required this.outstandingBalanceInPaisa,
    required this.transactionCount,
  });

  static const BalanceSummary zero = BalanceSummary(
    totalCreditInPaisa: 0,
    totalPaymentInPaisa: 0,
    outstandingBalanceInPaisa: 0,
    transactionCount: 0,
  );

  /// Calculates authoritative balance from an iterable of transactions.
  /// Rule: Outstanding balance = total credit - total payments.
  factory BalanceSummary.fromTransactions(
    Iterable<LedgerTransaction> transactions,
  ) {
    int totalCredit = 0;
    int totalPayment = 0;
    int count = 0;

    for (final tx in transactions) {
      count++;
      switch (tx.type) {
        case TransactionType.credit:
          totalCredit += tx.amountInPaisa;
          break;
        case TransactionType.payment:
          totalPayment += tx.amountInPaisa;
          break;
      }
    }

    final int balance = totalCredit - totalPayment;

    return BalanceSummary(
      totalCreditInPaisa: totalCredit,
      totalPaymentInPaisa: totalPayment,
      outstandingBalanceInPaisa: balance,
      transactionCount: count,
    );
  }
}
