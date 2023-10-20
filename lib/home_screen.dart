import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:loan_calculator/widgets/title_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double loanAmount = 0.0;
  double interestRate = 0.0;
  int loanTerm = 0;
  double monthlyPayment = 0.0;
  double totalPayment = 0.0;
  double totalInterest = 0.0;

  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController loanTermController = TextEditingController();

  void calculateMonthlyPayment() {
    double principal = loanAmount;
    double monthlyInterestRate = (interestRate / 100) / 12;
    int numberOfPayments = loanTerm * 12;

    if (monthlyInterestRate != 0.0) {
      monthlyPayment = (principal * monthlyInterestRate) /
          (1 - pow(1 + monthlyInterestRate, -numberOfPayments));
      totalPayment = monthlyPayment * numberOfPayments;
      totalInterest = totalPayment - principal;
    } else {
      // Handle division by zero or zero interest rate.
      monthlyPayment = principal / numberOfPayments;
      totalPayment = principal;
      totalInterest = 0.0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.notes,
          size: 30,
          color: Colors.white,
        ),
        toolbarHeight: 30,
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.info,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey[100],
          ),
          child: Column(
            children: [
              Container(
                height: 170,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Loan Calculator",
                          style: GoogleFonts.robotoMono(
                              fontSize: 35, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleTextField(
                      textEditingController: loanAmountController,
                      title: 'Loan Amount',
                      hintText: "Enter Loan Amount",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TitleTextField(
                      textEditingController: interestRateController,
                      title: 'Interest Rate (%)',
                      hintText: "Enter Interest Rate",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TitleTextField(
                      textEditingController: loanTermController,
                      title: 'Loan Term (years)',
                      hintText: "Enter Loan Term",
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        loanAmount = double.parse(loanAmountController.text);
                        interestRate =
                            double.parse(interestRateController.text);
                        loanTerm = int.parse(loanTermController.text);
                        calculateMonthlyPayment();
                      },
                      child: const Text('Calculate'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                        'Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}'),
                    Text('Total Payment: \$${totalPayment.toStringAsFixed(2)}'),
                    Text(
                        'Total Interest: \$${totalInterest.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
