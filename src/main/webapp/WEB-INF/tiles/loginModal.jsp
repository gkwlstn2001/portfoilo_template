<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tiles/common/ctld.jsp"%>     
        <!-- 사이트 소개 / 이력 소개 / 기술스택 소개시 사용할 모달 -->
        <div class="portfolio-modal modal fade" id="defloginModal" tabindex="-1" aria-labelledby="defloginModal" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header border-0"><button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button></div>
                    <div class="modal-body text-center pb-5">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <!-- Portfolio Modal - Title-->
                                    <h2 class="portfolio-modal-title text-secondary text-uppercase mb-0" id="displayTitle">관리자 로그인</h2>
                                    <!-- Icon Divider-->
                                    <div class="divider-custom">
                                        <div class="divider-custom-line"></div>
                                        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                        <div class="divider-custom-line"></div>
                                    </div>
                                    <!-- Portfolio Modal - Image-->
                                    <form action="/login" method="post">
                                    	<table style="width:50%; margin: 0 auto;">
	                                    	<tr>
	                                    		<th>
	                                    			<label>아이디 :</label>
	                                    		</th>
	                                    		<td>
	                                    			<input type="text" name="id" value="" placeholder="ID를 입력하세요" style="width:100%; text-align:center;">
	                                    		</td>	                                    
	                                    	</tr>
	                                    	<tr>
	                                    		<th>
	                                    			<label>패스워드 :</label>
	                                    		</th>
	                                    		<td>
	                                    			<input type="password" name="pwd" value="" placeholder="PW를 입력하세요" style="width:100%; text-align:center;">
	                                    		</td>
	                                    	</tr>
                                    	</table>	                                    
	                                    <!-- Portfolio Modal - Text-->
	                                    <br>
	                                    <p class="mb-4" id="displayIntroduce">관리자계정으로 로그인하세요</p>
	                                    <input type="submit" class="btn btn-primary" value="로그인">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>              