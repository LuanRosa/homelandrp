//#include a_samp
//#include dof2

#define pasta_rank  "rank/rank_%s.ini"

/*
native createrank(rankname[]);
native getrank(rankname[], description[]);
native checkrank(rankname[], points);
native deleterank(rankname[]);
native resetrank(rankname[]);
*/

stock createrank(rankname[])
{

	new string[100];
	format(string, sizeof string, pasta_rank, rankname);

	if(!DOF2_FileExists(string)){

	    //position 1
	    DOF2_SetString(string, "name1", "ninguem");
	    DOF2_SetInt(string, "points1", 0);
	    //position 2
	    DOF2_SetString(string, "name2", "ninguem");
	    DOF2_SetInt(string, "points2", 0);
	    //position 3
	    DOF2_SetString(string, "name3", "ninguem");
	    DOF2_SetInt(string, "points3", 0);
	    //position 4
	    DOF2_SetString(string, "name4", "ninguem");
	    DOF2_SetInt(string, "points4", 0);
		//position 5
	    DOF2_SetString(string, "name5", "ninguem");
	    DOF2_SetInt(string, "points5", 0);
	    //position 6
	    DOF2_SetString(string, "name6", "ninguem");
	    DOF2_SetInt(string, "points6", 0);
	    //position 7
	    DOF2_SetString(string, "name7", "ninguem");
	    DOF2_SetInt(string, "points7", 0);
	    //position 8
	    DOF2_SetString(string, "name8", "ninguem");
	    DOF2_SetInt(string, "points8", 0);
	    //position 9
	    DOF2_SetString(string, "name9", "ninguem");
	    DOF2_SetInt(string, "points9", 0);
	    //position 10
	    DOF2_SetString(string, "name10", "ninguem");
	    DOF2_SetInt(string, "points10", 0);
	    //position 11 - EXTRA
	    DOF2_SetString(string, "name11", "ninguem");
	    DOF2_SetInt(string, "points11", 0);
	    //save
	    DOF2_SaveFile();

	    printf("#rank %s criado com sucesso", rankname);

	}
	return 1;
}
stock resetrank(rankname[])
{

	new string[100];
	format(string, sizeof string, pasta_rank, rankname);

	if(DOF2_FileExists(string)){

	    DOF2_SetString(string, 		"name1", "ninguem");
	    DOF2_SetInt(string, 		"points1", 0);
	    DOF2_SetString(string, 		"name2", "ninguem");
	    DOF2_SetInt(string, 		"points2", 0);
	    DOF2_SetString(string, 		"name3", "ninguem");
	    DOF2_SetInt(string, 		"points3", 0);
	    DOF2_SetString(string, 		"name4", "ninguem");
	    DOF2_SetInt(string, 		"points4", 0);
	    DOF2_SetString(string, 		"name5", "ninguem");
	    DOF2_SetInt(string, 		"points5", 0);
	    DOF2_SetString(string, 		"name6", "ninguem");
	    DOF2_SetInt(string, 		"points6", 0);
	    DOF2_SetString(string, 		"name7", "ninguem");
	    DOF2_SetInt(string, 		"points7", 0);
	    DOF2_SetString(string, 		"name8", "ninguem");
	    DOF2_SetInt(string, 		"points8", 0);
	    DOF2_SetString(string, 		"name9", "ninguem");
	    DOF2_SetInt(string, 		"points9", 0);
	    DOF2_SetString(string, 		"name10", "ninguem");
	    DOF2_SetInt(string, 		"points10", 0);
	    //position 11 - EXTRA
	    DOF2_SetString(string, "name11", "ninguem");
	    DOF2_SetInt(string, "points11", 0);

		//save
		DOF2_SaveFile();

		printf("#rank %s foi resetado", rankname);
	}
	return 1;
}

stock deleterank(rankname[])
{

	new string[100];
	format(string, sizeof string, pasta_rank, rankname);

	if(DOF2_FileExists(string)){

		DOF2_RemoveFile(file);
		printf("#rank %s foi deletado com sucesso", rankname);
	}
	return 1;
}


stock getrank(rankname[], description[])
{
	new buffer[800], file[100], string[100];
    format(file, sizeof file, pasta_rank, rankname);
	//rank 1
    format(string, sizeof string, "{00d900}» 1º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%d {00d900}%s\n", DOF2_GetString(file, "name1"), DOF2_GetInt(file, "points1"), description);
    strcat(buffer, string);
	//rank 2
    format(string, sizeof string, "{00d900}» 2º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%d {00d900}%s\n", DOF2_GetString(file, "name2"), DOF2_GetInt(file, "points2"), description);
    strcat(buffer, string);
	//rank 3
    format(string, sizeof string, "{00d900}» 3º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%d {00d900}%s\n", DOF2_GetString(file, "name3"), DOF2_GetInt(file, "points3"), description);
    strcat(buffer, string);
	//rank 4
    format(string, sizeof string, "{00d900}» 4º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%d {00d900}%s\n", DOF2_GetString(file, "name4"), DOF2_GetInt(file, "points4"), description);
    strcat(buffer, string);
	//rank 5
    format(string, sizeof string, "{00d900}» 5º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%d {00d900}%s\n", DOF2_GetString(file, "name5"), DOF2_GetInt(file, "points5"), description);
    strcat(buffer, string);
	//rank 6
    format(string, sizeof string, "{00d900}» 6º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%d {00d900}%s\n", DOF2_GetString(file, "name6"), DOF2_GetInt(file, "points6"), description);
    strcat(buffer, string);
	//rank 7
    format(string, sizeof string, "{00d900}» 7º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%d {00d900}%s\n", DOF2_GetString(file, "name7"), DOF2_GetInt(file, "points7"), description);
    strcat(buffer, string);
	//rank 8
    format(string, sizeof string, "{00d900}» 8º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%d {00d900}%s\n", DOF2_GetString(file, "name8"), DOF2_GetInt(file, "points8"), description);
    strcat(buffer, string);
	//rank 9
    format(string, sizeof string, "{00d900}» 9º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%d {00d900}%s\n", DOF2_GetString(file, "name9"), DOF2_GetInt(file, "points9"), description);
    strcat(buffer, string);
	//rank 10
    format(string, sizeof string, "{00d900}» 10º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%d {00d900}%s\n", DOF2_GetString(file, "name10"), DOF2_GetInt(file, "points10"), description);
    strcat(buffer, string);
	return buffer;
}
stock getrank2(rankname[], description[])
{
	new buffer[800], file[100], string[100];
    format(file, sizeof file, pasta_rank, rankname);
	//rank 1
    format(string, sizeof string, "{00d900}» 1º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%s {00d900}%s\n", DOF2_GetString(file, "name1"), ConvertTime(DOF2_GetInt(file, "points1")), description);
    strcat(buffer, string);
	//rank 2
    format(string, sizeof string, "{00d900}» 2º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%s {00d900}%s\n", DOF2_GetString(file, "name2"), ConvertTime(DOF2_GetInt(file, "points2")), description);
    strcat(buffer, string);
	//rank 3
    format(string, sizeof string, "{00d900}» 3º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%s {00d900}%s\n", DOF2_GetString(file, "name3"), ConvertTime(DOF2_GetInt(file, "points3")), description);
    strcat(buffer, string);
	//rank 4
    format(string, sizeof string, "{00d900}» 4º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%s {00d900}%s\n", DOF2_GetString(file, "name4"), ConvertTime(DOF2_GetInt(file, "points4")), description);
    strcat(buffer, string);
	//rank 5
    format(string, sizeof string, "{00d900}» 5º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%s {00d900}%s\n", DOF2_GetString(file, "name5"), ConvertTime(DOF2_GetInt(file, "points5")), description);
    strcat(buffer, string);
	//rank 6
    format(string, sizeof string, "{00d900}» 6º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%s {00d900}%s\n", DOF2_GetString(file, "name6"), ConvertTime(DOF2_GetInt(file, "points6")), description);
    strcat(buffer, string);
	//rank 7
    format(string, sizeof string, "{00d900}» 7º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%s {00d900}%s\n", DOF2_GetString(file, "name7"), ConvertTime(DOF2_GetInt(file, "points7")), description);
    strcat(buffer, string);
	//rank 8
    format(string, sizeof string, "{00d900}» 8º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%s {00d900}%s\n", DOF2_GetString(file, "name8"), ConvertTime(DOF2_GetInt(file, "points8")), description);
    strcat(buffer, string);
	//rank 9
    format(string, sizeof string, "{00d900}» 9º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%s {00d900}%s\n", DOF2_GetString(file, "name9"), ConvertTime(DOF2_GetInt(file, "points9")), description);
    strcat(buffer, string);
	//rank 10
    format(string, sizeof string, "{00d900}» 10º {FFFFFF}Lugar: {00e7c6}%s {FFFFFF}%s {00d900}%s\n", DOF2_GetString(file, "name10"), ConvertTime(DOF2_GetInt(file, "points10")), description);
    strcat(buffer, string);
	return buffer;
}
stock FixSpaces2(rankname[])
{
	new file[100], bool:mudanca=false;

    format(file, sizeof file, pasta_rank, rankname);



	new
		name1[50],points1,
		name2[50],points2,
		name3[50],points3,
		name4[50],points4,
		name5[50],points5,
		name6[50],points6,
		name7[50],points7,
		name8[50],points8,
		name9[50],points9,
		name10[50],points10,
		name11[50],points11;

	format(name1, sizeof name1, DOF2_GetString(file, "name1"));
	points1 = DOF2_GetInt(file, "points1");
	format(name2, sizeof name2, DOF2_GetString(file, "name2"));
	points2 = DOF2_GetInt(file, "points2");
	format(name3, sizeof name3, DOF2_GetString(file, "name3"));
	points3 = DOF2_GetInt(file, "points3");
	format(name4, sizeof name4, DOF2_GetString(file, "name4"));
	points4 = DOF2_GetInt(file, "points4");
	format(name5, sizeof name5, DOF2_GetString(file, "name5"));
	points5 = DOF2_GetInt(file, "points5");
	format(name6, sizeof name6, DOF2_GetString(file, "name6"));
	points6 = DOF2_GetInt(file, "points6");
	format(name7, sizeof name7, DOF2_GetString(file, "name7"));
	points7 = DOF2_GetInt(file, "points7");
	format(name8, sizeof name8, DOF2_GetString(file, "name8"));
	points8 = DOF2_GetInt(file, "points8");
	format(name9, sizeof name9, DOF2_GetString(file, "name9"));
	points9 = DOF2_GetInt(file, "points9");
	format(name10, sizeof name10, DOF2_GetString(file, "name10"));
	points10 = DOF2_GetInt(file, "points10");
	format(name11, sizeof name11, DOF2_GetString(file, "name11"));
	points11 = DOF2_GetInt(file, "points11");


	if(points1 < 1)
	{
	    mudanca=true;
		format(name1, sizeof name1, name2);points1=points2;
		format(name2, sizeof name2, name3);points2=points3;
		format(name3, sizeof name3, name4);points3=points4;
		format(name4, sizeof name4, name5);points4=points5;
		format(name5, sizeof name5, name6);points5=points6;
		format(name6, sizeof name6, name7);points6=points7;
		format(name7, sizeof name7, name8);points7=points8;
		format(name8, sizeof name8, name9);points8=points9;
		format(name9, sizeof name9, name10);points9=points10;
		format(name10, sizeof name10, name11);points10=points11;
	}
	if(points2 < 1)
	{
	    mudanca=true;
		format(name2, sizeof name2, name3);points2=points3;
		format(name3, sizeof name3, name4);points3=points4;
		format(name4, sizeof name4, name5);points4=points5;
		format(name5, sizeof name5, name6);points5=points6;
		format(name6, sizeof name6, name7);points6=points7;
		format(name7, sizeof name7, name8);points7=points8;
		format(name8, sizeof name8, name9);points8=points9;
		format(name9, sizeof name9, name10);points9=points10;
		format(name10, sizeof name10, name11);points10=points11;
	}
	if(points3 < 1)
	{
	    mudanca=true;
		format(name3, sizeof name3, name4);points3=points4;
		format(name4, sizeof name4, name5);points4=points5;
		format(name5, sizeof name5, name6);points5=points6;
		format(name6, sizeof name6, name7);points6=points7;
		format(name7, sizeof name7, name8);points7=points8;
		format(name8, sizeof name8, name9);points8=points9;
		format(name9, sizeof name9, name10);points9=points10;
		format(name10, sizeof name10, name11);points10=points11;
	}
	if(points4 < 1)
	{
	    mudanca=true;
		format(name4, sizeof name4, name5);points4=points5;
		format(name5, sizeof name5, name6);points5=points6;
		format(name6, sizeof name6, name7);points6=points7;
		format(name7, sizeof name7, name8);points7=points8;
		format(name8, sizeof name8, name9);points8=points9;
		format(name9, sizeof name9, name10);points9=points10;
		format(name10, sizeof name10, name11);points10=points11;
	}
	if(points5 < 1)
	{
	    mudanca=true;
		format(name5, sizeof name5, name6);points5=points6;
		format(name6, sizeof name6, name7);points6=points7;
		format(name7, sizeof name7, name8);points7=points8;
		format(name8, sizeof name8, name9);points8=points9;
		format(name9, sizeof name9, name10);points9=points10;
		format(name10, sizeof name10, name11);points10=points11;
	}
	if(points6 < 1)
	{
	    mudanca=true;
		format(name6, sizeof name6, name7);points6=points7;
		format(name7, sizeof name7, name8);points7=points8;
		format(name8, sizeof name8, name9);points8=points9;
		format(name9, sizeof name9, name10);points9=points10;
		format(name10, sizeof name10, name11);points10=points11;
	}
	if(points7 < 1)
	{
	    mudanca=true;
		format(name7, sizeof name7, name8);points7=points8;
		format(name8, sizeof name8, name9);points8=points9;
		format(name9, sizeof name9, name10);points9=points10;
		format(name10, sizeof name10, name11);points10=points11;
	}
	if(points8 < 1)
	{
	    mudanca=true;
		format(name8, sizeof name8, name9);points8=points9;
		format(name9, sizeof name9, name10);points9=points10;
		format(name10, sizeof name10, name11);points10=points11;
	}
	if(points9 < 1)
	{
	    mudanca=true;
		format(name9, sizeof name9, name10);points9=points10;
		format(name10, sizeof name10, name11);points10=points11;
	}
	if(points10 < 1)
	{
	    mudanca=true;
		format(name10, sizeof name10, name11);points10=points11;
	}
	
	if(mudanca)
	{
	    DOF2_SetString(file, 		"name1", 	name1);
	    DOF2_SetInt(file, 		"points1", 	points1);
		DOF2_SetString(file, 		"name2", 	name2);
	    DOF2_SetInt(file, 		"points2", 	points2);
		DOF2_SetString(file, 		"name3", 	name3);
	    DOF2_SetInt(file, 		"points3", 	points3);
		DOF2_SetString(file, 		"name4", 	name4);
	    DOF2_SetInt(file, 		"points4", 	points4);
		DOF2_SetString(file, 		"name5", 	name5);
	    DOF2_SetInt(file, 		"points5", 	points5);
		DOF2_SetString(file, 		"name6", 	name6);
	    DOF2_SetInt(file, 		"points6", 	points6);
		DOF2_SetString(file, 		"name7", 	name7);
	    DOF2_SetInt(file, 		"points7", 	points7);
		DOF2_SetString(file, 		"name8", 	name8);
	    DOF2_SetInt(file, 		"points8", 	points8);
		DOF2_SetString(file, 		"name9", 	name9);
	    DOF2_SetInt(file, 		"points9", 	points9);
		DOF2_SetString(file, 		"name10", 	name10);
	    DOF2_SetInt(file, 		"points10", 	points10);
		DOF2_SaveFile();
	}
	return 1;
}


stock removenamerank(rankname[], removename[])
{
	new file[100], name[15], points[15], bool:temnick=false;

    format(file, sizeof file, pasta_rank, rankname);

	for(new i=1; i < 11; i++)
	{
		format(name, sizeof name, "name%d", i);
	    format(points, sizeof points, "points%d", i);

		if(!strcmp(removename, DOF2_GetString(file, name), true)){
	    
	        temnick=true;
		    DOF2_SetString(file, 		name, "ninguem");
		    DOF2_SetInt(file, 			points, 0);
		    break;
	    }
	}
	if(temnick){
		DOF2_SaveFile();
	}

	return 1;
}

stock checkrank(rankname[], name[], points)
{

	new string[100];

    format(string, sizeof string, pasta_rank, rankname);

    removenamerank(rankname, name);

	new
		name1[50],points1,
		name2[50],points2,
		name3[50],points3,
		name4[50],points4,
		name5[50],points5,
		name6[50],points6,
		name7[50],points7,
		name8[50],points8,
		name9[50],points9,
		name10[50],points10,
		name11[50],points11;

	format(name1, sizeof name1, DOF2_GetString(string, "name1"));
	points1 = DOF2_GetInt(string, "points1");
	format(name2, sizeof name2, DOF2_GetString(string, "name2"));
	points2 = DOF2_GetInt(string, "points2");
	format(name3, sizeof name3, DOF2_GetString(string, "name3"));
	points3 = DOF2_GetInt(string, "points3");
	format(name4, sizeof name4, DOF2_GetString(string, "name4"));
	points4 = DOF2_GetInt(string, "points4");
	format(name5, sizeof name5, DOF2_GetString(string, "name5"));
	points5 = DOF2_GetInt(string, "points5");
	format(name6, sizeof name6, DOF2_GetString(string, "name6"));
	points6 = DOF2_GetInt(string, "points6");
	format(name7, sizeof name7, DOF2_GetString(string, "name7"));
	points7 = DOF2_GetInt(string, "points7");
	format(name8, sizeof name8, DOF2_GetString(string, "name8"));
	points8 = DOF2_GetInt(string, "points8");
	format(name9, sizeof name9, DOF2_GetString(string, "name9"));
	points9 = DOF2_GetInt(string, "points9");
	format(name10, sizeof name10, DOF2_GetString(string, "name10"));
	points10 = DOF2_GetInt(string, "points10");
	format(name11, sizeof name11, DOF2_GetString(string, "name11"));
	points11 = DOF2_GetInt(string, "points11");

    if(points > points1)
	{
        DOF2_SetString(string, 		"name2", 	name1);
	    DOF2_SetInt(string, 		"points2", 	points1);
        DOF2_SetString(string, 		"name3", 	name2);
	    DOF2_SetInt(string, 		"points3", 	points2);
        DOF2_SetString(string, 		"name4", 	name3);
	    DOF2_SetInt(string, 		"points4", 	points3);
        DOF2_SetString(string, 		"name5", 	name4);
	    DOF2_SetInt(string, 		"points5", 	points4);
        DOF2_SetString(string, 		"name6", 	name5);
	    DOF2_SetInt(string, 		"points6", 	points5);
        DOF2_SetString(string, 		"name7", 	name6);
	    DOF2_SetInt(string, 		"points7", 	points6);
        DOF2_SetString(string, 		"name8", 	name7);
	    DOF2_SetInt(string, 		"points8", 	points7);
        DOF2_SetString(string, 		"name9", 	name8);
	    DOF2_SetInt(string, 		"points9", 	points8);
        DOF2_SetString(string, 		"name10", 	name9);
	    DOF2_SetInt(string, 		"points10",	points9);

		//set rank
        DOF2_SetString(string, 		"name1", 	name);
	    DOF2_SetInt(string, 		"points1", 	points);

		//save
		DOF2_SaveFile();
    }
    else if(points > points2)
	{
	    //removenamerank(rankname, name);
        DOF2_SetString(string, 		"name3", 	name2);
	    DOF2_SetInt(string, 		"points3", 	points2);
        DOF2_SetString(string, 		"name4", 	name3);
	    DOF2_SetInt(string, 		"points4", 	points3);
        DOF2_SetString(string, 		"name5", 	name4);
	    DOF2_SetInt(string, 		"points5", 	points4);
        DOF2_SetString(string, 		"name6", 	name5);
	    DOF2_SetInt(string, 		"points6", 	points5);
        DOF2_SetString(string, 		"name7", 	name6);
	    DOF2_SetInt(string, 		"points7", 	points6);
        DOF2_SetString(string, 		"name8", 	name7);
	    DOF2_SetInt(string, 		"points8", 	points7);
        DOF2_SetString(string, 		"name9", 	name8);
	    DOF2_SetInt(string, 		"points9", 	points8);
        DOF2_SetString(string, 		"name10", 	name9);
	    DOF2_SetInt(string, 		"points10",	points9);

        DOF2_SetString(string, 		"name2", 	name);
	    DOF2_SetInt(string, 		"points2", 	points);

		//save
		DOF2_SaveFile();
    }
    else if(points > points3)
	{
	    //removenamerank(rankname, name);
        DOF2_SetString(string, 		"name4", 	name3);
	    DOF2_SetInt(string, 		"points4", 	points3);
        DOF2_SetString(string, 		"name5", 	name4);
	    DOF2_SetInt(string, 		"points5", 	points4);
        DOF2_SetString(string, 		"name6", 	name5);
	    DOF2_SetInt(string, 		"points6", 	points5);
        DOF2_SetString(string, 		"name7", 	name6);
	    DOF2_SetInt(string, 		"points7", 	points6);
        DOF2_SetString(string, 		"name8", 	name7);
	    DOF2_SetInt(string, 		"points8", 	points7);
        DOF2_SetString(string, 		"name9", 	name8);
	    DOF2_SetInt(string, 		"points9", 	points8);
        DOF2_SetString(string, 		"name10", 	name9);
	    DOF2_SetInt(string, 		"points10",	points9);

        DOF2_SetString(string, 		"name3", 	name);
	    DOF2_SetInt(string, 		"points3", 	points);

		//save
		DOF2_SaveFile();
    }
    else if(points > points4)
	{
	    //removenamerank(rankname, name);
        DOF2_SetString(string, 		"name5", 	name4);
	    DOF2_SetInt(string, 		"points5", 	points4);
        DOF2_SetString(string, 		"name6", 	name5);
	    DOF2_SetInt(string, 		"points6", 	points5);
        DOF2_SetString(string, 		"name7", 	name6);
	    DOF2_SetInt(string, 		"points7", 	points6);
        DOF2_SetString(string, 		"name8", 	name7);
	    DOF2_SetInt(string, 		"points8", 	points7);
        DOF2_SetString(string, 		"name9", 	name8);
	    DOF2_SetInt(string, 		"points9", 	points8);
        DOF2_SetString(string, 		"name10", 	name9);
	    DOF2_SetInt(string, 		"points10",	points9);

        DOF2_SetString(string, 		"name4", 	name);
	    DOF2_SetInt(string, 		"points4", 	points);

		//save
		DOF2_SaveFile();
    }
    else if(points > points5)
	{
	    //removenamerank(rankname, name);
        DOF2_SetString(string, 		"name6", 	name5);
	    DOF2_SetInt(string, 		"points6", 	points5);
        DOF2_SetString(string, 		"name7", 	name6);
	    DOF2_SetInt(string, 		"points7", 	points6);
        DOF2_SetString(string, 		"name8", 	name7);
	    DOF2_SetInt(string, 		"points8", 	points7);
        DOF2_SetString(string, 		"name9", 	name8);
	    DOF2_SetInt(string, 		"points9", 	points8);
        DOF2_SetString(string, 		"name10", 	name9);
	    DOF2_SetInt(string, 		"points10",	points9);

        DOF2_SetString(string, 		"name5", 	name);
	    DOF2_SetInt(string, 		"points5", 	points);

		//save
		DOF2_SaveFile();
    }
    else if(points > points6)
	{
	    //removenamerank(rankname, name);
        DOF2_SetString(string, 		"name7", 	name6);
	    DOF2_SetInt(string, 		"points7", 	points6);
        DOF2_SetString(string, 		"name8", 	name7);
	    DOF2_SetInt(string, 		"points8", 	points7);
        DOF2_SetString(string, 		"name9", 	name8);
	    DOF2_SetInt(string, 		"points9", 	points8);
        DOF2_SetString(string, 		"name10", 	name9);
	    DOF2_SetInt(string, 		"points10",	points9);

        DOF2_SetString(string, 		"name6", 	name);
	    DOF2_SetInt(string, 		"points6", 	points);

		//save
		DOF2_SaveFile();
    }
    else if(points > points6)
	{
	    //removenamerank(rankname, name);
        DOF2_SetString(string, 		"name7", 	name6);
	    DOF2_SetInt(string, 		"points7", 	points6);
        DOF2_SetString(string, 		"name8", 	name7);
	    DOF2_SetInt(string, 		"points8", 	points7);
        DOF2_SetString(string, 		"name9", 	name8);
	    DOF2_SetInt(string, 		"points9", 	points8);
        DOF2_SetString(string, 		"name10", 	name9);
	    DOF2_SetInt(string, 		"points10",	points9);

        DOF2_SetString(string, 		"name6", 	name);
	    DOF2_SetInt(string, 		"points6", 	points);

		//save
		DOF2_SaveFile();
    }
    else if(points > points7)
	{
	    //removenamerank(rankname, name);
        DOF2_SetString(string, 		"name8", 	name7);
	    DOF2_SetInt(string, 		"points8", 	points7);
        DOF2_SetString(string, 		"name9", 	name8);
	    DOF2_SetInt(string, 		"points9", 	points8);
        DOF2_SetString(string, 		"name10", 	name9);
	    DOF2_SetInt(string, 		"points10",	points9);

        DOF2_SetString(string, 		"name7", 	name);
	    DOF2_SetInt(string, 		"points7", 	points);

		//save
		DOF2_SaveFile();
    }
    else if(points > points8)
	{
	    //removenamerank(rankname, name);
        DOF2_SetString(string, 		"name9", 	name8);
	    DOF2_SetInt(string, 		"points9", 	points8);
        DOF2_SetString(string, 		"name10", 	name9);
	    DOF2_SetInt(string, 		"points10",	points9);

        DOF2_SetString(string, 		"name8", 	name);
	    DOF2_SetInt(string, 		"points8", 	points);

		//save
		DOF2_SaveFile();
    }
    else if(points > points9)
	{
        //removenamerank(rankname, name);
        DOF2_SetString(string, 		"name10", 	name9);
	    DOF2_SetInt(string, 		"points10",	points9);

        DOF2_SetString(string, 		"name9", 	name);
	    DOF2_SetInt(string, 		"points9", 	points);

		//save
		DOF2_SaveFile();
    }
    else if(points > points10)
	{
	    //removenamerank(rankname, name);
        DOF2_SetString(string, 		"name10", 	name);
	    DOF2_SetInt(string, 		"points10", points);

		//save
		DOF2_SaveFile();
    }
    
    //Extra
    else if(points > points11)
	{
	    //removenamerank(rankname, name);
        DOF2_SetString(string, 		"name11", 	name);
	    DOF2_SetInt(string, 		"points11", points);

		//save
		DOF2_SaveFile();
    }

    FixSpaces2(rankname);

	return 1;
}
