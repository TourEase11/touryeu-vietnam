<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/WEB-INF/views/header.jsp" %>

<style>
:root {
    --primary-gradient: linear-gradient(135deg, #0d6efd 0%, #0043a8 100%);
}

body {
    background-color: #f4f7f6;
    font-family: 'Inter', sans-serif;
}

/* Sidebar Modern - Đồng bộ 100% */
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

/* Main Content Card - Đồng bộ 100% */
.card.main-content {
    border: none;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
}

.form-label {
    font-weight: 600;
    color: #495057;
    font-size: 0.9rem;
    margin-bottom: 0.5rem;
}

.form-control, .form-select {
    border-radius: 10px;
    border: 1px solid #e0e0e0;
    padding: 0.6rem 1rem;
    transition: all 0.2s;
}

.form-control:focus {
    border-color: #0d6efd;
    box-shadow: 0 0 0 0.25 darkrgba(13, 110, 253, 0.1);
}

/* Preview Image Box */
.img-preview-container {
    width: 100%;
    max-width: 300px;
    height: 180px;
    border-radius: 15px;
    border: 2px dashed #ddd;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    background-color: #f8f9fa;
}

#imgPreview {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.btn-save {
    background: var(--primary-gradient);
    border: none;
    border-radius: 10px;
    font-weight: 600;
    padding: 0.7rem 2rem;
}
</style>

<div class="container-fluid my-4">
    <div class="row">
        <div class="col-md-2">
            <div class="list-group shadow-sm bg-white p-2" style="border-radius: 16px;">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item list-group-item-action"> 
                    <i class="bi bi-speedometer2 me-2"></i> Dashboard
                </a> 
                <a href="${pageContext.request.contextPath}/admin/tours" class="list-group-item list-group-item-action active"> 
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
                    <i class="bi bi-house-door me-2"></i> Về Trang Chủ
                </a>
            </div>
        </div>

        <div class="col-md-10">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">
                    <i class="bi bi-plus-circle-fill text-primary me-2"></i> 
                    ${tour.id != null ? 'Cập nhật Tour' : 'Thêm Tour Mới'}
                </h2>
                <a href="${pageContext.request.contextPath}/admin/tours" class="btn btn-outline-secondary rounded-pill px-4">
                    <i class="bi bi-arrow-left me-2"></i> Quay lại
                </a>
            </div>

            <div class="card main-content p-4">
                <form method="post" action="${pageContext.request.contextPath}/admin/tours/save">
                    <c:if test="${tour.id != null}">
                        <input type="hidden" name="id" value="${tour.id}">
                    </c:if>

                    <div class="row">
                        <div class="col-md-8">
                            <div class="row g-3 mb-3">
                                <div class="col-md-8">
                                    <label class="form-label">Tên Tour *</label>
                                    <input type="text" class="form-control" name="name" value="${tour.name}" placeholder="Nhập tên tour du lịch..." required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Danh mục *</label>
                                    <select name="categoryId" class="form-select" required>
                                        <c:forEach items="${categories}" var="cat">
                                            <option value="${cat.id}" ${tour.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Mô tả hành trình *</label>
                                <textarea class="form-control" name="description" rows="5" placeholder="Mô tả chi tiết lịch trình..." required>${tour.description}</textarea>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Địa điểm khởi hành/đến *</label>
                                    <input type="text" class="form-control" name="location" value="${tour.location}" placeholder="Ví dụ: Đà Nẵng, Nhật Bản..." required>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Giá niêm yết (VNĐ) *</label>
                                    <input type="number" class="form-control" name="price" value="${tour.price}" required>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Ngày khởi hành *</label>
                                    <input type="date" class="form-control" name="departureDate" value="${tour.departureDate}" required>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 border-start ps-4">
                            <div class="mb-4">
                                <label class="form-label">Đường dẫn hình ảnh (URL Unsplash) *</label>
                                <input type="text" class="form-control mb-3" name="image" id="imageUrl" 
                                       value="${tour.image}" placeholder="Dán link ảnh tại đây..." required>
                                
                                <label class="form-label d-block">Xem trước ảnh:</label>
                                <div class="img-preview-container mx-auto">
                                    <img src="${not empty tour.image ? tour.image : ''}" id="imgPreview" 
                                         class="${empty tour.image ? 'd-none' : ''}">
                                    <div id="noImgText" class="text-muted small ${not empty tour.image ? 'd-none' : ''}">
                                        <i class="bi bi-image fs-1 d-block mb-2"></i> Chưa có ảnh
                                    </div>
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-6">
                                    <label class="form-label">Số ngày</label>
                                    <input type="number" class="form-control" name="duration" value="${tour.duration}" placeholder="Ví dụ: 3">
                                </div>
                                <div class="col-6">
                                    <label class="form-label">Số chỗ</label>
                                    <input type="number" class="form-control" name="availableSeats" value="${tour.availableSeats}" placeholder="Ví dụ: 20">
                                </div>
                            </div>

                            <div class="card bg-light border-0 p-3 mb-4">
                                <div class="form-check form-switch">
                                    <input type="checkbox" class="form-check-input" name="featured" id="f" ${tour.featured ? 'checked' : ''}>
                                    <label class="form-check-label fw-bold" for="f">Đánh dấu Tour nổi bật</label>
                                </div>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-save shadow-sm">
                                    <i class="bi bi-cloud-arrow-up-fill me-2"></i> Lưu Tour
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/tours" class="btn btn-light rounded-pill fw-bold">Hủy bỏ</a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    const urlInput = document.getElementById('imageUrl');
    const preview = document.getElementById('imgPreview');
    const noImgText = document.getElementById('noImgText');

    urlInput.addEventListener('input', function(e) {
        const url = e.target.value.trim();
        if (url) {
            preview.src = url;
            preview.classList.remove('d-none');
            noImgText.classList.add('d-none');
        } else {
            preview.classList.add('d-none');
            noImgText.classList.remove('d-none');
        }
    });

    // Xử lý khi ảnh lỗi (link die)
    preview.addEventListener('error', function() {
        this.classList.add('d-none');
        noImgText.classList.remove('d-none');
        noImgText.innerHTML = '<i class="bi bi-exclamation-triangle fs-1 d-block mb-2 text-danger"></i> Link ảnh lỗi';
    });
</script>

<%@ include file="/WEB-INF/views/footer.jsp" %>