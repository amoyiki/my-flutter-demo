import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../utils/config.dart';
import '../widgets/gallery.dart';

class PostEditPage extends StatefulWidget {
  const PostEditPage({super.key});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  // 已选中图片列表
  List<AssetEntity> _selectedAssets = [];
  Widget _buildPhotoList() {
    return Padding(
      padding: const EdgeInsets.all(spacing),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double width = (constraints.maxWidth - spacing * 2) / 3;
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              for (final asset in _selectedAssets)
                _buildPhotoItem(asset, width),
              // 小于9张图片显示添加按钮
              if (_selectedAssets.length < maxAssets)
                _buildAddButton(context, width)
            ],
          );
        },
      ),
    );
  }

  // 添加图片按钮
  Widget _buildAddButton(BuildContext context, double width) {
    return GestureDetector(
      onTap: () async {
        // 显示已选中图片
        final List<AssetEntity>? result = await AssetPicker.pickAssets(context,
            pickerConfig: AssetPickerConfig(
                selectedAssets: _selectedAssets, maxAssets: maxAssets));
        setState(() {
          _selectedAssets = result ?? [];
        });
      },
      child: Container(
        color: Colors.black12,
        width: width,
        height: width,
        child: const Icon(
          Icons.add,
          size: 48,
          color: Colors.black38,
        ),
      ),
    );
  }

  // 显示图片项
  Widget _buildPhotoItem(AssetEntity asset, double width) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return GalleryWidget(
            initialIndex: _selectedAssets.indexOf(asset),
            items: _selectedAssets,
          );
        }));
      },
      child: Container(
        // 圆角行为
        clipBehavior: Clip.antiAlias,
        // 圆角弧度
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),
        child: AssetEntityImage(
          asset,
          width: width,
          height: width,
          fit: BoxFit.cover,
          isOriginal: false, // 非原图，减小刷新
        ),
      ),
    );
  }

  // 主视图
  Widget _mainView() {
    return Column(
      children: [
        _buildPhotoList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("发布")),
      body: _mainView(),
    );
  }
}
