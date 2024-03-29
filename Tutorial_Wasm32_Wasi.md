# How to run wasm applications with wasmedge-core (General Wasm32-wasi with interpreter mode)

## Environment Setup for Rust, Nodejs, and rustwasmc

```bash
$ sudo apt-get update
$ sudo apt-get -y upgrade
$ sudo apt install build-essential curl wget git vim libboost-all-dev

$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
$ source $HOME/.cargo/env

$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

$ export NVM_DIR="$HOME/.nvm"
$ [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
$ [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

$ nvm install v14.2.0
$ nvm use v14.2.0

$ npm i -g rustwasmc
```

## Example 1. Print environment variables, arguments, and test filesystem

### Create a new rust project

```bash
cargo new file-example
cd file-example
```

### Write Rust code

Below is the entire content of the `src/main.rs` file.

```rust
use std::env;
use std::fs;
use std::fs::File;
use std::io::{Write, Read};

fn main() {
    println!("This is a demo application to show how to run a standalone wasi program with wasmedge-core!");
    println!("============================================");
    println!("Print environment variables");
    println!("--------------------------------------------");
    println!("The env vars are as follows.");
    for (key, value) in env::vars() {
        println!("{}: {}", key, value);
    }
    println!("============================================\n");
    println!("Print arguments");
    println!("--------------------------------------------");
    println!("The args are as follows.");
    for argument in env::args() {
        println!("{}", argument);
    }
    println!("============================================\n");
    println!("Test filesystem, create a /hello.txt, read and write to it, and then delete it");
    println!("--------------------------------------------");
    let path = "/hello.txt".to_string();
    let content = "Hello from WasmEdge\nThis file is located at wasm binary folder".to_string();
    let mut output = File::create(&path).unwrap();
    output.write_all(&content.as_bytes()).unwrap();
    let mut f = File::open(&path).unwrap();
    let mut s = String::new();
    let ret = match f.read_to_string(&mut s) {
        Ok(_) => s,
        Err(e) => e.to_string(),
    };
    println!("Output: {}", ret);
    fs::remove_file(&path).expect("Unable to delete");
    println!("============================================\n");
}
```

### Build the WASM bytecode with cargo wasm32-wasi backend

```bash
cargo build --release --target wasm32-wasi
```

After building, our target wasm file is located at `target/wasm32-wasi/release/file-example.wasm`.

### Install WasmEdge-core addon for your application

```bash
npm install wasmedge-core
```

or if you want to build from source:

```bash
export CXX=g++-9
npm install --build-from-source https://github.com/second-state/wasmedge-core
```

### Use WasmEdge addon
After installing the WasmEdge addon, we could now interact with `file_example.wasm` generated by wasm32-wasi backend in Node.js.

- Create js file `app.js` and `lib.js` in the root folder.

#### Folder structure

```
├── Cargo.lock
├── Cargo.toml
├── README.md
├── app.js
├── lib.js
├── package-lock.json
├── src
│   └── main.rs
└── target
    ├── release
    │   ├── ...omitted...
    │   └── incremental
    └── wasm32-wasi
        └── release
            ├── ...omitted...
            ├── file-example.d
            ├── file-example.wasm
            └── incremental
```

#### The entire content of `app.js`:

```javascript
const { file_demo } = require('./lib.js');

file_demo();
```

#### The entire content of `lib.js`:

```javascript
let vm;
module.exports.file_demo = function() {
        return vm.Start();
};

const wasmedge = require('wasmedge-core');
const path = require('path').join(__dirname, 'target/wasm32-wasi/release/file-example.wasm');

vm = new wasmedge.VM(path, {"EnableWasiStartFunction": true, env: process.env, args: process.argv, preopens:{'/': __dirname}});
```

### Execute and check results

```bash
$ node app.js arg1 arg2

This is a demo application to show how to run a standalone wasi program with wasmedge-core!
============================================
Print environment variables
--------------------------------------------
The env vars are as follows.
LANG: C.UTF-8
(...omitted...)
PATH: /bin:/usr/local/sbin:/usr/local/bin:/usr/local/sbin
PWD: /home/hydai/workspace/wasm-learning/ssvm/file-example
_: /home/hydai/.nvm/versions/node/v14.5.0/bin/node
============================================

Print arguments
--------------------------------------------
The args are as follows.
_start
arg1
arg2
============================================

Test filesystem, create a /hello.txt, read and write to it, and then delete it
--------------------------------------------
Output: Hello from WasmEdge
This file is located at wasm binary folder
============================================
```

