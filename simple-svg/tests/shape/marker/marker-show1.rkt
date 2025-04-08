#lang racket

(require "../../../main.rkt"
         racket/runtime-path)

(let ([show_svg
       (svg-out
        300 300
        (lambda ()
          (let (
                [triangle1_marker (svg-def-shape (new-marker 'triangle1))]
                [triangle2_marker (svg-def-shape (new-marker 'triangle2))]
                [circle_marker (svg-def-shape (new-marker 'circle))]
                [indent1_marker (svg-def-shape (new-marker 'indent1))]
                [indent2_marker (svg-def-shape (new-marker 'indent2))]
                [diamond1_marker (svg-def-shape (new-marker 'diamond1))]
                [diamond2_marker (svg-def-shape (new-marker 'diamond2))]
                [curve1_marker (svg-def-shape (new-marker 'curve1))]
                [curve2_marker (svg-def-shape (new-marker 'curve2))]
                [line_id (svg-def-shape (new-line '(0 . 0) '(100 . 0)))]
                [line_sstyle (sstyle-new)]
                [triangle1_comment_id (svg-def-shape (new-text "triangle1" #:font-size 15))]
                [triangle2_comment_id (svg-def-shape (new-text "triangle2" #:font-size 15))]
                [circle_comment_id (svg-def-shape (new-text "circle" #:font-size 15))]
                [indent1_comment_id (svg-def-shape (new-text "indent1" #:font-size 15))]
                [indent2_comment_id (svg-def-shape (new-text "indent2" #:font-size 15))]
                [diamond1_comment_id (svg-def-shape (new-text "diamond1" #:font-size 15))]
                [diamond2_comment_id (svg-def-shape (new-text "diamond2" #:font-size 15))]
                [curve1_comment_id (svg-def-shape (new-text "curve1" #:font-size 15))]
                [curve2_comment_id (svg-def-shape (new-text "curve2" #:font-size 15))]
                [comment_sstyle (sstyle-new)]
                )

            (set-SSTYLE-stroke-width! line_sstyle 2)
            (set-SSTYLE-stroke! line_sstyle "#000000")
            (set-SSTYLE-fill! comment_sstyle "#FB8C00")

            (svg-place-widget line_id #:at '(30 . 30) #:style line_sstyle #:marker_start_id triangle1_marker #:marker_end_id triangle1_marker)
            (svg-place-widget triangle1_comment_id #:style comment_sstyle #:at '(150 . 35))

            (svg-place-widget line_id #:at '(30 . 60) #:style line_sstyle #:marker_start_id triangle2_marker #:marker_end_id triangle2_marker)
            (svg-place-widget triangle2_comment_id #:style comment_sstyle #:at '(150 . 65))

            (svg-place-widget line_id #:at '(30 . 90) #:style line_sstyle #:marker_start_id circle_marker #:marker_end_id circle_marker)
            (svg-place-widget circle_comment_id #:style comment_sstyle #:at '(150 . 95))

            (svg-place-widget line_id #:at '(30 . 120) #:style line_sstyle #:marker_start_id indent1_marker #:marker_end_id indent1_marker)
            (svg-place-widget indent1_comment_id #:style comment_sstyle #:at '(150 . 125))

            (svg-place-widget line_id #:at '(30 . 150) #:style line_sstyle #:marker_start_id indent2_marker #:marker_end_id indent2_marker)
            (svg-place-widget indent2_comment_id #:style comment_sstyle #:at '(150 . 155))

            (svg-place-widget line_id #:at '(30 . 180) #:style line_sstyle #:marker_start_id diamond1_marker #:marker_end_id diamond1_marker)
            (svg-place-widget diamond1_comment_id #:style comment_sstyle #:at '(150 . 185))

            (svg-place-widget line_id #:at '(30 . 210) #:style line_sstyle #:marker_start_id diamond2_marker #:marker_end_id diamond2_marker)
            (svg-place-widget diamond2_comment_id #:style comment_sstyle #:at '(150 . 215))

            (svg-place-widget line_id #:at '(30 . 240) #:style line_sstyle #:marker_start_id curve1_marker #:marker_end_id curve1_marker)
            (svg-place-widget curve1_comment_id #:style comment_sstyle #:at '(150 . 245))

            (svg-place-widget line_id #:at '(30 . 270) #:style line_sstyle #:marker_start_id curve2_marker #:marker_end_id curve2_marker)
            (svg-place-widget curve2_comment_id #:style comment_sstyle #:at '(150 . 275))
            )))])
  
;  (printf "~a\n" show_svg))
  (void))
