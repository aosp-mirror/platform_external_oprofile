/**
 * @file op_libiberty.c
 * Wrapper for libiberty - always use this instead of
 * libiberty.h
 *
 * @remark Copyright 2002 OProfile authors
 * @remark Read the file COPYING
 *
 * @author John Levon
 * @author Philippe Elie
 */

#include <string.h>
#include <stdlib.h>

#include "op_libiberty.h"

#ifndef HAVE_XCALLOC
/* some system have a valid libiberty without xcalloc */
void * xcalloc(size_t n_elem, size_t sz)
{
	void * ptr = xmalloc(n_elem * sz);

	memset(ptr, '\0', n_elem * sz);

	return ptr;
}
#endif

#ifndef HAVE_XMEMDUP
void * xmemdup (void const * input, size_t copy_size, size_t alloc_size)
{
	void * output = xcalloc(1, alloc_size);

	memcpy(output, input, copy_size);

	return output;
}
#endif

#ifndef HAVE_LIBIBERTY_H

void xmalloc_set_program_name(char const * a)
{
}

void * xmalloc(size_t s)
{
    return malloc(s);
}

void * xrealloc(void *p, size_t s)
{
    return realloc(p, s);
}

/* Copy a string into a memory buffer without fail.  */
char * xstrdup(char const * str)
{
    return strdup(str);
}

#endif
