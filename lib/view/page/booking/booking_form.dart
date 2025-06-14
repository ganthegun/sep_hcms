import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();

  List<DateTime> _date = [];

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Add Booking',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  splashFactory: InkRipple.splashFactory,
                  splashColor: Colors.black.withOpacity(0.2),
                  child: Ink(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 168, 196, 108),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.upload_sharp,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                ),
              ),
              const Text(
                'upload image here',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Table(
                border: null,
                columnWidths: <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                },
                children: <TableRow>[
                  TableRow(
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text(
                          "Address: ",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      TableCell(
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "Enter your address",
                            alignLabelWithHint: true,
                          ),
                        ),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text(
                          "Size:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      TableCell(
                        child: Row(
                          children: [
                            Expanded( // Wrap TextField with Expanded
                              child: TextField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "Enter your house size",
                                  alignLabelWithHint: true,
                                ),
                              ),
                            ),
                            Text(
                              "sqft",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text(
                          "Date:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      TableCell(
                        child: Align(
                          alignment: Alignment.center,  // or any other alignment
                          child: SizedBox(
                            width: 150,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text("Pick a date"),
                            ),
                          ),
                        ),
                      )
                    ]
                  )
                ],
              ),
              // DatePickerDialog(firstDate: firstDate, lastDate: lastDate)
            ],
          ),
        ),
      ),
    );
  }
}
