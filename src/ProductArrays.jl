module ProductArrays

using LinearAlgebra
using ZippedArrays

import Base: size, axes, getindex
import LinearAlgebra: diag

export ProductArray

include("arrays.jl")

end
