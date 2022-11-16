"""
    CartesianPlane{D}(ind, inds)

Creates a lazy `N`-dimensional array of `CartesianIndex{N+1}` whose `D`th index is
fixed and set to `ind`.

!!! note

    `CartesianPlane` is a lazy array of `CartesianIndex` where an argument is fixed.

    See also `Base.Fix1` and `Base.Fix2`.

# Example

```
julia> iter = CartesianPlane{2}(3, CartesianIndices((2, 3)))
2×3 CartesianPlane{2, 2, 3, CartesianIndices{2, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}}}}:
 CartesianIndex(1, 3, 1)  CartesianIndex(1, 3, 2)  CartesianIndex(1, 3, 3)
 CartesianIndex(2, 3, 1)  CartesianIndex(2, 3, 2)  CartesianIndex(2, 3, 3)

```

"""
struct CartesianPlane{D,N,M,A<:AbstractArray{CartesianIndex{N},N}} <: AbstractArray{CartesianIndex{M},N}
    ind::Int
    inds::A
end

function CartesianPlane{D}(ind, inds) where {D}
    N = ndims(inds)
    CartesianPlane{D,N,N+1,typeof(inds)}(ind, inds)
end

parent(this::CartesianPlane) = this.inds
abscissa(this::CartesianPlane) = this.ind

size(this::CartesianPlane) = size(parent(this))
axes(this::CartesianPlane) = axes(parent(this))

function getindex(this::CartesianPlane{D}, i...) where {D}
    I = Tuple(getindex(parent(this), i...))
    CartesianIndex(I[begin:begin+D-2]..., abscissa(this), I[begin+D-1:end]...)
end
#=

"""
    ProductArray(f::Type{<:CartesianIndices}, args)

Workaround the fact that `CartesianIndices` constructors only accept a single `Tuple`
of `Union{<:Integer,OrdinalRange{<:Integer}`.

In other words, this addresses the fact that `CartesianIndices((1:3,))` is allowed
but `CartesianIndices(1:3)` is not.

"""
function ProductArray(f::Type{<:CartesianIndices}, args)
    T = Core.Compiler.return_type(f, Tuple{Tuple{eltype.(args)...}})
    f = Slurped(T)
    ProductArray(f, args)
end
=#
