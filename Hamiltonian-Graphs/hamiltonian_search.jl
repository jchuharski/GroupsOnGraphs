
s = read("./AdjMats2/A5AdjMat.txt", String)

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

function random_search(adj)
    adjacent = deepcopy(adj)
    n = Int64(sqrt(length(adjacent)))
    start = rand((1:n)) # Choose a random starting index
    start_row = adjacent[start,:] # get the starting row
    seen = [start] # initialize the path array
    cur = start
    for i = 1:n-1
        minsum = Inf
        min = []
        for id in 1:n # Find neighbor with the minimum number of respective neighbors and move there.
            if adjacent[cur, id] == 1
                s = Int64(sum(adjacent[:, id]))
                if s > 0 && s <= minsum
                    if s < minsum
                        min = []
                    end
                    minsum = s
                    append!(min, id)
                end
            end
        end
        for i in 1:n
            adjacent[cur,i] = 0 
            adjacent[i,cur] = 0
        end
        if minsum == Inf # if there are
            return "fail"
        end
        cur = rand(min) # Tie break by random choice.
        push!(seen, cur)
    end
    if start_row[cur] == 1 # Check that we have a loop from the starting row
        push!(seen, start)
        return seen
    end
    return "fail"
end


for i=1:10 # Try the search until find an answer
        ans = random_search(adj_mat)
        if ans != "fail"
            print(ans)
            break
        end
end
print("Done")
