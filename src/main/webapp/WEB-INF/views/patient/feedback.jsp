<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Give Feedback</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>

    <style>
        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(28px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes floatY {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-14px);
            }
        }

        @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        @keyframes shineMove {
            0% { transform: translateX(-140%) skewX(-22deg); }
            100% { transform: translateX(240%) skewX(-22deg); }
        }

        @keyframes pulseGlow {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(59,130,246,0.20);
            }
            50% {
                box-shadow: 0 0 0 12px rgba(59,130,246,0);
            }
        }

        @keyframes borderGlow {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(245,158,11,0.00);
            }
            50% {
                box-shadow: 0 0 0 6px rgba(245,158,11,0.08);
            }
        }

        .fade-up {
            animation: fadeUp 0.85s ease forwards;
        }

        .main-bg {
            background: linear-gradient(-45deg, #e0f2fe, #eef2ff, #fdf2f8, #fff7ed, #ecfeff);
            background-size: 400% 400%;
            animation: gradientMove 14s ease infinite;
        }

        .glass-card {
            background: rgba(255,255,255,0.80);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            border: 1px solid rgba(255,255,255,0.50);
        }

        .soft-shadow {
            box-shadow: 0 20px 45px rgba(15, 23, 42, 0.10);
        }

        .floating-blob {
            animation: floatY 7s ease-in-out infinite;
        }

        .sidebar-link {
            transition: all 0.28s ease;
        }

        .sidebar-link:hover {
            transform: translateX(8px);
        }

        .pulse-glow {
            animation: pulseGlow 2.8s infinite;
        }

        .hero-card {
            position: relative;
            overflow: hidden;
        }

        .hero-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: -30%;
            width: 30%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255,255,255,0.35),
                transparent
            );
            animation: shineMove 4.8s linear infinite;
        }

        .shine-btn {
            position: relative;
            overflow: hidden;
        }

        .shine-btn::before {
            content: "";
            position: absolute;
            top: 0;
            left: -35%;
            width: 28%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255,255,255,0.38),
                transparent
            );
        }

        .shine-btn:hover::before {
            animation: shineMove 0.9s ease;
        }

        .action-btn {
            transition: all 0.28s ease;
        }

        .action-btn:hover {
            transform: translateY(-2px) scale(1.02);
        }

        .mini-chip {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border-radius: 999px;
            padding: 10px 15px;
            font-size: 13px;
            font-weight: 700;
        }

        .alert-box {
            border-radius: 20px;
            padding: 16px 18px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .field-label {
            display: block;
            margin-bottom: 10px;
            font-size: 0.95rem;
            font-weight: 700;
            color: #334155;
        }

        .input-shell {
            position: relative;
            border-radius: 22px;
            overflow: hidden;
            animation: borderGlow 3.8s ease-in-out infinite;
        }

        .input-shell::before {
            content: "";
            position: absolute;
            top: 0;
            left: -35%;
            width: 28%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255,255,255,0.55),
                transparent
            );
            opacity: 0;
            z-index: 2;
            pointer-events: none;
        }

        .input-shell:hover::before,
        .input-shell:focus-within::before {
            opacity: 1;
            animation: shineMove 1s ease;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 20px;
            color: #64748b;
            font-size: 15px;
            z-index: 4;
            transition: all 0.25s ease;
        }

        .form-control {
            width: 100%;
            border: 1px solid rgba(148,163,184,0.28);
            border-radius: 20px;
            padding: 15px 16px 15px 46px;
            background: rgba(255,255,255,0.92);
            outline: none;
            transition: all 0.28s ease;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.70);
            position: relative;
            z-index: 1;
        }

        .form-control:hover {
            border-color: rgba(245,158,11,0.55);
            background: #ffffff;
            box-shadow: 0 10px 24px rgba(245,158,11,0.10);
            transform: translateY(-1px);
        }

        .form-control:focus {
            border-color: #f59e0b;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(245,158,11,0.18), 0 14px 30px rgba(245,158,11,0.12);
        }

        .input-shell:focus-within .input-icon,
        .input-shell:hover .input-icon {
            color: #d97706;
            transform: scale(1.08);
        }

        .textarea-control {
            min-height: 150px;
            resize: vertical;
            padding-top: 16px;
        }

        .info-card {
            border-radius: 22px;
            padding: 16px;
            background: rgba(255,255,255,0.72);
            border: 1px solid rgba(148,163,184,0.18);
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 14px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .rating-card {
            border-radius: 24px;
            background: rgba(255,255,255,0.72);
            border: 1px solid rgba(148,163,184,0.18);
        }

        .star-btn {
            width: 58px;
            height: 58px;
            border-radius: 18px;
            border: 1px solid rgba(148,163,184,0.18);
            background: rgba(255,255,255,0.95);
            color: #cbd5e1;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            transition: all 0.22s ease;
            cursor: pointer;
        }

        .star-btn:hover {
            transform: translateY(-3px) scale(1.04);
        }

        .star-btn.active {
            color: #f59e0b;
            background: #fff7ed;
            border-color: rgba(245,158,11,0.32);
            box-shadow: 0 10px 24px rgba(245,158,11,0.14);
        }

        .rating-label-chip {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 14px;
            border-radius: 999px;
            background: #fff7ed;
            color: #b45309;
            font-weight: 700;
            font-size: 13px;
        }
    </style>
</head>
<body class="main-bg min-h-screen overflow-x-hidden">

    <div class="fixed top-10 left-8 sm:left-16 w-52 sm:w-64 h-52 sm:h-64 bg-sky-200/40 rounded-full blur-3xl floating-blob pointer-events-none"></div>
    <div class="fixed bottom-8 right-8 sm:right-16 w-64 sm:w-80 h-64 sm:h-80 bg-pink-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay:1s;"></div>
    <div class="fixed top-1/3 right-1/4 w-44 h-44 bg-indigo-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay:2s;"></div>

    <div class="min-h-screen flex flex-col lg:flex-row relative z-10">

        <aside class="w-full lg:w-72 shrink-0 bg-blue-900/90 text-white p-4 sm:p-6 shadow-2xl backdrop-blur-xl border-r border-white/10">
            <div class="mb-8 lg:mb-10">
                <div class="flex items-center gap-3 mb-3">
                    <div class="w-12 h-12 rounded-2xl bg-gradient-to-r from-blue-400 to-indigo-500 flex items-center justify-center shadow-lg pulse-glow">
                        <i class="fa-solid fa-user text-white text-xl"></i>
                    </div>
                    <div>
                        <h2 class="text-2xl font-extrabold">Patient Panel</h2>
                        <p class="text-sm text-blue-100/80">Clinic Management</p>
                    </div>
                </div>

                <div class="mt-5 bg-white/10 rounded-2xl px-4 py-3 border border-white/10">
                    <p class="text-sm text-blue-100/80">Welcome back</p>
                    <p class="font-bold text-lg text-white mt-1"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Patient" %></p>
                </div>
            </div>

            <nav class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-1 gap-3">
                <a href="/patient/dashboard" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-gauge-high"></i>
                    <span>Dashboard</span>
                </a>

                <a href="/patient/profile" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-user"></i>
                    <span>Profile</span>
                </a>

                <a href="/patient/doctors" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-user-doctor"></i>
                    <span>View Doctors</span>
                </a>

                <a href="/patient/my-appointments" class="sidebar-link flex items-center gap-3 bg-gradient-to-r from-blue-500 to-indigo-500 px-4 py-3 rounded-2xl font-semibold shadow-lg">
                    <i class="fa-solid fa-calendar-check"></i>
                    <span>My Appointments</span>
                </a>

                <a href="/patient/notifications" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-bell"></i>
                    <span>Notifications</span>
                </a>

                <a href="/patient/change-password" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-key"></i>
                    <span>Change Password</span>
                </a>

                <a href="/logout" class="sidebar-link col-span-2 sm:col-span-3 lg:col-span-1 flex items-center justify-center gap-3 mt-1 lg:mt-8 bg-gradient-to-r from-rose-500 to-red-500 px-4 py-3 rounded-2xl font-semibold shadow-lg">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    <span>Logout</span>
                </a>
            </nav>
        </aside>

        <main class="flex-1 p-4 sm:p-6 lg:p-8">

            <div class="hero-card glass-card soft-shadow rounded-[30px] p-6 sm:p-8 mb-8 fade-up">
                <div class="flex flex-col xl:flex-row xl:items-center xl:justify-between gap-6">
                    <div>
                        <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-800">Doctor Feedback</h1>
                        <p class="text-slate-600 mt-3 text-base sm:text-lg">
                            Share your rating and feedback based on your consultation experience with the doctor.
                        </p>

                        <div class="flex flex-wrap gap-3 mt-5">
                            <span class="mini-chip bg-amber-100 text-amber-700">
                                <i class="fa-solid fa-star"></i>
                                Rate Experience
                            </span>
                            <span class="mini-chip bg-blue-100 text-blue-700">
                                <i class="fa-solid fa-comments"></i>
                                Write Review
                            </span>
                            <span class="mini-chip bg-emerald-100 text-emerald-700">
                                <i class="fa-solid fa-heart"></i>
                                Help Improve Care
                            </span>
                        </div>
                    </div>

                    <div class="bg-gradient-to-r from-amber-500 to-orange-500 text-white px-7 py-6 rounded-[26px] shadow-xl min-w-[250px]">
                        <div class="flex items-center justify-between gap-4">
                            <div>
                                <p class="text-sm uppercase tracking-widest text-amber-100">Feedback</p>
                                <p class="text-3xl font-extrabold mt-2">Open</p>
                                <p class="mt-2 text-amber-100">Share your opinion</p>
                            </div>
                            <i class="fa-solid fa-star-half-stroke text-3xl text-white/90"></i>
                        </div>
                    </div>
                </div>
            </div>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert-box bg-green-50 border border-green-200 text-green-700 mb-5 fade-up">
                    <i class="fa-solid fa-circle-check text-lg mt-0.5"></i>
                    <div>
                        <p class="font-bold">Success</p>
                        <p><%= request.getAttribute("success") %></p>
                    </div>
                </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-box bg-red-50 border border-red-200 text-red-700 mb-5 fade-up">
                    <i class="fa-solid fa-circle-xmark text-lg mt-0.5"></i>
                    <div>
                        <p class="font-bold">Error</p>
                        <p><%= request.getAttribute("error") %></p>
                    </div>
                </div>
            <% } %>

            <div class="max-w-7xl mx-auto grid grid-cols-1 xl:grid-cols-3 gap-8">

                <div class="xl:col-span-1 fade-up">
                    <div class="glass-card soft-shadow rounded-[30px] p-6">
                        <div class="mb-6">
                            <h2 class="text-2xl font-extrabold text-slate-800">Appointment Summary</h2>
                            <p class="text-slate-500 mt-1">Review consultation details before submitting feedback.</p>
                        </div>

                        <div class="space-y-4">
                            <div class="info-card">
                                <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Doctor</p>
                                <p class="font-bold text-slate-800 mt-2">${appointment.doctor.user.name}</p>
                            </div>

                            <div class="info-card">
                                <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Specialization</p>
                                <p class="font-bold text-slate-800 mt-2">${appointment.doctor.specialization}</p>
                            </div>

                            <div class="info-card">
                                <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Date</p>
                                <p class="font-bold text-slate-800 mt-2">${appointment.appointmentDate}</p>
                            </div>

                            <div class="info-card">
                                <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Time</p>
                                <p class="font-bold text-slate-800 mt-2">${appointment.appointmentTime}</p>
                            </div>

                            <div class="info-card">
                                <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Status</p>
                                <div class="mt-2">
                                    <span class="status-pill bg-green-100 text-green-700">
                                        <i class="fa-solid fa-circle-check"></i>
                                        ${appointment.status}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="xl:col-span-2 fade-up">
                    <div class="glass-card soft-shadow rounded-[30px] p-5 sm:p-7 lg:p-8">
                        <div class="mb-6">
                            <h2 class="text-2xl font-extrabold text-slate-800">Submit Your Feedback</h2>
                            <p class="text-slate-500 mt-1">Give a rating and write a short comment about your experience.</p>
                        </div>

                        <form action="/patient/feedback" method="post" class="space-y-6">
                            <input type="hidden" name="appointmentId" value="${appointment.id}">
                            <input type="hidden" id="ratingValue" name="rating" value="${feedback.rating}">

                            <div class="rating-card p-6">
                                <label class="field-label">Rating</label>

                                <div class="flex flex-wrap gap-3 mb-4">
                                    <button type="button" class="star-btn" onclick="setRating(1)">
                                        <i class="fa-solid fa-star"></i>
                                    </button>
                                    <button type="button" class="star-btn" onclick="setRating(2)">
                                        <i class="fa-solid fa-star"></i>
                                    </button>
                                    <button type="button" class="star-btn" onclick="setRating(3)">
                                        <i class="fa-solid fa-star"></i>
                                    </button>
                                    <button type="button" class="star-btn" onclick="setRating(4)">
                                        <i class="fa-solid fa-star"></i>
                                    </button>
                                    <button type="button" class="star-btn" onclick="setRating(5)">
                                        <i class="fa-solid fa-star"></i>
                                    </button>
                                </div>

                                <div id="ratingText" class="rating-label-chip">
                                    <i class="fa-solid fa-star"></i>
                                    <span>Select rating</span>
                                </div>
                            </div>

                            <div>
                                <label class="field-label">Comment</label>
                                <div class="input-shell">
                                    <i class="fa-solid fa-comment-dots input-icon"></i>
                                    <textarea name="comment"
                                              rows="6"
                                              required
                                              class="form-control textarea-control"
                                              placeholder="Write your feedback here">${feedback.comment}</textarea>
                                </div>
                            </div>

                            <div class="pt-2 flex flex-wrap gap-4">
                                <button type="submit"
                                        class="shine-btn action-btn inline-flex items-center gap-2 bg-gradient-to-r from-amber-500 to-orange-500 text-white px-8 py-3 rounded-2xl shadow-lg font-semibold">
                                    <i class="fa-solid fa-star"></i>
                                    <span>Save Feedback</span>
                                </button>

                                <a href="/patient/my-appointments"
                                   class="shine-btn action-btn inline-flex items-center gap-2 bg-white text-slate-700 px-8 py-3 rounded-2xl border border-slate-200 shadow-sm font-semibold hover:bg-slate-50">
                                    <i class="fa-solid fa-arrow-left"></i>
                                    <span>Back</span>
                                </a>
                            </div>
                        </form>
                    </div>
                </div>

            </div>

        </main>
    </div>

    <script>
        const starButtons = document.querySelectorAll('.star-btn');
        const ratingValueInput = document.getElementById('ratingValue');
        const ratingText = document.getElementById('ratingText');

        function getRatingLabel(value) {
            if (value === 1) return 'Very Bad';
            if (value === 2) return 'Bad';
            if (value === 3) return 'Good';
            if (value === 4) return 'Very Good';
            if (value === 5) return 'Excellent';
            return 'Select rating';
        }

        function renderStars(value) {
            starButtons.forEach((btn, index) => {
                if (index < value) {
                    btn.classList.add('active');
                } else {
                    btn.classList.remove('active');
                }
            });

            ratingText.innerHTML =
                '<i class="fa-solid fa-star"></i><span>' + getRatingLabel(value) + '</span>';
        }

        function setRating(value) {
            ratingValueInput.value = value;
            renderStars(value);
        }

        document.addEventListener('DOMContentLoaded', function () {
            const existingRating = parseInt(ratingValueInput.value) || 0;
            renderStars(existingRating);
        });
    </script>

</body>
</html>