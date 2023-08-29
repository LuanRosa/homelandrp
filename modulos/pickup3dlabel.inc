CarregarPickup3dLabel()
{
	CreateDynamicPickup(1275, 23, 1171.679931, -1306.941650, -44.064826); //Equipar Hospital
	CreateDynamicPickup(19339, 23, 934.1115, -1103.3857, 24.3118);//Transportador de Tumba
	CreateDynamicPickup(19921, 23, 1972.660156, -1783.894287, 13.543199);//Mecanica
	CreateDynamicPickup(19056, 23, 1682.7653, -2278.0766, 13.5063);//Presente
	
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}'para \npegar o material.", -1, 1277.651367, -1301.349487, 13.336478, 25.0); // Carregamento Materiais LS
	CreateDynamicPickup(2037, 23, 1277.651367, -1301.349487, 13.336478); //
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}'para \ndeixar o material.", -1, 1258.313720, -1263.115478, 17.821365, 25.0); // Descarregamento Materiais LS
	CreateDynamicPickup(2228, 23, 1258.313720, -1263.115478, 17.821365); //
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}'para \npegar uma camera.", -1, -5467.627441, -4536.831054, 4046.774902, 25.0); // Camera
	CreateDynamicPickup(1275, 23, -5467.627441, -4536.831054, 4046.774902);//Camera

	CreateDynamic3DTextLabel("{FF00FF}Hospital\n{FFFFFF}Use: 'F'", -1, 1150.7927,-1324.8185,-43.4495, 15.0);

	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}'para \nabrir o menu.", -1, 1679.127563, -2290.863525, 13.529936, 15.0);
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}'para \nabrir o menu.", -1, 1686.527221, -2288.146728, 13.510719, 15.0);
	print("[Arquivos Load] Todos os Pickups e 3DLabel foram carregados.");
}