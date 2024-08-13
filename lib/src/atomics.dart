

import 'dart:js_interop';



@JS("Atomics")
extension type Atomics._(JSObject _) implements JSObject {
  @JS('add')
  external static int add(JSTypedArray typedArray, int index, int value);

  @JS('and')
  external static int and(JSTypedArray typedArray, int index, int value);

  @JS('compareExchange')
  external static int compareExchange(
      JSTypedArray typedArray, int index, int expectedValue, int replacementValue);

  @JS('exchange')
  external static int exchange(JSTypedArray typedArray, int index, int value);

  @JS('isLockFree')
  external static bool isLockFree(int size);

  @JS('load')
  external static int load(JSTypedArray typedArray, int index);

  @JS('notify')
  external static int notify(JSTypedArray typedArray, int index, [int count]);

  @JS('or')
  external static int or(JSTypedArray typedArray, int index, int value);

  @JS('store')
  external static int store(JSTypedArray typedArray, int index, int value);

  @JS('sub')
  external static int sub(JSTypedArray typedArray, int index, int value);

  @JS('wait')
  external static String wait(JSTypedArray typedArray, int index, int value,
      [num timeout]);

  @JS('xor')
  external static int xor(JSTypedArray typedArray, int index, int value);

  @JS('waitAsync')
  external static JSPromise awaitAsync(JSTypedArray typedArray,int index, int value);
}



