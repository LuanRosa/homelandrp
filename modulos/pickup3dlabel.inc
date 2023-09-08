CarregarPickup3dLabel()
{
	CreateDynamicPickup(1275, 23, 1171.679931, -1306.941650, -44.064826); //Equipar Hospital
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \niniciar uma rota.", -1, 934.1115, -1103.3857, 24.3118, 25.0);
	CreateDynamicPickup(19339, 23, 934.1115, -1103.3857, 24.3118);//Transportador de Tumba
	CreateDynamicPickup(19921, 23, 1972.660156, -1783.894287, 13.543199);//Mecanica
	CreateDynamicPickup(19056, 23, 1682.7653, -2278.0766, 13.5063);//Presente
	
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \ncomecar a minerar.", -1, -368.498535, 2378.540771, 33.939697, 25.0); // Carregamento Materiais LS
	CreateDynamicPickup(337, 23, -368.498535, 2378.540771, 33.939697); //

	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \ncarregar seu caminhao.", -1, -520.421813, -504.999450, 24.635631, 25.0); // Carregamento Materiais LS
	CreateDynamicPickup(1220, 23, -520.421813, -504.999450, 24.635631); //
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \ncarregar seu caminhao.", -1, -529.748168, -504.937561, 24.640802, 25.0); // Carregamento Materiais LS
	CreateDynamicPickup(1220, 23, -529.748168, -504.937561, 24.640802); //
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \ncarregar seu caminhao.", -1, -557.552368, -505.473480, 24.596021, 25.0); // Carregamento Materiais LS
	CreateDynamicPickup(1220, 23, -557.552368, -505.473480, 24.596021); //

	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \npegar o material.", -1, 1277.651367, -1301.349487, 13.336478, 25.0); // Carregamento Materiais LS
	CreateDynamicPickup(2037, 23, 1277.651367, -1301.349487, 13.336478); //
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \ndeixar o material.", -1, 1258.313720, -1263.115478, 17.821365, 25.0); // Descarregamento Materiais LS
	CreateDynamicPickup(2228, 23, 1258.313720, -1263.115478, 17.821365); //
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \npegar uma camera.", -1, -5467.627441, -4536.831054, 4046.774902, 25.0); // Camera
	CreateDynamicPickup(1275, 23, -5467.627441, -4536.831054, 4046.774902);//Camera

	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \nabrir o menu.", -1, 1679.127563, -2290.863525, 13.529936, 15.0);
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \nabrir o menu.", -1, 1686.527221, -2288.146728, 13.510719, 15.0);

	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \nprocessar a peca de carne.", -1, 942.577758, 2117.902099, 1011.030273, 15.0);
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \npegar uma embalagem.", -1, 938.006469, 2144.264892, 1011.023437, 15.0);
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \ncolocar a carne na caixa.", -1, 942.416259, 2137.294921, 1011.023437, 15.0);
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \nrevisar a caixa.", -1, 942.421325, 2153.745849, 1011.023437, 15.0);
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \npegar a caixa.", -1, 942.288391, 2173.139404, 1011.023437, 15.0);
	CreateDynamic3DTextLabel("Ponto de entrega.", -1, 964.872192, 2159.816406, 1011.030273, 15.0);
	print("[Arquivos Load] Todos os Pickups e 3DLabel foram carregados.");
}