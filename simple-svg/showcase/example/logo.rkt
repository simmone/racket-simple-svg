#lang racket

(require "../../main.rkt")

;; comment section add blur effect
(with-output-to-file
    "logo.svg" #:exists 'replace
    (lambda ()
      (printf
       "~a\n"
       (svg-out
        519.875 519.824
        (lambda ()
          (let ([background_circle_sstyle (sstyle-new)]
                [background_circle_id (svg-def-shape (new-circle 253.093))]
                [blue_piece_sstyle (sstyle-new)]
                [blue_piece_id
                 (svg-def-shape
                  (new-path
                   (lambda ()
                     (svg-path-raw
                      (string-append
                       "M455.398,412.197c33.792-43.021,53.946-97.262,53.946-156.211"
                   	   "c0-139.779-113.313-253.093-253.093-253.093c-30.406,0-59.558,5.367-86.566,15.197"
                       "C272.435,71.989,408.349,247.839,455.398,412.197z")
                      ))))]
                [left_red_piece_sstyle (sstyle-new)]
                [left_red_piece_id
                 (svg-def-shape
                  (new-path
                   (lambda ()
                     (svg-path-raw
                      (string-append
                       "M220.003,164.337c-39.481-42.533-83.695-76.312-130.523-98.715"
	                     "C36.573,112.011,3.159,180.092,3.159,255.986c0,63.814,23.626,122.104,62.597,166.623"
	                     "C100.111,319.392,164.697,219.907,220.003,164.337z")
                      ))))]
                [bottom_red_piece_sstyle (sstyle-new)]
                [bottom_red_piece_id
                 (svg-def-shape
                  (new-path
                   (lambda ()
                     (svg-path-raw
                      (string-append
                       "M266.638,221.727c-54.792,59.051-109.392,162.422-129.152,257.794"
	                     "c35.419,18.857,75.84,29.559,118.766,29.559c44.132,0,85.618-11.306,121.74-31.163"
                       "C357.171,381.712,317.868,293.604,266.638,221.727z")
                      ))))]
;;                [filter_id (svg-def-shape (new-blur-dropdown))]
                )

            (set-SSTYLE-fill! background_circle_sstyle "white")
            (svg-place-widget background_circle_id #:style background_circle_sstyle #:at '(256.252 . 255.986))

            (set-SSTYLE-fill! blue_piece_sstyle "#3E5BA9")
            (svg-place-widget blue_piece_id #:style blue_piece_sstyle)
;;            (svg-place-widget blue_piece_id #:style blue_piece_sstyle #:filter_id filter_id)

            (set-SSTYLE-fill! left_red_piece_sstyle "#9F1D20")
            (svg-place-widget left_red_piece_id #:style left_red_piece_sstyle)
;;            (svg-place-widget left_red_piece_id #:style left_red_piece_sstyle #:filter_id filter_id)

            (set-SSTYLE-fill! bottom_red_piece_sstyle "#9F1D20")
            (svg-place-widget bottom_red_piece_id #:style bottom_red_piece_sstyle)
;;            (svg-place-widget bottom_red_piece_id #:style bottom_red_piece_sstyle #:filter_id filter_id)
            ))))))
