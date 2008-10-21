/**
 * @file op_abi.cpp
 * This file contains a simple C interface to the ABI-describing functionality,
 * the majority of which is implemented in C++. this is the file which is 
 * intended for use in files outside the /libabi directory.
 *
 * @remark Copyright 2002 OProfile authors
 * @remark Read the file COPYING
 *
 * @author Graydon Hoare
 */

#include "op_abi.h"
#include "odb.h"
#include "op_sample_file.h"

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define byte_addr(x) (reinterpret_cast<unsigned char *>(&(x)))
#define field_offset(s, f) (byte_addr(s.f) - byte_addr(s))

int op_write_abi_to_file(char const * abi_file)
{
	odb_node_t node;
	odb_descr_t descr;
	struct opd_header header;

    FILE* file = fopen(abi_file, "wt");

    fprintf(file, "sizeof_double %u\n",  sizeof(double));

	fprintf(file, "sizeof_time_t %u\n", sizeof(time_t));
	fprintf(file, "sizeof_u8 %u\n", sizeof(u8));
	fprintf(file, "sizeof_u32 %u\n", sizeof(u32));
	fprintf(file, "sizeof_int %u\n", sizeof(int));
	fprintf(file, "sizeof_unsigned_int %u\n", sizeof(unsigned int));
	fprintf(file, "sizeof_odb_key_t %u\n", sizeof(odb_key_t));
	fprintf(file, "sizeof_odb_index_t %u\n", sizeof(odb_index_t));
	fprintf(file, "sizeof_odb_value_t %u\n", sizeof(odb_value_t));
	fprintf(file, "sizeof_odb_node_nr_t %u\n", sizeof(odb_node_nr_t));
	fprintf(file, "sizeof_odb_descr_t %u\n", sizeof(odb_descr_t));
	fprintf(file, "sizeof_odb_node_t %u\n", sizeof(odb_node_t));
	fprintf(file, "sizeof_struct_opd_header %u\n", sizeof(struct opd_header));		
	
	fprintf(file, "offsetof_node_key %u\n", field_offset(node, key));
	fprintf(file, "offsetof_node_value %u\n", field_offset(node, value));
	fprintf(file, "offsetof_node_next %u\n", field_offset(node, next));
	
	fprintf(file, "offsetof_descr_size %u\n", field_offset(descr, size));
	fprintf(file, "offsetof_descr_current_size %u\n", field_offset(descr, current_size));
	
	fprintf(file, "offsetof_header_magic %u\n", field_offset(header, magic));
	fprintf(file, "offsetof_header_version %u\n", field_offset(header, version));
	fprintf(file, "offsetof_header_cpu_type %u\n", field_offset(header, cpu_type));
	fprintf(file, "offsetof_header_ctr_event %u\n", field_offset(header, ctr_event));
	fprintf(file, "offsetof_header_ctr_um %u\n", field_offset(header, ctr_um));
	fprintf(file, "offsetof_header_ctr_count %u\n", field_offset(header, ctr_count));
	fprintf(file, "offsetof_header_is_kernel %u\n", field_offset(header, is_kernel));
	fprintf(file, "offsetof_header_cpu_speed %u\n", field_offset(header, cpu_speed));
	fprintf(file, "offsetof_header_mtime %u\n", field_offset(header, mtime));
	fprintf(file, "offsetof_header_cg_to_is_kernel %u\n", field_offset(header, cg_to_is_kernel));
	fprintf(file, "offsetof_header_anon_start %u\n", field_offset(header, anon_start));
	fprintf(file, "offsetof_header_cg_to_anon_start %u\n", field_offset(header, cg_to_anon_start));
    
	// determine endianness

	unsigned int probe = 0xff;
	size_t sz = sizeof(unsigned int);
	unsigned char * probe_byte = reinterpret_cast<unsigned char *>(&probe);

	assert(probe_byte[0] == 0xff || probe_byte[sz - 1] == 0xff);

	if (probe_byte[0] == 0xff)
		fprintf(file, "little_endian 1\n");
	else
		fprintf(file, "little_endian 0\n");

	fprintf(file, "\n");

    fclose(file);
	return 1;
}
