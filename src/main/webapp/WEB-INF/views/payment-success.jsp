<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow text-center">
                <div class="card-body p-5">
                    <div class="mb-4">
                        <i class="bi bi-check-circle-fill text-success" style="font-size: 5rem;"></i>
                    </div>
                    <h2 class="text-success mb-3">Thanh Toán Thành Công!</h2>
                    <p class="lead mb-4">Đơn đặt tour của bạn đã được xác nhận</p>
                    
                    <div class="alert alert-info mb-4">
                        <p class="mb-2"><strong>Mã đơn hàng:</strong> #${bookingId}</p>
                        <p class="mb-0">Chúng tôi đã gửi thông tin xác nhận đến email của bạn</p>
                    </div>
                    
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/booking/my-bookings" class="btn btn-primary btn-lg">
                            <i class="bi bi-calendar-check"></i> Xem Đơn Đặt
                        </a>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary">
                            <i class="bi bi-house"></i> Về Trang Chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>