<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title != null ? param.title : 'TourBook'} - Đặt Tour Du Lịch</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --accent-color: #f59e0b;
        }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar { box-shadow: 0 2px 10px rgba(0,0,0,0.1); background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)) !important; }
        .navbar-brand { font-weight: bold; font-size: 1.5rem; }
        .btn-primary { background-color: var(--primary-color); border-color: var(--primary-color); }
        .btn-primary:hover { background-color: var(--secondary-color); border-color: var(--secondary-color); }
        .hero-section { background: linear-gradient(135deg, rgba(37,99,235,0.9), rgba(30,64,175,0.9)), url('https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=1600') center/cover; color: white; padding: 100px 0; }
        .card { transition: transform 0.3s, box-shadow 0.3s; border: none; box-shadow: 0 2px 15px rgba(0,0,0,0.08); }
        .card:hover { transform: translateY(-10px); box-shadow: 0 10px 30px rgba(0,0,0,0.15); }
        .card-img-top { height: 220px; object-fit: cover; }
        .badge-discount { position: absolute; top: 10px; right: 10px; background-color: var(--accent-color); padding: 5px 10px; font-size: 0.9rem; }
        .footer { background-color: #1f2937; color: white; padding: 40px 0; margin-top: 50px; }
        .price-tag { font-size: 1.5rem; font-weight: bold; color: var(--primary-color); }
        .price-old { text-decoration: line-through; color: #9ca3af; font-size: 1rem; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="bi bi-airplane"></i> TourBook</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Trang Chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/tours">Tours</a></li>
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <c:if test="${sessionScope.user.admin}">
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2"></i> Admin</a></li>
                            </c:if>
                            <c:if test="${!sessionScope.user.admin}">
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/booking/my-bookings"><i class="bi bi-calendar-check"></i> Đơn Đặt</a></li>
                            </c:if>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-person-circle"></i> ${sessionScope.user.fullname}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth/profile">Thông Tin</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout">Đăng Xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/auth/login">Đăng Nhập</a></li>
                            <li class="nav-item"><a class="nav-link btn btn-warning text-dark ms-2" href="${pageContext.request.contextPath}/auth/register">Đăng Ký</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>