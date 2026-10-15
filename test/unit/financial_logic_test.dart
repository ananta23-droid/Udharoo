import 'package:flutter_test/flutter_test.dart';
import 'package:udhaaro/core/utils/currency_formatter.dart';
import 'package:udhaaro/core/utils/input_validators.dart';
import 'package:udhaaro/features/ledger/models/balance_summary.dart';
import 'package:udhaaro/features/ledger/models/ledger_transaction.dart';

void main() {
  group('CurrencyFormatter & Paisa Precision', () {
    test('Correctly formats integer paisa to NPR currency strings', () {
      expect(CurrencyFormatter.formatPaisa(100000), 'Rs 1,000');
      expect(CurrencyFormatter.formatPaisa(150050), 'Rs 1,500.50');
      expect(CurrencyFormatter.formatPaisa(0), 'Rs 0');
      expect(CurrencyFormatter.formatPaisa(50), 'Rs 0.50');
      expect(
        CurrencyFormatter.formatPaisa(10000000),
        'Rs 1,00,000',
      ); // Nepali grouping
    });

    test(
      'Parses input correctly to integer paisa without floating point error',
      () {
        expect(CurrencyFormatter.parseInputToPaisa('1000'), 100000);
        expect(CurrencyFormatter.parseInputToPaisa('1000.50'), 100050);
        expect(CurrencyFormatter.parseInputToPaisa('1000.5'), 100050);
        expect(CurrencyFormatter.parseInputToPaisa('Rs 1,500.25'), 150025);
        expect(CurrencyFormatter.parseInputToPaisa('0'), isNull);
        expect(CurrencyFormatter.parseInputToPaisa('-100'), isNull);
        expect(CurrencyFormatter.parseInputToPaisa('abc'), isNull);
        expect(CurrencyFormatter.parseInputToPaisa(''), isNull);
      },
    );

    test('Converts paisa back to editable string for inputs', () {
      expect(CurrencyFormatter.paisaToEditableString(100000), '1000');
      expect(CurrencyFormatter.paisaToEditableString(100050), '1000.50');
    });
  });

  group('Authoritative Balance Rules', () {
    test('Zero transactions result in zero balance', () {
      final summary = BalanceSummary.fromTransactions([]);
      expect(summary.totalCreditInPaisa, 0);
      expect(summary.totalPaymentInPaisa, 0);
      expect(summary.outstandingBalanceInPaisa, 0);
      expect(summary.transactionCount, 0);
    });

    test('Credit increases outstanding balance', () {
      final now = DateTime.now();
      final txs = [
        LedgerTransaction(
          id: 'tx1',
          shopId: 'shop1',
          customerId: 'cust1',
          type: TransactionType.credit,
          amountInPaisa: 100000, // Rs 1,000
          createdAt: now,
        ),
      ];

      final summary = BalanceSummary.fromTransactions(txs);
      expect(summary.totalCreditInPaisa, 100000);
      expect(summary.totalPaymentInPaisa, 0);
      expect(summary.outstandingBalanceInPaisa, 100000);
      expect(summary.transactionCount, 1);
    });

    test('Payment decreases outstanding balance: Rs 1,000 credit - Rs 300 payment = Rs 700 balance', () {
      final now = DateTime.now();
      final txs = [
        LedgerTransaction(
          id: 'tx1',
          shopId: 'shop1',
          customerId: 'cust1',
          type: TransactionType.credit,
          amountInPaisa: 100000, // Rs 1,000
          createdAt: now,
        ),
        LedgerTransaction(
          id: 'tx2',
          shopId: 'shop1',
          customerId: 'cust1',
          type: TransactionType.payment,
          amountInPaisa: 30000, // Rs 300
          createdAt: now.add(const Duration(minutes: 5)),
        ),
      ];

      final summary = BalanceSummary.fromTransactions(txs);
      expect(summary.totalCreditInPaisa, 100000);
      expect(summary.totalPaymentInPaisa, 30000);
      expect(summary.outstandingBalanceInPaisa, 70000); // Exactly Rs 700
      expect(summary.transactionCount, 2);
    });

    test(
      'Zero or negative transaction amounts are rejected by model assertions',
      () {
        expect(
          () => LedgerTransaction(
            id: 'tx_inv',
            shopId: 'shop1',
            customerId: 'cust1',
            type: TransactionType.credit,
            amountInPaisa: 0,
            createdAt: DateTime.now(),
          ),
          throwsA(isA<AssertionError>()),
        );

        expect(
          () => LedgerTransaction(
            id: 'tx_inv',
            shopId: 'shop1',
            customerId: 'cust1',
            type: TransactionType.credit,
            amountInPaisa: -5000,
            createdAt: DateTime.now(),
          ),
          throwsA(isA<AssertionError>()),
        );
      },
    );
  });

  group('Input Validation Rules', () {
    test('Customer name validation enforces minimum characters', () {
      expect(InputValidators.validateCustomerName(''), isNotNull);
      expect(InputValidators.validateCustomerName('A'), isNotNull);
      expect(InputValidators.validateCustomerName('Ram Bahadur'), isNull);
    });

    test('Phone validation accommodates Nepali and international numbers', () {
      expect(InputValidators.validatePhone('9841234567'), isNull);
      expect(InputValidators.validatePhone('01-4422334'), isNull);
      expect(InputValidators.validatePhone('+977 9801234567'), isNull);
      expect(InputValidators.validatePhone('abc1234'), isNotNull);
    });

    test('Payment amount cannot exceed current outstanding balance', () {
      const balancePaisa = 70000; // Rs 700
      expect(
        InputValidators.validatePaymentAmount('500', balancePaisa),
        isNull,
      );
      expect(
        InputValidators.validatePaymentAmount('700', balancePaisa),
        isNull,
      );
      expect(
        InputValidators.validatePaymentAmount('701', balancePaisa),
        isNotNull,
      );
      expect(
        InputValidators.validatePaymentAmount('1000', balancePaisa),
        isNotNull,
      );
      expect(
        InputValidators.validatePaymentAmount('0', balancePaisa),
        isNotNull,
      );
      expect(
        InputValidators.validatePaymentAmount('-50', balancePaisa),
        isNotNull,
      );
    });
  });
}
