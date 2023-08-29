///////////////////////////////////////////////////////////////////////////////
//
//
//        #### ########   ######     ######## ########    ###    ##     ##
//         ##  ##     ## ##    ##       ##    ##         ## ##   ###   ###
//         ##  ##     ## ##             ##    ##        ##   ##  #### ####
//         ##  ########   ######        ##    ######   ##     ## ## ### ##
//         ##  ##              ##       ##    ##       ######### ##     ##
//         ##  ##        ##    ##       ##    ##       ##     ## ##     ##
//        #### ##         ######        ##    ######## ##     ## ##     ##
//
//
//                    Criado por Bruno da Silva (iPs DraKiNs)
//
//          Acesse meu blog sobre programação www.brunodasilva.com.br
//
//              Seja membro da melhor equipe de programação
//         http://ips-team.forumeiros.com/t2-informacao-inscricao-na-ips

//                    [iPs]TeaM soluções de programação em geral
//
//
//              [Bruno]Ini Files (Bini) Versão 4.0 (ultra rápido)
//
//
/////////////////////////////////////////////////////////////////////////////////

// Funções Atuais:

//   CallBack INI_WriteString("arquivo", "key", "valor")
//   CallBack INI_WriteFloat("arquivo"",key", valor)
//   CallBack INI_WriteInt("arquivo","key", valor)
//   CallBack INI_WriteBool("arquivo","key", bool:valor)

//   CallBack INI_ReadString("arquivo", "key")
//   CallBack INI_ReadInt("arquivo", "key")
//   CallBack INI_ReadFloat("arquivo","key")
//   CallBack INI_ReadBool("arquivo","key")

//   CallBack INI_Create("arquivo")
//   CallBack INI_Delete("arquivo")
//   CallBack INI_Open("arquivo")

//   CallBack INI_Isset("arquivo","tag")
//   CallBack INI_Print()


// [ Configurações Gerais ]

#define max_lines_file          (999)
#define max_chars_file          (256)
#define max_dep_memory          (125)

// [ Declarações ]

stock bufferStrings[max_lines_file][max_dep_memory];
stock nomeKey[max_lines_file][max_dep_memory];
stock nomeArquivo[max_dep_memory];
stock sizeMemory   = 0;
stock destinoString[20];
stock bool:vaWrite;
stock totalLinhas = 0;


#define stringGet(%0)               bufferStrings[getproperty(0,%0)]
#define CallBack%0(%1)              stock %0(%1)
#define INI_Isset(%2,%0)            !!(INI_Open(%2), existproperty(0, %0))
#define INI_Create(%1)              fclose(fopen(%1, io_write))
#define INI_WriteBool(%2,%0,%1)     INI_WriteString(%0, %1 ? ("true") : ("false"))
#define INI_ReadInt(%2,%0)          strval(INI_ReadString(%2,%0))
#define INI_ReadFloat(%2,%0)        floatstr(INI_ReadString(%2,%0))
#define INI_Delete(%0)              fremove(%0)
#define INI_ReadBool(%2,%0)         bool:strcmp((format(destinoString, sizeof(destinoString), "%i", %0),destinoString), false)
#define INI_WriteInt(%2,%0,%1)      INI_WriteString(%2,%0,(format(destinoString, sizeof(destinoString), "%i", %1),destinoString))
#define INI_WriteFloat(%2,%0,%1)    INI_WriteString(%2,%0,(format(destinoString, sizeof(destinoString), "%f", %1),destinoString))
#define INI_ReadString(%0,%1)       (INI_Open(%0), stringGet(%1))
#define prev_strcmp(%0,%1)          INI_HashString(%0) == INI_HashString(%1)

CallBack INI_Exit()
{
    if(strlen(nomeArquivo)) {
        if(vaWrite) INI_Save();
        INI_Close();
    }
    return true;
}




CallBack INI_Open(arquivoLer[])
{
    if(prev_strcmp(arquivoLer, nomeArquivo)) {
        if(!strcmp(arquivoLer, nomeArquivo, false)) {
            return true;
        }
    }
    else {
        INI_Exit();
    }

    new
        bufferArquivo[max_chars_file],
        linhasArquivo = 0xFFFFFFFF,
        bufferIntArquivo = 0xFFFFFFFF,
        File:arquivoFopen,
        bufferStringValor[max_dep_memory];

    strcat((nomeArquivo[0] = '\0', nomeArquivo),arquivoLer,sizeof nomeArquivo);

    if((arquivoFopen = fopen(arquivoLer, io_read))) {

        while(fread(arquivoFopen, bufferArquivo)) {
            if(strlen(bufferArquivo) > 1) {
                if((bufferIntArquivo = strfind(bufferArquivo, "=")) == -1 || bufferIntArquivo > max_chars_file) continue;

                bufferArquivo[strlen(bufferArquivo) - 2]  = EOS;
                strcat((bufferStringValor[0] = '\0', bufferStringValor), bufferArquivo[bufferIntArquivo+1], max_dep_memory);

                ++linhasArquivo;
                bufferArquivo[bufferIntArquivo] = EOS;

                strcat((nomeKey[linhasArquivo][0] = '\0', nomeKey[linhasArquivo]), bufferArquivo, max_dep_memory);
                stringSet(bufferArquivo, bufferStringValor);
            }
        }
        totalLinhas = linhasArquivo+1;
        fclose(arquivoFopen);
    }
    return true;
}


new
	idxMatriz
;

CallBack stringSet(string[], set[])
{
    if(existproperty(0, string)) {
        idxMatriz = getproperty(0,string);
        setproperty(0, .name=string, .value=idxMatriz);
        strcat((bufferStrings[idxMatriz][0] = '\0', bufferStrings[idxMatriz]), set, max_dep_memory);
    }
    else {
        sizeMemory++;
        setproperty(0, .name=string, .value=sizeMemory);
        strcat((bufferStrings[sizeMemory][0] = '\0', bufferStrings[sizeMemory]), set, max_dep_memory);
    }
    return true;
}


new
	totalContadoINIHASH = 0
;

CallBack INI_HashString(buffer[])
{
    totalContadoINIHASH = 0;
    for(new i = strlen(buffer); i != -1; i--) {
        totalContadoINIHASH += buffer[i];
    }
    return totalContadoINIHASH;
}


new lineSaveINI[max_chars_file];
new File:arquivoIniFopen;

CallBack INI_Save()
{
    arquivoIniFopen = fopen(nomeArquivo, io_write);

    for(new i = 0; i < totalLinhas; ++i) {
        format(lineSaveINI, max_chars_file, "%s=%s\r\n", nomeKey[i], stringGet(nomeKey[i]));
        fwrite(arquivoIniFopen, lineSaveINI);
    }
    return fclose(arquivoIniFopen);
}


CallBack INI_Print()
{
    for(new i ; i < totalLinhas ; ++i) {
        printf("%s=%s" ,nomeKey[i], stringGet(nomeKey[i]));
    }
    return true;
}


CallBack INI_Close()
{
    vaWrite = false;
    for(new i = 0; i <= totalLinhas; i++) {
        nomeKey[i][0] = EOS;
        bufferStrings[i][0] = EOS;
        deleteproperty(0, "", i);
    }
    return sizeMemory = 0, totalLinhas = 0, true;
}


CallBack INI_WriteString(file[], keySet[], valueSet[])
{
    INI_Open(file);

    if(!existproperty(0, keySet)) {
        strcat(nomeKey[totalLinhas], keySet);
        totalLinhas++;
    }

    vaWrite = true;
    return stringSet(keySet, valueSet);
}


////////////////////////////////////////////////////////////////////////////////
