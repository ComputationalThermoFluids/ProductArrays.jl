struct ProductArray{T,N,F,A} <: AbstractArray{T,N}
    f::F
    args::A

    function ProductArray(f::F, args) where {F}
        T = Core.Compiler.return_type(f, Tuple{eltype.(args)...})
        new{T,length(args),F,typeof(args)}(f, args)
    end
    function ProductArray(f::Type{F}, args) where {F}
        T = Core.Compiler.return_type(f, Tuple{eltype.(args)...})
        new{T,length(args),Type{T},typeof(args)}(T, args)
    end
end

handle(a::ProductArray) = a.f
parent(a::ProductArray) = a.args

size(a::ProductArray) = length.(parent(a))

getindex(a::ProductArray{T,N}, i::Vararg{Int,N}) where {T,N} =
    handle(a)(getindex.(parent(a), i)...)

axes(a::ProductArray) = map(parent(a)) do el
    only(axes(el))
end

diag(a::ProductArray{T,N,typeof(tuple)}) where {T,N} =
    ZippedArray(parent(a)...)
