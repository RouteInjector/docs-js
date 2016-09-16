# Typebased

Typebased routes are generated from relations and types.
There are several Typebased injections including the ones that can be generated from references and arrays.

## References
References in route generation are for linking and creating shortcuts between refered objects. For example,
given a certain relation it is possible to fetch in both ways the relation N:M.

Learn more at [typebased references](references.md)

## Arrays
The arrays route generation includes operations on Add, Get and Remove elements from models which have arrays.
In this way it is easy to manipulate inner arrays without pushing to the server the whole document.

Learn more at [array references](arrays.md)