// script.js - ACCESSO Modern UI Interactivity

document.addEventListener('DOMContentLoaded', () => {
    
    // 1. Intersection Observer for Scroll Animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const scrollObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
                scrollObserver.unobserve(entry.target);
            }
        });
    }, observerOptions);

    // Targets for scroll animation
    const animateTargets = document.querySelectorAll('.glass-card, .minimal-card, .section-header');
    animateTargets.forEach(target => {
        target.style.opacity = '0';
        target.style.transform = 'translateY(30px)';
        target.style.transition = 'all 0.8s cubic-bezier(0.16, 1, 0.3, 1)';
        scrollObserver.observe(target);
    });

    // 2. Modern Add to Cart Animation & AJAX
    window.animateAddToCart = function(btn) {
        if (!btn) return;
        const originalContent = btn.innerHTML;
        
        btn.disabled = true;
        btn.classList.add('loading');
        btn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i>';
        
        return new Promise((resolve) => {
            setTimeout(() => {
                btn.classList.remove('loading');
                btn.classList.add('success');
                btn.innerHTML = '<i class="fa-solid fa-check"></i> Added';
                
                setTimeout(() => {
                    btn.classList.remove('success');
                    btn.innerHTML = originalContent;
                    btn.disabled = false;
                    resolve();
                }, 2000);
            }, 600);
        });
    };

    window.addToCartAjax = function(btn, productId, contextPath) {
        const originalContent = btn.innerHTML;
        btn.disabled = true;
        btn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i>';

        fetch(`${contextPath}/CartServlet`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `action=add&id=${productId}&ajax=true`
        })
        .then(response => {
            if (response.ok) {
                // Success animation
                btn.innerHTML = '<i class="fa-solid fa-check"></i> Added';
                btn.style.background = '#00C851';
                
                // Update cart count if possible
                const cartCount = document.getElementById('cartCount') || document.querySelector('.cart-count');
                if (cartCount) {
                    cartCount.innerText = parseInt(cartCount.innerText) + 1;
                    cartCount.classList.add('bump');
                    setTimeout(() => cartCount.classList.remove('bump'), 300);
                }
            } else {
                btn.innerHTML = '<i class="fa-solid fa-xmark"></i> Error';
                btn.style.background = '#FF4D4D';
            }
        })
        .catch(err => {
            console.error('Cart Error:', err);
            btn.innerHTML = '<i class="fa-solid fa-xmark"></i> Error';
        })
        .finally(() => {
            setTimeout(() => {
                btn.innerHTML = originalContent;
                btn.style.background = '';
                btn.disabled = false;
            }, 2000);
        });
    };

    // 3. Smooth Sticky Navbar behavior
    const nav = document.querySelector('.nav-glass');
    const navToggle = document.querySelector('.nav-toggle');
    const navLinks = document.querySelector('.nav-links');

    if (nav) {
        window.addEventListener('scroll', () => {
            const currentScroll = window.pageYOffset;
            if (currentScroll > 50) {
                nav.classList.add('scrolled');
            } else {
                nav.classList.remove('scrolled');
            }
        });
    }

    if (navToggle && navLinks) {
        navToggle.addEventListener('click', () => {
            navLinks.classList.toggle('active');
            const icon = navToggle.querySelector('i');
            if (navLinks.classList.contains('active')) {
                icon.classList.replace('fa-bars', 'fa-xmark');
            } else {
                icon.classList.replace('fa-xmark', 'fa-bars');
            }
        });

        // Close menu when clicking a link
        navLinks.querySelectorAll('.nav-item').forEach(link => {
            link.addEventListener('click', () => {
                navLinks.classList.remove('active');
                navToggle.querySelector('i').classList.replace('fa-xmark', 'fa-bars');
            });
        });
    }

    // 5. Hero Carousel Logic (Restored)
    const carouselContainer = document.querySelector('.carousel-container');
    const slides = document.querySelectorAll('.carousel-slide');
    const dots = document.querySelectorAll('.nav-dot');
    
    if (carouselContainer && slides.length > 0) {
        let currentSlideIdx = 0;
        
        function showSlide(index) {
            currentSlideIdx = index;
            const offset = -index * 100;
            carouselContainer.style.transform = `translateX(${offset}%)`;
            
            // Update dots
            dots.forEach((dot, i) => {
                dot.classList.toggle('active', i === index);
            });

            // Update active slide class
            slides.forEach((slide, i) => {
                slide.classList.toggle('active', i === index);
            });
        }

        dots.forEach((dot, i) => {
            dot.addEventListener('click', () => showSlide(i));
        });

        // Auto-play
        let autoPlayInterval = setInterval(() => {
            let next = (currentSlideIdx + 1) % slides.length;
            showSlide(next);
        }, 5000);

        // Pause on interaction
        carouselContainer.addEventListener('mouseenter', () => clearInterval(autoPlayInterval));
    }

    // 6. Global Image Fallback Handler
    window.errorImageHandler = function(img) {
        img.onerror = null;
        img.src = 'https://via.placeholder.com/600x400/F4F7F9/2C3E50?text=ACCESSO+Premium';
        img.classList.add('is-placeholder');
    };

    document.querySelectorAll('img').forEach(img => {
        img.addEventListener('error', function() {
            window.errorImageHandler(this);
        });
    });

    // 7. Smooth Scroll for Anchor Links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            
            const target = document.querySelector(targetId);
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
});
