package com.psyssp.mapper;

import java.util.List;

import org.springframework.stereotype.Service;

import com.psyssp.beans.Paa;

@Service
public interface PaaMapper extends TblMapper<Paa> {

	List<List<?>> selectaa();

}
