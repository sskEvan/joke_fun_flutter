import 'package:flutter/material.dart';

/// 自定义进度条
class ProgressBar extends StatefulWidget {
  final Function()? onDragStart;
  final Function()? onDragEnd;
  final Function()? onDragUpdate;
  final Function(double value) onChange;
  final Key? key;
  double value;
  double width;
  double height;
  double trackHeight;
  double thumbSize;
  double thumbDraggingSize;
  Color activeTrackColor;
  Color inactiveTrackColor;
  Color thumbColor;
  bool isDragging = false;

  ProgressBar(
      {this.key,
      this.value = 0.0,
      this.width = double.infinity,
      this.height = 16,
      this.trackHeight = 2,
      this.thumbSize = 8,
      this.thumbDraggingSize = 12,
      this.activeTrackColor = Colors.white,
      this.inactiveTrackColor = Colors.white,
      this.thumbColor = Colors.white,
      this.onDragStart,
      this.onDragEnd,
      this.onDragUpdate,
      required this.onChange})
      : super(key: key);

  @override
  ProgressBarState createState() {
    return ProgressBarState();
  }
}

class ProgressBarState extends State<ProgressBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Container(
          height: widget.height,
          width: widget.width,
          color: Colors.transparent,
          child: CustomPaint(
            painter: _ProgressBarPainter(
                widget.value,
                widget.isDragging,
                widget.trackHeight,
                widget.thumbSize,
                widget.thumbDraggingSize,
                widget.activeTrackColor,
                widget.inactiveTrackColor,
                widget.thumbColor),
          ),
        ),
      ),
      onHorizontalDragStart: (DragStartDetails details) {
        _seekToRelativePosition(details.globalPosition);
        widget.onDragStart ?? ();
        setState(() {
          widget.isDragging = true;
        });
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        _seekToRelativePosition(details.globalPosition);
        widget.onDragUpdate ?? ();
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        widget.onDragEnd ?? ();
        setState(() {
          widget.isDragging = false;
        });
      },
      onTapDown: (TapDownDetails details) {
        _seekToRelativePosition(details.globalPosition);
      },
    );
  }

  void _seekToRelativePosition(Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox;
    final Offset tapPos = box.globalToLocal(globalPosition);
    final double relative = tapPos.dx / box.size.width;
    if (relative >= 0 && relative <= 1) {
      widget.value = relative;
      widget.onChange(relative);
      setState(() {});
    }
  }
}

class _ProgressBarPainter extends CustomPainter {
  final double trackHeight;
  final double thumbSize;
  final double thumbDraggingSize;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color thumbColor;
  final Paint _paint = Paint();

  bool isDragging;
  double value;

  _ProgressBarPainter(
    this.value,
    this.isDragging,
    this.trackHeight,
    this.thumbSize,
    this.thumbDraggingSize,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
  );

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double playedPart = value > 1 ? size.width : value * size.width;

    _paint.color = activeTrackColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(0.0, (size.height - trackHeight) / 2),
          Offset(playedPart, (size.height + trackHeight) / 2),
        ),
        Radius.circular(trackHeight),
      ),
      _paint,
    );
    _paint.color = inactiveTrackColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(playedPart, (size.height - trackHeight) / 2),
          Offset(size.width, (size.height + trackHeight) / 2),
        ),
        Radius.circular(trackHeight),
      ),
      _paint,
    );
    _paint.color = thumbColor;
    canvas.drawCircle(
      Offset(playedPart, size.height / 2),
      (isDragging ? thumbDraggingSize / 2 : thumbSize / 2),
      _paint,
    );
  }
}
