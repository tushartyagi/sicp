#|
The difference between special forms and procedures is that all the arguments
are not evaluated in the former, but are evaluated in the latter.

With the problem at hand, while Evaluator can go ahead without any damage in 
the expressions that he gave wherein 0 and 1 evaluate to themselves, this will 
be different in case of a more complex procedure.

In short, sqrt-iter procedure will be evaluated in new-if, but not in the old 
one.
|#
