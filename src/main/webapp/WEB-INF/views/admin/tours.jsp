<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container-fluid my-4">
    <div class="row">
        <div class="col-md-2">
            <div class="list-group">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item list-group-item-action">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/tours" class="list-group-item list-group-item-action active">
                    <i class="bi bi-compass"></i> Quản lý Tours
                </a>
                <a href="${pageContext.request.contextPath}/admin/bookings" class="list-group-item list-group-item-action">
                    <i class="bi bi-calendar-check"></i> Quản lý Đặt Tour
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="list-group-item list-group-item-action">
                    <i class="bi bi-people"></i> Quản lý Users
                </a>
                <a href="${pageContext.request.contextPath}/" class="list-group-item list-group-item-action">
                    <i class="bi bi-house"></i> Về Trang Chủ
                </a>
            </div>
        </div>
        
        <div class="col-md-10">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="bi bi-compass"></i> Quản Lý Tours</h2>
                <a href="${pageContext.request.contextPath}/admin/tours/create" class="btn btn-primary">
                    <i class="bi bi-plus-circle"></i> Thêm Tour Mới
                </a>
            </div>
            
            <div class="card shadow">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Tên Tour</th>
                                    <th>Địa điểm</th>
                                    <th>Giá</th>
                                    <th>Giảm giá</th>
                                    <th>Chỗ</th>
                                    <th>Nổi bật</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${tours}" var="tour">
                                    <tr>
                                        <td>${tour.id}</td>
                                        <td>${tour.name}</td>
                                        <td>${tour.location}</td>
                                        <td><fmt:formatNumber value="${tour.price}" type="number"/> VNĐ</td>
                                        <td>${tour.discount}%</td>
                                        <td>${tour.availableSeats}</td>
                                        <td>
                                            <c:if test="${tour.featured}">
                                                <i class="bi bi-star-fill text-warning"></i>
                                            </c:if>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/tours/edit/${tour.id}" class="btn btn-sm btn-warning">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/tours/delete/${tour.id}" 
                                               class="btn btn-sm btn-danger"
                                               onclick="return confirm('Bạn có chắc muốn xóa tour này?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
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