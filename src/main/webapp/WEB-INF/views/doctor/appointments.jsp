<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor Appointments</title>
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
                box-shadow: 0 0 0 0 rgba(34,197,94,0.20);
            }
            50% {
                box-shadow: 0 0 0 12px rgba(34,197,94,0);
            }
        }

        .fade-up {
            animation: fadeUp 0.85s ease forwards;
        }

        .main-bg {
            background: linear-gradient(-45deg, #dcfce7, #dbeafe, #ede9fe, #fef3c7, #ecfdf5);
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

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 14px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .table-row {
            transition: all 0.24s ease;
        }

        .table-row:hover {
            background: rgba(255,255,255,0.70);
        }

        .table-wrap::-webkit-scrollbar {
            height: 8px;
        }

        .table-wrap::-webkit-scrollbar-thumb {
            background: rgba(148, 163, 184, 0.35);
            border-radius: 999px;
        }
    </style>
</head>
<body class="main-bg min-h-screen overflow-x-hidden">

    <div class="fixed top-10 left-8 sm:left-16 w-52 sm:w-64 h-52 sm:h-64 bg-green-200/40 rounded-full blur-3xl floating-blob pointer-events-none"></div>
    <div class="fixed bottom-8 right-8 sm:right-16 w-64 sm:w-80 h-64 sm:h-80 bg-blue-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay:1s;"></div>
    <div class="fixed top-1/3 right-1/4 w-44 h-44 bg-purple-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay:2s;"></div>

    <div class="min-h-screen flex flex-col lg:flex-row relative z-10">

        <aside class="w-full lg:w-72 shrink-0 bg-emerald-900/90 text-white p-4 sm:p-6 shadow-2xl backdrop-blur-xl border-r border-white/10">
            <div class="mb-8 lg:mb-10">
                <div class="flex items-center gap-3 mb-3">
                    <div class="w-12 h-12 rounded-2xl bg-gradient-to-r from-green-400 to-emerald-500 flex items-center justify-center shadow-lg pulse-glow">
                        <i class="fa-solid fa-user-doctor text-white text-xl"></i>
                    </div>
                    <div>
                        <h2 class="text-2xl font-extrabold">Doctor Panel</h2>
                        <p class="text-sm text-emerald-100/80">Clinic Management</p>
                    </div>
                </div>

                <div class="mt-5 bg-white/10 rounded-2xl px-4 py-3 border border-white/10">
                    <p class="text-sm text-emerald-100/80">Welcome back</p>
                    <p class="font-bold text-lg text-white mt-1"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Doctor" %></p>
                </div>
            </div>

            <nav class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-1 gap-3">
                <a href="/doctor/dashboard" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-gauge-high"></i>
                    <span>Dashboard</span>
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

                <a href="/doctor/appointments" class="sidebar-link flex items-center gap-3 bg-gradient-to-r from-green-500 to-emerald-500 px-4 py-3 rounded-2xl font-semibold shadow-lg">
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

                <a href="/doctor/change-password" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
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
                        <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-800">My Appointments</h1>
                        <p class="text-slate-600 mt-3 text-base sm:text-lg">
                            View assigned appointments, manage prescriptions and complete patient visits smoothly.
                        </p>

                    </div>

                    <div class="bg-gradient-to-r from-green-500 to-emerald-500 text-white px-7 py-6 rounded-[26px] shadow-xl min-w-[250px]">
                        <div class="flex items-center justify-between gap-4">
                            <div>
                                <p class="text-sm uppercase tracking-widest text-green-100">Doctor Task</p>
                                <p class="text-3xl font-extrabold mt-2">Active</p>
                                <p class="mt-2 text-green-100">Manage patient flow easily</p>
                            </div>
                            <i class="fa-solid fa-calendar-days text-3xl text-white/90"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="glass-card soft-shadow rounded-[30px] p-5 sm:p-6 fade-up">
                <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4 mb-6">
                    <div>
                        <h2 class="text-2xl font-extrabold text-slate-800">Appointment Table</h2>
                        <p class="text-slate-500 mt-1">Check patient details, status and available actions.</p>
                    </div>

                    <a href="/doctor/dashboard"
                       class="shine-btn action-btn inline-flex items-center gap-2 bg-white text-slate-700 px-5 py-3 rounded-2xl border border-slate-200 shadow-sm font-semibold hover:bg-slate-50">
                        <i class="fa-solid fa-arrow-left"></i>
                        <span>Back to Dashboard</span>
                    </a>
                </div>

                <div class="table-wrap overflow-x-auto rounded-2xl border border-slate-200/70">
                    <table class="w-full min-w-[1050px] border-collapse">
                        <thead>
                            <tr class="bg-slate-100/90">
                                <th class="text-left p-4 text-sm font-extrabold text-slate-700">Patient</th>
                                <th class="text-left p-4 text-sm font-extrabold text-slate-700">Date</th>
                                <th class="text-left p-4 text-sm font-extrabold text-slate-700">Time</th>
                                <th class="text-left p-4 text-sm font-extrabold text-slate-700">Reason</th>
                                <th class="text-left p-4 text-sm font-extrabold text-slate-700">Status</th>
                                <th class="text-left p-4 text-sm font-extrabold text-slate-700">Action</th>
                            </tr>
                        </thead>

                        <tbody class="bg-white/70">
                            <c:choose>
                                <c:when test="${not empty appointments}">
                                    <c:forEach var="appointment" items="${appointments}">
                                        <tr class="table-row border-b border-slate-200/70">
                                            <td class="p-4 font-semibold text-slate-800">
                                                <div class="flex items-center gap-3">
                                                    <div class="w-11 h-11 rounded-2xl bg-green-100 text-green-700 flex items-center justify-center shadow-sm">
                                                        <i class="fa-solid fa-user"></i>
                                                    </div>
                                                    <div>
                                                        <p class="font-bold text-slate-800">${appointment.patient.user.name}</p>
                                                        <p class="text-xs text-slate-500">Patient</p>
                                                    </div>
                                                </div>
                                            </td>

                                            <td class="p-4 text-slate-700">${appointment.appointmentDate}</td>
                                            <td class="p-4 text-slate-700">${appointment.appointmentTime}</td>
                                            <td class="p-4 text-slate-700 max-w-[240px]">${appointment.reason}</td>

                                            <td class="p-4">
                                                <c:if test="${appointment.status == 'APPROVED'}">
                                                    <span class="status-badge bg-green-100 text-green-700">
                                                        <i class="fa-solid fa-circle-check"></i>
                                                        APPROVED
                                                    </span>
                                                </c:if>

                                                <c:if test="${appointment.status == 'PENDING'}">
                                                    <span class="status-badge bg-amber-100 text-amber-700">
                                                        <i class="fa-solid fa-hourglass-half"></i>
                                                        PENDING
                                                    </span>
                                                </c:if>

                                                <c:if test="${appointment.status == 'REJECTED'}">
                                                    <span class="status-badge bg-red-100 text-red-700">
                                                        <i class="fa-solid fa-circle-xmark"></i>
                                                        REJECTED
                                                    </span>
                                                </c:if>

                                                <c:if test="${appointment.status == 'COMPLETED'}">
                                                    <span class="status-badge bg-blue-100 text-blue-700">
                                                        <i class="fa-solid fa-check-double"></i>
                                                        COMPLETED
                                                    </span>
                                                </c:if>

                                                <c:if test="${appointment.status == 'CANCELLED'}">
                                                    <span class="status-badge bg-slate-200 text-slate-700">
                                                        <i class="fa-solid fa-ban"></i>
                                                        CANCELLED
                                                    </span>
                                                </c:if>
                                            </td>

                                            <td class="p-4">
                                                <div class="flex flex-wrap gap-2">
                                                    <c:if test="${appointment.status == 'APPROVED'}">
                                                        <a href="/doctor/prescription/${appointment.id}"
                                                           class="shine-btn action-btn inline-flex items-center gap-2 bg-gradient-to-r from-purple-500 to-fuchsia-500 text-white px-4 py-2 rounded-xl shadow font-semibold text-sm">
                                                            <i class="fa-solid fa-file-prescription"></i>
                                                            <span>Add Prescription</span>
                                                        </a>

                                                        <a href="/doctor/appointment/complete/${appointment.id}"
                                                           class="shine-btn action-btn inline-flex items-center gap-2 bg-gradient-to-r from-blue-500 to-indigo-500 text-white px-4 py-2 rounded-xl shadow font-semibold text-sm">
                                                            <i class="fa-solid fa-circle-check"></i>
                                                            <span>Complete</span>
                                                        </a>
                                                    </c:if>

                                                    <c:if test="${appointment.status == 'COMPLETED'}">
                                                        <a href="/doctor/prescription/${appointment.id}"
                                                           class="shine-btn action-btn inline-flex items-center gap-2 bg-gradient-to-r from-slate-700 to-slate-800 text-white px-4 py-2 rounded-xl shadow font-semibold text-sm">
                                                            <i class="fa-solid fa-pen-to-square"></i>
                                                            <span>View/Edit</span>
                                                        </a>
                                                    </c:if>

                                                    <c:if test="${appointment.status == 'PENDING' || appointment.status == 'REJECTED' || appointment.status == 'CANCELLED'}">
                                                        <span class="inline-flex items-center gap-2 bg-slate-100 text-slate-500 px-4 py-2 rounded-xl font-semibold text-sm">
                                                            <i class="fa-solid fa-lock"></i>
                                                            <span>No Action</span>
                                                        </span>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="p-10 text-center">
                                            <div class="w-20 h-20 mx-auto rounded-full bg-green-100 text-green-700 flex items-center justify-center text-3xl shadow-sm mb-4">
                                                <i class="fa-solid fa-calendar-check"></i>
                                            </div>
                                            <h3 class="text-2xl font-extrabold text-slate-800">No Appointments Found</h3>
                                            <p class="text-slate-500 mt-2">No appointments are assigned right now.</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>
    </div>

</body>
</html>