<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container my-5">
    <div class="row">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0"><i class="bi bi-clipboard-check"></i> Thông Tin Đặt Tour</h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${error != null}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    
                    <form method="post" action="${pageContext.request.contextPath}/booking/create">
                        <input type="hidden" name="tourId" value="${tour.id}">
                        
                        <div class="mb-4">
                            <h5 class="mb-3">Thông tin liên hệ</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Họ tên *</label>
                                    <input type="text" class="form-control" name="contactName" value="${sessionScope.user.fullname}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Số điện thoại *</label>
                                    <input type="tel" class="form-control" name="contactPhone" value="${sessionScope.user.phone}" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email *</label>
                                <input type="email" class="form-control" name="contactEmail" value="${sessionScope.user.email}" required>
                            </div>
                        </div>
                        
                        <div class="mb-4">
                            <h5 class="mb-3">Chi tiết chuyến đi</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Ngày khởi hành *</label>
                                    <input type="date" class="form-control" name="departureDate" value="${tour.departureDate}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Số người *</label>
                                    <input type="number" class="form-control" name="numPeople" min="1" max="${tour.availableSeats}" value="1" id="numPeople" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Ghi chú</label>
                                <textarea class="form-control" name="notes" rows="3" placeholder="Yêu cầu đặc biệt..."></textarea>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary btn-lg w-100">
                            <i class="bi bi-check-circle"></i> Tiếp Tục Thanh Toán
                        </button>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card shadow">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Thông tin tour</h5>
                </div>
                <div class="card-body">
                    <img src="${tour.image}" class="img-fluid rounded mb-3" alt="${tour.name}">
                    <h6>${tour.name}</h6>
                    <p class="text-muted mb-2"><i class="bi bi-geo-alt"></i> ${tour.location}</p>
                    <p class="text-muted mb-2"><i class="bi bi-clock"></i> ${tour.duration} ngày</p>
                    <hr>
                    <div class="d-flex justify-content-between">
                        <span>Giá tour:</span>
                        <strong><fmt:formatNumber value="${tour.finalPrice}" type="number"/> VNĐ</strong>
                    </div>
                    <small class="text-muted">Giá cuối cùng sẽ tính theo số người</small>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>