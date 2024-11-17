/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#include <memory.h> /* for memset */
#include "uber.h"

/* Default timeout can be changed using clnt_control() */
static struct timeval TIMEOUT = { 25, 0 };

InfoAuto *
solicitarviaje_1(Posicion *argp, CLIENT *clnt)
{
	static InfoAuto clnt_res;

	memset((char *)&clnt_res, 0, sizeof(clnt_res));
	if (clnt_call (clnt, SolicitarViaje,
		(xdrproc_t) xdr_Posicion, (caddr_t) argp,
		(xdrproc_t) xdr_InfoAuto, (caddr_t) &clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return (NULL);
	}
	return (&clnt_res);
}

void *
terminarviaje_1(TerminarViajeArgs *argp, CLIENT *clnt)
{
	static char clnt_res;

	memset((char *)&clnt_res, 0, sizeof(clnt_res));
	if (clnt_call (clnt, TerminarViaje,
		(xdrproc_t) xdr_TerminarViajeArgs, (caddr_t) argp,
		(xdrproc_t) xdr_void, (caddr_t) &clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return (NULL);
	}
	return ((void *)&clnt_res);
}

EstadoServicio *
estadoservicio_1(void *argp, CLIENT *clnt)
{
	static EstadoServicio clnt_res;

	memset((char *)&clnt_res, 0, sizeof(clnt_res));
	if (clnt_call (clnt, estadoServicio,
		(xdrproc_t) xdr_void, (caddr_t) argp,
		(xdrproc_t) xdr_EstadoServicio, (caddr_t) &clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return (NULL);
	}
	return (&clnt_res);
}