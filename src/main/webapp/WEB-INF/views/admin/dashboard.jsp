<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
:root {
	--glass-bg: rgba(255, 255, 255, 0.95);
	--primary-gradient: linear-gradient(135deg, #0d6efd 0%, #0043a8 100%);
}

body {
	background-color: #f4f7f6;
	font-family: 'Inter', sans-serif;
}

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

/* Stats Cards - Giống 100% Quản lý Đặt Tour */
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

/* Main Content Card */
.card.main-content {
	border: none;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
}

/* Table Modern */
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

/* Badges */
.badge {
	padding: 0.6em 1em;
	border-radius: 8px;
	font-weight: 600;
	font-size: 0.75rem;
}

.badge.bg-warning { background-color: #fff4e5 !important; color: #ff9800 !important; }
.badge.bg-success { background-color: #e8f5e9 !important; color: #2e7d32 !important; }
.badge.bg-primary { background-color: #e3f2fd !important; color: #1565c0 !important; }
.badge.bg-danger { background-color: #ffebee !important; color: #c62828 !important; }

/* Custom Form */
.form-control-sm {
	border-radius: 8px;
	border: 1px solid #e0e0e0;
}
</style>

<div class="container-fluid my-4">
	<div class="row">
		<div class="col-md-2">
			<div class="list-group shadow-sm bg-white p-2" style="border-radius: 16px;">
				<a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item list-group-item-action active"> 
					<i class="bi bi-speedometer2 me-2"></i> Dashboard
				</a> 
				<a href="${pageContext.request.contextPath}/admin/tours" class="list-group-item list-group-item-action"> 
					<i class="bi bi-compass me-2"></i> Quản lý Tours
				</a> 
				<a href="${pageContext.request.contextPath}/admin/bookings" class="list-group-item list-group-item-action"> 
					<i class="bi bi-calendar-check me-2"></i> Quản lý Đặt Tour
				</a> 
				<a href="${pageContext.request.contextPath}/admin/users" class="list-group-item list-group-item-action"> 
					<i class="bi bi-people me-2"></i> Quản lý Users
				</a>
				<hr>
				<a href="${pageContext.request.contextPath}/" class="list-group-item list-group-item-action text-danger"> 
					<i class="bi bi-house me-2"></i> Về Trang Chủ
				</a>
			</div>
		</div>

		<div class="col-md-10">
			<div class="d-flex justify-content-between align-items-center mb-4">
				<h2 class="fw-bold">
					<i class="bi bi-speedometer2 text-primary me-2"></i> Hệ Thống Quản Trị
				</h2>
			</div>

			<div class="row mb-4">
				<div class="col-md-4">
					<div class="card stat-card shadow-sm border-0 border-bottom border-primary border-4 h-100">
						<div class="card-body">
							<h6 class="text-muted">Tổng số Tours</h6>
							<h3 class="text-primary">${totalTours}</h3>
							<i class="bi bi-compass position-absolute end-0 bottom-0 m-3 opacity-25 fs-1"></i>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card stat-card shadow-sm border-0 border-bottom border-success border-4 h-100">
						<div class="card-body">
							<h6 class="text-muted">Tổng đơn đặt</h6>
							<h3 class="text-success">${totalBookings}</h3>
							<i class="bi bi-calendar-check position-absolute end-0 bottom-0 m-3 opacity-25 fs-1"></i>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card stat-card shadow-sm border-0 border-bottom border-warning border-4 h-100">
						<div class="card-body">
							<h6 class="text-muted">Tổng người dùng</h6>
							<h3 class="text-warning">${totalUsers}</h3>
							<i class="bi bi-people position-absolute end-0 bottom-0 m-3 opacity-25 fs-1"></i>
						</div>
					</div>
				</div>
			</div>

			<div class="row mb-4">
				<div class="col-md-4">
					<div class="card main-content shadow-sm h-100">
						<div class="card-header bg-white border-0 pt-4 px-4">
							<h6 class="fw-bold mb-0">Trạng Thái Đơn Hàng</h6>
						</div>
						<div class="card-body p-4 d-flex align-items-center">
							<canvas id="bookingStatusChart"></canvas>
						</div>
					</div>
				</div>

				<div class="col-md-8">
					<div class="card main-content shadow-sm h-100">
						<div class="card-header bg-white border-0 pt-4 px-4 d-flex justify-content-between align-items-center">
							<h6 class="fw-bold mb-0">Thống Kê Doanh Thu</h6>
							<form method="get" class="d-flex gap-2">
								<input type="date" name="fromDate" class="form-control form-control-sm" value="${fromDate}">
								<input type="date" name="toDate" class="form-control form-control-sm" value="${toDate}">
								<button type="submit" class="btn btn-sm btn-primary rounded-pill px-3">Lọc</button>
							</form>
						</div>
						<div class="card-body p-4">
							<canvas id="revenueChart" style="max-height: 300px;"></canvas>
						</div>
					</div>
				</div>
			</div>

			<div class="card main-content shadow-sm">
				<div class="card-header bg-white border-0 pt-4 px-4">
					<h6 class="fw-bold mb-0">Giao dịch gần đây</h6>
				</div>
				<div class="card-body p-4">
					<div class="table-responsive">
						<table class="table table-hover mb-0">
							<thead>
								<tr>
									<th>Mã đơn</th>
									<th>Khách hàng</th>
									<th>Thông tin Tour</th>
									<th>Ngày đặt</th>
									<th>Tổng tiền</th>
									<th>Trạng thái</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${recentBookings}" var="booking">
									<tr>
										<td class="fw-bold">#${booking.id}</td>
										<td>${booking.userFullname}</td>
										<td class="fw-medium">${booking.tourName}</td>
										<td><fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy"/></td>
										<td>
											<div class="fw-bold text-danger">
												<fmt:formatNumber value="${booking.totalPrice}" type="number"/> đ
											</div>
										</td>
										<td>
											<c:choose>
												<c:when test="${booking.status == 'PENDING'}"><span class="badge bg-warning">Đang xử lý</span></c:when>
												<c:when test="${booking.status == 'CONFIRMED'}"><span class="badge bg-success">Đã xác nhận</span></c:when>
												<c:when test="${booking.status == 'COMPLETED'}"><span class="badge bg-primary">Hoàn thành</span></c:when>
												<c:when test="${booking.status == 'CANCELLED'}"><span class="badge bg-danger">Đã hủy</span></c:when>
											</c:choose>
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

<script>
    // 1. Biểu đồ tròn (Doughnut)
    const statusCtx = document.getElementById('bookingStatusChart').getContext('2d');
    new Chart(statusCtx, {
        type: 'doughnut',
        data: {
            labels: ['Đang xử lý', 'Đã xác nhận', 'Hoàn thành', 'Đã hủy'],
            datasets: [{
                data: [${pendingCount}, ${confirmedCount}, ${completedCount}, ${cancelledCount}],
                backgroundColor: ['#ff9800', '#2e7d32', '#1565c0', '#c62828'],
                borderWidth: 0
            }]
        },
        options: { 
            plugins: { legend: { position: 'bottom', labels: { boxWidth: 12, font: { size: 11 } } } },
            cutout: '65%'
        }
    });

    // 2. Biểu đồ đường (Revenue)
    const revenueLabels = ${not empty revenueDates ? revenueDates : '[]'};
    const revenueData = ${not empty revenueValues ? revenueValues : '[]'};

    const revCtx = document.getElementById('revenueChart').getContext('2d');
    new Chart(revCtx, {
        type: 'line',
        data: {
            labels: revenueLabels,
            datasets: [{
                label: 'Doanh thu (VNĐ)',
                data: revenueData,
                borderColor: '#0d6efd',
                backgroundColor: 'rgba(13, 110, 253, 0.05)',
                fill: true,
                tension: 0.4,
                pointRadius: 4,
                pointBackgroundColor: '#0d6efd'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: { 
                    beginAtZero: true,
                    ticks: { callback: function(value) { return value.toLocaleString() + ' đ'; } }
                }
            },
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) { return 'Doanh thu: ' + context.parsed.y.toLocaleString() + ' đ'; }
                    }
                }
            }
        }
    });
</script>

<%@ include file="/WEB-INF/views/footer.jsp" %>