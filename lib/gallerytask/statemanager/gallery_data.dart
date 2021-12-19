import 'package:first_flutter_project/gallerytask/domain/entities.dart';
import 'package:mobx/mobx.dart';

part 'gallery_data.g.dart';

class GalleryStateManager = _GalleryStateManager with _$GalleryStateManager;

abstract class _GalleryStateManager with Store {
  @observable
  ObservableList<Photo> photos = ObservableList();

  @observable
  Photo? shownPhoto;

  @action
  void photoUnselected() {
    shownPhoto = null;
  }

  @action
  void addPhoto(Photo photo) {
    photos.add(photo);
  }

  @action
  void selectPhoto(Photo photo) {
    shownPhoto = photo;
  }
}
