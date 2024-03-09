(defvar OP_PLUS "+")
(defvar OP_MINUS "-")
(defvar OP_MULT "*")
(defvar OP_DIV "/")
(defvar OP_COMMA ",")
(defvar OP_OP "(")
(defvar OP_CP ")")

(defun split-and-trim (input)
  (remove #\space input))

(defun classify-characters (input)
  (loop for char across input
        collect (cond
                  ((string= (string char) " ") "OP_SPACE")       ; Whitespace
                  ((string= (string char) OP_PLUS) "OP_PLUS")    ; Plus Operator
                  ((string= (string char) OP_MINUS) "OP_MINUS")  ; Minus Operator
                  ((string= (string char) OP_MULT) "OP_MULT")    ; Multiply Operator
                  ((string= (string char) OP_DIV) "OP_DIV")      ; Divide Operator
                  ((string= (string char) OP_COMMA) "OP_COMMA")  ; Comma Operator
                  ((string= (string char) OP_OP) "OP_OP")        ; Open Parentheses Operator
                  ((string= (string char) OP_CP) "OP_CP")        ; Close Parentheses Operator
                  (t "IDENTIFIER"))))                            ; Default: Identifier

(format t "Enter an expression: ")
(finish-output)

(let ((user-input (read-line)))
  (setq user-input (split-and-trim user-input))
  (setq classified-input (classify-characters user-input))
  (format t "~a~%" classified-input))
