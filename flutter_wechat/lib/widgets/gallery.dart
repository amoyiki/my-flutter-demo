// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// 图像浏览器
class GalleryWidget extends StatefulWidget {
  const GalleryWidget({
    Key? key,
    required this.initialIndex,
    required this.items,
    this.isBarVisible,
  }) : super(key: key);

  // 初始图片位置
  final int initialIndex;
  // 图片列表
  final List<AssetEntity> items;
  // 是否显示bar
  final bool? isBarVisible;
  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget>
    with SingleTickerProviderStateMixin {
  bool visible = true;
  // 动画控制器
  late final AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = widget.isBarVisible ?? true;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  Widget _buildImageView() {
    return ExtendedImageGesturePageView.builder(
        controller: ExtendedPageController(
          initialPage: widget.initialIndex,
        ),
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          final AssetEntity item = widget.items[index];
          return ExtendedImage(
            image: AssetEntityImageProvider(item, isOriginal: true),
            fit: BoxFit.contain,
            mode: ExtendedImageMode.gesture,
            initGestureConfigHandler: (state) {
              return GestureConfig(
                minScale: 0.9,
                animationMinScale: 0.7,
                maxScale: 3.0,
                animationMaxScale: 3.5,
                speed: 1.0,
                inertialSpeed: 100.0,
                initialScale: 1.0,
                inPageView: true,
              );
            },
          );
        });
  }

  Widget _mainView() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.black,
        body: _buildImageView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }
}
