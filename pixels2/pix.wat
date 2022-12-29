(module
  ;;(memory $mem 1)
  (import "env" "mem" (memory $mem 50))
  (func $draw (param $mod i32) (param $W i32) (param $H i32) 
    (local $x i32)
    (local $y i32)
    (local $idx i32)
(;     (local $pages i32)
    (local.set $pages 
      (i32.div_u 
        (i32.mul 
          (i32.mul (local.get $W)(local.get $H))
          (i32.const 4))
        (i32.const 65536)))
    (drop (memory.grow (local.get $pages))) ;)
    (local.set $idx (i32.const 0))
    (local.set $y (i32.const 0))
    (loop $loopy
      (if (i32.lt_s (local.get $y) (local.get  $H))
        (then
          (local.set $x (i32.const 0))
          (loop $loopx
            (if (i32.lt_s (local.get $x) (local.get $W))
              (then
                (local.set $idx (i32.add (local.get $idx)(i32.const 4)))
                (i32.store 
                  (local.get $idx)
                  (call $color (local.get $mod)(local.get $x)(local.get $y)))
                (local.set $x (i32.add (local.get $x) (i32.const 1)))
                (br $loopx))))
          (local.set $y (i32.add (local.get $y) (i32.const 1)))
          (br $loopy)))))
  
  ;; func color(x, y) return color of a pixel
  ;; 
  (func $color (param $mod i32) (param $x i32) (param $y i32)
    (result i32)
    (local $res i32)
    (if (i32.eqz (i32.rem_u (i32.xor(local.get $x)(local.get $y)) (local.get $mod)))
      (then
        (local.set $res (i32.const 0xffffffff)))
      (else 
        (local.set $res (i32.const 0xff000000))))
    (local.get $res))
  (export "draw" (func $draw))
)
