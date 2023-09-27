import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/common/util/keyboard_util.dart';
import 'package:joke_fun_flutter/common/util/preference_utils.dart';
import 'package:joke_fun_flutter/common/util/toast_util.dart';
import 'package:joke_fun_flutter/common/view_state/view_state_logic.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/theme/color_palettes.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PublishLogic extends ViewStateLogic {
  final String _editInfoMapKey = "_editInfoMapKey";

  TextEditingController textEditingController = TextEditingController();
  RxString input = "".obs;
  RxBool isInputValid = false.obs;
  List<AssetEntity> _selectedImageAssets = [];
  RxList<String> imagePaths = <String>[].obs;
  AssetEntity? selectedVideoAsset;
  RxString videoPath = "".obs;
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() async {
    super.onInit();
    String localJson = PreferenceUtils.instance.getString(_editInfoMapKey);
    if (localJson.isNotEmpty) {
      Map<String, dynamic> localEditInfoMap = jsonDecode(localJson);
      updateInput(localEditInfoMap["input"]);
      if (localEditInfoMap["selectedImageAssetIds"] != null) {
        List<String> selectedImageAssetIds =
            localEditInfoMap["selectedImageAssetIds"].cast<String>();
        for (var assetId in selectedImageAssetIds) {
          AssetEntity? asset = await AssetEntity.fromId(assetId);
          if (asset != null) {
            _selectedImageAssets.add(asset);
          }
        }
      }
      if (localEditInfoMap["imagePaths"] != null) {
        imagePaths.value = localEditInfoMap["imagePaths"].cast<String>();
      }
      if (localEditInfoMap["selectedVideoAssetId"] != null) {
        AssetEntity? asset = await AssetEntity.fromId(localEditInfoMap["selectedVideoAssetId"]);
        if (asset != null) {
          selectedVideoAsset = asset;
        }
      }
      if (localEditInfoMap["videoPath"] != null) {
        videoPath.value = localEditInfoMap["videoPath"];
      }
    }
  }

  void updateInput(String value) {
    input.value = value;
    isInputValid.value = value.isNotEmpty;
    textEditingController.value = TextEditingValue(
        text: value,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: value.length)));
  }

  void selectPics(BuildContext context) async {
    if (videoPath.value.isNotEmpty) {
      videoPath.value = "";
      selectedVideoAsset = null;
    }

    await AssetPicker.pickAssets(context,
            pickerConfig: AssetPickerConfig(
                selectedAssets: _selectedImageAssets,
                requestType: RequestType.image,
                themeColor: ColorPalettes.instance.primary,
                textDelegate: const AssetPickerTextDelegate()))
        .then((List<AssetEntity>? list) async {
      if (list != null) {
        _selectedImageAssets = list;
        imagePaths.clear();
        for (var asset in _selectedImageAssets) {
          File? imgFile = await asset.file;
          if (imgFile != null) {
            imagePaths.add(imgFile.path);
          }
        }
      }
      focusNode.unfocus();
      hideKeyboard();
    });
  }

  void selectVideo(BuildContext context) async {
    imagePaths.clear();
    _selectedImageAssets.clear();

    await AssetPicker.pickAssets(context,
            pickerConfig: AssetPickerConfig(
                selectedAssets:
                    (selectedVideoAsset == null) ? null : [selectedVideoAsset!],
                maxAssets: 1,
                requestType: RequestType.video,
                themeColor: ColorPalettes.instance.primary,
                textDelegate: const AssetPickerTextDelegate()))
        .then((List<AssetEntity>? list) async {
      if (list != null) {
        selectedVideoAsset = list[0];
        File? videoFile = await selectedVideoAsset!.file;
        if (videoFile != null) {
          videoPath.value = videoFile.path;
        }
      }
      focusNode.unfocus();
      hideKeyboard();
    });
  }

  void removePic(String path) {
    _selectedImageAssets.removeAt(imagePaths.indexOf(path));
    imagePaths.remove(path);
    imagePaths.refresh();
  }

  void publish() {
    sendRequest(RetrofitClient.instance.apiService.postJoke(input.value, 1),
        bindViewState: false,
        showLoadingDialog: true,
        emptyAsSuccess: true, successCallback: (value) {
      showToast("发布成功");
      clearEditInfo();
      Get.back();
    });
  }

  bool hasEdit() =>
      input.isNotEmpty || imagePaths.isNotEmpty || videoPath.isNotEmpty;

  void saveEditInfo() {
    Map<String, dynamic> editInfoMap = {
      "input": input.value,
      "imagePaths": imagePaths,
      "selectedImageAssetIds": _selectedImageAssets.map((e) => e.id).toList(),
      "videoPath": videoPath.value,
      "selectedVideoAssetId": selectedVideoAsset?.id,
    };
    String json = jsonEncode(editInfoMap);
    PreferenceUtils.instance.putString(_editInfoMapKey, json);

    Get.back();
  }

  void clearEditInfo() {
    input.value = "";
    _selectedImageAssets.clear();
    imagePaths.clear();
    videoPath.value = "";
    selectedVideoAsset = null;
    PreferenceUtils.instance.putString(_editInfoMapKey, "");
    Get.back();
  }


}
