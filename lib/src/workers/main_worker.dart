


import 'dart:js_interop';
import 'package:web/web.dart';


import '../atomics.dart';
import '../int_32_array_ext.dart';
import '../shared_array_buffer.dart';
import '../web_worker_event.dart';
import 'worker_messages.dart';

/// A web worker that spawns a sub worker then posts a SharedArrayBuffer to it and
/// then waits for it to increment a atomic value, after the value is incremented it
/// posts a message back to the main process.
void main() {
  var self = globalContext as DedicatedWorkerGlobalScope;
  var subWorker = Worker('sub_worker.js'.toJS);
  SharedArrayBuffer sab = SharedArrayBuffer(4);
  JSInt32Array int32array = JSInt32ArrayExt.createFromSharedArrayBuffer(sab);

  // Post the shared array buffer to a sub worker.
  subWorker.postMessage(SharedArrayBufferMessage(sab: sab));

  // Wait for the sub worker to respond that it has been loaded.
  subWorker.onmessage = (WebWorkerEvent message) {
    var msg = message.data as WorkerMessage;
    switch (msg.type) {
      case SUBWORKER_LOADED_MSG:
        // Pause execution waiting fo the sub worker to increment the value.
        Atomics.wait(int32array, 0, 0);
        // Post back the new value to the main thread.
        self.postMessage(AtomicValueMessage(data: Atomics.load(int32array, 0)));
      default:
      // Do nothing
    }
  }.toJS;
}
