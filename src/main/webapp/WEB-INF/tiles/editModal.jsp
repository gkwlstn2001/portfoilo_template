<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tiles/common/ctld.jsp"%>        
        <!-- 편집용 모달 -->
        <div class="portfolio-modal modal fade" id="defEditModal" tabindex="-1" aria-labelledby="defEditModal" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header border-0"><button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button></div>
                    <div class="modal-body text-center pb-5">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <!-- Portfolio Modal - Title-->
                                    <h2 class="portfolio-modal-title text-secondary text-uppercase mb-0">편집하기</h2>
                                    <!-- Icon Divider-->
                                    <div class="divider-custom">
                                        <div class="divider-custom-line"></div>
                                        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                        <div class="divider-custom-line"></div>
                                    </div>
                                    <form action="/submitEditData" name="editModalForm" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
	                                    <table id="editContents" style="width:100%">
	                                    	<tr>
	                                    		<th>
	                                    			<label>tableName</label>
	                                    		</th>
	                                    		<td>
	                                    			<select name="table" onchange="getSeqList()" style="width:100%; text-align:center;">
				                                    	<c:forEach var="table" items="${tables}">
				                                    		<option value="${table}">${table}</option>
				                                    	</c:forEach>                                    	
				                                    </select>
	                                    		</td>
	                                    	</tr>	                                                                        	                                    		                                    	
	                                    	<c:forEach var="column" items="${columns}">
	                                    		<tr>   
	                                    			<c:if test="${column!='regdate'}">                     
		                                    			<th>            			
			                                    			<label>${column}</label>
			                                    		</th>
		                                    		</c:if>
		                                    		<c:choose>
		                                    			<c:when test="${fn:contains(column,'seq')}">
		                                    				<td id="seq"></td>
		                                    			</c:when>
		                                    			<c:when test="${fn:contains(column,'introduce')}">
		                                    				<td>
		                                    					<textarea name="${column}" id="contents" rows="10" cols="60" style="width:100%;"></textarea>
		                                    				</td>
		                                    			</c:when>
		                                    			<c:when test="${fn:contains(column,'file')}">	
		                                    				<td>
		                                    					<input type="file" name="${column}">
		                                    				</td>	                                    						                                    				
		                                    			</c:when>		                                    			
		                                    			<c:otherwise>
		                                    				<c:if test="${column!='regdate'}">		                                    				
				                                    			<td>
				                                    				<input type="text" name="${column}" style="width:100%; text-align:center;">
				                                    			</td>	
			                                    			</c:if>	      		                                 				
		                                    			</c:otherwise>
		                                    		</c:choose>	                                    			                                    			                                    	
	                                    		</tr>
	                                    	</c:forEach>
	                                    </table>                                    
	                                    <!-- Portfolio Modal - Text-->
	                                    <br/>	                                    
                                    </form>
                                    <input class="btn btn-primary" type="button" value="추가모드" onclick="addMode()">
                                    <input class="btn btn-primary saveBtn" type="button" value="추가">
	                                <input class="btn btn-primary saveBtn" type="button" value="수정">
	                                <input class="btn btn-primary" type="button" value="삭제" onclick="delData()">                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>  