<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/WEB-INF/views/header.jsp" %>

<style>
:root {
    --glass-bg: rgba(255, 255, 255, 0.95);
    --primary-gradient: linear-gradient(135deg, #0d6efd 0%, #0043a8 100%);
}

body {
    background-color: #f4f7f6;
    font-family: 'Inter', sans-serif;
}

/* Sidebar Modern - Copy 100% từ Dashboard */
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

/* Stats Cards - Đồng bộ 100% */
.stat-card {
    border: none;
    border-radius: 16px;
    transition: transform 0.3s;
    overflow: hidden;
    position: relative;
}
.stat-card:hover { transform: translateY(-5px); }
.stat-card h3 { font-weight: 800; margin-bottom: 0; }
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

/* User Avatar Placeholder */
.avatar-circle {
    width: 45px;
    height: 45px;
    background: var(--primary-gradient);
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
    font-weight: 700;
    box-shadow: 0 4px 8px rgba(13, 110, 253, 0.2);
}

/* Badges Pastel */
.badge-role {
    padding: 0.5rem 1rem;
    border-radius: 8px;
    font-weight: 600;
    font-size: 0.75rem;
}
.role-admin { background-color: #ffebee; color: #c62828; }
.role-user { background-color: #e3f2fd; color: #1565c0; }

.search-box {
    border-radius: 12px;
    border: 1px solid #e0e0e0;
    padding: 0.6rem 1rem 0.6rem 2.8rem;
}

.pagination .page-link {
    border: none;
    margin: 0 3px;
    border-radius: 8px;
    color: #6c757d;
}
.pagination .page-item.active .page-link {
    background: var(--primary-gradient);
    color: white;
}
</style>

<div class="container-fluid my-4">
    <div class="row">
        <div class="col-md-2">
            <div class="list-group shadow-sm bg-white p-2" style="border-radius: 16px;">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item list-group-item-action"> 
                    <i class="bi bi-speedometer2 me-2"></i> Dashboard
                </a> 
                <a href="${pageContext.request.contextPath}/admin/tours" class="list-group-item list-group-item-action"> 
                    <i class="bi bi-compass me-2"></i> Quản lý Tours
                </a> 
                <a href="${pageContext.request.contextPath}/admin/bookings" class="list-group-item list-group-item-action"> 
                    <i class="bi bi-calendar-check me-2"></i> Quản lý Đặt Tour
                </a> 
                <a href="${pageContext.request.contextPath}/admin/users" class="list-group-item list-group-item-action active"> 
                    <i class="bi bi-people me-2"></i> Quản lý Users
                </a>
                <hr>
                <a href="${pageContext.request.contextPath}/" class="list-group-item list-group-item-action text-danger"> 
                    <i class="bi bi-house-door me-2"></i> Về Trang Chủ
                </a>
            </div>
        </div>

        <div class="col-md-10">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold"><i class="bi bi-people text-primary me-2"></i> Hệ Thống Quản Lý Người Dùng</h2>
            </div>

            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card stat-card shadow-sm border-0 border-bottom border-primary border-4 h-100">
                        <div class="card-body">
                            <h6 class="text-muted">Tổng Người Dùng</h6>
                            <h3 class="text-primary">${users.size()}</h3>
                            <i class="bi bi-people position-absolute end-0 bottom-0 m-3 opacity-25 fs-1"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card stat-card shadow-sm border-0 border-bottom border-danger border-4 h-100">
                        <div class="card-body">
                            <h6 class="text-muted">Quản trị viên</h6>
                            <h3 class="text-danger">
                                <c:set var="adminCount" value="0" />
                                <c:forEach var="u" items="${users}"><c:if test="${u.admin}"><c:set var="adminCount" value="${adminCount + 1}" /></c:if></c:forEach>
                                ${adminCount}
                            </h3>
                            <i class="bi bi-shield-lock position-absolute end-0 bottom-0 m-3 opacity-25 fs-1"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card stat-card shadow-sm border-0 border-bottom border-success border-4 h-100">
                        <div class="card-body">
                            <h6 class="text-muted">Tài khoản mới (Tháng này)</h6>
                            <h3 class="text-success">2</h3>
                            <i class="bi bi-person-plus position-absolute end-0 bottom-0 m-3 opacity-25 fs-1"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card main-content shadow-sm">
                <div class="card-header bg-white border-0 pt-4 px-4">
                    <div class="row align-items-center">
                        <div class="col-md-6 position-relative">
                            <i class="bi bi-search position-absolute text-muted" style="left: 28px; top: 12px;"></i>
                            <input type="text" id="searchInput" class="form-control search-box shadow-none" placeholder="Tìm tên, email, username...">
                        </div>
                    </div>
                </div>
                <div class="card-body p-4">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>Thông tin thành viên</th>
                                    <th>Liên hệ</th>
                                    <th class="text-center">Vai trò</th>
                                    <th>Ngày tham gia</th>
                                    <th class="text-end">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody">
                                <c:forEach items="${users}" var="user">
                                    <tr class="user-row">
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="avatar-circle me-3">
                                                    ${user.username.substring(0,1).toUpperCase()}
                                                </div>
                                                <div>
                                                    <div class="fw-bold text-dark mb-0">@${user.username}</div>
                                                    <small class="text-muted">${user.fullname}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="small fw-bold text-dark"><i class="bi bi-envelope me-1"></i> ${user.email}</div>
                                            <div class="small text-muted"><i class="bi bi-geo-alt me-1"></i> ${not empty user.address ? user.address : 'Chưa cập nhật'}</div>
                                        </td>
                                        <td class="text-center">
                                            <span class="badge-role ${user.admin ? 'role-admin' : 'role-user'}">
                                                <i class="bi ${user.admin ? 'bi-shield-check' : 'bi-person'} me-1"></i>
                                                ${user.admin ? 'Quản trị viên' : 'Thành viên'}
                                            </span>
                                        </td>
                                        <td class="text-muted small">
                                            <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td class="text-end">
                                            <c:if test="${!user.admin}">
                                                <a href="${pageContext.request.contextPath}/admin/users/delete/${user.id}" 
                                                   class="text-danger fs-5 ms-2" 
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')">
                                                    <i class="bi bi-trash3"></i>
                                                </a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer bg-white border-0 py-3 d-flex justify-content-between align-items-center">
                    <div id="pageInfo" class="small text-muted fw-bold"></div>
                    <nav><ul class="pagination mb-0" id="pagination"></ul></nav>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Logic Phân trang & Tìm kiếm giữ nguyên như bản cũ nhưng đã cập nhật style mới
    const rowsPerPage = 5; 
    let currentPage = 1;
    const rows = Array.from(document.querySelectorAll('.user-row'));
    let filtered = [...rows];

    function update() {
        const start = (currentPage - 1) * rowsPerPage;
        const end = start + rowsPerPage;
        rows.forEach(r => r.style.display = 'none');
        if (filtered.length === 0) {
            document.getElementById('pageInfo').innerText = "Không tìm thấy dữ liệu";
            document.getElementById('pagination').innerHTML = "";
            return;
        }
        filtered.slice(start, end).forEach(r => r.style.display = '');
        renderPager();
        document.getElementById('pageInfo').innerText = 'Đang xem ' + (start + 1) + ' đến ' + Math.min(end, filtered.length) + ' trong tổng số ' + filtered.length + ' người dùng';
    }

    function renderPager() {
        const count = Math.ceil(filtered.length / rowsPerPage);
        const pager = document.getElementById('pagination');
        pager.innerHTML = ''; 
        if (count <= 1) return;
        for (let i = 1; i <= count; i++) {
            const li = document.createElement('li');
            li.className = 'page-item ' + (i === currentPage ? 'active' : '');
            li.innerHTML = `<a class="page-link shadow-none" href="javascript:void(0)" onclick="currentPage=${i};update()">${i}</a>`;
            pager.appendChild(li);
        }
    }

    document.getElementById('searchInput').addEventListener('input', e => {
        const term = e.target.value.toLowerCase();
        filtered = rows.filter(r => r.innerText.toLowerCase().includes(term));
        currentPage = 1; 
        update();
    });

    update();
</script>

<%@ include file="/WEB-INF/views/footer.jsp" %>