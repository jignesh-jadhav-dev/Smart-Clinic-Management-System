<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:choose>
    <c:when test="${role == 'ADMIN'}">
        <c:set var="panelTitle" value="Admin Panel"/>
        <c:set var="sidebarBg" value="bg-slate-900/90"/>
        <c:set var="primaryBg" value="from-blue-500 to-indigo-500"/>
        <c:set var="dashboardUrl" value="/admin/dashboard"/>
        <c:set var="notificationReadUrlPrefix" value="/admin/notification/read/"/>
        <c:set var="rolePath" value="admin"/>
        <c:set var="iconClass" value="fa-user-shield"/>
    </c:when>
    <c:when test="${role == 'DOCTOR'}">
        <c:set var="panelTitle" value="Doctor Panel"/>
        <c:set var="sidebarBg" value="bg-emerald-900/90"/>
        <c:set var="primaryBg" value="from-green-500 to-emerald-500"/>
        <c:set var="dashboardUrl" value="/doctor/dashboard"/>
        <c:set var="notificationReadUrlPrefix" value="/doctor/notification/read/"/>
        <c:set var="rolePath" value="doctor"/>
        <c:set var="iconClass" value="fa-user-doctor"/>
    </c:when>
    <c:otherwise>
        <c:set var="panelTitle" value="Patient Panel"/>
        <c:set var="sidebarBg" value="bg-blue-900/90"/>
        <c:set var="primaryBg" value="from-blue-500 to-indigo-500"/>
        <c:set var="dashboardUrl" value="/patient/dashboard"/>
        <c:set var="notificationReadUrlPrefix" value="/patient/notification/read/"/>
        <c:set var="rolePath" value="patient"/>
        <c:set var="iconClass" value="fa-user"/>
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Notifications</title>
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

        .notification-card {
            transition: all 0.28s ease;
        }

        .notification-card:hover {
            transform: translateY(-4px);
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

        .status-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 12px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .word-safe {
            word-break: break-word;
            overflow-wrap: anywhere;
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
                        <p class="text-xs sm:text-sm text-white/70">Notification Center</p>
                    </div>
                </div>

                <div class="mt-4 bg-white/10 rounded-2xl px-4 py-3 border border-white/10">
                    <p class="text-xs sm:text-sm text-white/70">Unread Notifications</p>
                    <p class="font-bold text-base sm:text-lg text-white mt-1">${unreadCount}</p>
                </div>
            </div>

            <nav class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-1 gap-3">
                <a href="${dashboardUrl}" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-gauge-high"></i>
                    <span class="text-sm sm:text-base">Dashboard</span>
                </a>
				
				<a href="/admin/add-doctor"
				  class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
				                    <i class="fa-solid fa-user-doctor"></i>
				                    <span>Add Doctor</span>
				                </a>
								
								<a href="/admin/add-patient" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
								    <i class="fa-solid fa-user-plus"></i>
								    <span>Add Patient</span>
								</a>
								
								<a href="/admin/specializations" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
								    <i class="fa-solid fa-layer-group"></i>
								    <span>Specializations</span>
								</a>

				                <a href="/admin/view-doctors"
				                   class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
				                    <i class="fa-solid fa-stethoscope"></i>
				                    <span>View Doctors</span>
				                </a>

				                <a href="/admin/view-patients"
				                   class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
				                    <i class="fa-solid fa-users"></i>
				                    <span>View Patients</span>
				                </a>

				                <a href="/admin/appointments"
				                   class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
				                    <i class="fa-solid fa-calendar-check"></i>
				                    <span>Appointments</span>
				                </a>
								
								<a href="/admin/reports" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
								    <i class="fa-solid fa-chart-column"></i>
								    <span>Reports</span>
								</a>			
				
				
				

                <a href="/${rolePath}/notifications" class="sidebar-link flex items-center gap-3 bg-gradient-to-r ${primaryBg} px-4 py-3 rounded-2xl font-semibold shadow-lg">
                    <i class="fa-solid fa-bell"></i>
                    <span class="text-sm sm:text-base">Notifications</span>
                </a>

				<a href="/admin/change-password"
				                   class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
				                    <i class="fa-solid fa-key"></i>
				                    <span>Change Password</span>
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
                        <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-800">Notifications</h1>
                        <p class="text-slate-600 mt-3 text-base sm:text-lg">
                            All your recent updates, status changes and system alerts appear here.
                        </p>

                    </div>

                    <div class="w-full sm:w-auto">
                        <div class="flex items-center justify-center gap-3 px-5 py-4 rounded-2xl bg-white/70 shadow w-full sm:w-auto">
                            <i class="fa-solid fa-bell text-amber-500 text-xl"></i>
                            <span class="font-bold text-slate-700">${unreadCount} unread</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="space-y-4 sm:space-y-5">
                <c:choose>
                    <c:when test="${not empty notifications}">
                        <c:forEach var="notification" items="${notifications}">
                            <div class="notification-card glass-card soft-shadow rounded-[24px] p-5 sm:p-6 fade-up">
                                <div class="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-5">

                                    <div class="flex-1 min-w-0">
                                        <div class="flex flex-wrap items-center gap-3 mb-3">
                                            <h2 class="text-xl sm:text-2xl font-extrabold text-slate-800 word-safe">${notification.title}</h2>

                                            <c:if test="${notification.type == 'SUCCESS'}">
                                                <span class="status-pill bg-green-100 text-green-700">
                                                    <i class="fa-solid fa-circle-check"></i>
                                                    SUCCESS
                                                </span>
                                            </c:if>

                                            <c:if test="${notification.type == 'INFO'}">
                                                <span class="status-pill bg-blue-100 text-blue-700">
                                                    <i class="fa-solid fa-circle-info"></i>
                                                    INFO
                                                </span>
                                            </c:if>

                                            <c:if test="${notification.type == 'WARNING'}">
                                                <span class="status-pill bg-amber-100 text-amber-700">
                                                    <i class="fa-solid fa-triangle-exclamation"></i>
                                                    WARNING
                                                </span>
                                            </c:if>

                                            <c:if test="${notification.readFlag == false}">
                                                <span class="status-pill bg-red-100 text-red-700">
                                                    <i class="fa-solid fa-envelope"></i>
                                                    UNREAD
                                                </span>
                                            </c:if>

                                            <c:if test="${notification.readFlag == true}">
                                                <span class="status-pill bg-slate-200 text-slate-700">
                                                    <i class="fa-solid fa-envelope-open"></i>
                                                    READ
                                                </span>
                                            </c:if>
                                        </div>

                                        <p class="text-slate-600 leading-7 word-safe">${notification.message}</p>

                                        <p class="text-sm text-slate-400 mt-4 word-safe">
                                            <i class="fa-solid fa-clock mr-1"></i>
                                            ${notification.createdAt}
                                        </p>
                                    </div>

                                    <div class="w-full lg:w-auto">
                                        <c:if test="${notification.readFlag == false}">
                                            <a href="${notificationReadUrlPrefix}${notification.id}"
                                               class="shine-btn action-btn inline-flex items-center justify-center gap-2 bg-gradient-to-r ${primaryBg} text-white px-5 py-3 rounded-2xl shadow font-semibold w-full lg:w-auto">
                                                <i class="fa-solid fa-check"></i>
                                                <span>Mark Read</span>
                                            </a>
                                        </c:if>
                                    </div>

                                </div>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div class="glass-card soft-shadow rounded-[24px] p-8 sm:p-10 text-center fade-up">
                            <div class="w-20 h-20 mx-auto rounded-full bg-blue-100 text-blue-700 flex items-center justify-center text-3xl shadow-sm mb-4">
                                <i class="fa-solid fa-bell-slash"></i>
                            </div>
                            <h2 class="text-2xl font-bold text-slate-700">No Notifications Yet</h2>
                            <p class="text-slate-500 mt-2">New updates and alerts will appear here.</p>

                            <a href="${dashboardUrl}"
                               class="shine-btn action-btn inline-flex items-center gap-2 mt-5 bg-gradient-to-r ${primaryBg} text-white px-6 py-3 rounded-2xl shadow-lg font-semibold">
                                <i class="fa-solid fa-arrow-left"></i>
                                <span>Back to Dashboard</span>
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </main>
    </div>

</body>
</html>