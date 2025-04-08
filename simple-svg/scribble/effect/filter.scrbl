#lang scribble/manual

@title{Filter}

1. Blur and Dropdown Filter.

@codeblock|{
(new-blur-dropdown (->*
  ()
  (
    #:blur (or/c #f number?)
    #:dropdown_offset (or/c #f number?)
    #:dropdown_color (or/c #f string?)
  )
  BLUR-DROPDOWN?))
}|

  blur: blur depth, default: 2.
  
  dropdown_offset: dropdown depth, default: 3.

  dropdown_color: dropdown color, default: black.

@codeblock|{
(svg-out
  140 140
  (lambda ()
    (let ([circle_id (svg-def-shape (new-circle 50))]
          [filter_id (svg-def-shape (new-blur-dropdown))]
          [_sstyle (sstyle-new)])

      (set-SSTYLE-stroke! _sstyle "red")
      (set-SSTYLE-stroke-width! _sstyle 12)

      (svg-place-widget circle_id #:style _sstyle #:filter_id filter_id #:at '(70 . 70)))))
}|
@image{showcase/filter/filter_blur_dropdown.svg}
