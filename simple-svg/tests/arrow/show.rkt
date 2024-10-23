#lang racket

(require "../../main.rkt"
         racket/runtime-path)

(let ([show_svg
       (svg-out
        300 300
        (lambda ()
          (let (
                [arrow_id (svg-def-shape (new-arrow '(50 . 50) '(200 . 200) 40 40 80))]
                [sstyle_arrow (sstyle-new)]
                [point_id (svg-def-shape (new-circle 10))]
                [start_point_sstyle (sstyle-new)]
                [end_point_sstyle (sstyle-new)]
                [handle_base_id (svg-def-shape (new-line '(50 . 50) '(21.715728752538098 . 78.2842712474619)))]
                [handle_base_sstyle (sstyle-new)]
                [head_base_id (svg-def-shape (new-line '(171.7157287525381 . 228.2842712474619) '(143.4314575050762 . 256.5685424949238)))]
                [head_base_sstyle (sstyle-new)]
                [head_height_id (svg-def-shape (new-line '(200 . 200) '(256.5685424949238 . 256.5685424949238)))]
                [head_height_sstyle (sstyle-new)]
                )

            (set-SSTYLE-stroke-width! sstyle_arrow 5)
            (set-SSTYLE-stroke! sstyle_arrow "teal")
            (set-SSTYLE-fill! sstyle_arrow "lavender")
            (svg-place-widget arrow_id #:style sstyle_arrow)

            (set-SSTYLE-fill! start_point_sstyle "#3949AB")
            (svg-place-widget point_id #:style start_point_sstyle #:at '(50 . 50))

            (set-SSTYLE-fill! end_point_sstyle "#FB8C00")
            (svg-place-widget point_id #:style end_point_sstyle #:at '(200 . 200))

            (set-SSTYLE-stroke-width! handle_base_sstyle 5)
            (set-SSTYLE-stroke! handle_base_sstyle "#FFD600")
            (svg-place-widget handle_base_id #:style handle_base_sstyle)

            (set-SSTYLE-stroke-width! head_base_sstyle 5)
            (set-SSTYLE-stroke! head_base_sstyle "#F4511E")
            (svg-place-widget head_base_id #:style head_base_sstyle)

            (set-SSTYLE-stroke-width! head_height_sstyle 5)
            (set-SSTYLE-stroke! head_height_sstyle "#4CAF50")
            (svg-place-widget head_height_id #:style head_height_sstyle)
            )))])
  
;  (printf "~a\n" show_svg))
  (void))
