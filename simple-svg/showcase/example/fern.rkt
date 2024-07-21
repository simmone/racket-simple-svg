#lang racket/base

(require racket/math
         racket/function
         "../../main.rkt")

(define pair cons)
(define pair-first car)
(define pair-second cdr)
 
;;;; ----- parameters -----
(define canvas-width 600)
(define canvas-height 600)
 
(define start-point '(300 . 50))
(define start-length 120)
(define start-deg 100) ;100°
(define start-width 3)
(define step-width 0.86)
(define color "#5a5")
 
(define min-length 0.5)
(define central-reduction 0.75)
(define lateral-reduction 0.35)
(define lateral-deg 80) ;80°
(define bend 5) ;5°
 
;;;; ----- create the svg -----
(define (svg-data)
  (svg-out
   canvas-width canvas-height
   (lambda ()
     ;; draw the stem
     (define end (end-point start-point #:length start-length #:deg start-deg))
     (make-line start-point end #:width start-width)
     ;; start the fern
     (fern end
           #:length start-length
           #:deg start-deg
           #:width start-width))))
 
;;; draw the fern
(define (fern start
              #:length prev-length
              #:deg prev-deg
              #:width prev-width)
 
  (define central-length (* central-reduction prev-length))
  (when (>= central-length min-length)
    (define new-width (* step-width prev-width))
    ;; central branch
    (define central-deg (- prev-deg bend))
    (define central-end (end-point start
                                   #:length central-length
                                   #:deg central-deg))
 
    (make-line start central-end #:width new-width)
 
    (fern central-end
          #:length central-length
          #:deg central-deg
          #:width new-width)
 
    ;; left branch
    (define left-length (* lateral-reduction prev-length))
    (define left-deg (- (+ prev-deg lateral-deg) bend))
    (define left-end (end-point start
                           #:length left-length
                           #:deg left-deg))
 
    (make-line start left-end #:width new-width)
 
    (fern left-end
          #:length left-length
          #:deg left-deg
          #:width new-width)
 
    ;; right branch
    (define right-length (* lateral-reduction prev-length))
    (define right-deg (- (- prev-deg lateral-deg) bend))
    (define right-end (end-point start
                           #:length right-length
                           #:deg right-deg))
 
    (make-line start right-end #:width new-width)
 
    (fern right-end
          #:length right-length
          #:deg right-deg
          #:width new-width)))
 
;;; calculate the end point
(define (end-point start #:length length #:deg deg)
  (define end (make-polar length (* 2 pi (/ deg 360))))
  (define end-x (+ (pair-first  start) (real-part end)))
  (define end-y (+ (pair-second start) (imag-part end)))
  (pair end-x end-y))
 
;;; create a line
(define (make-line start end  #:width [width 1])
  (define start-x (pair-first start))
  (define start-y (pair-second start))
  (define end-x (pair-first end))
  (define end-y (pair-second end))
  (define line_id (svg-def-shape (new-line (pair start-x (- canvas-height start-y))
                                           (pair end-x   (- canvas-height end-y)))))
  (define line-style (sstyle-new))
  (set-SSTYLE-stroke-width! line-style width)
  (set-SSTYLE-stroke! line-style color)
  (svg-place-widget line_id #:style line-style))
 
;;;; ----- write the svg data ------
(with-output-to-file
    "fern.svg" #:exists 'replace
  (lambda () (display (svg-data))))
