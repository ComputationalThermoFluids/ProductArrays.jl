"""
    FlattenedProduct(pa)

Given an `N`-dimensional `ProductArray` that yields `N`-dimensional arrays,
return an array that yields the elements of those iterators.

This behaves differently from `Base.Iterators.Flatten`, in the sense that it
preserves the product structure of the elements.

Put differently, whereas `collect` applied to a `Base.Iterators.Flatten`
iterator always yields a vector, `collect` on a `FlattenedProduct` returns
an `N`-dimension array.

"""
struct FlattenedProduct{T,N,A<:ProductArray{<:AbstractArray{T,N},N}} <: AbstractArray{T,N}
    data::A
end

parent(a::FlattenedProduct) = a.data

size(a::FlattenedProduct) =
    sum.(length, arguments(parent(a)))

# For debugging purposes only (very inefficient)
function getindex(a::FlattenedProduct, i::Int...)
    ranges = map(enumerate(arguments(parent(a)))) do (d, iter)
        init = firstindex(a, d)
        map(iter) do el
            n = length(el)
            start = init; init += n
            range(start, length=n)
        end
    end
    indices = @. findfirst(Base.Fix1(in, i), ranges)
    j = @. i - first(getindex(ranges, indices)) + 1
    getindex(getindex(parent(a), indices...), j...)
end
