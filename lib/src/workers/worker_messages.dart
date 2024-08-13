import 'dart:js_interop';

import '../shared_array_buffer.dart';

const SUBWORKER_LOADED_MSG = 1;
const SHARED_ARRAY_BUFFER_MSG = 2;
const ATOMIC_VALUE_MSG = 3;

@JS()
extension type WorkerMessage._(JSObject jsObject) implements JSObject {
  external int get type;
  external set _isWorkerMessage(bool value);
  external bool get _isWorkerMessage;
  bool get isWorkerMessage => _isWorkerMessage == true;
  external WorkerMessage.create({required int type});

  factory WorkerMessage() {
    var msg = WorkerMessage.create(type: SUBWORKER_LOADED_MSG);
    msg._isWorkerMessage = true;
    return msg;
  }
}

@JS()
extension type SubWorkerLoadedMessage._(WorkerMessage _workerMessage) implements WorkerMessage {
  external SubWorkerLoadedMessage._create({required int type});
  factory SubWorkerLoadedMessage() {
    var msg = SubWorkerLoadedMessage._create(type: SUBWORKER_LOADED_MSG);
    msg._isWorkerMessage = true;

    return msg;
  }
}

@JS()
extension type SharedArrayBufferMessage._(WorkerMessage _workerMessage) implements WorkerMessage {
  external SharedArrayBuffer data;
  external SharedArrayBufferMessage._create({required int type, required JSAny data});
  factory SharedArrayBufferMessage({required SharedArrayBuffer sab}) {
    var msg = SharedArrayBufferMessage._create(type: SHARED_ARRAY_BUFFER_MSG, data: sab);
    msg._isWorkerMessage = true;
    return msg;
  }
}
@JS()
extension type AtomicValueMessage._(WorkerMessage _workerMessage) implements WorkerMessage {
  external int data;
  external AtomicValueMessage._create({required int type, required int data});
  factory AtomicValueMessage({required int data}) {
    var msg = AtomicValueMessage._create(type: ATOMIC_VALUE_MSG, data: data);
    msg._isWorkerMessage = true;

    return msg;
  }
}
