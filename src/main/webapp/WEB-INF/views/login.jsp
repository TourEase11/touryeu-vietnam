<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow">
                <div class="card-body p-5">
                    <h3 class="text-center mb-4"><i class="bi bi-box-arrow-in-right"></i> Đăng Nhập</h3>
                    
                    <c:if test="${error != null}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <c:if test="${success != null}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>
                    
                    <form method="post" action="${pageContext.request.contextPath}/auth/login">
                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mb-3">Đăng Nhập</button>
                    </form>
                    
                    <div class="text-center">
                        <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/auth/register">Đăng ký ngay</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>