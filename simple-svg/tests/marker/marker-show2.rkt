#lang racket

(require "../../main.rkt"
         racket/runtime-path)

(let ([show_svg
       (svg-out
        700 400
        (lambda ()
          (let (
                [line_id (svg-def-shape (new-line '(0 . 0) '(100 . 0)))]
                [line1_sstyle (sstyle-new)]
                [curve2_marker (svg-def-shape (new-marker 'curve2))]
                [normal_comment_id (svg-def-shape (new-text "normal line stroke-width: 2, marker size: 6, x: 1" #:font-size 15))]
                [line2_sstyle (sstyle-new)]
                [stroke4_comment_id (svg-def-shape (new-text "line stroke-width: 4" #:font-size 15))]
                [line3_sstyle (sstyle-new)]
                [stroke6_comment_id (svg-def-shape (new-text "line stroke-width: 6" #:font-size 15))]
                [size4_marker (svg-def-shape (new-marker 'curve2 #:size 4))]
                [size4_comment_id (svg-def-shape (new-text "line stroke-width: 4, marker size: 4" #:font-size 15))]
                [size8_marker (svg-def-shape (new-marker 'curve2 #:size 8))]
                [size8_comment_id (svg-def-shape (new-text "line stroke-width: 4, marker size: 8" #:font-size 15))]
                [indent2_marker (svg-def-shape (new-marker 'indent2))]
                [line4_sstyle (sstyle-new)]
                [stroke8_comment_id (svg-def-shape (new-text "line stroke-width: 8, indent2 default" #:font-size 15))]
                [indent2x4_marker (svg-def-shape (new-marker 'indent2 #:x 6))]
                [x4_comment_id (svg-def-shape (new-text "line stroke-width: 8, marker x: 6" #:font-size 15))]
                [comment_sstyle (sstyle-new)]
                )

            (set-SSTYLE-fill! comment_sstyle "#FB8C00")

            (set-SSTYLE-stroke-width! line1_sstyle 2)
            (set-SSTYLE-stroke! line1_sstyle "#000000")
            (svg-place-widget line_id #:at '(50 . 30) #:style line1_sstyle #:marker_start_id curve2_marker #:marker_end_id curve2_marker)
            (svg-place-widget normal_comment_id #:style comment_sstyle #:at '(200 . 35))

            (set-SSTYLE-stroke-width! line2_sstyle 4)
            (set-SSTYLE-stroke! line2_sstyle "#000000")
            (svg-place-widget line_id #:at '(50 . 80) #:style line2_sstyle #:marker_start_id curve2_marker #:marker_end_id curve2_marker)
            (svg-place-widget stroke4_comment_id #:style comment_sstyle #:at '(200 . 85))

            (set-SSTYLE-stroke-width! line3_sstyle 6)
            (set-SSTYLE-stroke! line3_sstyle "#000000")
            (svg-place-widget line_id #:at '(50 . 130) #:style line3_sstyle #:marker_start_id curve2_marker #:marker_end_id curve2_marker)
            (svg-place-widget stroke6_comment_id #:style comment_sstyle #:at '(200 . 135))

            (svg-place-widget line_id #:at '(50 . 180) #:style line2_sstyle #:marker_start_id size4_marker #:marker_end_id size4_marker)
            (svg-place-widget size4_comment_id #:style comment_sstyle #:at '(200 . 185))

            (svg-place-widget line_id #:at '(50 . 230) #:style line2_sstyle #:marker_start_id size8_marker #:marker_end_id size8_marker)
            (svg-place-widget size8_comment_id #:style comment_sstyle #:at '(200 . 235))

            (set-SSTYLE-stroke-width! line4_sstyle 8)
            (set-SSTYLE-stroke! line4_sstyle "#000000")
            (svg-place-widget line_id #:at '(50 . 280) #:style line4_sstyle #:marker_start_id indent2_marker #:marker_end_id indent2_marker)
            (svg-place-widget stroke8_comment_id #:style comment_sstyle #:at '(200 . 285))

            (svg-place-widget line_id #:at '(50 . 330) #:style line4_sstyle #:marker_start_id indent2x4_marker #:marker_end_id indent2x4_marker)
            (svg-place-widget x4_comment_id #:style comment_sstyle #:at '(200 . 335))
            )))])
  
;  (printf "~a\n" show_svg))
  (void))
