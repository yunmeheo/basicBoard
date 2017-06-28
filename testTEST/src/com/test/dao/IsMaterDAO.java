package com.test.dao;

import java.util.List;

import com.test.vo.IsMater;

public interface IsMaterDAO {
	
	/**
	 * 사원 등록
	 * @param im  사원정보
	 */
	public void insert(IsMater im);
	
	/**
	 * 모든사원의 정보 불러오기
	 * @return   모든사원정보
	 */
	public List<IsMater> selectAll(int a ,int b);
	
	/**
	 * 모든사원 정보 불러오기
	 * @return   모든사원정보
	 */
	public List<IsMater> selectAll(String searchItem, String searchValue);

	
	/**
	 * 
	 * @param searchItem 검색기준
	 * @param searchValue  검색어
	 * @return 사원정보
	 */
	/*public List<IsMater> selectByItem(String searchItem, String searchValue);*/
}
