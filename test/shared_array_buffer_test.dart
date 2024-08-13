@TestOn('dart2js')
library;

import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';
import 'package:test/test.dart';

import 'package:js_typed_array_with_sab_and_atomics/src/int_32_array_ext.dart';
import 'package:js_typed_array_with_sab_and_atomics/src/shared_array_buffer.dart';
import 'package:js_typed_array_with_sab_and_atomics/src/web_worker_event.dart';
import 'package:js_typed_array_with_sab_and_atomics/src/workers/worker_messages.dart';

import 'package:web/web.dart' hide Int32List;

void main() {
  test('Cross origin headers enabled for tests', () {
    expect(window.crossOriginIsolated, true,
        reason:
            "crossOriginIsolated must be enable.  The dart test package does not enable the cross origin headers headers automatically. "
            "Use the patched test package from git that enables them.");
  });

  test('Create a SharedArrayBuffer', () {
    var sab = SharedArrayBuffer(4);
    expect(sab, isA<SharedArrayBuffer>());
    expect(true, sab.instanceOfString('SharedArrayBuffer'));
  });

  test('SharedArrayBuffer growable property', () {
    var sab = SharedArrayBuffer(4, SharedArrayBufferOptions(maxByteLength: 8));
    expect(true, sab.growable, reason: "SharedArrayBuffer should be able to grow if created with maxByteLength option");
  });

  test('SharedArrayBuffer grow method', () {
    var sab = SharedArrayBuffer(4, SharedArrayBufferOptions(maxByteLength: 8));
    expect(() => sab.grow(8), returnsNormally,
        reason: "SharedArrayBuffer should not throw when grown with a size less than or equal to maxByteLenght");
    expect(sab.byteLength, 8);
    expect(() => sab.grow(20), throwsA(isA<ArgumentError>()),
        reason: "SharedArrayBuffer throw when trying to grow larger than maxByteLength");
    expect(() => sab.grow(4), throwsA(isA<ArgumentError>()),
        reason: "SharedArrayBuffer throw when trying to shrink to smaller than byteLength");
  });

  test('SharedArrayBuffer slice method', () {
    var sab = SharedArrayBuffer(16);
    var int32Array = JSInt32ArrayExt.createFromSharedArrayBuffer(sab);
    expect(int32Array, [0, 0, 0, 0]);
    int32Array.toDart.buffer.asInt32List()[1] = 42;
    var sliced = JSInt32ArrayExt.createFromSharedArrayBuffer(sab.slice(4, 12));
    expect(sliced, [42, 0]);
  });

  test('Pass a SharedArrayBuffer to a JSInt32Array', () {
    SharedArrayBuffer sab = SharedArrayBuffer(4);
    JSInt32Array int32array = JSInt32ArrayExt.createFromSharedArrayBuffer(sab);
    expect(int32array, isA<JSInt32Array>());
  });

  test('Cast a JSInt32Array to a Int32List', () {
    SharedArrayBuffer sab = SharedArrayBuffer(4);
    JSInt32Array int32array = JSInt32ArrayExt.createFromSharedArrayBuffer(sab);
    Int32List int32list = int32array.toDart;
    expect(int32list, isA<Int32List>());
  });

  test('Call Int32List.buffer.asUint8List', () {
    SharedArrayBuffer sab = SharedArrayBuffer(4);
    JSInt32Array int32array = JSInt32ArrayExt.createFromSharedArrayBuffer(sab);
    Int32List int32list = int32array.toDart;
    expect(() => int32list.buffer.asUint8List(), returnsNormally, reason: "Throws an error accessing asUint8List");
  });


  test('Share a SharedArrayBuffer between web Workers and increment a value using Atomics', () async {
    Worker worker = Worker('workers/main_worker.js' as JSString);
    var completer = Completer<dynamic>();
    worker.onmessage = (WebWorkerEvent message) {
      var msg = message.data as WorkerMessage;
      switch (msg.type) {
        case ATOMIC_VALUE_MSG:
          completer.complete((msg as AtomicValueMessage).data);
        default:
      }
    }.toJS;

    var atomicValue = await completer.future;

    expect(6, atomicValue);
  });
}
