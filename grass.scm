#!/usr/bin/env guile
!#

(load "util/boolean.scm")
(load "util/error.scm")
(load "util/functional.scm")
(load "util/io.scm")

;;; TODO nice error handling
;;; TODO tests

;;; Constraint handling

(define (grass:static-type v)
  (cond ((number? v) 'number)
        ((symbol? v) 'symbol)
        (else 'uk))) ; TODO error

;; Construct a list of constraints on a static value.
(define (grass:static-constraints v)
  (cond ((number? v) '())
        ((symbol? v) `((eq . ,v)))
        (else '())))

(define grass:get-value car)
(define grass:get-type cadr)
(define grass:get-constraints cddr)

(define grass:constraint-function #f) ; closure
(let ((cfs `((eq . ,eq?))))
  (set! grass:constraint-function
    (lambda (sym) (cdr (assq sym cfs)))))

;; Check that a raw value satisfies a constraint
(define (grass:check-constraint val constraint)
  (let ((f (grass:constraint-function (car constraint)))
        (v (cdr constraint)))
    (apply f (list v val))))

;; Check that a grass value satisfies all constraints.
(define (grass:check-constraints val)
  (let ((cs (grass:get-constraints val))
        (v (grass:get-value val)))
    (and@ (map (curry grass:check-constraint v) cs))))

;; Lift a value into grass.
(define (grass:lift v) `(,v ,(grass:static-type v) . ,(grass:static-constraints v)))

;; Read a value from standard input.
(define (grass:read) '())

;; Aliases for commonly used methods.
(define _ grass:lift)

; TODO the puzzle here is to make sure we can run through all the proofs
; without execution. This means the grass functions being called to construct
; the program must not do any actual work themselves, but simply be creating a
; data structure with all necessary information behind the scenes.


(let ((v (_ 'hi)))
  (displayln v)
  (displayln (grass:check-constraints v)))

