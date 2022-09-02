import 'package:bloc/bloc.dart';
import 'package:flutter_tst/ProductImageVideoModels/image_file_model.dart';
import 'package:flutter_tst/ProductImageVideoModels/video_file_model.dart';
import 'package:flutter_tst/BLOC/productBloc/blocLayer/blocEvents.dart';
import 'package:flutter_tst/BLOC/productBloc/blocLayer/blocModel.dart';

class ProductBloc extends Bloc<ProductEvent, blocModel> {
  ProductBloc()
      : super(blocModel(
            title: "",
            desc: "",
            price: 0,
            quantity: 0,
            category: "",
            user: "",
            images: ImageFileModel(),
            videos: VideoFileModel(),
            attr: {},
            attrVal: {})) {
    on<ChangeTitle>((event, emit) => emit(state.copyWith(title: event.title)));
    on<ChangeDesc>((event, emit) => emit(state.copyWith(desc: event.desc)));
    on<ChangePrice>((event, emit) => emit(state.copyWith(price: event.price)));
    on<ChangeQuantity>(
        (event, emit) => emit(state.copyWith(quantity: event.quan)));
    on<ChangeCategory>(
        (event, emit) => emit(state.copyWith(category: event.id)));
    on<ChangeUser>((event, emit) => emit(state.copyWith(user: event.id)));
    on<AddUploadImage>((event, emit) {
      state.addImage(event.image);
      emit(state.copyWith(images: state.images));
    });
    on<RemoveUploadImage>((event, emit) {
      state.removeImage(event.image);
      emit(state.copyWith(images: state.images));
    });
    on<AddUploadVideo>((event, emit) {
      state.videos.addFile(event.video, event.thumbnailImage);
      emit(state.copyWith(videos: state.videos));
    });
    on<RemoveUploadVideo>((event, emit) {
      state.removeVideo(event.video, event.thumbnailImage);
      emit(state.copyWith(videos: state.videos));
    });
    on<ChangeAttr>((event, emit) {
      emit(state.copyWith(attr: event.attr));
    });
    on<ChangeAttrVal>((event, emit) {
      emit(state.copyWith(attrVal: event.attrVal));
    });
  }
}
