# from https://github.com/JuliaArrays/MappedArrays.jl/pull/48
eltypes(A::AbstractArray) = Tuple{eltype(A)}
@Base.pure eltypes(A::Tuple{Vararg{<:AbstractArray}}) = Tuple{(eltype.(A))...}

const OrdinalRangeInt = OrdinalRange{Int,Int}
const TupleN{T,N} = NTuple{N,T}

struct ProductArray{T,N,F,A<:NTuple{N,AbstractVector}} <: AbstractArray{T,N}
    f::F
    args::A

    function ProductArray(f, args)
        T = Base._return_type(f, Tuple{eltypes(args)})
        new{T,length(args),typeof(f),typeof(args)}(f, args)
    end
    function ProductArray(::Type{F}, args) where {F}
        T = Base._return_type(F, Tuple{eltypes(args)})
        new{T,length(args),Type{F},typeof(args)}(F, args)
    end
end

operation(a::ProductArray) = a.f
arguments(a::ProductArray) = a.args

size(a::ProductArray) = length.(arguments(a))

getindex(a::ProductArray{T,N}, i::Vararg{Int,N}) where {T,N} =
    operation(a)(getindex.(arguments(a), i))

axes(this::ProductArray) = only.(axes.(arguments(this)))

product(args) = product(identity, args)
product(f, args) = ProductArray(f, args)

product(::Type{CartesianIndex{N}}, args::NTuple{N,OrdinalRangeInt}) where {N} =
    CartesianIndices(args)
product(::Type{CartesianIndex}, args::TupleN{OrdinalRangeInt}) =
    CartesianIndices(args)

ProductArray(::Type{CartesianIndices{N}}, args::NTuple{N,OnlyVector{<:OrdinalRangeInt}}) where {N} =
    OnlyArray{length(args)}(CartesianIndices(only.(args)))
ProductArray(::Type{CartesianIndices}, args::TupleN{OnlyVector{<:OrdinalRangeInt}}) =
    OnlyArray{length(args)}(CartesianIndices(only.(args)))

diag(a::ProductArray{T,N,typeof(identity)}) where {T,N} =
    ZippedArray(arguments(a)...)
