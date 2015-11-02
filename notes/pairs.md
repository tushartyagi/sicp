There are two ways of creating so called lists in scheme and I got to know about it today when I came across the function `pair?` while doing the exercises of SICP.

The idea is that there are two ways of creating lists:

* improper list
* proper list

While both of these can use the `cons` function, the underlying structure is different for each.

Ideally, or what I understood from lists, was that a list should be a linked list, containing both the data and a pointer to the next element. And after reading through the text and seeing it all over, I knew that the representation of such list was:

`> (list 1 2 3 4)
'(1 2 3 4)
`
And then there was the longer way of creating such list:

`> (cons 1 (cons 2 (cons 3 (cons 4 null))))
'(1 2 3 4)
`

What never struck me, because possibly it was not used before in the text, was that the `cons` function was used to create *pairs* and lists are a special types of pair.

A pair is what we get when using two primitives in `cons`:

`> (cons 1 2)
'(1 . 2)
`
In such a pair, there is no pointer to the next element, there are just two elements, and the pair contains these two elements. We can use car/cdr  functions on these without any issues:

`> (define one-pair (cons 1 2))
'(1 . 2)
> (car one-pair)
1
> (cdr one-pair)
2
`

And since this is a pair as well, this works too:

`
(pair? one-pair)
#t
`

Uptil now, we were creating *improper list* because this does not end with a null pointer.

A proper list is the actual linked list, with proper pointers to the next element of the list, and which terminates with a null pointer.

`
> (define a-list (cons 1 (cons 2 (cons 3 (cons 4 null)))))
'(1 2 3 4)
> (define another-list (list 5 6 7 8))
> (car a-list)
1
> (cdr another-list)
'(6 7 8)
> (pair? a-list)
#t
> (pair? another-list)
#t
`

With cdr, we are going through the list unless we get to the null pointer.
`list` function creates a linked list behind the scenes.

Is a proper-list pair as well? Yes, it is.
The condition of being a pair is that it has two parts, which can be accessed by car and cdr.
In case of proper list, the car is the first element, and cdr is the list of all the remaining elements.
In case of improper list, the car is the first element, and cdr is the second element.

This was the source of my confusion since in SICP authors are using `pair?` to check for tree structure, which I thought was only going to work if the tree is binary (huh :P). But as it turns out, the pair will work for lists as well because behind the scenes each proper list is a pair as well.

Now coming to the point where the lists are being used as trees, without any changes: This is because the lists _can_ be treated as a binary tree wherein the left and right pointers point to the left and right sub-trees. This was the usual way of creating trees in C, where node* was stored in the left and right elements of the structure.

So a list like this creates a binary tree:

`
> (define binary-tree (list (list 1 2) (list 3 4)))
'((1 2) (3 4))
`

Although the syntax is same, I find using `car` and `cdr` with trees a bit unclean. I prefer using `first` and `second` functions to get the first and second values, or to create left and right functions:

`
> (define left first)
> (define right second)

> (left binary-tree)
'(1 2)
> (right binary-tree)
'(3 4)
`



** References:
http://icem-www.folkwang-hochschule.de/~finnendahl/cm_kurse/doc/schintro/schintro_93.html
