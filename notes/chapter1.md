## Chapter 1: Building Abstractions With Procedures ##


Computational processes are abstract beings which evolve and, as a result,
manipulate data. The evolution is directed by set of instructions called
program.


### Elements of programming: ###

Every language provides mechanisms to convert simple ideas to complex ones.
These are usually done by the following:

* Primitive Expressions: The simplest things,
* Means of Combination: Where we combine primitive to make complex, and
* Means of Abstraction: Where the complex expressions can be used as a unit.

Here __combination__ means part of code where we apply some operation to result
in something new. `(define x 1)` for instance, is not a combination, whereas
`(+ x 1)` is. The former is called a _special form_, and each special form
has its own evaluation rules (primarily, they differ from functions becuase
every parameter may not be evaluated, e.g. logical operators _and_ and _or_
_short circuit_ their parameters. In contast, _not_ is a procedure.



### Evaluating Combinations: ###
To evaluate a combination, do the following:
1. Evaluate the subexpression of the combination.
2. Apply the procedure that is teh value of the leftmost subexpression (the
operator) to the arguments that are the values of the other subexpressions (the
operands). _This is highly limited to prefix notation_

The first rule is recursive in nature, and the structure that we have turns out
to be a sort of tree where the nodes are expressions themselves. As we move up
the tree, we come closer to the final answer. This process is called
_tree accumulation_.



#### Substitution Model:  ####

A simple model to learn how the evalution of a program works, though this isn't
how interpreter actually works.

One form of this model first evaluates all the arguments and then applies the
higher order operations. This is called _applicative order evaluation_.

	(sum-of-squares (+ 2 1) (+ 3 1))
	(sum-of-squares 3 4)
	(+ (square 3) (square 4))
	(+ (* 3 3) (* 4 4))
	(+ 9 16)
	25

In contrast, the alternate form, called _normal order evaluation_ first expands
all the parameters and then reduces them. Taking the above example:

	;;; expansions
	(sum-of-square (+ 2 1) (+ 3 1))
	(+ (sum-of-square (+ 2 1) (+ 3 1)))
	(+ (square (+ 2 1)) (square (+ 3 1)))
	(+ (* (+ 2 1) (+ 2 1)) (* (+ 3 1) (+ 3 1)))
	;;; reductions
	(+ (* 3 3) (* 4 4))
	(+ 9 16)
	25

All the processes which can be modeled using Substitution model give the same
result no matter which evaluation order is used. 
