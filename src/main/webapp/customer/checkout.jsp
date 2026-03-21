<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Checkout | ACCESSO</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        :root {
            --primary: #0f172a;
            --accent: #3b82f6;
            --bg-light: #f8fafc;
            --text-dark: #334155;
            --text-muted: #64748b;
            --radius-lg: 24px;
            --radius-md: 16px;
        }

        /* Professional Centered Navbar */
        .nav-glass {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            width: 90%;
            max-width: 900px;
            height: 70px;
            padding: 0 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(12px);
            border-radius: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .nav-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
        }

        .nav-brand {
            font-size: 1.6rem;
            font-weight: 900;
            text-decoration: none;
            color: #000;
            letter-spacing: -1px;
            display: flex;
            align-items: center;
        }

        .nav-brand span { color: var(--accent); }

        /* Checkout Specifics */
        .checkout-grid { display: grid; grid-template-columns: 1fr 400px; gap: 40px; }
        .checkout-step { background: white; padding: 40px; border-radius: 24px; border: 1px solid #EEE; margin-bottom: 25px; }
        .step-num { width: 32px; height: 32px; background: var(--primary); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.8rem; margin-right: 15px; }
        .step-header { display: flex; align-items: center; margin-bottom: 30px; }
        .step-header h3 { font-size: 1.4rem; font-weight: 800; margin: 0; }
        .summary-sticky { position: sticky; top: 120px; }
        .qr-card { background: #F8F9FA; padding: 25px; border-radius: 20px; text-align: center; margin-top: 20px; border: 1px dashed #DDD; display: none; }
        @media (max-width: 992px) {
            .checkout-grid {
                grid-template-columns: 1fr;
            }
            .summary-sticky {
                position: static;
                width: 100%;
            }
        }
        
        @media (max-width: 768px) {
            .checkout-step {
                padding: 20px;
            }
            .step-header h3 {
                font-size: 1.1rem;
            }
            .checkout-steps input, .checkout-steps select {
                font-size: 16px !important; /* Prevent zoom on iOS */
            }
            .shipping-inner {
                grid-template-columns: 1fr !important;
            }
        }
    </style>
</head>
<body style="background: var(--bg-light);">

    <nav class="nav-glass" id="mainNavbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/index.jsp" class="nav-brand">
                ACCESSO<span>.in</span>
                <small style="font-weight: 400; font-size: 0.8rem; margin-left:15px; opacity: 0.5;">Secure Checkout</small>
            </a>
        </div>
    </nav>

    <main class="container" style="padding-top: 150px; padding-bottom: 100px;">
        <c:if test="${not empty param.error}">
            <div style="background: #fee2e2; color: #dc2626; padding: 20px; border-radius: 15px; margin-bottom: 30px; border: 1px solid #fecaca; font-weight: 700; text-align: center;">
                <i class="fa-solid fa-circle-exclamation" style="margin-right: 10px;"></i>
                ${param.error}. <a href="${pageContext.request.contextPath}/alterDb.jsp" style="color: #b91c1c; text-decoration: underline;">Click here to fix database</a>
            </div>
        </c:if>

        <div class="checkout-grid">
            <div class="checkout-steps">
                
                <!-- 1. Shipping -->
                <div class="checkout-step">
                    <div class="step-header">
                        <div class="step-num">1</div>
                        <h3>Delivery Destination</h3>
                    </div>
                    <div style="padding-left: 47px;">
                    <div class="shipping-inner" style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 8px;">
                            <div>
                                <label style="font-size: 0.78rem; font-weight: 700; color: #AAA; display: block; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.05em;">Full Name</label>
                                <input type="text" name="recipientName" value="${sessionScope.user.name}" style="width:100%; padding: 12px 14px; border: 1.5px solid #E5E7EB; border-radius: 10px; font-size: 0.9rem; font-family: inherit; outline: none; transition: border 0.2s;" onfocus="this.style.borderColor='#3B82F6'" onblur="this.style.borderColor='#E5E7EB'" required>
                            </div>
                            <div>
                                <label style="font-size: 0.78rem; font-weight: 700; color: #AAA; display: block; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.05em;">Phone Number</label>
                                <input type="tel" name="phone" placeholder="10-digit mobile number" style="width:100%; padding: 12px 14px; border: 1.5px solid #E5E7EB; border-radius: 10px; font-size: 0.9rem; font-family: inherit; outline: none; transition: border 0.2s;" onfocus="this.style.borderColor='#3B82F6'" onblur="this.style.borderColor='#E5E7EB'">
                            </div>
                        </div>
                        <div style="margin-bottom: 8px;">
                            <label style="font-size: 0.78rem; font-weight: 700; color: #AAA; display: block; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.05em;">House / Flat / Building, Area, Locality</label>
                            <input type="text" name="addressLine1" placeholder="e.g. 42, Green Valley, Near Tech Park" style="width:100%; padding: 12px 14px; border: 1.5px solid #E5E7EB; border-radius: 10px; font-size: 0.9rem; font-family: inherit; outline: none; transition: border 0.2s;" onfocus="this.style.borderColor='#3B82F6'" onblur="this.style.borderColor='#E5E7EB'" required>
                        </div>
                        <div class="shipping-inner" style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 12px;">
                            <div>
                                <label style="font-size: 0.78rem; font-weight: 700; color: #AAA; display: block; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.05em;">City</label>
                                <input type="text" name="city" placeholder="City" style="width:100%; padding: 12px 14px; border: 1.5px solid #E5E7EB; border-radius: 10px; font-size: 0.9rem; font-family: inherit; outline: none; transition: border 0.2s;" onfocus="this.style.borderColor='#3B82F6'" onblur="this.style.borderColor='#E5E7EB'" required>
                            </div>
                            <div>
                                <label style="font-size: 0.78rem; font-weight: 700; color: #AAA; display: block; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.05em;">State</label>
                                <input type="text" name="state" placeholder="State" style="width:100%; padding: 12px 14px; border: 1.5px solid #E5E7EB; border-radius: 10px; font-size: 0.9rem; font-family: inherit; outline: none; transition: border 0.2s;" onfocus="this.style.borderColor='#3B82F6'" onblur="this.style.borderColor='#E5E7EB'">
                            </div>
                            <div>
                                <label style="font-size: 0.78rem; font-weight: 700; color: #AAA; display: block; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.05em;">PIN Code</label>
                                <input type="text" name="pincode" placeholder="e.g. 411045" maxlength="6" style="width:100%; padding: 12px 14px; border: 1.5px solid #E5E7EB; border-radius: 10px; font-size: 0.9rem; font-family: inherit; outline: none; transition: border 0.2s;" onfocus="this.style.borderColor='#3B82F6'" onblur="this.style.borderColor='#E5E7EB'">
                            </div>
                        </div>
                        <%-- Hidden field that combines all address parts on form submit --%>
                        <input type="hidden" name="deliveryAddress" id="deliveryAddressHidden">
                    </div>
                </div>

                <!-- 2. Payment -->
                <div class="checkout-step">
                    <div class="step-header">
                        <div class="step-num">2</div>
                        <h3>Payment Orchestration</h3>
                    </div>
                    <div style="padding-left: 47px;">
                        <label class="payment-option active">
                            <input type="radio" name="pay_mode" checked onclick="toggleQR(false)" style="accent-color: var(--primary);">
                            <div>
                                <div style="font-weight: 800;">Cash on Delivery</div>
                                <div style="font-size: 0.85rem; color: #AAA;">Pay at your doorstep (Cash/UPI)</div>
                            </div>
                        </label>
                        
                        <label class="payment-option">
                            <input type="radio" name="pay_mode" onclick="toggleQR(true)" style="accent-color: var(--primary);">
                            <div>
                                <div style="font-weight: 800;">Instant Digital Payment</div>
                                <div style="font-size: 0.85rem; color: #AAA;">Scan to pay instantly via UPI</div>
                            </div>
                        </label>
                        
                        <div id="qrSection" class="qr-card">
                            <div style="font-weight: 800; font-size: 0.9rem; margin-bottom: 15px;">Scan to Pay ₹${cartTotal}</div>
                            <img src="https://api.qrserver.com/v1/create-qr-code/?size=160x160&data=upi://pay?pa=accesso@okaxis&pn=ACCESSO&am=${cartTotal}&cu=INR" alt="UPI QR">
                            <div style="margin-top: 15px; font-size: 0.75rem; color: #AAA;">Secure Payment via ACCESSO Gateway</div>
                        </div>
                    </div>
                </div>

                <!-- 3. Review -->
                <div class="checkout-step">
                    <div class="step-header">
                        <div class="step-num">3</div>
                        <h3>Selection Review</h3>
                    </div>
                    <div style="padding-left: 47px;">
                        <c:forEach var="item" items="${cartItems}">
                            <div style="display: flex; gap: 20px; align-items: center; margin-bottom: 20px;">
                                <div style="width: 60px; height: 60px; background: #F8F9FA; border-radius: 12px; display: flex; align-items: center; justify-content: center; overflow: hidden; border: 1px solid #EEE;">
                                    <img src="${not empty item.product.image ? item.product.image : 'https://via.placeholder.com/60'}" style="max-width: 100%; max-height: 100%; object-fit: contain;">
                                </div>
                                <div style="flex: 1;">
                                    <div style="font-weight: 800; font-size: 1rem;">${item.product.name}</div>
                                    <div style="color: var(--accent); font-weight: 800; font-size: 0.9rem;">₹${item.product.price} <span style="color: #AAA; font-weight: 600; font-size: 0.8rem;">x ${item.quantity}</span></div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <aside class="summary-sticky">
                <div class="summary-card" style="padding: 40px; background: white; border-radius: 24px; border: 1px solid #EEE; box-shadow: var(--shadow-soft);">
                    <form action="${pageContext.request.contextPath}/OrderServlet" method="POST" id="checkoutForm">
                        <input type="hidden" name="action" value="place">
                        <input type="hidden" name="couponCode" id="appliedCouponCode">
                        
                        <h3 style="font-size: 1.2rem; font-weight: 800; margin-bottom: 25px;">Final Totals</h3>
                        
                        <div style="background: #F8F9FA; padding: 20px; border-radius: 15px; margin-bottom: 25px;">
                            <div style="font-size: 0.8rem; font-weight: 800; color: #AAA; text-transform: uppercase; margin-bottom: 15px;">Have a coupon?</div>
                            <div style="display: flex; gap: 10px;">
                                <input type="text" id="couponInput" placeholder="Enter code (e.g. SAVE10)" style="flex: 1; padding: 10px 15px; border: 1px solid #DDD; border-radius: 10px; font-size: 0.9rem;">
                                <button type="button" onclick="applyCoupon()" class="btn-minimal" style="width: auto; padding: 0 15px; background: var(--accent); white-space: nowrap;">Apply</button>
                            </div>
                            <div id="couponMsg" style="font-size: 0.75rem; margin-top: 8px; font-weight: 700;"></div>
                        </div>

                        <table style="width: 100%; font-size: 0.95rem; border-collapse: collapse;">
                            <tr style="height: 40px;">
                                <td style="color: #AAA;">Subtotal</td>
                                <td style="text-align: right; font-weight: 800;">₹${cartTotal}</td>
                            </tr>
                            <tr id="discountRow" style="height: 40px; display: none;">
                                <td style="color: var(--accent);">Discount</td>
                                <td style="text-align: right; font-weight: 800; color: var(--accent);">- ₹<span id="discountValue">0.00</span></td>
                            </tr>
                            <tr style="height: 40px;">
                                <td style="color: #AAA;">Shipping & Handling</td>
                                <td style="text-align: right; font-weight: 800; color: #00C851;">FREE</td>
                            </tr>
                            <tr style="height: 80px; font-size: 1.6rem; vertical-align: bottom;">
                                <td style="font-weight: 800; border-top: 1px solid #F5F5F5; padding-top: 20px;">Total</td>
                                <td style="text-align: right; font-weight: 800; border-top: 1px solid #F5F5F5; padding-top: 20px; color: var(--primary);">₹<span id="finalTotal">${cartTotal}</span></td>
                            </tr>
                        </table>

                        <button type="submit" class="btn-cta" style="width: 100%; padding: 18px; border-radius: 15px; margin-top: 40px; justify-content: center; font-size: 1.1rem; border: none; cursor: pointer;">
                            Confirm & Place Order
                        </button>
                    </form>
                    
                    <p style="font-size: 0.75rem; color: #AAA; text-align: center; margin-top: 25px; line-height: 1.6;">
                        By confirming, you agree to the ACCESSO <a href="#" style="color: var(--accent); font-weight: 700;">Purchase Terms</a>.
                    </p>
                </div>
            </aside>
        </div>
    </main>

    <script>
        function toggleQR(show) {
            document.getElementById('qrSection').style.display = show ? 'block' : 'none';
        }

        async function applyCoupon() {
            const code = document.getElementById('couponInput').value;
            const msgEl = document.getElementById('couponMsg');
            if (!code) return;

            try {
                const response = await fetch('${pageContext.request.contextPath}/CouponServlet?code=' + code);
                const data = await response.json();

                if (data.success) {
                    msgEl.style.color = '#00C851';
                    msgEl.textContent = 'Coupon applied successfully!';
                    document.getElementById('appliedCouponCode').value = code;
                    document.getElementById('discountRow').style.display = 'table-row';
                    document.getElementById('discountValue').textContent = data.discount.toFixed(2);
                    const subtotal = Number('${cartTotal}');
                    document.getElementById('finalTotal').textContent = (subtotal - data.discount).toFixed(2);
                    document.getElementById('couponInput').disabled = true;
                } else {
                    msgEl.style.color = '#FF4D4D';
                    msgEl.textContent = data.message;
                }
            } catch (error) {
                msgEl.textContent = 'Error applying coupon';
            }
        }

        // Combine address fields into hidden deliveryAddress on submit
        document.addEventListener('DOMContentLoaded', function() {
            var form = document.querySelector('form[action*="OrderServlet"]');
            if (form) {
                form.addEventListener('submit', function() {
                    var line1 = (document.querySelector('[name="addressLine1"]') || {}).value || '';
                    var city  = (document.querySelector('[name="city"]')         || {}).value || '';
                    var state = (document.querySelector('[name="state"]')        || {}).value || '';
                    var pin   = (document.querySelector('[name="pincode"]')      || {}).value || '';
                    document.getElementById('deliveryAddressHidden').value =
                        [line1, city, state, pin].filter(Boolean).join(', ');
                });
            }
        });
    </script>
</body>
</html>