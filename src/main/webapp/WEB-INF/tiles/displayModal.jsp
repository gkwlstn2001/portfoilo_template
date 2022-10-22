<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tiles/common/ctld.jsp"%>     
        <!-- 사이트 소개 / 이력 소개 / 기술스택 소개시 사용할 모달 -->
        <div class="portfolio-modal modal fade" id="defaultModal" tabindex="-1" aria-labelledby="defaultModal" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header border-0"><button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button></div>
                    <div class="modal-body text-center pb-5">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <!-- Portfolio Modal - Title-->
                                    <h2 class="portfolio-modal-title text-secondary text-uppercase mb-0" id="displayTitle"></h2>
                                    <!-- Icon Divider-->
                                    <div class="divider-custom">
                                        <div class="divider-custom-line"></div>
                                        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                        <div class="divider-custom-line"></div>
                                    </div>
                                    <!-- Portfolio Modal - Image-->
                                    <div class="swiper-container">
	                					<div class="swiper-wrapper" id="displayImg"></div>
	                					<!-- 네비게이션 지정 -->
										<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
										<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
							
										<!-- 페이징 -->
										<div class="swiper-pagination"></div>                	                   
                					</div>
                                    <!-- Portfolio Modal - Text-->
                                    <p class="mb-4" id="displayIntroduce"></p>
                                    <a class="btn btn-primary" href="#" target="blank" id="displayLink">사이트 체험하기</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>              