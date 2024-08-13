import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'shared_array_buffer.dart';

@JS('Int32Array')
external JSFunction get _int32ArrayConstructor;

/// An extension on JSInt32Array to create a typed array from a SharedArrayBuffer.
/// Not ideal but works within the current js_interop limitations.  Would be
/// nicer to have constructors on JSTypedArrays that accepted SharedArrayBuffer as an argument.
extension JSInt32ArrayExt on JSInt32Array {
  static JSInt32Array createFromSharedArrayBuffer(SharedArrayBuffer sab) {
    return _int32ArrayConstructor.callAsConstructor(sab);
  }

}


