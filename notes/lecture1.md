**Declarative Knowledge** What is some value?
**Imperative Knowledge** How to get some value?

**Process**: A magical spirit that lives in the computer and does something.
**Procedure**: A set of rules which act upon processes.

The reason of using computer science becomes clear when we have to design
huge systems, and computer science provides the techniques of reducing the
complexities.

Unlike physics, chemistry, or any other natural science, the limits of
creating software are set up by our own minds.

## Black Box Abstraction

### Primitive Procedures
### Primitive Data

## Means of Combinations
### Procedure Combination
### Construction of Compound Data

## Means of Abstraction
### Procedure Definition
### Simple Data Abstraction

## Capturing Common Patterns
### High Order Procedure
### Data as Procedure

The first two questions that need to be asked for every programming language:
* What are the primitive elements
* How to combine these elements
* What are the means of abstraction to use the combination of primitives as
new primitives?

Combination consists of applying an operator to a set of operands. Every paranthesis
starts a combination in Lisp.

```
(define (square x) (* x x))
```
is a syntactic sugar for
```
(define square (lambda (x) (* x x)))
```

Substitution model is the simplest model to approximate the way processes
and procedures work.

#### Kinds of expressions
* Numbers
* Symbols
* Combinations
-- The next three are special forms:
* Lambdas
* Conditionals
* Definitions


#### Substitution Rule
To evaluate an application
* Evaluate the operator to get the procedure
* Evaluate the operands to get arguments
* Apply the procedure to the arguments

The key of understanding complicated things is to know what not to look at.
It's also important to name things so it becomes easier to discuss them.

The thing about abstraction is that we can simply start using the function
without worrying about the details as to how it functions.

Taking the example of addition by Peano's arithmatic, we can have two
different methods of adding two numbers together. The first method adds
by decrementing one of the numbers and incrementing the other.

```
(define (+ a b)
    (if (= a 0)
    b
    (+ (sub1 a) (add1 b))))
```
    
This method takes in O(1) space, and O(a) time. Such processes are called
*iterations*.
This tells us about the properties of algorithm, that any machine can
implement this algorithm in constant space and linear time. This also
signifies the shape of the process.

The other way of adding two numbers is to defer the calculation of addition
and then compute these at a later stage.

```
(define (+ a b)
    (if (= a 0)
    b
    (add1 (+ (sub1 a) b))))
```

Both the time and the space required for this algorithm are O(a) because
increasing a both adds a new increment operation (which requires time) and
a deferred operation (which requires extra space to remember the data for
the deferred operation). Such processes are called *recursions*, and this
one specifically is linear recursion because it's linear in both time and
space for given input *a*.

In the case of Fibonacci number, both the procedure and the process are
recursive, the latter being exponentially recursive because increasing the
input by 1 requires calculating a proportion of the set. The time complexity
is O(fib(n)), and the space complexity is O(n) because each increment in
input requires to remember the longest path to the root of the tree, and the
path increases by 1 level (not one node) for each increment in `n`.

