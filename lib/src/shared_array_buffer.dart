import 'dart:js_interop';



/// Options for SharedArrayBuffer constructor
@JS()
extension type SharedArrayBufferOptions._(JSObject _jsObject) implements JSObject {
  external SharedArrayBufferOptions({int maxByteLength});
  external int get maxByteLength;
}


/// SharedArrayBuffer
@JS('SharedArrayBuffer')
extension type SharedArrayBuffer._(JSObject _jsObject) implements JSObject {
  /// Creates a JavaScript `ShardArrayBuffer` of size [length] using an optional
  /// [SharedArrayBufferOptions] JavaScript object that sets the `maxByteLength`.
  external SharedArrayBuffer(int length, [SharedArrayBufferOptions options]);

  /// The maxByteLength accessor property of SharedArrayBuffer instances returns the
  /// maximum length (in bytes) that this SharedArrayBuffer can be grown to.
  /// The value is established when the shared array is constructed, set via the maxByteLength
  /// option of the SharedArrayBuffer() constructor, and cannot be changed.
  /// If this SharedArrayBuffer was constructed without specifying a maxByteLength
  /// value, this property returns a value equal to the value of the
  /// SharedArrayBuffer's byteLength.
  external int maxByteLength;

  ///The byteLength accessor property of SharedArrayBuffer instances returns the length
  ///(in bytes) of this SharedArrayBuffer.
  external int byteLength;

  /// The growable accessor property of SharedArrayBuffer instances returns whether this
  /// SharedArrayBuffer can be grow or not.
  ///
  /// The growable property is an accessor property whose set accessor function is undefined,
  /// meaning that you can only read this property. The value is established when the array
  /// is constructed. If a maxByteLength option was set in the constructor, growable will return
  /// true; if not, it will return false.
  external bool growable;

  /// The grow() method grows a SharedArrayBuffer to the size specified by the newLength
  /// parameter, provided that the SharedArrayBuffer is growable and the new size is less
  /// than or equal to the maxByteLength of the SharedArrayBuffer. New bytes are
  /// initialized to 0.
  external void grow(int newLength);

  /// The slice() method of SharedArrayBuffer instances returns a new SharedArrayBuffer
  /// whose contents are a copy of this SharedArrayBuffer's bytes from start, inclusive,
  /// up to end, exclusive. If either start or end is negative, it refers to an index
  /// from the end of the array, as opposed to from the beginning.
  external SharedArrayBuffer slice([int begin, int end]);
}
