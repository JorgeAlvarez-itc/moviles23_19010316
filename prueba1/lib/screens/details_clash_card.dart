import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/fadein_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:prueba1/models/card_clash_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardClashDetailsScreen extends StatefulWidget {
  final ClashCard card;

  const CardClashDetailsScreen({required this.card});

  @override
  State<CardClashDetailsScreen> createState() => _CardClashDetailsScreenState();
}

class _CardClashDetailsScreenState extends State<CardClashDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.card.name ?? ''),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(widget.card.iconUrls ?? ''),
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Hero(
              tag: 'card_${widget.card.id}',
              child: FadeIn(
                child: Card(
                  elevation: 8,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 96),
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio:  12/ 8,
                          child: CachedNetworkImage(
                            imageUrl: widget.card.iconUrls ?? '',
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(widget.card.name ?? ''),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.confirmation_number),
                          title: Text(
                            'ID',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(widget.card.id.toString()),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.arrow_upward),
                          title: Text(
                            'Max Level',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(widget.card.maxLevel.toString()),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    /*
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.card.name ?? ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: CachedNetworkImage(
                  imageUrl: widget.card.iconUrls ?? '',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Name: ${widget.card.name}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'ID: ${widget.card.id}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Max Level: ${widget.card.maxLevel}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    */
  }
}
