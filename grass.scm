#!/usr/bin/env guile
!#

(load "util/functional.scm")
(load "util/io.scm")

;;; Constraint handling

(define (grass:static-type v)
  (cond ((number? v) 'number)
        ((symbol? v) 'symbol)
        (else 'uk))) ; TODO error

;; Construct a list of constraints on a static value.
(define (grass:static-constraints v)
  `())

(define grass:get-type cadr)

(define (grass:get-constraint c v)
  (let ((r (assq c (cddr v))))
    (cond
      ((pair? r) (cdr r))
      (else '()))))

;; Lift a value into grass.
(define (_ v) (cons v (cons (grass:static-type v) (grass:static-constraints v))))

(let ((v (_ 1)))
  (displayln (grass:get-constraint 'type v))
  (displayln (grass:get-type v))
  (displayln v))

