

import 'dart:js_interop';
import 'package:web/web.dart';

import '../atomics.dart';
import '../shared_array_buffer.dart';
import '../web_worker_event.dart';
import 'worker_messages.dart';


import '../int_32_array_ext.dart';

/// Waits for a message from the main worker containing a SharedArrayBuffer then increments
/// it and notifies waiting atomics that it has changed.

void main() {
  var self = globalContext as DedicatedWorkerGlobalScope;
  SharedArrayBuffer sab;
  JSInt32Array int32array;
  self.onmessage = (WebWorkerEvent message) {
    var msg = message.data as SharedArrayBufferMessage;
    // Post back to the main worker that the SharedArrayBuffer has been received.
    self.postMessage(SubWorkerLoadedMessage());
    sab = msg.data;
    int32array = JSInt32ArrayExt.createFromSharedArrayBuffer(sab);
    // Atomically store a value at index 0 of the SharedArrayBuffer.
    Atomics.store(int32array, 0, 6);
    // Notify the main worker that the value has been changed.
    Atomics.notify(int32array, 0);
  }.toJS;
}
