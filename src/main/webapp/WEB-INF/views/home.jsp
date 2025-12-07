<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="hero-section text-center">
    <div class="container">
        <h1 class="display-3 fw-bold mb-4">Khám Phá Thế Giới Cùng Chúng Tôi</h1>
        <p class="lead mb-5">Trải nghiệm những chuyến du lịch tuyệt vời với giá tốt nhất</p>
        
        <form action="${pageContext.request.contextPath}/tours" method="get" class="row g-3 justify-content-center">
            <div class="col-md-6">
                <input type="text" class="form-control form-control-lg" name="keyword" placeholder="Tìm kiếm điểm đến...">
            </div>
            <div class="col-md-3">
                <select name="categoryId" class="form-select form-select-lg">
                    <option value="">Tất cả danh mục</option>
                    <c:forEach items="${categories}" var="cat">
                        <option value="${cat.id}">${cat.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-warning btn-lg w-100"><i class="bi bi-search"></i> Tìm Kiếm</button>
            </div>
        </form>
    </div>
</div>

<div class="container my-5">
    <h2 class="text-center mb-5"><i class="bi bi-star-fill text-warning"></i> Tour Nổi Bật</h2>
    
    <div class="row g-4">
        <c:forEach items="${featuredTours}" var="tour">
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="position-relative">
                        <img src="${tour.image}" class="card-img-top" alt="${tour.name}">
                        <c:if test="${tour.discount > 0}">
                            <span class="badge badge-discount">-${tour.discount}%</span>
                        </c:if>
                    </div>
                    <div class="card-body">
                        <span class="badge bg-primary mb-2">${tour.categoryName}</span>
                        <h5 class="card-title">${tour.name}</h5>
                        <p class="card-text text-muted"><i class="bi bi-geo-alt"></i> ${tour.location}</p>
                        <p class="card-text"><i class="bi bi-clock"></i> ${tour.duration} ngày ${tour.duration - 1} đêm</p>
                        
                        <div class="d-flex align-items-center mb-3">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="bi bi-star${i <= tour.avgRating ? '-fill' : ''} text-warning"></i>
                            </c:forEach>
                            <span class="ms-2 text-muted">(${tour.reviewCount} đánh giá)</span>
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <c:if test="${tour.discount > 0}">
                                    <div class="price-old"><fmt:formatNumber value="${tour.price}" type="number"/> VNĐ</div>
                                </c:if>
                                <div class="price-tag"><fmt:formatNumber value="${tour.finalPrice}" type="number"/> VNĐ</div>
                            </div>
                            <a href="${pageContext.request.contextPath}/tours/detail/${tour.id}" class="btn btn-primary">Xem Chi Tiết</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    
    <div class="text-center mt-5">
        <a href="${pageContext.request.contextPath}/tours" class="btn btn-outline-primary btn-lg">Xem Tất Cả Tours</a>
    </div>
</div>

<div class="bg-light py-5">
    <div class="container">
        <div class="row text-center">
            <div class="col-md-3">
                <i class="bi bi-shield-check text-primary" style="font-size: 3rem;"></i>
                <h5 class="mt-3">An Toàn</h5>
                <p class="text-muted">Đảm bảo chất lượng tour</p>
            </div>
            <div class="col-md-3">
                <i class="bi bi-tag text-primary" style="font-size: 3rem;"></i>
                <h5 class="mt-3">Giá Tốt</h5>
                <p class="text-muted">Giá cả cạnh tranh nhất</p>
            </div>
            <div class="col-md-3">
                <i class="bi bi-headset text-primary" style="font-size: 3rem;"></i>
                <h5 class="mt-3">Hỗ Trợ 24/7</h5>
                <p class="text-muted">Luôn sẵn sàng hỗ trợ</p>
            </div>
            <div class="col-md-3">
                <i class="bi bi-heart text-primary" style="font-size: 3rem;"></i>
                <h5 class="mt-3">Trải Nghiệm</h5>
                <p class="text-muted">Chuyến đi đáng nhớ</p>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>