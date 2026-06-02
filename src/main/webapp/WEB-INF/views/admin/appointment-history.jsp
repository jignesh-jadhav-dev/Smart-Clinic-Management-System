<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Appointment History</title>
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

        .history-card {
            transition: all 0.28s ease;
        }

        .history-card:hover {
            transform: translateY(-4px);
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

        .value-box {
            border-radius: 20px;
            padding: 16px;
            border: 1px solid rgba(148, 163, 184, 0.18);
            background: rgba(255,255,255,0.72);
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

        <aside class="w-full lg:w-72 shrink-0 bg-slate-900/90 text-white p-4 sm:p-6 shadow-2xl backdrop-blur-xl border-r border-white/10">

            <div class="mb-8 lg:mb-10">
                <div class="flex items-center gap-3 mb-3">
                    <div class="w-11 h-11 sm:w-12 sm:h-12 rounded-2xl bg-gradient-to-r from-blue-400 to-indigo-500 flex items-center justify-center text-xl shadow-lg pulse-glow">
                        <i class="fa-solid fa-user-shield text-white"></i>
                    </div>
                    <div>
                        <h2 class="text-xl sm:text-2xl font-extrabold tracking-wide">Admin Panel</h2>
                        <p class="text-xs sm:text-sm text-slate-300">Clinic Management</p>
                    </div>
                </div>

                <div class="mt-4 bg-white/10 rounded-2xl px-4 py-3 border border-white/10">
                    <p class="text-xs sm:text-sm text-slate-300">Welcome back</p>
                    <p class="font-bold text-base sm:text-lg text-white mt-1"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Admin" %></p>
                </div>
            </div>

            <nav class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-1 gap-3">
                <a href="/admin/dashboard" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-gauge-high"></i>
                    <span class="text-sm sm:text-base">Dashboard</span>
                </a>

                <a href="/admin/add-doctor" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-user-doctor"></i>
                    <span class="text-sm sm:text-base">Add Doctor</span>
                </a>

                <a href="/admin/add-patient" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-user-plus"></i>
                    <span class="text-sm sm:text-base">Add Patient</span>
                </a>

                <a href="/admin/view-doctors" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-stethoscope"></i>
                    <span class="text-sm sm:text-base">View Doctors</span>
                </a>

                <a href="/admin/view-patients" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-users"></i>
                    <span class="text-sm sm:text-base">View Patients</span>
                </a>

                <a href="/admin/appointments" class="sidebar-link flex items-center gap-3 bg-gradient-to-r from-blue-500 to-indigo-500 px-4 py-3 rounded-2xl font-semibold shadow-lg">
                    <i class="fa-solid fa-calendar-check"></i>
                    <span class="text-sm sm:text-base">Appointments</span>
                </a>

                <a href="/admin/specializations" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-stethoscope"></i>
                    <span class="text-sm sm:text-base">Specializations</span>
                </a>

                <a href="/admin/reports" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-chart-column"></i>
                    <span class="text-sm sm:text-base">Reports</span>
                </a>

                <a href="/admin/notifications" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-bell"></i>
                    <span class="text-sm sm:text-base">Notifications</span>
                </a>

                <a href="/admin/change-password" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
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
                        <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-800">Appointment History</h1>
                        <p class="text-slate-600 mt-3 text-base sm:text-lg">
                            Track every appointment status change, date update and admin action.
                        </p>

                        <div class="flex flex-wrap gap-3 mt-5">
                            <span class="mini-chip bg-blue-100 text-blue-700">
                                <i class="fa-solid fa-clock-rotate-left"></i>
                                Change Timeline
                            </span>
                            <span class="mini-chip bg-emerald-100 text-emerald-700">
                                <i class="fa-solid fa-notes-medical"></i>
                                Audit Ready
                            </span>
                            <span class="mini-chip bg-purple-100 text-purple-700">
                                <i class="fa-solid fa-shield-halved"></i>
                                Secure Records
                            </span>
                        </div>
                    </div>

                    <a href="/admin/appointments"
                       class="shine-btn action-btn inline-flex items-center justify-center gap-2 bg-gradient-to-r from-blue-500 to-indigo-500 text-white px-6 py-3 rounded-2xl shadow-lg font-semibold w-full sm:w-auto">
                        <i class="fa-solid fa-arrow-left"></i>
                        <span>Back to Appointments</span>
                    </a>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4 mt-6">
                    <div class="value-box">
                        <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Patient</p>
                        <p class="text-slate-800 font-bold mt-2 word-safe">${appointment.patient.user.name}</p>
                    </div>

                    <div class="value-box">
                        <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Doctor</p>
                        <p class="text-slate-800 font-bold mt-2 word-safe">${appointment.doctor.user.name}</p>
                    </div>

                    <div class="value-box">
                        <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Date</p>
                        <p class="text-slate-800 font-bold mt-2 word-safe">${appointment.appointmentDate}</p>
                    </div>

                    <div class="value-box">
                        <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Time</p>
                        <p class="text-slate-800 font-bold mt-2 word-safe">${appointment.appointmentTime}</p>
                    </div>
                </div>
            </div>

            <div class="space-y-4 sm:space-y-5">
                <c:choose>
                    <c:when test="${not empty historyList}">
                        <c:forEach var="history" items="${historyList}">
                            <div class="history-card glass-card soft-shadow rounded-[24px] p-5 sm:p-6 fade-up">
                                <div class="flex flex-col gap-5">
                                    <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
                                        <div class="flex flex-col gap-3">
                                            <div class="flex flex-wrap items-center gap-3">
                                                <h2 class="text-xl sm:text-2xl font-extrabold text-slate-800 word-safe">${history.actionType}</h2>

                                                <span class="status-pill bg-blue-100 text-blue-700">
                                                    <i class="fa-solid fa-user-shield"></i>
                                                    ${history.changedByRole}
                                                </span>

                                                <span class="status-pill bg-slate-100 text-slate-700">
                                                    <i class="fa-solid fa-clock"></i>
                                                    ${history.createdAt}
                                                </span>
                                            </div>

                                            <p class="text-slate-500 text-sm">Appointment update record</p>
                                        </div>
                                    </div>

                                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-4">
                                        <div class="value-box">
                                            <div class="flex items-center gap-2 mb-3">
                                                <i class="fa-solid fa-arrow-rotate-left text-amber-600"></i>
                                                <h3 class="font-bold text-slate-800">Previous Details</h3>
                                            </div>

                                            <div class="space-y-2 text-slate-600 word-safe">
                                                <p><b>Old Status:</b> ${history.oldStatus}</p>
                                                <p><b>Old Date:</b> ${history.oldDate}</p>
                                                <p><b>Old Time:</b> ${history.oldTime}</p>
                                            </div>
                                        </div>

                                        <div class="value-box">
                                            <div class="flex items-center gap-2 mb-3">
                                                <i class="fa-solid fa-sparkles text-emerald-600"></i>
                                                <h3 class="font-bold text-slate-800">Updated Details</h3>
                                            </div>

                                            <div class="space-y-2 text-slate-600 word-safe">
                                                <p><b>New Status:</b> ${history.newStatus}</p>
                                                <p><b>New Date:</b> ${history.newDate}</p>
                                                <p><b>New Time:</b> ${history.newTime}</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="value-box">
                                        <div class="flex items-center gap-2 mb-3">
                                            <i class="fa-solid fa-note-sticky text-purple-600"></i>
                                            <h3 class="font-bold text-slate-800">Notes</h3>
                                        </div>
                                        <p class="text-slate-700 word-safe">${history.notes}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div class="glass-card soft-shadow rounded-[24px] p-8 sm:p-10 text-center fade-up">
                            <div class="w-20 h-20 mx-auto rounded-full bg-blue-100 text-blue-700 flex items-center justify-center text-3xl shadow-sm mb-4">
                                <i class="fa-solid fa-clock-rotate-left"></i>
                            </div>
                            <h2 class="text-2xl font-bold text-slate-700">No History Found</h2>
                            <p class="text-slate-500 mt-2">No appointment change history available for this record.</p>

                            <a href="/admin/appointments"
                               class="shine-btn action-btn inline-flex items-center gap-2 mt-5 bg-gradient-to-r from-blue-500 to-indigo-500 text-white px-6 py-3 rounded-2xl shadow-lg font-semibold">
                                <i class="fa-solid fa-arrow-left"></i>
                                <span>Back to Appointments</span>
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </main>
    </div>

</body>
</html>