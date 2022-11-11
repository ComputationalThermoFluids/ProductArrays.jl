struct Slurped{F} <: Function
    f::F

    Slurped(f::F) where {F} =  new{F}(f)
    Slurped(f::Type{F}) where {F} = new{Type{F}}(f)
end

(f::Slurped)(x...) = f.f(x)
