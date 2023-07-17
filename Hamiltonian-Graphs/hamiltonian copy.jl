


s = read("./A5AdjMat.txt", String)
sz = ""
for i in s
    global sz *= i
    if i == ' '
        break
    end
end
n = parse(Int64,sz)
numbers = []
for i in s
    if occursin(i, "10")
        append!(numbers, parse(Int64,i))
    end
end


adj_mat = matrix = reshape(numbers, n, n)

function random_search(adjacent)
    n = Int64(sqrt(length(adjacent)))
    start = rand((1:n))
    start_row = adjacent[start,:]
    seen = [start]
    cur = start
    count = 0
    for i = 1:n-1
        count +=1
        minsum = Inf
        min = 0
        for id in 1:n
            if adjacent[cur, id] == 1
                s = Int64(sum(adjacent[:, id]))
                if s > 0 && s < minsum
                    minsum = s
                    min = id
                end
            end
        end
        for i in 1:n
            adjacent[cur,i] = 0 
            adjacent[i,cur] = 0
        end
        if minsum == Inf
            return false
        end
        cur = min
        push!(seen, cur)
    end
    if start_row[cur] == 1
        push!(seen, start)
        return seen
    end
    return false
end

print(random_search(adj_mat))
