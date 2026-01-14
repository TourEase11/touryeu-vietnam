<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/views/header.jsp"%>

<style>
:root {
	--glass-bg: rgba(255, 255, 255, 0.95);
	--primary-gradient: linear-gradient(135deg, #0d6efd 0%, #0043a8 100%);
}

body {	
	background-color: #f4f7f6;
	font-family: 'Inter', sans-serif;
}

/* Sidebar Modern */
.list-group-item {
	border: none;
	padding: 0.8rem 1.2rem;
	border-radius: 8px !important;
	margin-bottom: 4px;
	font-weight: 500;
	transition: all 0.2s;
}

.list-group-item.active {
	background: var(--primary-gradient);
	box-shadow: 0 4px 12px rgba(13, 110, 253, 0.25);
}

/* Stats Cards */
.stat-card {
	border: none;
	border-radius: 16px;
	transition: transform 0.3s;
	overflow: hidden;
	position: relative;
}

.stat-card:hover {
	transform: translateY(-5px);
}

.stat-card h3 {
	font-weight: 800;
	margin-bottom: 0;
}

.stat-card h6 {
	text-transform: uppercase;
	letter-spacing: 1px;
	font-size: 0.75rem;
	font-weight: 700;
}

/* Table Modern */
.card.main-content {
	border: none;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
}

.table thead th {
	background-color: #f8f9fa;
	text-transform: uppercase;
	font-size: 0.7rem;
	letter-spacing: 1px;
	padding: 1.2rem;
	border: none;
	color: #6c757d;
}

.table tbody td {
	padding: 1.2rem;
	vertical-align: middle;
	border-bottom: 1px solid #f1f1f1;
}

/* Subtle Badges */
.badge {
	padding: 0.6em 1em;
	border-radius: 8px;
	font-weight: 600;
	font-size: 0.75rem;
}

.badge.bg-warning {
	background-color: #fff4e5 !important;
	color: #ff9800 !important;
}

.badge.bg-success {
	background-color: #e8f5e9 !important;
	color: #2e7d32 !important;
}

.badge.bg-primary {
	background-color: #e3f2fd !important;
	color: #1565c0 !important;
}

.badge.bg-danger {
	background-color: #ffebee !important;
	color: #c62828 !important;
}

/* Custom Search & Buttons */
.form-control {
	border-radius: 12px;
	padding: 0.7rem 1.2rem;
	border: 1px solid #e0e0e0;
}

.form-control:focus {
	box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.1);
	border-color: #0d6efd;
}

.btn-group .btn {
	border-radius: 10px !important;
	margin: 0 2px;
	border: none;
	font-weight: 600;
	font-size: 0.85rem;
}
</style>

<div class="container-fluid my-4">
	<div class="row">
		<div class="col-md-2">
			<div class="list-group shadow-sm bg-white p-2"
				style="border-radius: 16px;">
				<a href="${pageContext.request.contextPath}/admin/dashboard"
					class="list-group-item list-group-item-action"> <i
					class="bi bi-speedometer2 me-2"></i> Dashboard
				</a> <a href="${pageContext.request.contextPath}/admin/tours"
					class="list-group-item list-group-item-action"> <i
					class="bi bi-compass me-2"></i> Quản lý Tours
				</a> <a href="${pageContext.request.contextPath}/admin/bookings"
					class="list-group-item list-group-item-action active"> <i
					class="bi bi-calendar-check me-2"></i> Quản lý Đặt Tour
				</a> <a href="${pageContext.request.contextPath}/admin/users"
					class="list-group-item list-group-item-action"> <i
					class="bi bi-people me-2"></i> Quản lý Users
				</a>
				<hr>
				<a href="${pageContext.request.contextPath}/"
					class="list-group-item list-group-item-action text-danger"> <i
					class="bi bi-house me-2"></i> Về Trang Chủ
				</a>
			</div>
		</div>

		<div class="col-md-10">
			<div class="d-flex justify-content-between align-items-center mb-4">
				<h2 class="fw-bold">
					<i class="bi bi-calendar-check text-primary me-2"></i> Quản Lý Đặt
					Tour
				</h2>
			</div>

			<div class="row mb-4">
				<div class="col-md-3">
					<div
						class="card stat-card shadow-sm border-0 border-bottom border-warning border-4">
						<div class="card-body">
							<h6 class="text-muted">Đang xử lý</h6>
							<h3 class="text-warning">
								<c:set var="pendingCount" value="0" />
								<c:forEach items="${bookings}" var="b">
									<c:if test="${b.status == 'PENDING'}">
										<c:set var="pendingCount" value="${pendingCount + 1}" />
									</c:if>
								</c:forEach>
								${pendingCount}
							</h3>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div
						class="card stat-card shadow-sm border-0 border-bottom border-success border-4">
						<div class="card-body">
							<h6 class="text-muted">Đã xác nhận</h6>
							<h3 class="text-success">
								<c:set var="confirmedCount" value="0" />
								<c:forEach items="${bookings}" var="b">
									<c:if test="${b.status == 'CONFIRMED'}">
										<c:set var="confirmedCount" value="${confirmedCount + 1}" />
									</c:if>
								</c:forEach>
								${confirmedCount}
							</h3>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div
						class="card stat-card shadow-sm border-0 border-bottom border-primary border-4">
						<div class="card-body">
							<h6 class="text-muted">Hoàn thành</h6>
							<h3 class="text-primary">
								<c:set var="completedCount" value="0" />
								<c:forEach items="${bookings}" var="b">
									<c:if test="${b.status == 'COMPLETED'}">
										<c:set var="completedCount" value="${completedCount + 1}" />
									</c:if>
								</c:forEach>
								${completedCount}
							</h3>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div
						class="card stat-card shadow-sm border-0 border-bottom border-danger border-4">
						<div class="card-body">
							<h6 class="text-muted">Đã hủy</h6>
							<h3 class="text-danger">
								<c:set var="cancelledCount" value="0" />
								<c:forEach items="${bookings}" var="b">
									<c:if test="${b.status == 'CANCELLED'}">
										<c:set var="cancelledCount" value="${cancelledCount + 1}" />
									</c:if>
								</c:forEach>
								${cancelledCount}
							</h3>
						</div>
					</div>
				</div>
			</div>

			<div class="card main-content">
				<div class="card-body p-4">
					<div class="row g-3 mb-4">
						<div class="col-md-5">
							<div class="input-group">
								<span class="input-group-text bg-white border-end-0"><i
									class="bi bi-search text-muted"></i></span> <input type="text"
									id="searchInput" class="form-control border-start-0 ps-0"
									placeholder="Tìm theo tên, tour, số điện thoại...">
							</div>
						</div>
						<div class="col-md-7 text-end">
							<div class="btn-group p-1 bg-light rounded-3" role="group">
								<button type="button" class="btn btn-light active shadow-sm"
									onclick="filterStatus('ALL')">Tất cả</button>
								<button type="button" class="btn btn-light"
									onclick="filterStatus('PENDING')">Đang xử lý</button>
								<button type="button" class="btn btn-light"
									onclick="filterStatus('CONFIRMED')">Đã xác nhận</button>
								<button type="button" class="btn btn-light"
									onclick="filterStatus('COMPLETED')">Hoàn thành</button>
								<button type="button" class="btn btn-light text-danger"
									onclick="filterStatus('CANCELLED')">Đã hủy</button>
							</div>
						</div>
					</div>

					<div class="table-responsive">
						<table class="table table-hover" id="bookingsTable">
							<thead>
								<tr>
									<th>Mã đơn</th>
									<th>Khách hàng</th>
									<th>Thông tin Tour</th>
									<th>Thời gian</th>
									<th>Người</th>
									<th>Tổng thanh toán</th>
									<th>Trạng thái</th>
									<th class="text-center">Hành động</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${bookings}" var="booking">
									<tr data-status="${booking.status}">
										<td class="fw-bold">#${booking.id}</td>
										<td>
											<div class="fw-bold text-dark">${booking.userFullname}</div>
											<div class="small text-muted">
												<i class="bi bi-phone me-1"></i>${booking.contactPhone}</div>
										</td>
										<td>
											<div class="fw-bold"
												style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${booking.tourName}</div>
											<small class="text-primary"><i
												class="bi bi-geo-alt me-1"></i>Khởi hành: <fmt:formatDate
													value="${booking.departureDate}" pattern="dd/MM/yyyy" /></small>
										</td>
										<td>
											<div class="small fw-medium">
												<fmt:formatDate value="${booking.bookingDate}"
													pattern="dd/MM/yyyy" />
											</div>
											<div class="small text-muted">
												<fmt:formatDate value="${booking.bookingDate}"
													pattern="HH:mm" />
											</div>
										</td>
										<td class="text-center fw-bold text-dark">${booking.numPeople}</td>
										<td>
											<div class="fw-bold text-danger">
												<fmt:formatNumber value="${booking.totalPrice}"
													type="number" />
												đ
											</div>
										</td>
										<td><c:choose>
												<c:when test="${booking.status == 'PENDING'}">
													<span
														class="badge bg-warning text-warning border border-warning-subtle">Đang
														xử lý</span>
												</c:when>
												<c:when test="${booking.status == 'CONFIRMED'}">
													<span
														class="badge bg-success text-success border border-success-subtle">Đã
														xác nhận</span>
												</c:when>
												<c:when test="${booking.status == 'COMPLETED'}">
													<span
														class="badge bg-primary text-primary border border-primary-subtle">Hoàn
														thành</span>
												</c:when>
												<c:when test="${booking.status == 'CANCELLED'}">
													<span
														class="badge bg-danger text-danger border border-danger-subtle">Đã
														hủy</span>
												</c:when>
											</c:choose></td>
										<td class="text-center">
											<button type="button"
												class="btn btn-sm btn-outline-info rounded-pill"
												data-bs-toggle="modal"
												data-bs-target="#detailModal${booking.id}">
												<i class="bi bi-eye-fill"></i>
											</button>
											<div class="btn-group">
												<button type="button"
													class="btn btn-sm btn-dark rounded-pill dropdown-toggle ms-1"
													data-bs-toggle="dropdown">Sửa</button>
												<ul
													class="dropdown-menu dropdown-menu-end shadow border-0 p-2">
													<li><a class="dropdown-item rounded-2"
														href="${pageContext.request.contextPath}/admin/bookings/update-status?id=${booking.id}&status=CONFIRMED">
															<i class="bi bi-check2-circle text-success me-2"></i> Xác
															nhận đơn
													</a></li>
													<li><a class="dropdown-item rounded-2"
														href="${pageContext.request.contextPath}/admin/bookings/update-status?id=${booking.id}&status=COMPLETED">
															<i class="bi bi-patch-check text-primary me-2"></i> Hoàn
															thành đơn
													</a></li>
													<li><hr class="dropdown-divider"></li>
													<li><a class="dropdown-item rounded-2 text-danger"
														href="${pageContext.request.contextPath}/admin/bookings/update-status?id=${booking.id}&status=CANCELLED">
															<i class="bi bi-x-circle me-2"></i> Hủy đơn này
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

<c:forEach items="${bookings}" var="booking">
	<div class="modal fade" id="detailModal${booking.id}" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content border-0 shadow"
				style="border-radius: 24px; overflow: hidden;">
				<div class="modal-header bg-primary text-white p-4">
					<h5 class="modal-title fw-bold" id="detailModalLabel${booking.id}">
						<i class="bi bi-file-earmark-richtext me-2"></i> Chi Tiết Đơn Hàng
						#${booking.id}
					</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body p-4 bg-light">
					<div class="row g-4">
						<div class="col-md-6">
							<div class="card border-0 shadow-sm p-3 h-100"
								style="border-radius: 16px;">
								<h6 class="text-primary fw-bold mb-3 border-bottom pb-2">
									<i class="bi bi-person-circle me-2"></i>Khách hàng
								</h6>
								<table class="table table-borderless table-sm mb-0">
									<tr>
										<td class="text-muted fw-medium py-1" width="35%">Họ tên:</td>
										<td class="fw-bold">${booking.userFullname}</td>
									</tr>
									<tr>
										<td class="text-muted fw-medium py-1">Username:</td>
										<td><span class="badge bg-light text-dark fw-normal">@${booking.username}</span></td>
									</tr>
									<tr>
										<td class="text-muted fw-medium py-1">Liên hệ:</td>
										<td>${booking.contactName}</td>
									</tr>
									<tr>
										<td class="text-muted fw-medium py-1">Điện thoại:</td>
										<td><a href="tel:${booking.contactPhone}"
											class="text-decoration-none fw-bold">${booking.contactPhone}</a></td>
									</tr>
									<tr>
										<td class="text-muted fw-medium py-1">Email:</td>
										<td><a href="mailto:${booking.contactEmail}"
											class="text-decoration-none">${booking.contactEmail}</a></td>
									</tr>
								</table>
							</div>
						</div>

						<div class="col-md-6">
							<div class="card border-0 shadow-sm p-3 h-100"
								style="border-radius: 16px;">
								<h6 class="text-primary fw-bold mb-3 border-bottom pb-2">
									<i class="bi bi-compass me-2"></i>Dịch vụ đặt
								</h6>
								<table class="table table-borderless table-sm mb-0">
									<tr>
										<td class="text-muted fw-medium py-1" width="35%">Tên
											tour:</td>
										<td class="fw-bold">${booking.tourName}</td>
									</tr>
									<tr>
										<td class="text-muted fw-medium py-1">Ngày đặt:</td>
										<td><fmt:formatDate value="${booking.bookingDate}"
												pattern="dd/MM/yyyy HH:mm" /></td>
									</tr>
									<tr>
										<td class="text-muted fw-medium py-1">Khởi hành:</td>
										<td><span class="text-primary fw-bold"><fmt:formatDate
													value="${booking.departureDate}" pattern="dd/MM/yyyy" /></span></td>
									</tr>
									<tr>
										<td class="text-muted fw-medium py-1">Số khách:</td>
										<td><strong>${booking.numPeople}</strong> người lớn</td>
									</tr>
									<tr>
										<td class="text-muted fw-medium py-1">Thanh toán:</td>
										<td><h5 class="text-danger fw-extrabold mb-0">
												<fmt:formatNumber value="${booking.totalPrice}"
													type="number" />
												VNĐ
											</h5></td>
									</tr>
								</table>
							</div>
						</div>

						<div class="col-12">
							<div class="d-flex align-items-center bg-white p-3 shadow-sm"
								style="border-radius: 12px;">
								<span class="me-3 fw-bold">TRẠNG THÁI HIỆN TẠI:</span>
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
							<div class="col-12">
								<div class="alert alert-info border-0 shadow-sm mb-0"
									style="border-radius: 12px; background: #e3f2fd;">
									<h6 class="fw-bold">
										<i class="bi bi-chat-left-text me-2"></i>Ghi chú từ khách
										hàng:
									</h6>
									<div class="mt-2 text-dark">${booking.notes}</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
				<div class="modal-footer bg-white border-0 p-4">
					<button type="button"
						class="btn btn-light px-4 rounded-pill fw-bold"
						data-bs-dismiss="modal">Đóng</button>
					<a
						href="${pageContext.request.contextPath}/admin/bookings/update-status?id=${booking.id}&status=CONFIRMED"
						class="btn btn-success px-4 rounded-pill fw-bold shadow-sm"> <i
						class="bi bi-check-circle me-1"></i> Xác nhận đơn
					</a> <a
						href="${pageContext.request.contextPath}/admin/bookings/update-status?id=${booking.id}&status=CANCELLED"
						class="btn btn-outline-danger px-4 rounded-pill fw-bold ms-2">
						Hủy đơn </a>
				</div>
			</div>
		</div>
	</div>
</c:forEach>

<script>

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

// Lọc trạng thái - Giữ logic gốc của bạn
function filterStatus(status) {
    const table = document.getElementById('bookingsTable');
    const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
    const buttons = document.querySelectorAll('.btn-group button');

    buttons.forEach(btn => btn.classList.remove('active', 'shadow-sm'));
    event.target.classList.add('active', 'shadow-sm');

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

// Confirm - Giữ logic gốc của bạn
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

<%@ include file="/WEB-INF/views/footer.jsp"%>