solubilizer := function(G, max, x)
	rad := RadicalGroup(G);
	if x in rad then
		return G;
	else
		M := List(max);
		M := Set(Filtered(M, m -> x in m));
		maxes := [];
		solx := [];
		while Size(M) > 0 do
			m := M[1];
			if IsSolvable(m) then
				solx := Union(solx, List(m));
				maxes := Union(maxes, [m]);
				Remove(M, 1);
			else
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

checkGroup := function(G)
	Print("---------------------[ ", StructureDescription(G), " ]----------------------\n");
	solsizes := [];
	orders := [];
	max := MaximalSubgroups(G);
	for cl in ConjugacyClasses(G) do
		Append(solsizes, [Size(solubilizer(G, max, Representative(cl)))]);
		Append(orders, [Order(Representative(cl))]);
	od;
	Print("Solubilizer Orders: ", solsizes,"\nElement Orders: ",orders, "\n");
end;

adjMat := function(G)
	matrix := [];
	str := "";
	for x in List(G) do
		if Order(x) > 1 then
			row := [];
			max := MaximalSubgroups(G);
			solx := solubilizer(G, max, x);
			for y in List(G) do
				if y in solx and Order(y) <> 1 and y <> x and Order(x) <> 1 then
					Append(row, [1]);
					Append(str, "1");
				elif Order(y) > 1 then
					Append(row, [0]);
					Append(str, "0");
				fi;
			od;
			Append(matrix, [row]);
		fi;
	od;
	fname := Concatenation("./", StructureDescription(G), "Sz(8)AdjMat.txt");
	PrintTo(fname, Size(G)-1, str);
	return matrix;
end;

adjMat(SimpleGroup("Sz(8)"));
#groups := SimpleGroupsIterator(1, 10^18);
#for G in groups do
	#checkGroup(Image(IsomorphismPermGroup(G), G));
	#adjMat(G);
#od;

#G := PSL(2,7);
#path := 1 + [109, 278, 47, 105, 87, 296, 341, 259, 200, 193, 333, 179, 164, 232, 157, 268, 353, 197, 261, 314, 208, 190, 85, 295, 346, 136, 239, 110, 285, 356, 98, 183, 343, 322, 161, 57, 83, 307, 141, 310, 120, 122, 132, 264, 240, 180, 245, 330, 53, 337, 316, 344, 279, 86, 209, 238, 290, 107, 339, 235, 66, 21, 4, 3, 61, 18, 13, 70, 237, 5, 27, 94, 327, 241, 275, 277, 251, 226, 340, 313, 303, 41, 231, 108, 24, 294, 191, 246, 284, 350, 90, 270, 329, 227, 355, 97, 206, 104, 320, 256, 58, 77, 143, 176, 321, 59, 308, 218, 213, 203, 89, 217, 347, 326, 115, 224, 6, 12, 159, 289, 309, 139, 170, 158, 177, 55, 163, 171, 130, 172, 153, 142, 196, 199, 262, 358, 194, 202, 359, 352, 42, 8, 15, 78, 315, 2, 1, 280, 328, 30, 325, 60, 260, 148, 116, 286, 32, 64, 233, 229, 169, 189, 173, 165, 167, 187, 225, 99, 101, 223, 22, 299, 117, 250, 349, 219, 230, 357, 287, 160, 168, 282, 354, 228, 156, 300, 214, 272, 151, 335, 211, 93, 221, 298, 319, 249, 267, 17, 254, 133, 125, 127, 269, 147, 248, 145, 28, 119, 283, 111, 216, 297, 292, 23, 103, 95, 185, 244, 152, 331, 121, 247, 131, 123, 266, 14, 80, 33, 67, 40, 69, 175, 220, 273, 113, 288, 138, 174, 342, 276, 126, 149, 135, 26, 253, 257, 323, 195, 100, 56, 118, 207, 263, 338, 166, 305, 215, 92, 184, 301, 242, 182, 304, 91, 35, 210, 332, 155, 124, 271, 62, 75, 10, 19, 44, 7, 74, 16, 81, 43, 34, 51, 68, 37, 82, 39, 88, 317, 351, 188, 146, 265, 137, 243, 128, 252, 96, 192, 318, 54, 114, 162, 336, 204, 258, 222, 84, 312, 186, 348, 36, 73, 45, 52, 20, 49, 112, 291, 71, 205, 29, 134, 25, 11, 255, 144, 48, 198, 234, 306, 102, 150, 334, 302, 181, 65, 274, 154, 201, 106, 311, 236, 324, 140, 178, 281, 345, 212, 293, 129, 76, 9, 79, 46, 63, 38, 72, 31, 50, 109];

#Gl := List(G);
#for i in [1..Length(path)-1] do
	#if not IsSolvable(Subgroup(G, [Gl[path[i]], Gl[path[i+1]]])) then
		#Print("\nFAIL ", path[i], " ", path[i+1], " ", Gl[path[i]], " ", Gl[path[i+1]]);
#	fi;
#od;
Print("DONE");