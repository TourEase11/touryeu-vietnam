<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0"><i class="bi bi-credit-card"></i> Thanh Toán</h4>
                </div>
                <div class="card-body p-4">
                    <div class="mb-4">
                        <h5>Thông tin đơn đặt</h5>
                        <table class="table">
                            <tr>
                                <td><strong>Tour:</strong></td>
                                <td>${booking.tourName}</td>
                            </tr>
                            <tr>
                                <td><strong>Ngày khởi hành:</strong></td>
                                <td><fmt:formatDate value="${booking.departureDate}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                            <tr>
                                <td><strong>Số người:</strong></td>
                                <td>${booking.numPeople} người</td>
                            </tr>
                            <tr>
                                <td><strong>Người liên hệ:</strong></td>
                                <td>${booking.contactName}</td>
                            </tr>
                            <tr>
                                <td><strong>Số điện thoại:</strong></td>
                                <td>${booking.contactPhone}</td>
                            </tr>
                            <tr>
                                <td><strong>Email:</strong></td>
                                <td>${booking.contactEmail}</td>
                            </tr>
                            <tr class="table-primary">
                                <td><strong>Tổng tiền:</strong></td>
                                <td><strong class="text-primary fs-5"><fmt:formatNumber value="${booking.totalPrice}" type="number"/> VNĐ</strong></td>
                            </tr>
                        </table>
                    </div>
                    
                    <form method="post" action="${pageContext.request.contextPath}/booking/payment">
                        <input type="hidden" name="bookingId" value="${booking.id}">
                        
                        <h5 class="mb-3">Chọn phương thức thanh toán</h5>
                        
                        <div class="list-group mb-4">
                            <label class="list-group-item">
                                <input class="form-check-input me-3" type="radio" name="paymentMethod" value="CASH" checked>
                                <i class="bi bi-cash-coin text-success fs-4 me-2"></i>
                                <strong>Thanh toán bằng tiền mặt</strong>
                                <p class="mb-0 text-muted small ms-5">Thanh toán trực tiếp khi nhận vé</p>
                            </label>
                            
                            <label class="list-group-item">
                                <input class="form-check-input me-3" type="radio" name="paymentMethod" value="BANK_TRANSFER">
                                <i class="bi bi-bank text-primary fs-4 me-2"></i>
                                <strong>Chuyển khoản ngân hàng</strong>
                                <p class="mb-0 text-muted small ms-5">Chuyển khoản qua tài khoản ngân hàng</p>
                            </label>
                            
                            <label class="list-group-item">
                                <input class="form-check-input me-3" type="radio" name="paymentMethod" value="VNPAY">
                                <i class="bi bi-wallet2 text-danger fs-4 me-2"></i>
                                <strong>VNPay</strong>
                                <p class="mb-0 text-muted small ms-5">Thanh toán qua ví điện tử VNPay</p>
                            </label>
                            
                            <label class="list-group-item">
                                <input class="form-check-input me-3" type="radio" name="paymentMethod" value="MOMO">
                                <i class="bi bi-phone text-danger fs-4 me-2"></i>
                                <strong>MoMo</strong>
                                <p class="mb-0 text-muted small ms-5">Thanh toán qua ví điện tử MoMo</p>
                            </label>
                        </div>
                        
                        <div class="alert alert-info">
                            <i class="bi bi-info-circle"></i> Đây là chức năng thanh toán giả lập. Trong thực tế sẽ tích hợp với cổng thanh toán thật.
                        </div>
                        
                        <button type="submit" class="btn btn-success btn-lg w-100">
                            <i class="bi bi-check-circle"></i> Xác Nhận Thanh Toán
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>