<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
/* 1. Hệ thống màu sắc Dark-Mode chuẩn UI/UX */
:root {
	--f-bg: #111827; /* Nền tối sâu hiện đại */
	--f-text-main: #ffffff; /* Trắng tuyệt đối cho tiêu đề */
	--f-text-muted: #d1d5db; /* Xám sáng rõ nét - CHỐNG DÍNH NỀN */
	--f-accent: #3b82f6; /* Xanh dương chủ đạo */
	--f-border: rgba(255, 255, 255, 0.1);
	--f-card-bg: rgba(255, 255, 255, 0.05);
}

.footer-premium {
	background-color: var(--f-bg);
	color: var(--f-text-main);
	padding: 80px 0 30px;
	font-family: 'Inter', -apple-system, sans-serif;
	border-top: 4px solid var(--f-accent);
	position: relative;
}

/* 2. Ép màu nội dung luôn sáng để nổi bật trên nền tối */
.footer-premium p, 
.footer-premium span, 
.footer-premium .small,
.footer-premium .text-muted {
	color: var(--f-text-muted) !important;
	line-height: 1.6;
}

.footer-title {
	font-size: 1.1rem;
	font-weight: 700;
	margin-bottom: 25px;
	color: var(--f-text-main);
	text-transform: uppercase;
	letter-spacing: 1px;
}

/* 3. Lưới thanh toán Modern */
.payment-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 12px;
}

.payment-item {
	background: var(--f-card-bg);
	border: 1px solid var(--f-border);
	border-radius: 10px;
	padding: 10px;
	display: flex;
	align-items: center;
	gap: 10px;
	transition: all 0.3s ease;
}

.payment-item:hover {
	background: rgba(255, 255, 255, 0.1);
	border-color: var(--f-accent);
	transform: translateY(-2px);
}

.payment-item i {
	font-size: 1.3rem;
	color: var(--f-accent);
}

.payment-name {
	font-size: 0.8rem;
	font-weight: 600;
	color: #fff !important;
	display: block;
}

/* 4. Social & Newsletter */
.social-btns {
	display: flex;
	gap: 10px;
	margin-top: 20px;
}

.social-btn {
	width: 38px;
	height: 38px;
	background: var(--f-card-bg);
	border: 1px solid var(--f-border);
	border-radius: 8px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: white !important;
	text-decoration: none;
	transition: 0.3s;
}

.social-btn:hover {
	background: var(--f-accent);
	transform: translateY(-3px);
	color: white !important;
}

.newsletter-input {
	background: var(--f-card-bg) !important;
	border: 1px solid var(--f-border) !important;
	color: white !important;
	border-radius: 8px 0 0 8px;
}

/* 5. KHỐI CHỨNG NHẬN ĐÃ CẢI TIẾN - CHUYÊN NGHIỆP */
.bct-container {
    display: inline-flex;
    align-items: center;
    background: rgba(255, 255, 255, 0.08); /* Nền kính mờ hiện đại */
    padding: 8px 15px;
    border-radius: 12px;
    border: 1px solid rgba(255, 255, 255, 0.1);
    transition: all 0.3s ease;
    text-decoration: none !important;
}

.bct-container:hover {
    background: rgba(255, 255, 255, 0.15);
    border-color: var(--f-accent);
    transform: translateY(-3px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
}

.bct-icon-circle {
    width: 32px;
    height: 32px;
    background: #fff;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 12px;
    flex-shrink: 0;
}

.bct-text-content {
    display: flex;
    flex-direction: column;
    line-height: 1.2;
}

.bct-status {
    color: #ff4d4d; /* Màu đỏ sáng trên nền tối */
    font-weight: 800;
    font-size: 0.7rem;
    letter-spacing: 0.5px;
    white-space: nowrap;
}

.bct-authority {
    color: #ffffff;
    font-weight: 600;
    font-size: 0.6rem;
    opacity: 0.8;
    white-space: nowrap;
}

.footer-bottom {
	margin-top: 50px;
	padding-top: 25px;
	border-top: 1px solid var(--f-border);
}
</style>

<footer class="footer-premium">
	<div class="container">
		<div class="row g-4">
            <div class="col-lg-3 col-md-6">
				<div class="mb-4">
					<h4 class="fw-bold mb-0 text-white">
						<i class="bi bi-airplane-engines-fill text-primary me-2"></i>TourBook
					</h4>
				</div>
				<p class="small mb-4">Đồng hành cùng bạn trên mọi hành trình khám phá thế giới. Dịch vụ chuyên nghiệp, giá trị thực và niềm tin vững bền.</p>
				<div class="social-btns">
					<a href="#" class="social-btn"><i class="bi bi-facebook"></i></a> 
                    <a href="#" class="social-btn"><i class="bi bi-instagram"></i></a> 
                    <a href="#" class="social-btn"><i class="bi bi-youtube"></i></a> 
                    <a href="#" class="social-btn"><i class="bi bi-tiktok"></i></a>
				</div>
			</div>

            <div class="col-lg-3 col-md-6">
				<h6 class="footer-title">Thông Tin Liên Hệ</h6>
				<div class="d-flex mb-3">
					<i class="bi bi-geo-alt-fill text-primary me-3 mt-1"></i> 
                    <span class="small">123 Đường Lê Lợi, Bến Nghé, Quận 1, TP. Hồ Chí Minh</span>
				</div>
				<div class="d-flex mb-3">
					<i class="bi bi-telephone-fill text-primary me-3"></i> 
                    <span class="small">1900 6789</span>
				</div>
				<div class="d-flex mb-3">
					<i class="bi bi-envelope-paper-fill text-primary me-3"></i> 
                    <span class="small">support@tourbook.com</span>
				</div>
				<div class="d-flex">
					<i class="bi bi-clock-history text-primary me-3"></i> 
                    <span class="small">08:00 - 21:00 (T2 - CN)</span>
				</div>
			</div>

            <div class="col-lg-4 col-md-12">
				<h6 class="footer-title">Thanh Toán Trực Tuyến</h6>
				<div class="payment-grid">
					<div class="payment-item">
						<i class="bi bi-cash-stack"></i>
						<div class="payment-info">
							<span class="payment-name">Tiền mặt</span> 
                            <span class="payment-desc">Tại văn phòng</span>
						</div>
					</div>
					<div class="payment-item">
						<i class="bi bi-bank"></i>
						<div class="payment-info">
							<span class="payment-name">Chuyển khoản</span> 
                            <span class="payment-desc">Mọi ngân hàng</span>
						</div>
					</div>
					<div class="payment-item">
						<i class="bi bi-qr-code-scan"></i>
						<div class="payment-info">
							<span class="payment-name">VNPay</span> 
                            <span class="payment-desc">Ví điện tử / QR</span>
						</div>
					</div>
					<div class="payment-item">
						<i class="bi bi-wallet2"></i>
						<div class="payment-info">
							<span class="payment-name">MoMo</span> 
                            <span class="payment-desc">Ứng dụng MoMo</span>
						</div>
					</div>
				</div>
			</div>

            <div class="col-lg-2 col-md-6 newsletter-box">
				<h6 class="footer-title">Nhận Ưu Đãi</h6>
				<div class="input-group mb-4">
					<input type="email" class="form-control newsletter-input" placeholder="Email...">
					<button class="btn btn-primary">
						<i class="bi bi-send-fill"></i>
					</button>
				</div>

				<h6 class="footer-title mb-3" style="font-size: 0.8rem; opacity: 0.7;">Chứng nhận uy tín</h6>
				
                <a href="http://online.gov.vn/" target="_blank" class="bct-container">
                    <div class="bct-icon-circle">
                        <img src="http://online.gov.vn/Content/online2024/ImgOnDeAn/logoct.png"
                             alt="BCT" width="20"
                             onerror="this.src='https://img.icons8.com/color/48/checked-2.png'">
                    </div>
                    <div class="bct-text-content">
                        <span class="bct-status">ĐÃ THÔNG BÁO</span> 
                        <span class="bct-authority">BỘ CÔNG THƯƠNG</span>
                    </div>
                </a>
			</div>
		</div>

        <div class="footer-bottom">
			<div class="row align-items-center">
				<div class="col-md-6 text-center text-md-start">
					<p class="small mb-0">
						&copy; 2026 <strong>TourBook</strong>. All rights reserved.
					</p>
				</div>
				<div class="col-md-6 text-center text-md-end mt-3 mt-md-0">
					<div class="small">
						<a href="#" class="text-decoration-none me-3" style="color: var(--f-text-muted)">Chính sách</a> 
                        <a href="#" class="text-decoration-none me-3" style="color: var(--f-text-muted)">Điều khoản</a> 
                        <span style="color: var(--f-text-muted)">Phát triển bởi <strong class="text-white">TourBook Team</strong> với <i class="bi bi-heart-fill text-danger"></i></span>
					</div>
				</div>
			</div>
		</div>
	</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>