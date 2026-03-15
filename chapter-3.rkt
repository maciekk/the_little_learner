#lang racket

(require malt)

(include "chapter-1.rkt")

;; 58:5
;; Alas, for some reason cannot see these from the (include), so redefine.
(define line-xs
  (tensor 2.0 1.0 4.0 3.0))

(define line-ys
  (tensor 1.8 1.2 4.2 3.3))

;;58:6
((line line-xs) (list 0.0 0.0))

;; 60:12
(- line-ys ((line line-xs) (list 0.0 0.0)))

;; 61:15
(sum
  (sqr
    (- line-ys ((line line-xs) (list 0.0 0.0)))))

;; 61:16
(define l2-loss-line
  (λ (xs ys)
    (λ (θ)
      (let ((pred-ys ((line xs) θ)))
        (sum
          (sqr
            (- ys pred-ys)))))))

;; 63:22
(define l2-loss
  (λ (target)
    (λ (xs ys)
      (λ (θ)
        (let ((pred-ys ((target xs) θ)))
          (sum
            (sqr
              (- ys pred-ys))))))))

;; 64:26
;
; So just breaking things down:
; - l2-loss is itself ... "generalized" fn?
; - (l2-loss target-fn) gives "expectant" fn (expects dataset)
; - (expectant xs ys) gives "objective" fn (objective over which to fit θ)
; - (objective θ) gives a... scalar here (concrete loss)

;; 64:28
(((l2-loss line) line-xs line-ys)
 (list 0.0 0.0))

;; 66:31
(((l2-loss line) line-xs line-ys)
 (list 0.0099 0.0))

;; 69:42
(((l2-loss line) line-xs line-ys)
 (list 0.6263 0.0))
