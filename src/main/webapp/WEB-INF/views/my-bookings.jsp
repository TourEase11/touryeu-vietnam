<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container my-5">
    <h2 class="mb-4"><i class="bi bi-calendar-check"></i> Đơn Đặt Tour Của Tôi</h2>
    
    <c:choose>
        <c:when test="${not empty bookings}">
            <div class="row g-4">
                <c:forEach items="${bookings}" var="booking">
                    <div class="col-12">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-8">
                                        <h5 class="card-title">${booking.tourName}</h5>
                                        <p class="text-muted mb-2">
                                            <i class="bi bi-calendar3"></i> 
                                            Ngày đặt: <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </p>
                                        <p class="text-muted mb-2">
                                            <i class="bi bi-calendar-event"></i> 
                                            Ngày khởi hành: <fmt:formatDate value="${booking.departureDate}" pattern="dd/MM/yyyy"/>
                                        </p>
                                        <p class="text-muted mb-2">
                                            <i class="bi bi-people"></i> 
                                            Số người: ${booking.numPeople}
                                        </p>
                                        <p class="mb-0">
                                            <i class="bi bi-person"></i> 
                                            Người liên hệ: ${booking.contactName} - ${booking.contactPhone}
                                        </p>
                                    </div>
                                    
                                    <div class="col-md-4 text-end">
                                        <div class="mb-3">
                                            <c:choose>
                                                <c:when test="${booking.status == 'PENDING'}">
                                                    <span class="badge bg-warning text-dark fs-6">Đang xử lý</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'CONFIRMED'}">
                                                    <span class="badge bg-success fs-6">Đã xác nhận</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'COMPLETED'}">
                                                    <span class="badge bg-primary fs-6">Đã hoàn thành</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'CANCELLED'}">
                                                    <span class="badge bg-danger fs-6">Đã hủy</span>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                        
                                        <p class="fs-4 fw-bold text-primary mb-3">
                                            <fmt:formatNumber value="${booking.totalPrice}" type="number"/> VNĐ
                                        </p>
                                        
                                        <c:if test="${booking.status == 'PENDING' || booking.status == 'CONFIRMED'}">
                                            <a href="${pageContext.request.contextPath}/booking/cancel/${booking.id}" 
                                               class="btn btn-outline-danger btn-sm"
                                               onclick="return confirm('Bạn có chắc muốn hủy đơn đặt này?')">
                                                <i class="bi bi-x-circle"></i> Hủy đơn
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center my-5">
                <i class="bi bi-inbox" style="font-size: 5rem; color: #ccc;"></i>
                <p class="text-muted mt-3 mb-4">Bạn chưa có đơn đặt tour nào</p>
                <a href="${pageContext.request.contextPath}/tours" class="btn btn-primary">
                    <i class="bi bi-compass"></i> Khám Phá Tours
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>