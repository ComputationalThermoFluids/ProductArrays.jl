struct ProductArray{T,N,F,A} <: AbstractArray{T,N}
    f::F
    args::A
end

handle(a::ProductArray) = a.f
parent(a::ProductArray) = a.args

function ProductArray(f, args::Vararg{Any,N}) where {N}
    S = Tuple{eltype.(args)...}
    T = Core.Compiler.return_type(f, S)
    ProductArray{T,N,typeof(f),typeof(args)}(f, args)
end

size(a::ProductArray) = length.(parent(a))

getindex(a::ProductArray{T,N}, i::Vararg{Int,N}) where {T,N} =
    handle(a)(getindex.(parent(a), i)...)

axes(a::ProductArray) = map(parent(a)) do el
    only(axes(el))
end
