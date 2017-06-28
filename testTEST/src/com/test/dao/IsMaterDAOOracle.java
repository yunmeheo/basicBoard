package com.test.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.vo.IsMater;

@Repository
public class IsMaterDAOOracle implements IsMaterDAO{
	
	@Autowired
	SqlSession session;

	@Override
	public void insert(IsMater im) {
		
		session.insert("IsMaterMapper.insert",im);
		
	}

	public List<IsMater> selectAll(int startPage, int endPage) {
		
		Map<String,Object> map = new HashMap<>();
		System.out.println("IsMaterDAOOracle startPage : "+startPage+", endPage"+endPage);
		map.put("startPage", startPage);
		map.put("endPage",endPage);
		return session.selectList("IsMaterMapper.selectAll",map);
	}

	
	//길이만 뽑기위한 메서드
	@Override
	public List<IsMater> selectAll(String searchItem, String searchValue) {
		Map<String,Object> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchValue",searchValue);
		return session.selectList("IsMaterMapper.selectAllList",map);
	}

	public IsMater selectByNo(String checkedId) {
		return session.selectOne("IsMaterMapper.selectByNo",checkedId);
	}

	public List<IsMater> selectAll(int startPage, int endPage, String searchItem, String searchValue) {
		Map<String,Object> map = new HashMap<>();
		map.put("startPage", startPage);
		map.put("endPage",endPage);
		map.put("searchItem", searchItem);
		map.put("searchValue",searchValue);
		return session.selectList("IsMaterMapper.selectAll",map);
	}

	public void delete(String checkedId) {
		
		session.delete("IsMaterMapper.delete",checkedId);

	}

	public void modify(IsMater im) {
		session.update("IsMaterMapper.modify",im);
	}
	
	
	

	
	
	

}
