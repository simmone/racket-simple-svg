#lang racket

(require "../../main.rkt"
         racket/runtime-path)

(let ([show_svg
       (svg-out
        400 400
        (lambda ()
          (let (
                [arrow_id (svg-def-shape (new-arrow '(50 . 50) '(280 . 280) 40 40 80))]
                [sstyle_arrow (sstyle-new)]
                [point_id (svg-def-shape (new-circle 10))]
                [start_point_sstyle (sstyle-new)]
                [start_point_comment_id (svg-def-shape (new-text "start point" #:font-size 15))]
                [start_point_comment_sstyle (sstyle-new)]
                [end_point_sstyle (sstyle-new)]
                [end_point_comment_id (svg-def-shape (new-text "end point" #:font-size 15))]
                [end_point_comment_sstyle (sstyle-new)]
                [handle_base_id (svg-def-shape (new-line '(50 . 50) '(21.715728752538098 . 78.2842712474619)))]
                [handle_base_sstyle (sstyle-new)]
                [handle_base_comment_id (svg-def-shape (new-text "handle base" #:font-size 15))]
                [handle_base_comment_sstyle (sstyle-new)]
                [head_base_id (svg-def-shape (new-line '(195.1471862576143 . 251.7157287525381) '(166.8629150101524 . 280.0)))]
                [head_base_sstyle (sstyle-new)]
                [head_base_comment_id (svg-def-shape (new-text "head base" #:font-size 15))]
                [head_base_comment_sstyle (sstyle-new)]
                [head_height_id (svg-def-shape (new-line '(223.4314575050762 . 223.4314575050762) '(280 . 280)))]
                [head_height_sstyle (sstyle-new)]
                [head_height_comment_id (svg-def-shape (new-text "head height" #:font-size 15))]
                [head_height_comment_sstyle (sstyle-new)]
                )

            (set-SSTYLE-stroke-width! sstyle_arrow 5)
            (set-SSTYLE-stroke! sstyle_arrow "teal")
            (set-SSTYLE-fill! sstyle_arrow "lavender")
            (svg-place-widget arrow_id #:style sstyle_arrow)

            (set-SSTYLE-fill! start_point_sstyle "#3949AB")
            (svg-place-widget point_id #:style start_point_sstyle #:at '(50 . 50))
            (set-SSTYLE-stroke! start_point_comment_sstyle "#3949AB")
            (svg-place-widget start_point_comment_id #:style start_point_comment_sstyle #:at '(60 . 50))

            (set-SSTYLE-fill! end_point_sstyle "#FB8C00")
            (svg-place-widget point_id #:style end_point_sstyle #:at '(280 . 280))
            (set-SSTYLE-fill! end_point_comment_sstyle "#FB8C00")
            (svg-place-widget end_point_comment_id #:style end_point_comment_sstyle #:at '(290 . 280))

            (set-SSTYLE-stroke-width! handle_base_sstyle 5)
            (set-SSTYLE-stroke! handle_base_sstyle "#E6AC00")
            (svg-place-widget handle_base_id #:style handle_base_sstyle)
            (set-SSTYLE-fill! handle_base_comment_sstyle "#E6AC00")
            (svg-place-widget handle_base_comment_id #:style handle_base_comment_sstyle #:at '(40 . 80))

            (set-SSTYLE-stroke-width! head_base_sstyle 5)
            (set-SSTYLE-stroke! head_base_sstyle "#F4511E")
            (svg-place-widget head_base_id #:style head_base_sstyle)
            (set-SSTYLE-fill! head_base_comment_sstyle "#F4511E")
            (svg-place-widget head_base_comment_id #:style head_base_comment_sstyle #:at '(80 . 270))

            (set-SSTYLE-stroke-width! head_height_sstyle 5)
            (set-SSTYLE-stroke! head_height_sstyle "#4CAF50")
            (svg-place-widget head_height_id #:style head_height_sstyle)
            (set-SSTYLE-fill! head_height_comment_sstyle "#4CAF50")
            (svg-place-widget head_height_comment_id #:style head_height_comment_sstyle #:at '(255 . 250))
            )))])
  
; (printf "~a\n" show_svg))
  (void))
