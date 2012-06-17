Requirements
------------

We try to stick to pure R5RS scheme, to be as compatibile as possible.
Development is done with guile.

Interface
---------

### Data Representation

A grass value is structured as follows

    (val type . constraints)

where `val` is the actual value (usable in ordinary scheme code), `type` is the
name (as a symbol) of the type, and `constraints` is a list containing all
known constraints.

