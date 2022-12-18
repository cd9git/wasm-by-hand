(module
    (memory $mem 1)
    (export "mem" (memory $mem))
    (global $z (mut i32) (i32.const 362436069))
    (global $w (mut i32) (i32.const 521288629))
    (global $jsr (mut i32) (i32.const 123456789))
    (global $jcong (mut i32) (i32.const 380116160))
    (func $randoms (export "randoms" ) (param $n i32)
        (local $idx i32)
        (local $pages i32)
        (local.set $pages 
            (i32.div_u 
                (i32.mul 
                    (local.get $n)
                    (i32.const 4))
                (i32.const 65536)))
        (drop (memory.grow (local.get $pages)))
        (local.set $idx (i32.const 0))
        (loop $loopn
            (if (i32.gt_s (local.get $n) (i32.const 0))
                (then
                    (i32.store 
                        (local.get $idx)
                        (call $kiss))
                    (local.set $idx (i32.add (local.get $idx)(i32.const 4)))
                    (local.set $n (i32.sub (local.get $n)(i32.const 1)))
            (br $loopn)))))
    (func $kiss (export "kiss") (result i32)
        ;; Kiss algorithm 
        ;; --> http://www.cse.yorku.ca/~oz/marsaglia-rng.html
        (local $MWC i32)
        ;; znew in algo
        (global.set $z 
            (i32.add 
                (i32.mul 
                    (i32.const 36969)
                    (i32.and 
                        (global.get $z)
                        (i32.const 65535)))
                (i32.shr_u 
                    (global.get $z)
                    (i32.const 16))))
        ;; wnew in algo
        (global.set $w 
            (i32.add 
                (i32.mul 
                    (i32.const 18000)
                    (i32.and 
                        (global.get $w)
                        (i32.const 65535)))
                (i32.shr_u 
                    (global.get $w)
                    (i32.const 16))))
        ;; MWC 
        (local.set $MWC
            (i32.add
                (i32.shl
                    (global.get $z)
                    (i32.const 16))
                (global.get $w)))
        (global.set $jsr
            (i32.xor
                (global.get $jsr)
                (i32.shl
                    (global.get $jsr)
                    (i32.const 17))))
        (global.set $jsr
            (i32.xor
                (global.get $jsr)
                (i32.shr_u
                    (global.get $jsr)
                    (i32.const 13))))
        ;; SHR3 in algorithm
        (global.set $jsr
            (i32.xor
                (global.get $jsr)
                (i32.shl
                    (global.get $jsr)
                    (i32.const 5))))
        ;; CONG in algorithm
        (global.set $jcong
            (i32.add
                (i32.mul 
                    (global.get $jcong)
                    (i32.const 69069))
                (i32.const 1234567)))
        ;; return 
        (i32.add
            (i32.xor
                (local.get $MWC)
                (global.get $jcong))
            (global.get $jsr))
    )
)