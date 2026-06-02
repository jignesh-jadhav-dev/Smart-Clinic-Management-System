<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:choose>
    <c:when test="${role == 'ADMIN'}">
        <c:set var="panelTitle" value="Admin Panel"/>
        <c:set var="sidebarBg" value="bg-slate-900/90"/>
        <c:set var="primaryBg" value="from-blue-500 to-indigo-500"/>
        <c:set var="dashboardUrl" value="/admin/dashboard"/>
        <c:set var="profileUrl" value=""/>
        <c:set var="notificationsUrl" value="/admin/notifications"/>
        <c:set var="changePasswordUrl" value="/admin/change-password"/>
        <c:set var="iconClass" value="fa-user-shield"/>
    </c:when>

    <c:when test="${role == 'DOCTOR'}">
        <c:set var="panelTitle" value="Doctor Panel"/>
        <c:set var="sidebarBg" value="bg-emerald-900/90"/>
        <c:set var="primaryBg" value="from-green-500 to-emerald-500"/>
        <c:set var="dashboardUrl" value="/doctor/dashboard"/>
        <c:set var="profileUrl" value="/doctor/profile"/>
        <c:set var="notificationsUrl" value="/doctor/notifications"/>
        <c:set var="changePasswordUrl" value="/doctor/change-password"/>
        <c:set var="iconClass" value="fa-user-doctor"/>
    </c:when>

    <c:otherwise>
        <c:set var="panelTitle" value="Patient Panel"/>
        <c:set var="sidebarBg" value="bg-blue-900/90"/>
        <c:set var="primaryBg" value="from-blue-500 to-indigo-500"/>
        <c:set var="dashboardUrl" value="/patient/dashboard"/>
        <c:set var="profileUrl" value="/patient/profile"/>
        <c:set var="notificationsUrl" value="/patient/notifications"/>
        <c:set var="changePasswordUrl" value="/patient/change-password"/>
        <c:set var="iconClass" value="fa-user"/>
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
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
            0% { transform: translateX(-140%) skewX(-20deg); }
            100% { transform: translateX(220%) skewX(-20deg); }
        }

        @keyframes pulseGlow {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(59, 130, 246, 0.20);
            }
            50% {
                box-shadow: 0 0 0 12px rgba(59, 130, 246, 0);
            }
        }

        .fade-up {
            animation: fadeUp 0.85s ease forwards;
        }

        .main-bg {
            background: linear-gradient(-45deg, #eef7ff, #f7f5ff, #effdf7, #fff8eb);
            background-size: 400% 400%;
            animation: gradientMove 12s ease infinite;
        }

        .glass-card {
            background: rgba(255,255,255,0.80);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255,255,255,0.50);
        }

        .soft-shadow {
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.10);
        }

        .floating-blob {
            animation: floatY 6s ease-in-out infinite;
        }

        .sidebar-link {
            transition: all 0.28s ease;
        }

        .sidebar-link:hover {
            transform: translateX(8px);
        }

        .pulse-glow {
            animation: pulseGlow 2.6s infinite;
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
            animation: shineMove 4.5s linear infinite;
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
            width: 30%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255,255,255,0.35),
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
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-size: 15px;
            z-index: 2;
            transition: all 0.25s ease;
        }

        .form-control {
            width: 100%;
            border: 1px solid rgba(148, 163, 184, 0.28);
            border-radius: 20px;
            padding: 15px 16px 15px 46px;
            background: rgba(255,255,255,0.92);
            outline: none;
            transition: all 0.28s ease;
            box-shadow: inset 0 1px 0 rgba(255,255,255,0.70);
        }

        .form-control:hover {
            border-color: rgba(96, 165, 250, 0.45);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.08);
        }

        .form-control:focus {
            border-color: #60a5fa;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(96, 165, 250, 0.18), 0 12px 30px rgba(59, 130, 246, 0.10);
        }

        .input-shell:focus-within .input-icon {
            color: #2563eb;
            transform: translateY(-50%) scale(1.08);
        }

        .tip-card {
            border-radius: 24px;
            padding: 20px;
            background: rgba(255,255,255,0.72);
            border: 1px solid rgba(148, 163, 184, 0.18);
        }
    </style>
</head>
<body class="main-bg min-h-screen overflow-x-hidden">

    <div class="fixed top-16 left-72 w-52 h-52 bg-blue-200/40 rounded-full blur-3xl floating-blob pointer-events-none"></div>
    <div class="fixed bottom-12 right-10 w-72 h-72 bg-purple-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay: 1s;"></div>
    <div class="fixed top-1/3 right-1/4 w-44 h-44 bg-emerald-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay: 2s;"></div>

    <div class="min-h-screen flex flex-col lg:flex-row relative z-10">

		<aside class="w-full lg:w-72 shrink-0 ${sidebarBg} text-white p-4 sm:p-6 shadow-2xl backdrop-blur-xl border-r border-white/10">
		            <div class="mb-8 lg:mb-10">
		                <div class="flex items-center gap-3 mb-3">
		                    <div class="w-11 h-11 sm:w-12 sm:h-12 rounded-2xl bg-gradient-to-r ${primaryBg} flex items-center justify-center shadow-lg pulse-glow">
		                        <i class="fa-solid ${iconClass} text-white text-xl"></i>
		                    </div>
		                    <div>
		                        <h2 class="text-xl sm:text-2xl font-extrabold">${panelTitle}</h2>
		                        <p class="text-xs sm:text-sm text-white/70">Clinic Management</p>
		                    </div>
		                </div>

						<div class="mt-5 bg-white/10 rounded-2xl px-4 py-3 border border-white/10">
						                    <p class="text-sm text-slate-300">Welcome back</p>
						                    <p class="font-bold text-lg text-white mt-1"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Admin" %></p>
						                </div>
		            </div>

            <nav class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-1 gap-3">
                
				<a href="${dashboardUrl}" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
				                    <i class="fa-solid fa-gauge-high"></i>
				                    <span class="text-sm sm:text-base">Dashboard</span>
				                </a>
								
								<a href="/doctor/profile" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
								                    <i class="fa-solid fa-user"></i>
								                    <span>Profile</span>
								                </a>

								                <a href="/doctor/availability" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
								                    <i class="fa-solid fa-clock"></i>
								                    <span>Availability</span>
								                </a>

								                <a href="/doctor/leaves" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
								                    <i class="fa-solid fa-calendar-xmark"></i>
								                    <span>Leaves</span>
								                </a>

								                <a href="/doctor/appointments" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
								                    <i class="fa-solid fa-calendar-check"></i>
								                    <span>Appointments</span>
								                </a>

								                <a href="/doctor/feedbacks" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
								                    <i class="fa-solid fa-star"></i>
								                    <span>Feedbacks</span>
								                </a>

								                <a href="/doctor/notifications" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
								                    <i class="fa-solid fa-bell"></i>
								                    <span>Notifications</span>
								                </a>

                <a href="${changePasswordUrl}" class="sidebar-link flex items-center gap-3 bg-gradient-to-r ${primaryBg} px-4 py-3 rounded-2xl font-semibold shadow-lg">
                    <i class="fa-solid fa-key"></i>
                    <span class="text-sm sm:text-base">Change Password</span>
                </a>

                <a href="/logout" class="sidebar-link col-span-2 sm:col-span-3 lg:col-span-1 flex items-center justify-center gap-3 mt-1 lg:mt-8 bg-gradient-to-r from-rose-500 to-red-500 hover:from-rose-600 hover:to-red-600 px-4 py-3 rounded-2xl font-semibold shadow-lg">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    <span class="text-sm sm:text-base">Logout</span>
                </a>
            </nav>
        </aside>

        <main class="flex-1 p-4 sm:p-6 lg:p-8">

            <div class="hero-card glass-card soft-shadow rounded-[28px] p-5 sm:p-7 lg:p-8 mb-6 sm:mb-8 fade-up">
                <div class="flex flex-col xl:flex-row xl:items-center xl:justify-between gap-6">
                    <div>
                        <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-800">Change Password</h1>
                        <p class="text-slate-600 mt-3 text-base sm:text-lg">
                            Update your account password securely and keep your profile protected.
                        </p>

                    </div>

                    <div class="tip-card w-full xl:w-[320px]">
                        <div class="flex items-start gap-3">
                            <div class="w-11 h-11 rounded-2xl bg-amber-100 text-amber-700 flex items-center justify-center shadow-sm shrink-0">
                                <i class="fa-solid fa-lightbulb"></i>
                            </div>
                            <div>
                                <h3 class="font-extrabold text-slate-800">Security Tip</h3>
                                <p class="text-slate-600 text-sm mt-2">
                                    Use a strong password with letters, numbers and special characters.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="glass-card soft-shadow rounded-[28px] p-5 sm:p-7 lg:p-8 max-w-3xl mx-auto fade-up">

                <div class="flex items-center gap-3 mb-6">
                    <div class="w-14 h-14 rounded-2xl bg-blue-100 flex items-center justify-center text-blue-700 text-2xl shadow">
                        <i class="fa-solid fa-lock"></i>
                    </div>
                    <div>
                        <h2 class="text-2xl font-extrabold text-slate-800">Password Update Form</h2>
                        <p class="text-slate-500">Enter your current and new password carefully.</p>
                    </div>
                </div>

                <c:if test="${not empty success}">
                    <div class="alert-box bg-green-50 border border-green-200 text-green-700 mb-5">
                        <i class="fa-solid fa-circle-check text-lg mt-0.5"></i>
                        <div>
                            <p class="font-bold">Success</p>
                            <p>${success}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert-box bg-red-50 border border-red-200 text-red-700 mb-5">
                        <i class="fa-solid fa-circle-xmark text-lg mt-0.5"></i>
                        <div>
                            <p class="font-bold">Error</p>
                            <p>${error}</p>
                        </div>
                    </div>
                </c:if>

                <form action="${changePasswordUrl}" method="post" class="space-y-5">

                    <div>
                        <label class="field-label">Current Password</label>
                        <div class="input-shell">
                            <i class="fa-solid fa-unlock-keyhole input-icon"></i>
                            <input type="password"
                                   name="currentPassword"
                                   required
                                   class="form-control"
                                   placeholder="Enter current password">
                        </div>
                    </div>

                    <div>
                        <label class="field-label">New Password</label>
                        <div class="input-shell">
                            <i class="fa-solid fa-lock input-icon"></i>
                            <input type="password"
                                   name="newPassword"
                                   required
                                   class="form-control"
                                   placeholder="Enter new password">
                        </div>
                    </div>

                    <div>
                        <label class="field-label">Confirm New Password</label>
                        <div class="input-shell">
                            <i class="fa-solid fa-shield-heart input-icon"></i>
                            <input type="password"
                                   name="confirmPassword"
                                   required
                                   class="form-control"
                                   placeholder="Confirm new password">
                        </div>
                    </div>

                    <div class="pt-2 flex flex-wrap gap-4">
                        <button type="submit"
                                class="shine-btn action-btn inline-flex items-center gap-2 bg-gradient-to-r ${primaryBg} text-white px-8 py-3 rounded-2xl shadow-lg font-semibold w-full sm:w-auto justify-center">
                            <i class="fa-solid fa-floppy-disk"></i>
                            <span>Update Password</span>
                        </button>

                        <a href="${dashboardUrl}"
                           class="shine-btn action-btn inline-flex items-center gap-2 bg-white text-slate-700 px-8 py-3 rounded-2xl border border-slate-200 shadow-sm font-semibold hover:bg-slate-50 w-full sm:w-auto justify-center">
                            <i class="fa-solid fa-arrow-left"></i>
                            <span>Back</span>
                        </a>
                    </div>

                </form>
            </div>
        </main>

    </div>

</body>
</html>