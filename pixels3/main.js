// fill canvas with an image computed with wasm module
const canvas = document.getElementById("cnvs");
const ctx = canvas.getContext("2d");
var draw_wasm;
var memory;

(async() => {
    let obj = await WebAssembly.instantiateStreaming(fetch('pix.wasm'));
    draw_wasm = obj.instance.exports.draw;
    memory = obj.instance.exports.mem;
})();

const input = document.querySelector('input');
input.addEventListener('input', updateValue);

function updateValue(e) {
    let mod = parseInt(e.target.value);
    draw(mod);
}

function draw(mod) {
    let cnvs_wid = canvas.width;
    let cnvs_ht = canvas.height;
    let img_buf_size = cnvs_wid * cnvs_ht * 4;
    draw_wasm(mod, cnvs_wid, cnvs_ht);
    let image_data = new ImageData(new Uint8ClampedArray(memory.buffer, 0, img_buf_size), cnvs_wid, cnvs_ht);
    ctx.putImageData(image_data, 0, 0);
}

function init() {
    let mod = parseInt(document.getElementById("mod").value);
    draw(mod);
}