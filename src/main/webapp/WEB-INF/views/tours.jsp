<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container my-5">
    <h2 class="mb-4"><i class="bi bi-compass"></i> Tất Cả Tours</h2>
    
    <div class="card mb-4">
        <div class="card-body">
            <form method="get" action="${pageContext.request.contextPath}/tours">
                <div class="row g-3">
                    <div class="col-md-4">
                        <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm..." value="${keyword}">
                    </div>
                    <div class="col-md-3">
                        <select name="categoryId" class="form-select">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.id}" ${selectedCategoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <input type="number" class="form-control" name="minPrice" placeholder="Giá từ" value="${minPrice}">
                    </div>
                    <div class="col-md-2">
                        <input type="number" class="form-control" name="maxPrice" placeholder="Giá đến" value="${maxPrice}">
                    </div>
                    <div class="col-md-1">
                        <button type="submit" class="btn btn-primary w-100"><i class="bi bi-search"></i></button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <div class="row g-4">
        <c:forEach items="${tours}" var="tour">
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
                        <p class="card-text"><i class="bi bi-clock"></i> ${tour.duration} ngày</p>
                        
                        <div class="d-flex align-items-center mb-3">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="bi bi-star${i <= tour.avgRating ? '-fill' : ''} text-warning"></i>
                            </c:forEach>
                            <span class="ms-2 text-muted">(${tour.reviewCount})</span>
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <c:if test="${tour.discount > 0}">
                                    <div class="price-old"><fmt:formatNumber value="${tour.price}" type="number"/> VNĐ</div>
                                </c:if>
                                <div class="price-tag"><fmt:formatNumber value="${tour.finalPrice}" type="number"/> VNĐ</div>
                            </div>
                            <a href="${pageContext.request.contextPath}/tours/detail/${tour.id}" class="btn btn-primary">Chi Tiết</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    
    <c:if test="${empty tours}">
        <div class="text-center my-5">
            <i class="bi bi-search" style="font-size: 4rem; color: #ccc;"></i>
            <p class="text-muted mt-3">Không tìm thấy tour phù hợp</p>
        </div>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>