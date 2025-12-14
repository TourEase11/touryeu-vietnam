<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container-fluid my-4">
    <div class="row">
        <div class="col-md-2">
            <div class="list-group">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item list-group-item-action active">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/tours" class="list-group-item list-group-item-action">
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
            <h2 class="mb-4"><i class="bi bi-speedometer2"></i> Dashboard</h2>
            
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card text-white bg-primary">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-uppercase">Tổng Tours</h6>
                                    <h2 class="mb-0">${totalTours}</h2>
                                </div>
                                <i class="bi bi-compass" style="font-size: 3rem; opacity: 0.5;"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-uppercase">Đơn Đặt</h6>
                                    <h2 class="mb-0">${totalBookings}</h2>
                                </div>
                                <i class="bi bi-calendar-check" style="font-size: 3rem; opacity: 0.5;"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card text-white bg-warning">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-uppercase">Người Dùng</h6>
                                    <h2 class="mb-0">${totalUsers}</h2>
                                </div>
                                <i class="bi bi-people" style="font-size: 3rem; opacity: 0.5;"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-clock-history"></i> Đơn Đặt Gần Đây</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Khách hàng</th>
                                    <th>Tour</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${recentBookings}" var="booking">
                                    <tr>
                                        <td>#${booking.id}</td>
                                        <td>${booking.userFullname}</td>
                                        <td>${booking.tourName}</td>
                                        <td><fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy"/></td>
                                        <td><fmt:formatNumber value="${booking.totalPrice}" type="number"/> VNĐ</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${booking.status == 'PENDING'}">
                                                    <span class="badge bg-warning">Đang xử lý</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'CONFIRMED'}">
                                                    <span class="badge bg-success">Đã xác nhận</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'COMPLETED'}">
                                                    <span class="badge bg-primary">Hoàn thành</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'CANCELLED'}">
                                                    <span class="badge bg-danger">Đã hủy</span>
                                                </c:when>
                                            </c:choose>
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