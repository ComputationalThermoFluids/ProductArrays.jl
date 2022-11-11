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
