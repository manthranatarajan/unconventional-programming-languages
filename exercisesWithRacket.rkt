#lang racket

;; excersise 1

(define (process-9 f)
  (f 9))

;; excersice 2

(define (mymap f lst)
  (if (null? lst)
      '()
      (cons (f (car lst))
            (mymap f (cdr lst)))))

;; excersise 3

(define (second-min lst)
  (define (my-min lst)                
    (if (null? (cdr lst))
        (car lst)
        (min (car lst) (my-min (cdr lst)))))
  
  (let* ((min-val (my-min lst))             
         (new-list (remove min-val lst)))  
    (if (null? new-list)              
        (error "fewer than two unique values")
        (my-min new-list))))

;; excersise 4

(define (zipper list1 list2)
  (cond
    [(or (null? list1) (null? list2)) '()] 
    [else (cons (list (first list1) (first list2))
                (zipper (rest list1) (rest list2)))]))

;; excersise 5
(define (classify predicate lst)
  (cond
    [(null? lst) (list '() '())] 
    [else
     (define result (classify predicate (rest lst))) 
     (if (predicate (first lst)) 
         (list (cons (first lst) (first result)) (second result))
         (list (first result) (cons (first lst) (second result))))]))

;; excersise 6

(define (member-n-times? elem n lst)
  (define (count-occurrences elem lst count)
    (cond
      [(empty? lst) count] 
      [(equal? elem (first lst)) (count-occurrences elem (rest lst) (+ 1 count))] 
      [else (count-occurrences elem (rest lst) count)]))

  (equal? n (count-occurrences elem lst 0))) 


;; excersise 7

(define (luhn n)
  (define (digits num)
    (if (< num 10)
        (list num)
        (append (digits (quotient num 10)) 
                (list (remainder num 10)))))

  (define (double-every-second lst)
    (define (helper lst is-second)
      (cond
        [(empty? lst) '()]
        [else
         (let* ([first-digit (first lst)]
                [modified-digit (if is-second
                                    (let ([doubled (* 2 first-digit)])
                                      (if (> doubled 9) (- doubled 9) doubled))
                                    first-digit)])
           (cons modified-digit (helper (rest lst) (not is-second))))]))
    (reverse (helper (reverse lst) #f)))

  (define (sum lst)
    (foldl + 0 lst))

  (let* ([lst (digits n)]
         [processed-list (double-every-second lst)]
         [total (sum processed-list)])
    (= (remainder total 10) 0)))

;; excersise 8
(define (my-sorted? cmp lst)
  (cond
    [(or (empty? lst) (empty? (rest lst))) #t] 
    [else
     (if (cmp (first lst) (second lst)) 
         (my-sorted? cmp (rest lst))
         #f)]))

;; excersise 9

(define (my-flatten lst)
  (cond
    [(empty? lst) '()]
    [(list? (first lst))
     (append (my-flatten (first lst)) (my-flatten (rest lst)))] 
    [else
     (cons (first lst) (my-flatten (rest lst)))]))

;; excersise 10

(define (my-list-ref lst index)
  (cond
    [(< index 0) (error "error, index out of bounds")]
    [(empty? lst) (error "error, index out of bounds")]
    [(= index 0) (first lst)]
    [else
     (my-list-ref (rest lst) (- index 1))]))
