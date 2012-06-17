;;; Test framework for grass

(define test-files
  (list "tests/util/boolean.scm"))

(define suite #f)
(define run-tests #f)

(let ()
  (set! suite (lambda (name . rest) name))
  (set! run-tests (lambda () #f)))

(for-each load test-files)

(run-tests)

