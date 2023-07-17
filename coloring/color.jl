# import Pkg; Pkg.add("Permutations"); Pkg.add("Statistics")
using Permutations, Statistics


s = read("./AdjMats2/PSL(3,3)AdjMat.txt", String)
sz = ""
for i in s
    if i == ' '
        break
    end
    global sz *= i
end
n = parse(Int64,sz)


numbers = Array{Int16}(undef, 0)

check = true
for i in s
    if i == ' '
        global check = false
    end
    if check == true
        continue
    end
    if occursin(i, "10")
        append!(numbers, parse(Int16,i))
    end
end

adjacency_matrix = reshape(numbers, n, n)


# print(typeof(adjacency_matrix))
function coloring(adj_mat)

    for i = 2:n
        numSet = [x for x = 1:i]
        c_i = 1
        filter!(x -> x ∉ adj_mat[i, 1:i-1], numSet)
        c_i = minimum(numSet)
        adj_mat[:, i]*= c_i
    end
    return maximum(adj_mat)
end

# print(coloring(adjacency_matrix))



function PPP(adj_mat)
    ans = Array{Int16}(undef, 0)
    Threads.@threads for i =1:32
        ad = deepcopy(adj_mat)
        Perm = Matrix{Int16}(RandomPermutation(n))
        inv = Matrix{Int16}(Perm^-1)
        entering = Perm*ad*inv
        color = coloring(entering)
        if color == 117
            append!(ans, color)
            break
        end
        append!(ans, color)
    end
    return minimum(ans), maximum(ans), std(ans), mean(ans)
end


print(PPP(adjacency_matrix))