// fill canvas with an image computed with wasm module

function draw() {
    var canvas = document.getElementById('image');
    var ctx = canvas.getContext('2d');
    var wid = canvas.width;
    var ht = canvas.height;
    var mod = parseInt(document.getElementById("mod").value);


    WebAssembly.instantiateStreaming(fetch('pix.wasm'))
        .then(obj => {
            console.log(mod);
            obj.instance.exports.draw(mod, wid, ht);
            let image_data =
                new ImageData(new Uint8ClampedArray(obj.instance.exports.mem.buffer, 0, 4 * wid * ht), wid, ht);
            //console.log(image_data)
            //document.getElementById("textcontent").innerHTML = wid + "x" + ht + " x^y%9 ";
            ctx.putImageData(image_data, 0, 0);


        })
}