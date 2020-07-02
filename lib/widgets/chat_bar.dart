import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPofTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPofTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint){

      return Column(
      children: <Widget>[
        Container(
          height: constraint.maxHeight*0.15,
                  child: FittedBox(
            child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
        ),
        SizedBox(
          height: constraint.maxHeight*0.05,
        ),
        Container(
          height: constraint.maxHeight*0.6,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20)
                    ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPofTotal,
                child: Container(
                  decoration:
                      BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)
                      )
                        
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: constraint.maxHeight*0.05,
        ),
        Container(
          height: constraint.maxHeight*0.15,
          child: FittedBox(child: Text(label))),
      ],
    );

    },);
    
  }
}
