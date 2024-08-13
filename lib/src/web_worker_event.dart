import 'dart:js_interop';
import 'package:web/web.dart';

@JS('Event')
extension type WebWorkerEvent._(JSObject _jsObject) implements Event {
external JSAny get data;
}