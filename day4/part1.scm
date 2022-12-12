(use scheme.regex)
(use util.match)

(define section-regex
  (let ((capture-digits '($ (+ num))))
    (regexp
     `(: ,capture-digits "-"
         ,capture-digits ","
         ,capture-digits "-"
         ,capture-digits))))

(define (parse-section str)
  (match (cdr (regexp-match->list
               (regexp-matches section-regex str)))
    [(s1 s2 s3 s4)
     (list (cons (string->number s1)
                 (string->number s2))
           (cons (string->number s3)
                 (string->number s4)))]))

(define section-contains
  (match-lambda* [((s1 . e1) (s2 . e2))
                  (and (>= s2 s1) (<= e2 e1))]))

(define (read-sections-from-file file)
  (map parse-section
       (call-with-input-file file port->string-list)))

(define (count-containments sections)
  (count
   (match-lambda [(s1 s2)
                  (or (section-contains s1 s2) (section-contains s2 s1))])
   sections))

;;(count-containments (read-sections-from-file "/tmp/input"))
