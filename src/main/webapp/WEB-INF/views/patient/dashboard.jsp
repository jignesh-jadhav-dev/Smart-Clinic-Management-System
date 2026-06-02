<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Dashboard</title>
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

        .stat-card {
            transition: all 0.28s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-6px);
        }

        .stat-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: -35%;
            width: 28%;
            height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255,255,255,0.30),
                transparent
            );
            opacity: 0;
        }

        .stat-card:hover::before {
            opacity: 1;
            animation: shineMove 0.95s ease;
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

        .quick-card {
            transition: all 0.28s ease;
        }

        .quick-card:hover {
            transform: translateY(-4px);
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
                <a href="/patient/dashboard" class="sidebar-link flex items-center gap-3 bg-gradient-to-r from-blue-500 to-indigo-500 px-4 py-3 rounded-2xl font-semibold shadow-lg">
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

                <a href="/patient/my-appointments" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
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
                        <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-800">Patient Dashboard</h1>
                        <p class="text-slate-600 mt-3 text-base sm:text-lg">
                            Track your appointments, approvals, completed visits and health updates in one smart place.
                        </p>

                    </div>

                    <div class="bg-gradient-to-r from-blue-500 to-indigo-500 text-white px-7 py-6 rounded-[26px] shadow-xl min-w-[260px]">
                        <div class="flex items-center justify-between gap-4">
                            <div>
                                <p class="text-sm uppercase tracking-widest text-blue-100">Patient Access</p>
                                <p class="text-3xl font-extrabold mt-2">Active</p>
                                <p class="mt-2 text-blue-100">Health updates at one place</p>
                            </div>
                            <i class="fa-solid fa-heart-pulse text-3xl text-white/90"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-5 gap-6 mb-8">

                <div class="stat-card glass-card soft-shadow rounded-[28px] p-6 fade-up">
                    <div class="flex items-center justify-between gap-4">
                        <div>
                            <p class="text-slate-500 font-medium">Total</p>
                            <h2 class="text-5xl font-extrabold text-slate-800 mt-3">${totalAppointments}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-slate-100 flex items-center justify-center text-slate-700 text-2xl shadow">
                            <i class="fa-solid fa-layer-group"></i>
                        </div>
                    </div>
                    <div class="mt-5 h-2 rounded-full bg-slate-100 overflow-hidden">
                        <div class="h-full w-[88%] bg-gradient-to-r from-slate-400 to-slate-600 rounded-full"></div>
                    </div>
                </div>

                <div class="stat-card glass-card soft-shadow rounded-[28px] p-6 fade-up">
                    <div class="flex items-center justify-between gap-4">
                        <div>
                            <p class="text-slate-500 font-medium">Pending</p>
                            <h2 class="text-5xl font-extrabold text-amber-600 mt-3">${pendingAppointments}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-amber-100 flex items-center justify-center text-amber-700 text-2xl shadow">
                            <i class="fa-solid fa-hourglass-half"></i>
                        </div>
                    </div>
                    <div class="mt-5 h-2 rounded-full bg-amber-100 overflow-hidden">
                        <div class="h-full w-[72%] bg-gradient-to-r from-amber-400 to-orange-400 rounded-full"></div>
                    </div>
                </div>

                <div class="stat-card glass-card soft-shadow rounded-[28px] p-6 fade-up">
                    <div class="flex items-center justify-between gap-4">
                        <div>
                            <p class="text-slate-500 font-medium">Approved</p>
                            <h2 class="text-5xl font-extrabold text-green-600 mt-3">${approvedAppointments}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-green-100 flex items-center justify-center text-green-700 text-2xl shadow">
                            <i class="fa-solid fa-circle-check"></i>
                        </div>
                    </div>
                    <div class="mt-5 h-2 rounded-full bg-green-100 overflow-hidden">
                        <div class="h-full w-[84%] bg-gradient-to-r from-green-400 to-emerald-400 rounded-full"></div>
                    </div>
                </div>

                <div class="stat-card glass-card soft-shadow rounded-[28px] p-6 fade-up">
                    <div class="flex items-center justify-between gap-4">
                        <div>
                            <p class="text-slate-500 font-medium">Completed</p>
                            <h2 class="text-5xl font-extrabold text-blue-600 mt-3">${completedAppointments}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-blue-100 flex items-center justify-center text-blue-700 text-2xl shadow">
                            <i class="fa-solid fa-check-double"></i>
                        </div>
                    </div>
                    <div class="mt-5 h-2 rounded-full bg-blue-100 overflow-hidden">
                        <div class="h-full w-[78%] bg-gradient-to-r from-blue-400 to-indigo-400 rounded-full"></div>
                    </div>
                </div>

                <div class="stat-card glass-card soft-shadow rounded-[28px] p-6 fade-up">
                    <div class="flex items-center justify-between gap-4">
                        <div>
                            <p class="text-slate-500 font-medium">Cancelled</p>
                            <h2 class="text-5xl font-extrabold text-red-600 mt-3">${cancelledAppointments}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-red-100 flex items-center justify-center text-red-700 text-2xl shadow">
                            <i class="fa-solid fa-ban"></i>
                        </div>
                    </div>
                    <div class="mt-5 h-2 rounded-full bg-red-100 overflow-hidden">
                        <div class="h-full w-[60%] bg-gradient-to-r from-red-400 to-rose-400 rounded-full"></div>
                    </div>
                </div>

            </div>

            <div class="glass-card soft-shadow rounded-[30px] p-6 sm:p-8 fade-up">
                <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4 mb-6">
                    <div>
                        <h2 class="text-2xl font-extrabold text-slate-800">Quick Actions</h2>
                        <p class="text-slate-500 mt-1">Quickly access your most useful patient features.</p>
                    </div>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4">
                    <a href="/patient/doctors"
                       class="quick-card shine-btn flex items-center gap-3 bg-gradient-to-r from-blue-500 to-indigo-500 text-white px-6 py-4 rounded-2xl shadow-lg font-semibold">
                        <i class="fa-solid fa-user-doctor text-lg"></i>
                        <span>Find Doctors</span>
                    </a>

                    <a href="/patient/my-appointments"
                       class="quick-card shine-btn flex items-center gap-3 bg-gradient-to-r from-green-500 to-emerald-500 text-white px-6 py-4 rounded-2xl shadow-lg font-semibold">
                        <i class="fa-solid fa-calendar-check text-lg"></i>
                        <span>My Appointments</span>
                    </a>

                    <a href="/patient/profile"
                       class="quick-card shine-btn flex items-center gap-3 bg-gradient-to-r from-purple-500 to-fuchsia-500 text-white px-6 py-4 rounded-2xl shadow-lg font-semibold">
                        <i class="fa-solid fa-user text-lg"></i>
                        <span>My Profile</span>
                    </a>
                </div>
            </div>

        </main>
    </div>

</body>
</html>