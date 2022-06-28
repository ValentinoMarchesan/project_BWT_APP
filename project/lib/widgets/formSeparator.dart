import 'package:flutter/material.dart';

///Class that implements a custom [StatelessWidget] that acts as a separator in a [Form].
///It can be used to separate "categories" in a [Form].
class FormSeparator extends StatelessWidget {
  final label;

  FormSeparator({this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 3,
                width: 60,
                child: Container(
                  // color: Theme.of(context).accentColor,
                  color: Color.fromARGB(255, 239, 65, 123),
                ),
              ),
              Expanded(
                  child: Center(
                      child: Text(
                label,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Goldman',
                    fontSize: 16,
                    color: Color.fromARGB(255, 245, 174, 68)),
              ))),
              SizedBox(
                height: 3,
                width: 60,
                child: Container(
                  // color: Theme.of(context).accentColor,
                  color: Color.fromARGB(255, 239, 65, 123),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  } // build

} // FormSeparator