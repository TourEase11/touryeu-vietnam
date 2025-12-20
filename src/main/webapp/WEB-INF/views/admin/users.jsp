<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container-fluid my-4">
    <div class="row">
        <div class="col-md-2">
            <div class="list-group">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item list-group-item-action">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/tours" class="list-group-item list-group-item-action">
                    <i class="bi bi-compass"></i> Quản lý Tours
                </a>
                <a href="${pageContext.request.contextPath}/admin/bookings" class="list-group-item list-group-item-action">
                    <i class="bi bi-calendar-check"></i> Quản lý Đặt Tour
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="list-group-item list-group-item-action active">
                    <i class="bi bi-people"></i> Quản lý Users
                </a>
                <a href="${pageContext.request.contextPath}/" class="list-group-item list-group-item-action">
                    <i class="bi bi-house"></i> Về Trang Chủ
                </a>
            </div>
        </div>
        
        <div class="col-md-10">
            <h2 class="mb-4"><i class="bi bi-people"></i> Quản Lý Người Dùng</h2>
            
            <div class="card shadow">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Username</th>
                                    <th>Họ tên</th>
                                    <th>Email</th>
                                    <th>Số điện thoại</th>
                                    <th>Địa chỉ</th>
                                    <th>Vai trò</th>
                                    <th>Ngày tạo</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${users}" var="user">
                                    <tr>
                                        <td>${user.id}</td>
                                        <td><strong>@${user.username}</strong></td>
                                        <td>${user.fullname}</td>
                                        <td>${user.email}</td>
                                        <td>${user.phone}</td>
                                        <td>${user.address}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.admin}">
                                                    <span class="badge bg-danger">ADMIN</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-primary">USER</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy"/></td>
                                        <td>
                                            <c:if test="${!user.admin}">
                                                <a href="${pageContext.request.contextPath}/admin/users/delete/${user.id}" 
                                                   class="btn btn-sm btn-danger"
                                                   onclick="return confirm('Bạn có chắc muốn xóa người dùng này?')">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </c:if>
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