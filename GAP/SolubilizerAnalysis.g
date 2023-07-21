# Given an element x in a group G, the solubilizer function
# returns Sol_G(x)
solubilizer := function(G, max, x)
	rad := RadicalGroup(G);
	if x in rad then
		return G; # Elements in radical are universal vertices
	else
		M := List(max);
		M := Set(Filtered(M, m -> x in m));
		solx := [];
		# Iteratively search through maximal subgroups that 
		# contain x until we find the maximal solvable ones
		# and take their union
		while Size(M) > 0 do
			m := M[1];
			if IsSolvable(m) then
				# If m is solvable, add it to the union
				solx := Union(solx, List(m));
				Remove(M, 1);
			else
				# If m is not solvable, check it's maximal
				# subgroups as they might be solvable
				MM := MaximalSubgroups(m);
				MM := Set(Filtered(MM, mm -> x in mm));
				Append(M, MM);
				Remove(M, 1);
				M := Set(M);
			fi;
		od;
		return solx;
	fi;
end;

# Given a group G, checkGroup calculates the solubilizers for
# each conjugacy class of elements of G
checkGroup := function(G)
	G := Image(IsomorphismPermGroup(G), G);
	Print("---------------------[ ", StructureDescription(G), " ]----------------------\n");
	solsizes := [];
	orders := [];
	# Calculate maximal subgroups only once for each group since 
	# this is the slowest part of the program
	max := MaximalSubgroups(G);
	for cl in ConjugacyClasses(G) do
		x := Representative(cl);
		Append(solsizes, [Size(solubilizer(G, max, x))]);
		Append(orders, [Order(x)]);
	od;
	Print("Solubilizer Orders: ", solsizes,"\nElement Orders: ",orders, "\n");
	return(Length(Set(solsizes)));
end;

# Given a group G, adjMat uses the solubilizer function to
# create an adjacency matrix for the graph Delta_S(G).
# The output is formatted to be easily readable by a Julia script
adjMat := function(G)
	str := "";
	# Note that this is much slower than checkGroup since we
	# run it for every element of G, not just for conjugacy
	# classes. However, this is okay as it still runs faster
	# than the code used to analyze the matrices so we do not
	# need to optimize it.
	for x in List(G) do
		if Order(x) > 1 then
			max := MaximalSubgroups(G);
			solx := solubilizer(G, max, x);
			for y in List(G) do
				if y in solx and Order(y) <> 1 and y <> x and Order(x) <> 1 then
					Append(str, "1");
				elif Order(y) > 1 then
					Append(str, "0");
				fi;
			od;
		fi;
	od;
	# Saves result to text file in same folder
	fname := Concatenation(StructureDescription(G), "AdjMat.txt");
	PrintTo(fname, Size(G)-1, str);
end;

# Generates adjacency matrices for simple groups up to PSL(3,3)
groupsAdj := SimpleGroupsIterator(1, 6000);
for G in groupsAdj do
	adjMat(G);
od;

# Characterizes solubilizers for simple groups up to PSL(3,7).
# Can choose to ignore PSL(2,q) groups as they are well understood
groupsSol := SimpleGroupsIterator(1, 2*10^7:NOPSL2);
for G in groupsSol do
	checkGroup(G);
od;

