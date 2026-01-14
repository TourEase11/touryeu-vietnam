<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/WEB-INF/views/header.jsp" %>

<style>
:root {
    --glass-bg: rgba(255, 255, 255, 0.95);
    --primary-gradient: linear-gradient(135deg, #0d6efd 0%, #0043a8 100%);
}

body {
    background-color: #f4f7f6;
    font-family: 'Inter', sans-serif;
}

/* Sidebar Modern - Copy 100% từ Dashboard */
.list-group-item {
    border: none;
    padding: 0.8rem 1.2rem;
    border-radius: 8px !important;
    margin-bottom: 4px;
    font-weight: 500;
    transition: all 0.2s;
}

.list-group-item.active {
    background: var(--primary-gradient);
    box-shadow: 0 4px 12px rgba(13, 110, 253, 0.25);
}

/* Stats Cards - Copy 100% từ Dashboard */
.stat-card {
    border: none;
    border-radius: 16px;
    transition: transform 0.3s;
    overflow: hidden;
    position: relative;
}

.stat-card:hover { transform: translateY(-5px); }
.stat-card h3 { font-weight: 800; margin-bottom: 0; }
.stat-card h6 {
    text-transform: uppercase;
    letter-spacing: 1px;
    font-size: 0.75rem;
    font-weight: 700;
}

/* Main Content Card */
.card.main-content {
    border: none;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
}

/* Table Modern */
.table thead th {
    background-color: #f8f9fa;
    text-transform: uppercase;
    font-size: 0.7rem;
    letter-spacing: 1px;
    padding: 1.2rem;
    border: none;
    color: #6c757d;
}

.table tbody td {
    padding: 1.2rem;
    vertical-align: middle;
    border-bottom: 1px solid #f1f1f1;
}

/* Tour Image - Tối ưu cho link Unsplash */
.tour-img {
    width: 100px;
    height: 70px;
    object-fit: cover;
    border-radius: 12px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
}

/* Status Badges */
.badge-status {
    padding: 0.5rem 1rem;
    border-radius: 8px;
    font-weight: 600;
    font-size: 0.75rem;
    background-color: #e8f5e9;
    color: #2e7d32;
}

.search-box {
    border-radius: 12px;
    border: 1px solid #e0e0e0;
    padding: 0.6rem 1rem 0.6rem 2.8rem;
}
</style>

<div class="container-fluid my-4">
    <div class="row">
        <div class="col-md-2">
            <div class="list-group shadow-sm bg-white p-2" style="border-radius: 16px;">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item list-group-item-action"> 
                    <i class="bi bi-speedometer2 me-2"></i> Dashboard
                </a> 
                <a href="${pageContext.request.contextPath}/admin/tours" class="list-group-item list-group-item-action active"> 
                    <i class="bi bi-compass me-2"></i> Quản lý Tours
                </a> 
                <a href="${pageContext.request.contextPath}/admin/bookings" class="list-group-item list-group-item-action"> 
                    <i class="bi bi-calendar-check me-2"></i> Quản lý Đặt Tour
                </a> 
                <a href="${pageContext.request.contextPath}/admin/users" class="list-group-item list-group-item-action"> 
                    <i class="bi bi-people me-2"></i> Quản lý Users
                </a>
                <hr>
                <a href="${pageContext.request.contextPath}/" class="list-group-item list-group-item-action text-danger"> 
                    <i class="bi bi-house-door me-2"></i> Về Trang Chủ
                </a>
            </div>
        </div>

        <div class="col-md-10">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold"><i class="bi bi-compass text-primary me-2"></i> Hệ Thống Quản Lý Tour</h2>
                <a href="${pageContext.request.contextPath}/admin/tours/create" class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm">
                    <i class="bi bi-plus-lg me-2"></i> Thêm Tour Mới
                </a>
            </div>

            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card stat-card shadow-sm border-0 border-bottom border-primary border-4 h-100">
                        <div class="card-body">
                            <h6 class="text-muted">Tổng số Tours</h6>
                            <h3 class="text-primary">${tours.size()}</h3>
                            <i class="bi bi-compass position-absolute end-0 bottom-0 m-3 opacity-25 fs-1"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card stat-card shadow-sm border-0 border-bottom border-success border-4 h-100">
                        <div class="card-body">
                            <h6 class="text-muted">Đang Kinh Doanh</h6>
                            <h3 class="text-success">${tours.size()}</h3>
                            <i class="bi bi-check2-circle position-absolute end-0 bottom-0 m-3 opacity-25 fs-1"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card stat-card shadow-sm border-0 border-bottom border-warning border-4 h-100">
                        <div class="card-body">
                            <h6 class="text-muted">Tour Nổi Bật</h6>
                            <h3 class="text-warning">3</h3>
                            <i class="bi bi-star position-absolute end-0 bottom-0 m-3 opacity-25 fs-1"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card main-content shadow-sm">
                <div class="card-header bg-white border-0 pt-4 px-4">
                    <div class="row align-items-center">
                        <div class="col-md-6 position-relative">
                            <i class="bi bi-search position-absolute text-muted" style="left: 28px; top: 12px;"></i>
                            <input type="text" id="tourSearch" class="form-control search-box shadow-none" placeholder="Tìm kiếm tên tour hoặc địa điểm...">
                        </div>
                    </div>
                </div>
                <div class="card-body p-4">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th width="8%">Mã số</th>
                                    <th width="42%">Thông tin Tour</th>
                                    <th width="15%">Giá niêm yết</th>
                                    <th width="15%">Trạng thái</th>
                                    <th width="10%" class="text-center">Nổi bật</th>
                                    <th width="10%" class="text-end">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${tours}" var="tour">
                                    <tr>
                                        <td class="fw-bold text-muted">#${tour.id}</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <c:set var="finalImgUrl" value="${tour.image.startsWith('http') ? tour.image : pageContext.request.contextPath.concat('/').concat(tour.image)}" />
                                                <img src="${finalImgUrl}" class="tour-img me-3" onerror="this.src='https://placehold.co/100x70?text=Tour'">
                                                <div>
                                                    <div class="fw-bold text-dark mb-1">${tour.name}</div>
                                                    <small class="text-muted"><i class="bi bi-geo-alt me-1"></i>${tour.location}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-danger">
                                                <fmt:formatNumber value="${tour.price}" type="number"/> đ
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge-status">
                                                <i class="bi bi-people-fill me-2"></i> ${tour.availableSeats} chỗ
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <c:if test="${tour.featured}"><i class="bi bi-star-fill text-warning fs-5"></i></c:if>
                                        </td>
                                        <td class="text-end">
                                            <div class="d-flex justify-content-end gap-2">
                                                <a href="${pageContext.request.contextPath}/admin/tours/edit/${tour.id}" class="text-primary fs-5"><i class="bi bi-pencil-square"></i></a>
                                                <a href="${pageContext.request.contextPath}/admin/tours/delete/${tour.id}" class="text-danger fs-5" onclick="return confirm('Xác nhận xóa?')"><i class="bi bi-trash"></i></a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>