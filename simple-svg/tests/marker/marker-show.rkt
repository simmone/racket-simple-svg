#lang racket

(require "../../main.rkt"
         racket/runtime-path)

(let ([show_svg
       (svg-out
        300 200
        (lambda ()
          (let (
                [triangle_marker (svg-def-shape (new-marker 'triangle))]
                [circle_marker (svg-def-shape (new-marker 'circle))]
                [indent_marker (svg-def-shape (new-marker 'indent))]
                [diamond_marker (svg-def-shape (new-marker 'diamond))]
                [line_id (svg-def-shape (new-line '(0 . 0) '(100 . 0)))]
                [line_sstyle (sstyle-new)]
                [triangle_comment_id (svg-def-shape (new-text "triangle" #:font-size 15))]
                [circle_comment_id (svg-def-shape (new-text "circle" #:font-size 15))]
                [indent_comment_id (svg-def-shape (new-text "indent" #:font-size 15))]
                [diamond_comment_id (svg-def-shape (new-text "diamond" #:font-size 15))]
                [comment_sstyle (sstyle-new)]
                )

            (set-SSTYLE-stroke-width! line_sstyle 5)
            (set-SSTYLE-stroke! line_sstyle "#000000")
            (set-SSTYLE-fill! comment_sstyle "#FB8C00")

            (svg-place-widget line_id #:at '(30 . 30) #:style line_sstyle #:marker_start_id triangle_marker #:marker_end_id triangle_marker)
            (svg-place-widget triangle_comment_id #:style comment_sstyle #:at '(150 . 35))

            (svg-place-widget line_id #:at '(30 . 60) #:style line_sstyle #:marker_start_id circle_marker #:marker_end_id circle_marker)
            (svg-place-widget circle_comment_id #:style comment_sstyle #:at '(150 . 65))

            (svg-place-widget line_id #:at '(30 . 90) #:style line_sstyle #:marker_start_id indent_marker #:marker_end_id indent_marker)
            (svg-place-widget indent_comment_id #:style comment_sstyle #:at '(150 . 95))

            (svg-place-widget line_id #:at '(30 . 120) #:style line_sstyle #:marker_start_id diamond_marker #:marker_end_id diamond_marker)
            (svg-place-widget diamond_comment_id #:style comment_sstyle #:at '(150 . 125))
            )))])
  
;  (printf "~a\n" show_svg))
  (void))
