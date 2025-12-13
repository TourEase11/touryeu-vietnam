<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container my-5">
    <div class="row">
        <div class="col-md-3">
            <div class="card shadow">
                <div class="card-body text-center">
                    <i class="bi bi-person-circle" style="font-size: 5rem;"></i>
                    <h5 class="mt-3">${sessionScope.user.fullname}</h5>
                    <p class="text-muted">@${sessionScope.user.username}</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-9">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-person-lines-fill"></i> Thông Tin Cá Nhân</h5>
                </div>
                <div class="card-body p-4">
                    <c:if test="${error != null}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <c:if test="${success != null}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>
                    
                    <form method="post" action="${pageContext.request.contextPath}/auth/update-profile">
                        <div class="mb-3">
                            <label class="form-label">Họ tên</label>
                            <input type="text" class="form-control" name="fullname" value="${sessionScope.user.fullname}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" value="${sessionScope.user.email}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" name="phone" value="${sessionScope.user.phone}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control" name="address" value="${sessionScope.user.address}">
                        </div>
                        <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Cập Nhật</button>
                    </form>
                    
                    <hr class="my-4">
                    
                    <h5 class="mb-3"><i class="bi bi-key"></i> Đổi Mật Khẩu</h5>
                    <form method="post" action="${pageContext.request.contextPath}/auth/change-password">
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Mật khẩu cũ</label>
                                <input type="password" class="form-control" name="oldPassword" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Mật khẩu mới</label>
                                <input type="password" class="form-control" name="newPassword" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Xác nhận mật khẩu</label>
                                <input type="password" class="form-control" name="confirmPassword" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning"><i class="bi bi-shield-lock"></i> Đổi Mật Khẩu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>