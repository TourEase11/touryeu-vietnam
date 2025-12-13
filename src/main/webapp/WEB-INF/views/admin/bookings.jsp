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
                <a href="${pageContext.request.contextPath}/admin/bookings" class="list-group-item list-group-item-action active">
                    <i class="bi bi-calendar-check"></i> Quản lý Đặt Tour
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="list-group-item list-group-item-action">
                    <i;\ class="bi bi-people"></i> Quản lý Users
                </a>
                <a href="${pageContext.request.contextPath}/" class="list-group-item list-group-item-action">
                    <i class="bi bi-house"></i> Về Trang Chủ
                </a>
            </div>
        </div>
        
        <div class="col-md-10">
            <h2 class="mb-4"><i class="bi bi-calendar-check"></i> Quản Lý Đặt Tour</h2>

            <!-- Thống kê -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card border-warning shadow-sm">
                        <div class="card-body text-center">
                            <h6 class="text-muted">Đang xử lý</h6>
                            <h3 class="text-warning">
                                <c:set var="pendingCount" value="0"/>
                                <c:forEach items="${bookings}" var="b">
                                    <c:if test="${b.status == 'PENDING'}">
                                        <c:set var="pendingCount" value="${pendingCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${pendingCount}
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-success shadow-sm">
                        <div class="card-body text-center">
                            <h6 class="text-muted">Đã xác nhận</h6>
                            <h3 class="text-success">
                                <c:set var="confirmedCount" value="0"/>
                                <c:forEach items="${bookings}" var="b">
                                    <c:if test="${b.status == 'CONFIRMED'}">
                                        <c:set var="confirmedCount" value="${confirmedCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${confirmedCount}
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-primary shadow-sm">
                        <div class="card-body text-center">
                            <h6 class="text-muted">Hoàn thành</h6>
                            <h3 class="text-primary">
                                <c:set var="completedCount" value="0"/>
                                <c:forEach items="${bookings}" var="b">
                                    <c:if test="${b.status == 'COMPLETED'}">
                                        <c:set var="completedCount" value="${completedCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${completedCount}
                            </h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-danger shadow-sm">
                        <div class="card-body text-center">
                            <h6 class="text-muted">Đã hủy</h6>
                            <h3 class="text-danger">
                                <c:set var="cancelledCount" value="0"/>
                                <c:forEach items="${bookings}" var="b">
                                    <c:if test="${b.status == 'CANCELLED'}">
                                        <c:set var="cancelledCount" value="${cancelledCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${cancelledCount}
                            </h3>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card shadow">
                <div class="card-body">
                    <!-- Tìm kiếm và Lọc -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <input type="text" id="searchInput" class="form-control" placeholder="Tìm kiếm theo tên, tour, email, số điện thoại...">
                        </div>
                        <div class="col-md-6">
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-outline-secondary active" onclick="filterStatus('ALL')">Tất cả</button>
                                <button type="button" class="btn btn-outline-warning" onclick="filterStatus('PENDING')">Đang xử lý</button>
                                <button type="button" class="btn btn-outline-success" onclick="filterStatus('CONFIRMED')">Đã xác nhận</button>
                                <button type="button" class="btn btn-outline-primary" onclick="filterStatus('COMPLETED')">Hoàn thành</button>
                                <button type="button" class="btn btn-outline-danger" onclick="filterStatus('CANCELLED')">Đã hủy</button>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover" id="bookingsTable">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Khách hàng</th>
                                    <th>Tour</th>
                                    <th>Ngày đặt</th>
                                    <th>Ngày khởi hành</th>
                                    <th>Số người</th>
                                    <th>Tổng tiền</th>
                                    <th>Liên hệ</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${bookings}" var="booking">
                                    <tr data-status="${booking.status}">
                                        <td>#${booking.id}</td>
                                        <td>
                                            <strong>${booking.userFullname}</strong><br>
                                            <small class="text-muted">@${booking.username}</small>
                                        </td>
                                        <td>${booking.tourName}</td>
                                        <td><fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td><fmt:formatDate value="${booking.departureDate}" pattern="dd/MM/yyyy"/></td>
                                        <td>${booking.numPeople}</td>
                                        <td><fmt:formatNumber value="${booking.totalPrice}" type="number"/> VNĐ</td>
                                        <td>
                                            <small>
                                                ${booking.contactName}<br>
                                                ${booking.contactPhone}
                                            </small>
                                        </td>
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
                                        <td>
                                            <button type="button" class="btn btn-sm btn-info me-1" data-bs-toggle="modal" data-bs-target="#detailModal${booking.id}">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                            <div class="btn-group">
                                                <button type="button" class="btn btn-sm btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown">
                                                    Cập nhật
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/bookings/update-status?id=${booking.id}&status=CONFIRMED">
                                                        <i class="bi bi-check-circle"></i> Xác nhận
                                                    </a></li>
                                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/bookings/update-status?id=${booking.id}&status=COMPLETED">
                                                        <i class="bi bi-check-all"></i> Hoàn thành
                                                    </a></li>
                                                    <li><hr class="dropdown-divider"></li>
                                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/admin/bookings/update-status?id=${booking.id}&status=CANCELLED">
                                                        <i class="bi bi-x-circle"></i> Hủy
                                                    </a></li>
                                                </ul>
                                            </div>
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

<!-- Modal Chi tiết Booking -->
<c:forEach items="${bookings}" var="booking">
    <div class="modal fade" id="detailModal${booking.id}" tabindex="-1" aria-labelledby="detailModalLabel${booking.id}" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="detailModalLabel${booking.id}">
                        <i class="bi bi-file-text"></i> Chi Tiết Booking #${booking.id}
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <h6 class="text-primary"><i class="bi bi-person-circle"></i> Thông Tin Khách Hàng</h6>
                            <table class="table table-sm">
                                <tr>
                                    <th width="40%">Họ tên:</th>
                                    <td>${booking.userFullname}</td>
                                </tr>
                                <tr>
                                    <th>Username:</th>
                                    <td>@${booking.username}</td>
                                </tr>
                                <tr>
                                    <th>Tên liên hệ:</th>
                                    <td>${booking.contactName}</td>
                                </tr>
                                <tr>
                                    <th>Điện thoại:</th>
                                    <td><a href="tel:${booking.contactPhone}">${booking.contactPhone}</a></td>
                                </tr>
                                <tr>
                                    <th>Email:</th>
                                    <td><a href="mailto:${booking.contactEmail}">${booking.contactEmail}</a></td>
                                </tr>
                            </table>
                        </div>

                        <div class="col-md-6 mb-3">
                            <h6 class="text-primary"><i class="bi bi-compass"></i> Thông Tin Tour</h6>
                            <table class="table table-sm">
                                <tr>
                                    <th width="40%">Tên tour:</th>
                                    <td>${booking.tourName}</td>
                                </tr>
                                <tr>
                                    <th>Ngày đặt:</th>
                                    <td><fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                                </tr>
                                <tr>
                                    <th>Ngày khởi hành:</th>
                                    <td><fmt:formatDate value="${booking.departureDate}" pattern="dd/MM/yyyy"/></td>
                                </tr>
                                <tr>
                                    <th>Số người:</th>
                                    <td><strong>${booking.numPeople}</strong> người</td>
                                </tr>
                                <tr>
                                    <th>Tổng tiền:</th>
                                    <td><strong class="text-danger"><fmt:formatNumber value="${booking.totalPrice}" type="number"/> VNĐ</strong></td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12 mb-3">
                            <h6 class="text-primary"><i class="bi bi-info-circle"></i> Trạng Thái</h6>
                            <c:choose>
                                <c:when test="${booking.status == 'PENDING'}">
                                    <span class="badge bg-warning fs-6">Đang xử lý</span>
                                </c:when>
                                <c:when test="${booking.status == 'CONFIRMED'}">
                                    <span class="badge bg-success fs-6">Đã xác nhận</span>
                                </c:when>
                                <c:when test="${booking.status == 'COMPLETED'}">
                                    <span class="badge bg-primary fs-6">Hoàn thành</span>
                                </c:when>
                                <c:when test="${booking.status == 'CANCELLED'}">
                                    <span class="badge bg-danger fs-6">Đã hủy</span>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>

                    <c:if test="${not empty booking.notes}">
                        <div class="row">
                            <div class="col-12">
                                <h6 class="text-primary"><i class="bi bi-chat-left-text"></i> Ghi Chú</h6>
                                <div class="alert alert-info">
                                    ${booking.notes}
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <a href="${pageContext.request.contextPath}/admin/bookings/update-status?id=${booking.id}&status=CONFIRMED" class="btn btn-success">
                        <i class="bi bi-check-circle"></i> Xác nhận
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/bookings/update-status?id=${booking.id}&status=CANCELLED" class="btn btn-danger">
                        <i class="bi bi-x-circle"></i> Hủy
                    </a>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<script>
// Tìm kiếm
document.getElementById('searchInput').addEventListener('keyup', function() {
    const searchTerm = this.value.toLowerCase();
    const table = document.getElementById('bookingsTable');
    const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

    for (let row of rows) {
        const text = row.textContent.toLowerCase();
        if (text.includes(searchTerm)) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    }
});

// Lọc theo trạng thái
function filterStatus(status) {
    const table = document.getElementById('bookingsTable');
    const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
    const buttons = document.querySelectorAll('.btn-group button');

    // Cập nhật active button
    buttons.forEach(btn => btn.classList.remove('active'));
    event.target.classList.add('active');

    // Reset search khi lọc
    document.getElementById('searchInput').value = '';

    for (let row of rows) {
        if (status === 'ALL') {
            row.style.display = '';
        } else {
            const rowStatus = row.getAttribute('data-status');
            row.style.display = (rowStatus === status) ? '' : 'none';
        }
    }
}

// Xác nhận trước khi thay đổi trạng thái
document.querySelectorAll('.dropdown-item').forEach(item => {
    item.addEventListener('click', function(e) {
        if (this.classList.contains('text-danger')) {
            if (!confirm('Bạn có chắc muốn hủy booking này?')) {
                e.preventDefault();
            }
        }
    });
});
</script>

<%@ include file="/WEB-INF/views/footer.jsp" %>