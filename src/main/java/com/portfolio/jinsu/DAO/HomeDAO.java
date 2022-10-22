package com.portfolio.jinsu.DAO;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.portfolio.jinsu.DTO.HomeDTO;

@Repository
public class HomeDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String Namespace = "HomeDAO";

	public List<String> getTables() {
		return sqlSession.selectList(Namespace + ".getTables");
	}

	public List<String> getColumns() {
		return sqlSession.selectList(Namespace + ".getColumns");
	}

	public List<String> getSeqList(Map<String, String> JSON) {
		return sqlSession.selectList(Namespace + ".getSeqList", JSON);
	}

	public Map<String, String> getSeqData(Map<String, String> JSON) {
		return sqlSession.selectOne(Namespace + ".getSeqData", JSON);
	}

	public void insertData(HomeDTO homeDTO) {
		sqlSession.insert(Namespace + ".insertData", homeDTO);
	}

	public void updateData(HomeDTO homeDTO) {
		sqlSession.update(Namespace + ".updateData", homeDTO);
	}

	public List<Map<String, String>> getPortfolioData() {
		return sqlSession.selectList(Namespace + ".getPortfolioData");
	}

	public String getRecentSeq(Map<String,String> JSON) {
		return sqlSession.selectOne(Namespace + ".getRecentSeq",JSON);
	}

	public void delData(Map<String, String> JSON) {		
		sqlSession.delete(Namespace + ".delData", JSON);
	}

	public Map<String,String> loginCheck(Map<String,String> map) {
		return sqlSession.selectOne(Namespace + ".loginCheck",map);
	}
}
