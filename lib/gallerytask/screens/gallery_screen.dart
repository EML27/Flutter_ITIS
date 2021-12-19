import 'dart:io';

import 'package:first_flutter_project/gallerytask/domain/entities.dart';
import 'package:first_flutter_project/gallerytask/statemanager/gallery_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

var stateManager = GalleryStateManager();
var picker = ImagePicker();

class GalleryScreen extends StatelessWidget {
  void onAddPhotoPressed(BuildContext context) {
    showPhotoSelectDialog(context);
  }

  void onPhotoPressed(Photo photo) {
    stateManager.selectPhoto(photo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Галерея"),
        actions: [
          IconButton(
              onPressed: () {
                onAddPhotoPressed(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [PhotosGridView(onPhotoPressed), PhotoShowView()],
        ),
      ),
    );
  }

  Future<void> showPhotoSelectDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Select Photo"),
            actions: <Widget>[
              TextButton(
                child: Text("Gallery"),
                onPressed: () {
                  onGalleryVariantSelected();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Camera"),
                onPressed: () {
                  onCameraVariantSelected();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void onGalleryVariantSelected() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    handlePhotoFile(file);
  }

  void onCameraVariantSelected() async {
    final XFile? file = await picker.pickImage(source: ImageSource.camera);
    handlePhotoFile(file);
  }

  void handlePhotoFile(XFile? file) {
    if (file != null) {
      stateManager.addPhoto(Photo(file.path));
    }
  }
}

class PhotosGridView extends StatelessWidget {
  final void Function(Photo) onPhotoPressedCallback;

  PhotosGridView(this.onPhotoPressedCallback);

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Padding(
            padding: EdgeInsets.all(8),
            child: Expanded(
                child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 4, mainAxisSpacing: 4),
              itemCount: stateManager.photos.length,
              itemBuilder: (context, index) {
                return Wrap(children: [
                  InkWell(
                      onTap: () {
                        onPhotoPressedCallback(stateManager.photos[index]);
                      },
                      child: Hero(
                          tag: stateManager.photos[index].fileSrc,
                          child: Image.file(
                            File(stateManager.photos[index].fileSrc),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )))
                ]);
              },
            ))));
  }
}

class PhotoShowView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => stateManager.shownPhoto?.fileSrc != null
            ? Expanded(
                child: Container(
                    decoration: BoxDecoration(color: Colors.black),
                    child: Align(
                      alignment: Alignment.center,
                      child: InteractiveViewer(
                        child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Hero(
                                tag: stateManager.shownPhoto!.fileSrc,
                                child: Image.file(
                                    File(stateManager.shownPhoto!.fileSrc)))),
                        onInteractionEnd: (scaleEndDetails) {
                          var dir = scaleEndDetails
                              .velocity.pixelsPerSecond.direction;
                          //Никогда бы не подумал что тригонометрия мне еще пригодится
                          if (dir < -(3.14 / 4) &&
                              dir > -(3.14 / 4 * 3) &&
                              scaleEndDetails
                                      .velocity.pixelsPerSecond.distance >
                                  40 &&
                              scaleEndDetails.pointerCount == 0) {
                            stateManager.photoUnselected();
                          }
                        },
                      ),
                    )),
              )
            : Container());
  }
}
