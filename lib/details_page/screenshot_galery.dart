import 'package:flutter/material.dart';
import 'package:game_lib_app/game/screenshot.dart';
import 'package:game_lib_app/repositories/igdb_repository.dart';

class ScreenshotGalery extends StatelessWidget {
  final List<Screenshot>? screenshots;
  const ScreenshotGalery({Key? key, required this.screenshots})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int screenshotsAmount = screenshots?.length ?? 0;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: screenshotsAmount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => Dismissible(
                  direction: DismissDirection.down,
                  key: const Key('key'),
                  onDismissed: (_) => Navigator.of(context).pop(),
                  child: Dialog(
                    insetPadding: EdgeInsets.zero,
                    child: Image.network(
                        IgdbRepository.getPictureWithResolution(
                            screenshots![index].url!, '720p'),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  IgdbRepository.getPictureWithResolution(
                      screenshots![index].url!, '720p'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
