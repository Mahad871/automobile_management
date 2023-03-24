import 'package:automobile_management/dependency_injection/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  const BaseView({Key? key, required this.builder, required this.onModelReady})
      : super(key: key);
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Function(T) onModelReady;

  @override
  BaseViewState<T> createState() => BaseViewState<T>();
}

class BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  T? model = sl<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: sl<T>(),
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
