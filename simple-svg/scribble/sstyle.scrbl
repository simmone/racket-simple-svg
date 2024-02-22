#lang scribble/manual

@title{Svg Style}

each shape and group can have multiple styles: stroke, fill etc.

sstyle is a struct, use standard struct set-SSTYLE-*! to set styles.

each style's meaning please check the Joni's tutorial: @hyperlink["http://svgpocketguide.com/"]{"Svg Pocket Guide"}.

@codeblock|{
(struct
  SSTYLE
    (
      [fill (or/c #f string?)]
      [fill-rule (or/c #f 'nonzero 'evenodd 'inerit)]
      [fill-opacity (or/c #f (between/c 0 1))]
      [stroke (or/c #f string?)]
      [stroke-width (or/c #f number?)]
      [stroke-linecap (or/c #f 'butt 'round 'square 'inherit)]
      [stroke-linejoin (or/c #f 'miter 'round 'bevel)]
      [stroke-miterlimit (or/c #f (>=/c 1))]
      [stroke-dasharray (or/c #f string?)]
      [stroke-dashoffset (or/c #f number?)]
      [translate (or/c #f (cons/c number? number?))]
      [rotate (or/c #f number?)]
      [scale (or/c #f number? (cons/c number? number?))]
      [skewX (or/c #f number?)]
      [skewY (or/c #f number?)]
      [fill-gradient (or/c #f string?)]
    ))
}|