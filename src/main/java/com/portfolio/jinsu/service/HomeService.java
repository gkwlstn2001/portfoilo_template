package com.portfolio.jinsu.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.portfolio.jinsu.DAO.HomeDAO;
import com.portfolio.jinsu.DTO.HomeDTO;

@Service
public class HomeService {
	
	@Autowired
	HomeDAO hdao;

	public List<String> getTables() {
		return hdao.getTables();
	}

	public List<String> getColumns() {
		return hdao.getColumns();
	}

	public List<String> getSeqList(Map<String, String> JSON) {
		return hdao.getSeqList(JSON);
	}

	public Map<String, String> getSeqData(Map<String, String> JSON) {
		return hdao.getSeqData(JSON);
	}

	public void insertData(HomeDTO homeDTO) {
		hdao.insertData(homeDTO);
	}

	public void updateData(HomeDTO homeDTO) {
		hdao.updateData(homeDTO);
	}

	public List<Map<String, String>> getPortfolioData() {
		return hdao.getPortfolioData();
	}

	public String getRecentSeq(Map<String,String> JSON) {		
		return hdao.getRecentSeq(JSON);
	}

	public void delData(Map<String, String> JSON) {
		hdao.delData(JSON);
	}

	public Map<String,String> loginCheck(Map<String,String> map) {
		return hdao.loginCheck(map);
	}	
}
