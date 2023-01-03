part of 'screen_widget/screen_widget.dart';

class MaskWidget extends StatefulWidget {
  const MaskWidget({required this.child});

  final Widget child;
  @override
  State<StatefulWidget> createState() => _MaskWidgetState();
}

class _MaskWidgetState extends State<MaskWidget> with RouteAware {
  late GlobalKey globalKey;
  late List<GlobalKey> listOfMasks;
  final Logger logger = LoggerSDK.instance.maskWidgetLogger;
  @override
  void initState() {
    logger.d(
        'initState - child runtimeType: ${widget.child.runtimeType.toString()}');

    globalKey = GlobalKey();

    super.initState();
    // addMask(globalKey);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listOfMasks = _MaskList.of(context)!.listOfMasks;
    CustomRouteObserver.screenWidgetRouteObserver
        .subscribe(this, ModalRoute.of(context)!);
    logger.d('didChangeDependencies - listsOfMasks ${listOfMasks.toString()}');
  }

  @override
  void dispose() {
    logger.d('dispose');

    removeMask(globalKey);
    CustomRouteObserver.screenWidgetRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    logger.d('didPush');

    addMask(globalKey);
  }

  @override
  void didPopNext() {
    logger.d('didPopNext');

    // WidgetsBindingNullSafe.instance!.addPostFrameCallback((timeStamp) {
    addMask(globalKey);
    // });
  }

  @override
  void didPop() {
    logger.d('didPop');

    removeMask(globalKey);
  }

  @override
  void didPushNext() {
    logger.d('didPushNext');

    removeMask(globalKey);
  }

  void addMask(GlobalKey globalKey) {
    logger.d('addMask ${globalKey.toString()}');

    // if (listOfMasks == null)
    //   throw (StateError("MaskWidget must have an ancestor ScreenWidget"));
    if (!listOfMasks.contains(globalKey)) {
      listOfMasks.add(globalKey);
    }

    // if (!SessionReplay.instance.widgetsToMaskList.contains(globalKey)) {
    //   SessionReplay.instance.widgetsToMaskList.add(globalKey);
    // }
  }

  void removeMask(GlobalKey globalKey) {
    logger.d('removeMask ${globalKey.toString()}');

    //   final List<GlobalKey>? listOfMasks = _MaskList.of(context)?.listOfMasks;
    //   if (listOfMasks == null) return;
    if (listOfMasks.contains(globalKey)) {
      listOfMasks.remove(globalKey);
    }
  }

  void _debugCheckTabBarConfiguration(BuildContext context) {
    if (kDebugMode) {
      final bool isInsideTabBar =
          _ScreenWidgetInheritedWidget.of(context)?._child.tabController !=
              null;
      if (isInsideTabBar) {
        final bool hasScreenWidgetTabBarParent =
            context.getElementForInheritedWidgetOfExactType<
                    ScreenWidgetTabBar>() !=
                null;
        assert(
          hasScreenWidgetTabBarParent,
          '''
          This Mask is inside a TabBar that is not configured 
          correctly, a ScreenWidgetTabBar needs to wrap the body of 
          the Scaffold''',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _debugCheckTabBarConfiguration(context);
    return Ink(
      child: KeyedSubtree(
        key: globalKey,
        child: widget.child,
      ),
    );
  }
}
