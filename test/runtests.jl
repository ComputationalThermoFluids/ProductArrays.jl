using ProductArrays
using Test

@testset "ProductArrays.jl" begin
    xyz = Base.OneTo(10), -π:0.1:π+2, -1:5
    pa = ProductArray(tuple, xyz...)
    @test isequal(pa[5, 1, 3], (5, -π, 1))
    @test isequal(pa[5, 1, 3], pa[CartesianIndex(5, 1, 3)])
end
