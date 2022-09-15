# ProductArrays

Sometimes it's useful to index into product of operators, which `Iterators.ProductIterator` does not allow.

`ProductArray`s allow to do this, while also given the flexibility to pass a function that maps to product.
```
julia> ProductArray(CartesianIndex, (Base.OneTo(2), UnitRange(0, 2)))
2×3 ProductArray{CartesianIndex{2}, 2, Type{CartesianIndex{2}}, Tuple{Base.OneTo{Int64}, UnitRange{Int64}}}:
 CartesianIndex(1, 0)  CartesianIndex(1, 1)  CartesianIndex(1, 2)
 CartesianIndex(2, 0)  CartesianIndex(2, 1)  CartesianIndex(2, 2)
```
or
```
julia> ProductArray(tuple, (Base.OneTo(2), UnitRange(0, 2)))
2×3 ProductArray{Tuple{Int64, Int64}, 2, typeof(tuple), Tuple{Base.OneTo{Int64}, UnitRange{Int64}}}:
 (1, 0)  (1, 1)  (1, 2)
 (2, 0)  (2, 1)  (2, 2)
```
