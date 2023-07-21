using Permutations, Statistics

# Change file path to desired adjacency matrix
s = read("./AdjMats/A5AdjMat.txt", String) 

# Group size minus identity is included in text file
sz = "" # Extract the size.
for i in s
    if i == ' '
        break
    end
    global sz *= i
end
n = parse(Int64,sz) # n is size for the nxn matrix

numbers = [] # Next extract the digits in order
check = true
for i in s
    if i == ' '
        global check = false
    end
    if check == true
        continue
    end
    if occursin(i, "10")
        append!(numbers, parse(Int8,i))
    end
end

adj_mat = reshape(numbers, n, n) # reshape the digits into the nxn adjacency matrix


function coloring(adj_mat)
    """
    Greedy algorithm to find a valid graph coloring.
    """

    for i = 2:n
        numSet = [x for x = 1:i]
        c_i = 1
        filter!(x -> x ∉ adj_mat[i, 1:i-1], numSet)
        c_i = minimum(numSet)
        adj_mat[:, i]*= c_i
    end
    return maximum(adj_mat)
end

function runner(adj_mat)
    """
    Runs random permutations of the adjacency matrix to try to guess an optimal coloring.
    """
    ans = Array{Int16}(undef, 0)
    Threads.@threads for i =1:32
        ad = deepcopy(adj_mat)
        Perm = Matrix{Int16}(RandomPermutation(n))
        inv = Matrix{Int16}(Perm^-1)
        new_perm = Perm*ad*inv
        color = coloring(new_perm)
        if color == 117 ## CHANGE ME to the lower bound. Thus if theoretical lower bound found, stop running
            append!(ans, color)
            break
        end
        append!(ans, color)
    end
    return minimum(ans), maximum(ans), std(ans), mean(ans)
end

print(runner(adjacency_matrix))
