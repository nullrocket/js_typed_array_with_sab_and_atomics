

Tests creating a SharedArrayBuffer and constructing a JSInt32Array and using it to 
pass shared array buffers between web workers. I have been trying to move away from package:js and dart:html to 
js_interop and package:web. 

JSTypedArray using a SharedArrayBuffer has broken a few times in the past and is hard to test with the 
current test package so this repo uses dependency_overrides to point to a forked version of the test package that has a workaround at https://github.com/nullrocket/test.git  only a few lines have
been modified to add the following headers to tests.  

  Cross-Origin-Embedder-Policy': 'require-corp'   
  Cross-Origin-Opener-Policy': 'same-origin'


The tests are normal dart tests using the package:test api, before running tests compile workers with the sdk currently
being tested.  You need to recompile the workers for every sdk you test against.  The tests only work using the dart2js
compiler, build.yaml and dart_test.yaml are set up to ensure consistent options are set.



Current status of tests.

  * Dart 3.4 (flutter stable) Passes
  * Dart 3.5 (flutter beta) Passes 
  * Dart 3.6 (master)  Fails due to a constructor being defined for JSTypedArrays and subtypes that doesn't take a SharedArrayBuffer
as an argument.



Build workers for test:
```shell
dart compile js  ./lib/src/workers/main_worker.dart -o ./test/workers/main_worker.js
dart compile js  ./lib/src/workers/sub_worker.dart -o ./test/workers/sub_worker.js
```


Run tests with:
```shell
dart test  -p chrome --reporter=expanded
```
--or--
```shell
dart run build_runner test -- -p chrome --reporter=expanded
```



