import 'package:flutter/material.dart';
import 'package:prueba1/models/card_clash_model.dart';
import 'package:prueba1/screens/details_clash_card.dart';
class ItemClashCard extends StatefulWidget {
  ClashCard card;
  ItemClashCard({Key? key, required this.card}) : super(key: key);

  @override
  State<ItemClashCard> createState() => _ItemClashCardState();
}

class _ItemClashCardState extends State<ItemClashCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => CardClashDetailsScreen(
                  card: widget.card,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 4),
                  alignment: Alignment.center,
                  child: Image.network(
                    widget.card.iconUrls!,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.card.name!,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 0),
                    Text(
                      'Max Level: ${widget.card.maxLevel}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
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
