<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-body p-5">
                    <h3 class="text-center mb-4"><i class="bi bi-person-plus"></i> Đăng Ký</h3>
                    
                    <c:if test="${error != null}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    
                    <form method="post" action="${pageContext.request.contextPath}/auth/register">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tên đăng nhập *</label>
                                <input type="text" class="form-control" name="username" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Họ tên *</label>
                                <input type="text" class="form-control" name="fullname" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email *</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số điện thoại *</label>
                            <input type="tel" class="form-control" name="phone" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control" name="address">
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Mật khẩu *</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Xác nhận mật khẩu *</label>
                                <input type="password" class="form-control" name="confirmPassword" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mb-3">Đăng Ký</button>
                    </form>
                    
                    <div class="text-center">
                        <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/auth/login">Đăng nhập</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>