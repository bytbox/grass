; Helpful FP Procedures

; Identity is defined by R5RS
; (define (identity x) x)

(define (constant a b) a)

; ((flip f) a b . c) -> (f b a . c)
(define (flip f)
  (lambda (a b . rest) (apply f (cons b (cons a rest)))))

; fold-left

; (fold-right f x (cons a (cons b '()))) -> (f a (f b x))
(define (fold-right f b as)
  (if (null? as) b
    (f (car as) (fold-right f b (cdr as)))))

; ((compose a b c) x) -> (a (b (c x)))
(define (compose . fs)
  (lambda (x) (fold-right (lambda (f x) (apply f (list x))) x fs)))

; ((curry f a) b c) -> (f a b c)
(define (curry f a)
  (lambda (b . rest) (apply f (cons a (cons b rest)))))

; uncurry
(define (uncurry f a b) ((f a) b))

