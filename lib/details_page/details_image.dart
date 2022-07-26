import 'package:flutter/material.dart';

import 'package:game_lib_app/repositories/igdb_repository.dart';

class DetailsImage extends StatelessWidget {
  final String url, name;
  final double? rating;
  final int? ratingCount;
  const DetailsImage({
    Key? key,
    required this.url,
    required this.name,
    required this.rating,
    required this.ratingCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Hero(
        tag: "cover$url",
        child: Image.network(
          IgdbRepository.getPictureWithResolution(url, '720p'),
          fit: BoxFit.fitWidth,
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, -0.7),
                end: Alignment(0, 0.9),
                colors: [Color.fromARGB(0, 0, 0, 0), Colors.black],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(name,
                          style: const TextStyle(fontSize: 30),
                          overflow: TextOverflow.clip),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: Text(
                                ((rating ?? 0) / 20.0).toStringAsPrecision(3),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: Text(
                                (ratingCount ?? 0).toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      )
    ]);
  }
}
