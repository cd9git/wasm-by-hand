// fill canvas with an image computed with wasm module
const canvas = document.getElementById("cnvs");
const ctx = canvas.getContext("2d");
const cnvs_wid = canvas.width;
const cnvs_ht = canvas.height;
const img_buf_size = cnvs_wid * cnvs_ht * 4;
const pages = Math.ceil(img_buf_size / 65536);


const memory = new WebAssembly.Memory({ initial: pages, maximum: 100 });
const importObject = {
    env: {
        mem: memory,
    }
};
const image_data =
    new ImageData(new Uint8ClampedArray(memory.buffer, 0, img_buf_size), cnvs_wid, cnvs_ht);

var draw_wasm;

(async() => {
    let obj = await WebAssembly.instantiateStreaming(fetch('pix.wasm'),
        importObject);

    draw_wasm = obj.instance.exports.draw;
})();

const input = document.querySelector('input');
input.addEventListener('input', updateValue);

function updateValue(e) {
    var mod = parseInt(e.target.value);
    draw_wasm(mod, cnvs_wid, cnvs_ht);
    ctx.putImageData(image_data, 0, 0);
}