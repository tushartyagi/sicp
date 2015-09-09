# Chapter 1: Building Abstractions With Procedures ##

Computational processes are abstract beings which evolve and, as a result,
manipulate data. The evolution is directed by set of instructions called
program.

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

Procedures are a way of using imperative knowledge.

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

This Normal order evalution is _lazy_ because it will not evaluate the
expression which are not needed. To understand the difference, take a look
at the exercise 1.20.

Also, if the expression contains some reducible (sub)expressions, then
applicative order evaluates the leftmost-innermost redux which are generally
the parameters, and the normal order evaluates the leftmost-outermost which
is generally the expression itself. But the word generally is used without
any proof, need to dig deeper into this.

All the processes which can be modeled using Substitution model give the same
result no matter which evaluation order is used. 

#### Mathematical Function & Procedure ####
The difference between mathematical function and a programming language
procedure is the difference between declarative and imperative knowledge.
While the function tells us what the thing is, the programming language
tells us how we have to do things so that they behave as same as their
mathematical counterparts. With function, the brain tackles the how, in case
of programs, we need to supply the logic from the declarative to the imperative.

A procedure is a pattern of _local evolution_ of a computational process.

#### Procedures as black box abstractions ####
* Procedures can have a list of formal parameters, which are independent of
whatever is outside the procedure body. These parameters are called
_bound variables_ and the definition of the procedure binds these variables.
All the places where these variables can be accessed is called the _scope_ of
the variable name.

#### Lexical Scoping: ####
Lexical scoping means that the definition of a free variable comes from the
body of the enclosing parent procedure. In other words, they look for the
definitions in the environment in which the procedure was defined.


### Shapes of Process: ###
An extremely amazing concept is the shape of the process. Taking the example
of a procedure which calculates the procedure of a given number, we can make
sense of the whole thing.

	    (define (factorial-recursive n)
			(if (= n 1)
				1
				(* n (factorial-recursive (- n 1)))))

	    (define (factorial-iter product n)
			(if (= n 1)
				product
				(factorial-iter (* product n) (- n 1))))

	    (define (factorial n)
			(factorial-iter 1 n))


While the procedure definitions (and hence the procedures) are recursive in
the sense that each of them calls itself in order to calculate the procedure,
the process that these procedures generate are different.

The first one produces a linear recursive process and in each procedure call,
the interpreter has to keep track of all the operations that need to be
performed later on because of chain of deferred process calls. If the process
is stopped in the middle, we have to start it from the beginning.

In contrast, the second process only keeps a tab on `product` and `n`, and if
it is somehow stopped, we can start it again by providing these two parameters.

These processes are called linear in the sense that the number of steps
required to calculate n increase linearly with n.

An linear iterative process doesn't require extra space, and hence can be
implemented in hardware with fixed memory size. Recursive process, on the other
hand, requires extra memory, which is called _stack_.

#### Tree Recursion ####
After linear recursion, we have in our hands tree recursion wherein the
recursive method calls result in a tree data structure.

Generally, in a tree recursive process, the number of steps required will be
proportional to the nodes in the tree, and hence grows exponentially with n,
because accessing every node will mean that it is going to be solved. The space
required will be propotional to the maximum depth of the tree; at depth m, we
have 2^m nodes, which essentially means that the number of steps double, and we
only need to keep the information for those, the space requirement.


#### Order of Growth ####
R(n) = Θ(f(n)) if there are positive constants k1 and k2, independent of n,
such that:

k1∙f(n) ≤ R(n) ≤ k2∙f(n) 
