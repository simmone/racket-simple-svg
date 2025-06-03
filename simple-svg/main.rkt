#lang racket

(require "src/function.rkt")
(require "src/gadget/table.rkt")

(provide (contract-out
          [svg-out (->* (number? number? procedure?)
                        (
                         #:background (or/c #f string?)
                         #:viewBox (or/c #f VIEW-BOX?)
                         #:precision (or/c #f natural?)
                         )
                        string?)]
          [new-view-box (-> number? number? number? number? VIEW-BOX?)]
          [new-rect (->* (number? number?)
                         (
                          #:radius_x (or/c #f number?)
                                     #:radius_y (or/c #f number?)
                                     )
                         RECT?
                         )]
          [new-circle (-> number? CIRCLE?)]
          [new-ellipse (-> number? number? ELLIPSE?)]
          [new-line (-> (cons/c number? number?) (cons/c number? number?) LINE?)]
          [new-polygon (-> (listof (cons/c number? number?)) POLYGON?)]
          [new-polyline (-> (listof (cons/c number? number?)) POLYLINE?)]
          [new-linear-gradient (->*
                                ((listof (list/c (between/c 0 100) string? (between/c 0 1))))
                                (
                                 #:x1 (or/c #f number?)
                                      #:y1 (or/c #f number?)
                                      #:x2 (or/c #f number?)
                                      #:y2 (or/c #f number?)
                                      #:gradientUnits (or/c #f 'userSpaceOnUse 'objectBoundingBox)
                                      #:spreadMethod (or/c #f 'pad 'repeat 'reflect)
                                      )
                                LINEAR-GRADIENT?)]
          [new-radial-gradient (->*
                                ((listof (list/c (between/c 0 100) string? (between/c 0 1))))
                                (
                                 #:cx (or/c #f (between/c 0 100))
                                      #:cy (or/c #f (between/c 0 100))
                                      #:fx (or/c #f (between/c 0 100))
                                      #:fy (or/c #f (between/c 0 100))
                                      #:r (or/c #f number?)
                                      #:gradientUnits (or/c #f 'userSpaceOnUse 'objectBoundingBox)
                                      #:spreadMethod (or/c #f 'pad 'repeat 'reflect)
                                      )
                                RADIAL-GRADIENT?)]
          [new-blur-dropdown (->*
                              ()
                              (
                               #:blur (or/c #f number?)
                               #:dropdown_offset (or/c #f number?)
                               #:dropdown_color (or/c #f string?)
                               )
                              BLUR-DROPDOWN?)]
          [new-path (-> procedure? PATH?)]
          [svg-path-moveto (-> (cons/c number? number?) void?)]
          [svg-path-moveto* (-> (cons/c number? number?) void?)]
          [svg-path-arc (->
                         (cons/c number? number?)
                         (cons/c number? number?)
                         (or/c 'left_big 'left_small 'right_big 'right_small)
                         void?)]
          [svg-path-arc* (->
                          (cons/c number? number?)
                          (cons/c number? number?)
                          (or/c 'left_big 'left_small 'right_big 'right_small)
                          void?)]
          [svg-path-lineto (-> (cons/c number? number?) void?)]
          [svg-path-lineto* (-> (cons/c number? number?) void?)]
          [svg-path-hlineto (-> number? void?)]
          [svg-path-vlineto (-> number? void?)]
          [svg-path-close (-> void?)]
          [svg-path-ccurve (-> 
                            (cons/c number? number?)
                            (cons/c number? number?)
                            (cons/c number? number?)
                            void?)]
          [svg-path-ccurve* (->
                             (cons/c number? number?)
                             (cons/c number? number?)
                             (cons/c number? number?)
                             void?)]
          [svg-path-qcurve (-> 
                            (cons/c number? number?)
                            (cons/c number? number?)
                            void?)]
          [svg-path-qcurve* (->
                             (cons/c number? number?)
                             (cons/c number? number?)
                             void?)]
          [svg-path-raw (-> string? void?)]
          [new-text (->*
                     (string?)
                     (
                      #:font-size (or/c #f number?)
                                  #:font-family (or/c #f string?)
                                  #:dx (or/c #f number?)
                                  #:dy (or/c #f number?)
                                  #:rotate (or/c #f (listof number?))
                                  #:textLength (or/c #f number?)
                                  #:kerning (or/c #f number? 'auto 'inherit)
                                  #:letter-space (or/c #f number? 'normal 'inherit)
                                  #:word-space (or/c #f number? 'normal 'inherit)
                                  #:text-decoration (or/c #f 'overline 'underline 'line-through)
                                  #:path (or/c #f string?)
                                  #:path-startOffset (or/c #f (between/c 0 100))
                                  )
                     TEXT?)]
          [new-arrow (-> (cons/c number? number?) (cons/c number? number?) number? number? number? ARROW?)]
          [new-marker (->*
                       ((or/c 'triangle1 'triangle2 'circle 'indent1 'indent2 'diamond1 'diamond2 'curve1 'curve2))
                       (
                        #:size (or/c #f number?)
                        #:x (or/c #f number?)
                       )
                       MARKER?)]
          [svg-def-shape (-> (or/c RECT? CIRCLE? ELLIPSE? LINE? POLYGON?
                                   POLYLINE? LINEAR-GRADIENT? RADIAL-GRADIENT? PATH? TEXT?
                                   BLUR-DROPDOWN? ARROW? MARKER?) string?)]
          [svg-def-group (-> procedure? string?)]
          [svg-gadget-table (->* (
                                  (listof (listof string?))
                                  procedure?
                                  )
                                 (
                                  #:col_width number?
                                  #:row_height number?
                                  #:color string?
                                  #:cell_margin_top number?
                                  #:cell_margin_left number?
                                  #:font_size number?
                                  #:font_color string?
                                  )
                                 string?)]
          [struct SSTYLE
                  (
                   (fill (or/c #f string?))
                   (fill-rule (or/c #f 'nonzero 'evenodd 'inerit))
                   (fill-opacity (or/c #f (between/c 0 1)))
                   (stroke (or/c #f string?))
                   (stroke-width (or/c #f number?))
                   (stroke-linecap (or/c #f 'butt 'round 'square 'inherit))
                   (stroke-linejoin (or/c #f 'miter 'round 'bevel))
                   (stroke-miterlimit (or/c #f (>=/c 1)))
                   (stroke-dasharray (or/c #f string?))
                   (stroke-dashoffset (or/c #f number?))
                   (translate (or/c #f (cons/c number? number?)))
                   (rotate (or/c #f number?))
                   (scale (or/c #f number? (cons/c number? number?)))
                   (skewX (or/c #f number?))
                   (skewY (or/c #f number?))
                   (fill-gradient (or/c #f string?))
                   )]
          [sstyle-new (-> SSTYLE?)]
          [svg-place-widget (->* (string?)
                                 (
                                  #:style SSTYLE?
                                  #:at (cons/c number? number?)
                                  #:filter_id string?
                                  #:marker_start_id string?
                                  #:marker_mid_id string?
                                  #:marker_end_id string?
                                  )
                                 void?)]
          [set-table-col-width! (-> (listof natural?) number? any)]
          [set-table-row-height! (-> (listof natural?) number? any)]
          [set-table-col-margin-left! (-> (listof natural?) number? any)]
          [set-table-row-margin-top! (-> (listof natural?) number? any)]
          [set-table-cell-font-size! (-> (listof (cons/c natural? natural?)) number? any)]
          [set-table-cell-font-color! (-> (listof (cons/c natural? natural?)) string? any)]
          ))
