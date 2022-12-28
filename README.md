# Webassembly by hand
Minimalistic html examples using webassembly code written by hand thru WAT (webassembly text format).
Rely on wat2wasm command from WebAssembly Binary Toolkit (WABT) 
--> https://github.com/WebAssembly/wabt

This repo comes with a static file webserver (post to 8100 port by default), run
    ./webserver

To generate all necessary binary files (wasm and a webserver), simply run
    make
