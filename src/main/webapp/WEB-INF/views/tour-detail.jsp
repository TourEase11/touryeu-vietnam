<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container my-5">
    <div class="row">
        <div class="col-md-8">
            <img src="${tour.image}" class="img-fluid rounded mb-4" alt="${tour.name}">
            
            <h2 class="mb-3">${tour.name}</h2>
            
            <div class="d-flex align-items-center mb-4">
                <span class="badge bg-primary me-2">${tour.categoryName}</span>
                <c:forEach begin="1" end="5" var="i">
                    <i class="bi bi-star${i <= tour.avgRating ? '-fill' : ''} text-warning"></i>
                </c:forEach>
                <span class="ms-2 text-muted">(${tour.reviewCount} đánh giá)</span>
            </div>
            
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <i class="bi bi-geo-alt text-primary fs-4"></i>
                            <div class="mt-2">
                                <strong>Địa điểm</strong>
                                <p class="mb-0 text-muted">${tour.location}</p>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <i class="bi bi-clock text-primary fs-4"></i>
                            <div class="mt-2">
                                <strong>Thời gian</strong>
                                <p class="mb-0 text-muted">${tour.duration} ngày ${tour.duration - 1} đêm</p>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <i class="bi bi-calendar3 text-primary fs-4"></i>
                            <div class="mt-2">
                                <strong>Khởi hành</strong>
                                <p class="mb-0 text-muted"><fmt:formatDate value="${tour.departureDate}" pattern="dd/MM/yyyy"/></p>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <i class="bi bi-bus-front text-primary fs-4"></i>
                            <div class="mt-2">
                                <strong>Phương tiện</strong>
                                <p class="mb-0 text-muted">${tour.vehicle}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-info-circle"></i> Mô Tả Tour</h5>
                </div>
                <div class="card-body">
                    <p>${tour.description}</p>
                </div>
            </div>
            
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-list-ol"></i> Lịch Trình</h5>
                </div>
                <div class="card-body">
                    <pre class="mb-0" style="white-space: pre-wrap;">${tour.itinerary}</pre>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-chat-dots"></i> Đánh Giá (${tour.reviewCount})</h5>
                </div>
                <div class="card-body">
                       
                    <c:forEach items="${reviews}" var="review">
                        <div class="border-bottom pb-3 mb-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <strong>${review.userFullname}</strong>
                                <small class="text-muted"><fmt:formatDate value="${review.createdAt}" pattern="dd/MM/yyyy HH:mm"/></small>
                            </div>
                            <div class="my-2">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="bi bi-star${i <= review.rating ? '-fill' : ''} text-warning"></i>
                                </c:forEach>
                            </div>
                            <p class="mb-0">${review.comment}</p>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty reviews}">
                        <p class="text-muted text-center">Chưa có đánh giá nào</p>
                    </c:if>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card shadow sticky-top" style="top: 100px;">
                <div class="card-body">
                    <div class="mb-3">
                        <c:if test="${tour.discount > 0}">
                            <div class="price-old"><fmt:formatNumber value="${tour.price}" type="number"/> VNĐ</div>
                        </c:if>
                        <div class="price-tag"><fmt:formatNumber value="${tour.finalPrice}" type="number"/> VNĐ</div>
                        <small class="text-muted">/ người</small>
                    </div>
                    
                    <c:if test="${tour.discount > 0}">
                        <div class="alert alert-warning">
                            <i class="bi bi-tag-fill"></i> Giảm ${tour.discount}%
                        </div>
                    </c:if>
                    
                    <div class="mb-3">
                        <i class="bi bi-people"></i> Còn ${tour.availableSeats} chỗ
                    </div>
                    
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <a href="${pageContext.request.contextPath}/booking/create?tourId=${tour.id}" class="btn btn-primary w-100 btn-lg mb-2">
                                <i class="bi bi-cart-plus"></i> Đặt Tour Ngay
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-primary w-100 btn-lg mb-2">
                                Đăng nhập để đặt tour
                            </a>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="mt-3 pt-3 border-top">
                        <h6>Hỗ trợ đặt tour</h6>
                        <p class="mb-1"><i class="bi bi-telephone"></i> 1900-xxxx</p>
                        <p class="mb-0"><i class="bi bi-envelope"></i> booking@tourbook.com</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>