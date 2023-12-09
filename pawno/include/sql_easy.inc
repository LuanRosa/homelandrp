/*
 *
 * Copyright (C) 2015 Dimmy
 *
 * Data: 17 Set de 2016
 * Criado para uso exclusivo
 *
 *

native sql_init(stringinit[]);
native sql_setint(key[], value);
native sql_setfloat(key[], Float:value);
native sql_setbool(key[], bool:value);
native sql_setstring(key[], value[]);
native sql_getint(DBResult:result, key[]);
native sql_getfloat(DBResult:result, key[]);
native sql_getbool(DBResult:result, key[]);
native sql_getstring(DBResult:result, key[]);
native sql_setrequires(requires[]);
native sql_save();
*/

static stock sql_string_total[1024];
static stock sql_keys_count;

/*
 * sql_init
 * Usado para iniciar uma aplicação
 */
stock sql_init(stringinit[]) {
    format(sql_string_total, sizeof (sql_string_total), stringinit), sql_keys_count = 0;
}

/*
 * sql_setint
 * Usado para setar um valor inteiro a uma key
 */
stock sql_setint(key[], value) {
	format(sql_string_total, sizeof (sql_string_total), "%s%s`%s`='%d'", sql_string_total, sql_keys_count ? (",") : (" SET "), key, value), sql_keys_count++;
}

/*
 * sql_setfloat
 * Usado para setar um valor float a uma key
 */
stock sql_setfloat(key[], Float:value) {
    format(sql_string_total, sizeof (sql_string_total), "%s%s`%s`='%f'", sql_string_total, sql_keys_count ? (",") : (" "), key, value), sql_keys_count++;
}

/*
 * sql_setbool
 * Usado para setar um valor boolean a uma key
 */
stock sql_setbool(key[], bool:value) {
    format(sql_string_total, sizeof (sql_string_total), "%s%s`%s`='%d'", sql_string_total, sql_keys_count ? (",") : (" "), key, value), sql_keys_count++;
}

/*
 * sql_setstring
 * Usado para setar uma string a uma key
 */
stock sql_setstring(key[], value[]) {
    format(sql_string_total, sizeof (sql_string_total), "%s%s`%s`='%s'", sql_string_total, sql_keys_count ? (",") : (" "), key, value), sql_keys_count++;
}

/*
 * sql_getint
 * Usado para pegar um valor inteiro de uma consulta
 */
stock sql_getint(DBResult:result, key[]) {
	return db_get_field_assoc_int(result, key);
}

/*
 * sql_getfloat
 * Usado para pegar um valor float de uma consulta
 */
stock Float:sql_getfloat(DBResult:result, key[]) {
    return db_get_field_assoc_float(result, key);
}

/*
 * sql_getbool
 * Usado para pegar um valor boolean de uma consulta
 */
stock bool:sql_getbool(DBResult:result, key[]) {
    return bool:db_get_field_assoc_int(result, key);
}

/*
 * sql_getstring
 * Usado para pegar uma string de uma consulta
 */
stock sql_getstring(DBResult:result, key[]) {
	static string_result[144];
	db_get_field_assoc(result, key, string_result, sizeof (string_result));
	return string_result;
}

/*
 * sql_setrequires
 * Usado para setar os requisitos para setar os valores
 */
stock sql_setrequires(requires[]) {
	format(sql_string_total, sizeof (sql_string_total), "%s %s", sql_string_total, requires);
}

/*
 * sql_save
 * Usado para setar os valores
 */
stock sql_save(DB:db, bool:closedb = false) {
	db_free_result(db_query(db, sql_string_total));

	if (closedb) db_close(db);
}

