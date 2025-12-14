<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="container-fluid my-4">
    <div class="row">
        <div class="col-md-2">
            <div class="list-group">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="list-group-item list-group-item-action">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/tours" class="list-group-item list-group-item-action active">
                    <i class="bi bi-compass"></i> Quản lý Tours
                </a>
                <a href="${pageContext.request.contextPath}/admin/bookings" class="list-group-item list-group-item-action">
                    <i class="bi bi-calendar-check"></i> Quản lý Đặt Tour
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="list-group-item list-group-item-action">
                    <i class="bi bi-people"></i> Quản lý Users
                </a>
            </div>
        </div>
        
        <div class="col-md-10">
            <h2 class="mb-4">${tour != null ? 'Sửa' : 'Thêm'} Tour</h2>
            
            <div class="card shadow">
                <div class="card-body p-4">
                    <form method="post" action="${pageContext.request.contextPath}/admin/tours/save">
                        <c:if test="${tour != null}">
                            <input type="hidden" name="id" value="${tour.id}">
                        </c:if>
                        
                        <div class="row">
                            <div class="col-md-8 mb-3">
                                <label class="form-label">Tên tour *</label>
                                <input type="text" class="form-control" name="name" value="${tour.name}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Danh mục *</label>
                                <select name="categoryId" class="form-select" required>
                                    <c:forEach items="${categories}" var="cat">
                                        <option value="${cat.id}" ${tour.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Mô tả *</label>
                            <textarea class="form-control" name="description" rows="3" required>${tour.description}</textarea>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Địa điểm *</label>
                                <input type="text" class="form-control" name="location" value="${tour.location}" required>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label">Thời gian (ngày) *</label>
                                <input type="number" class="form-control" name="duration" value="${tour.duration}" required>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label class="form-label">Phương tiện *</label>
                                <input type="text" class="form-control" name="vehicle" value="${tour.vehicle}" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Giá (VNĐ) *</label>
                                <input type="number" class="form-control" name="price" value="${tour.price}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Giảm giá (%) *</label>
                                <input type="number" class="form-control" name="discount" value="${tour.discount}" min="0" max="100" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Số chỗ *</label>
                                <input type="number" class="form-control" name="availableSeats" value="${tour.availableSeats}" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-8 mb-3">
                                <label class="form-label">URL Hình ảnh *</label>
                                <input type="text" class="form-control" name="image" value="${tour.image}" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Ngày khởi hành *</label>
                                <input type="date" class="form-control" name="departureDate" value="${tour.departureDate}" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Lịch trình *</label>
                            <textarea class="form-control" name="itinerary" rows="5" required>${tour.itinerary}</textarea>
                        </div>
                        
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" name="featured" id="featured" ${tour.featured ? 'checked' : ''}>
                            <label class="form-check-label" for="featured">Tour nổi bật</label>
                        </div>
                        
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i> Lưu</button>
                            <a href="${pageContext.request.contextPath}/admin/tours" class="btn btn-secondary">Hủy</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>