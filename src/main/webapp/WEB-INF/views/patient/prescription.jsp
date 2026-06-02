<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Prescription</title>
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

        .info-card {
            border-radius: 22px;
            padding: 16px;
            background: rgba(255,255,255,0.72);
            border: 1px solid rgba(148,163,184,0.18);
        }

        .section-card {
            border-radius: 26px;
            background: rgba(255,255,255,0.72);
            border: 1px solid rgba(148,163,184,0.18);
            transition: all 0.28s ease;
        }

        .section-card:hover {
            transform: translateY(-3px);
        }

        .doctor-info-row {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #475569;
        }

        .doctor-info-icon {
            width: 34px;
            height: 34px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(59,130,246,0.10);
            color: #2563eb;
            flex-shrink: 0;
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

        .prescription-text {
            white-space: pre-line;
            line-height: 1.8;
            color: #334155;
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
                        <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-800">Prescription Details</h1>
                        <p class="text-slate-600 mt-3 text-base sm:text-lg">
                            View the doctor’s prescription, medicine details, advice and next visit information.
                        </p>

                        <div class="flex flex-wrap gap-3 mt-5">
                            <span class="mini-chip bg-blue-100 text-blue-700">
                                <i class="fa-solid fa-file-prescription"></i>
                                Prescription Record
                            </span>
                            <span class="mini-chip bg-emerald-100 text-emerald-700">
                                <i class="fa-solid fa-capsules"></i>
                                Medicine Details
                            </span>
                            <span class="mini-chip bg-purple-100 text-purple-700">
                                <i class="fa-solid fa-calendar-plus"></i>
                                Next Visit Info
                            </span>
                        </div>
                    </div>

                    <div class="bg-gradient-to-r from-purple-500 to-fuchsia-500 text-white px-7 py-6 rounded-[26px] shadow-xl min-w-[250px]">
                        <div class="flex items-center justify-between gap-4">
                            <div>
                                <p class="text-sm uppercase tracking-widest text-purple-100">Prescription</p>
                                <p class="text-3xl font-extrabold mt-2">Ready</p>
                                <p class="mt-2 text-purple-100">Doctor advice available</p>
                            </div>
                            <i class="fa-solid fa-notes-medical text-3xl text-white/90"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="max-w-7xl mx-auto grid grid-cols-1 xl:grid-cols-3 gap-8">

                <div class="xl:col-span-1 fade-up">
                    <div class="glass-card soft-shadow rounded-[30px] p-6">
                        <div class="mb-6">
                            <h2 class="text-2xl font-extrabold text-slate-800">Appointment Summary</h2>
                            <p class="text-slate-500 mt-1">Basic details of your completed visit.</p>
                        </div>

                        <div class="space-y-4">
                            <div class="info-card">
                                <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Patient</p>
                                <p class="font-bold text-slate-800 mt-2">${appointment.patient.user.name}</p>
                            </div>

                            <div class="info-card">
                                <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Doctor</p>
                                <p class="font-bold text-slate-800 mt-2">${appointment.doctor.user.name}</p>
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
                                <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Reason</p>
                                <p class="font-bold text-slate-800 mt-2">${appointment.reason}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="xl:col-span-2 fade-up">
                    <div class="glass-card soft-shadow rounded-[30px] p-5 sm:p-7 lg:p-8">

                        <div class="mb-6">
                            <h2 class="text-2xl font-extrabold text-slate-800">Doctor Prescription</h2>
                            <p class="text-slate-500 mt-1">Read medicine instructions and follow the advice carefully.</p>
                        </div>

                        <c:choose>
                            <c:when test="${not empty prescription}">

                                <div class="grid grid-cols-1 gap-5">
                                    <div class="section-card p-6">
                                        <div class="flex items-center gap-3 mb-4">
                                            <div class="w-12 h-12 rounded-2xl bg-purple-100 text-purple-700 flex items-center justify-center text-xl">
                                                <i class="fa-solid fa-capsules"></i>
                                            </div>
                                            <div>
                                                <h3 class="text-xl font-extrabold text-slate-800">Medicine</h3>
                                                <p class="text-slate-500 text-sm">Prescribed medicines and dosage</p>
                                            </div>
                                        </div>

                                        <div class="prescription-text bg-white/70 rounded-2xl p-5 border border-slate-200/70">
                                            ${prescription.medicine}
                                        </div>
                                    </div>

                                    <div class="section-card p-6">
                                        <div class="flex items-center gap-3 mb-4">
                                            <div class="w-12 h-12 rounded-2xl bg-emerald-100 text-emerald-700 flex items-center justify-center text-xl">
                                                <i class="fa-solid fa-heart-pulse"></i>
                                            </div>
                                            <div>
                                                <h3 class="text-xl font-extrabold text-slate-800">Advice</h3>
                                                <p class="text-slate-500 text-sm">Doctor instructions and care guidance</p>
                                            </div>
                                        </div>

                                        <div class="prescription-text bg-white/70 rounded-2xl p-5 border border-slate-200/70">
                                            ${prescription.advice}
                                        </div>
                                    </div>

                                    <div class="section-card p-6">
                                        <div class="flex items-center gap-3 mb-4">
                                            <div class="w-12 h-12 rounded-2xl bg-blue-100 text-blue-700 flex items-center justify-center text-xl">
                                                <i class="fa-solid fa-calendar-plus"></i>
                                            </div>
                                            <div>
                                                <h3 class="text-xl font-extrabold text-slate-800">Next Visit Date</h3>
                                                <p class="text-slate-500 text-sm">Suggested follow-up appointment date</p>
                                            </div>
                                        </div>

                                        <div class="bg-white/70 rounded-2xl p-5 border border-slate-200/70">
                                            <c:choose>
                                                <c:when test="${not empty prescription.nextVisitDate}">
                                                    <span class="status-pill bg-blue-100 text-blue-700">
                                                        <i class="fa-solid fa-calendar-day"></i>
                                                        ${prescription.nextVisitDate}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-slate-500">No next visit date suggested.</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>

                            </c:when>

                            <c:otherwise>
                                <div class="section-card p-10 text-center">
                                    <div class="w-20 h-20 mx-auto rounded-full bg-purple-100 text-purple-700 flex items-center justify-center text-3xl shadow-sm mb-4">
                                        <i class="fa-solid fa-file-prescription"></i>
                                    </div>
                                    <h3 class="text-2xl font-extrabold text-slate-800">No Prescription Found</h3>
                                    <p class="text-slate-500 mt-2">Prescription details are not available for this appointment yet.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <div class="mt-6 flex flex-wrap gap-4">
                            <a href="/patient/my-appointments"
                               class="shine-btn action-btn inline-flex items-center gap-2 bg-gradient-to-r from-blue-500 to-indigo-500 text-white px-6 py-3 rounded-2xl shadow-lg font-semibold">
                                <i class="fa-solid fa-arrow-left"></i>
                                <span>Back</span>
                            </a>

                            <a href="/patient/doctors"
                               class="shine-btn action-btn inline-flex items-center gap-2 bg-white text-slate-700 px-6 py-3 rounded-2xl border border-slate-200 shadow-sm font-semibold hover:bg-slate-50">
                                <i class="fa-solid fa-user-doctor"></i>
                                <span>Find Doctors</span>
                            </a>
                        </div>

                    </div>
                </div>

            </div>

        </main>
    </div>

</body>
</html>