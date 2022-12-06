
import 'package:flutter/material.dart';

class ChartPaint extends CustomPainter {
  final List<String> x;
  final List<double> y;
  final double min, max;
  ChartPaint(this.x, this.y, this.min, this.max);

  final Color backgroundColor = Colors.black;
  final linePaint =Paint()
  ..color = Colors.white
  ..style = PaintingStyle.stroke
  ..strokeWidth = 1.0;

  
  final ylabelStyle = TextStyle(color: Colors.white38, fontSize: 14);
  final xLabelStyle = TextStyle(color: Colors.white38, fontSize: 16, fontWeight: FontWeight.bold);
  static double border = 10.0;
  static double radius = 5;

  
  @override
  void paint(Canvas canvas, Size size) {
    final dotPaintFill = Paint()
    ..color = backgroundColor
    ..style = PaintingStyle.fill
    ..strokeWidth = 1.0;

    final clipRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(clipRect);
    canvas.drawPaint(Paint()..color = backgroundColor);
    // computer the drawable chart width and height
    final drawableHeight = size.height - 2.0 * border;
    final drawableWidth = size.width*2.5 - 2.0 * border;
    final hd = drawableHeight / 5.0;
    final wd = drawableWidth / this.x.length.toDouble();

    final height = hd * 3.0;
    final width = drawableWidth;
    //escape if values are invalid
    if(height <= 0.0 || width <= 0.0) return;
    if(max - min < 1.0e-6) return;

    final hr = height/ (max-min);//height per unit value
    final left = border;
    final top = border *6;
    final c = Offset(left + wd/2.0, top+ height/2.0);
    _drawOutline(canvas, c, wd, height);

    final points = _computerPoints(c, wd, height, hr);
    final path = _computerPath(points);
    final labels = _computerLabels();
    
    //draw data points and labels
    canvas.drawPath(path, linePaint);
    _drawDataPoints( canvas, points, dotPaintFill);
    _drawYLabels( canvas,labels,points, wd, top);

  //_draw x Labels
  final c1 = Offset(c.dx, top - border*3);
    _drawXLabels(canvas, c1, wd);

  }


  void _drawXLabels(Canvas canvas, Offset c ,double wd ){
    x.forEach((xp) {
      drawTextCentered(canvas, c, xp, xLabelStyle, wd);
      c += Offset(wd, 0);
    });
  }
  void _drawYLabels(
    Canvas canvas, List<String> labels,List<Offset> points, double wd , double top ){
      var i = 0;
    labels.forEach((label) { 
      final dp = points[i];
      final dy = (dp.dy -15.0)< top ? 15.0 : -15.0;
      final ly = dp + Offset(0, dy);
      drawTextCentered(canvas, ly, label, ylabelStyle, wd);
      i++;

    });
  }
  void _drawDataPoints(
    Canvas canvas, List<Offset> points, Paint dotPaintFill) {
    points.forEach((dp) {
      canvas.drawCircle(dp, radius, dotPaintFill);
      canvas.drawCircle(dp, radius, linePaint);
    });
  }

  Path _computerPath(List<Offset> points) {
    final Path path = Path();
    for(var i = 0; i < points.length; i++){
      final p = points[i];
      if(i == 0 ){
        path.moveTo(p.dx, p.dy);
      }else{
        path.lineTo(p.dx, p.dy);
      }
    }
    return path;
  }
    

  List<Offset>  _computerPoints(Offset c, double width, double height, double hr) {
    List<Offset> points = [];
    y.forEach((yp) {
      final yy =height - (yp - min) *hr;
      final dp = Offset(c.dx, c.dy - height/2.0 + yy);
      points.add(dp);
      c += Offset(width, 0);
    });
  return points;
 }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
  final Paint outlinePaint = Paint()
  ..strokeWidth = 1.0
  ..style = PaintingStyle.stroke
  ..color = Colors.white;

  void _drawOutline(Canvas canvas, Offset c, double width, double height) {
    y.forEach((p) {
      final rect = Rect.fromCenter(center: c, width: width, height: height);
      canvas.drawRect(rect, outlinePaint);
      c += Offset(width, 0);
    });
  }
  
  List<String> _computerLabels() {
    return y.map((yp) => "${yp.toStringAsFixed(1)}").toList();
  }
  
  TextPainter measureText ( String s, TextStyle style, double maxWidth, TextAlign align){
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(text: span, textAlign: align, textDirection: TextDirection.ltr);
  tp.layout(minWidth: 0, maxWidth: maxWidth);
  return tp;
  }
  Size drawTextCentered(Canvas canvas, Offset c, String text, TextStyle style , double maxWidth) {
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final offset = c + Offset(-tp.width / 2.0, -tp.height/2.0);
    tp.paint(canvas, offset);
    return tp.size;
  }
    
  
}