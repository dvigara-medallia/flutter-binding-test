import 'package:decibel_sdk/features/session_replay.dart';
import 'package:decibel_sdk/utility/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MaskWidget extends StatefulWidget {
  MaskWidget({required this.child}) : super(key: GlobalKey());

  final Widget child;

  @override
  State<StatefulWidget> createState() => _MaskWidgetState();
}

class _MaskWidgetState extends State<MaskWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(),
      onVisibilityChanged: (VisibilityInfo info) {
        if (widget.key != null) {
          if (info.visibleFraction == VisibilityConst.notVisible) {
            SessionReplay.instance.widgetsToMaskList.remove(widget.key);
          } else {
            // if (!SessionReplay.instance.widgetsToMaskList
            //     .contains(widget.key! as GlobalKey)) {
            // }
            SessionReplay.instance.widgetsToMaskList
                .add(widget.key! as GlobalKey);
            //debugPrint('++++++++++++++ ADDED MASK ++++++++++++++++');
            //TODO: How to ensure masks has been loaded?
          }
        }
      },
      child: widget.child,
    );
  }
}
