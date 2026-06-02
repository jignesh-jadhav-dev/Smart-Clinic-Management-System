<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Reports</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        .stat-card {
            transition: all 0.28s ease;
        }

        .stat-card:hover {
            transform: translateY(-7px);
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

        .chart-card {
            position: relative;
            overflow: hidden;
        }

        .chart-card::before {
            content: "";
            position: absolute;
            inset: 0;
            pointer-events: none;
            border-radius: 28px;
            background: linear-gradient(135deg, rgba(255,255,255,0.14), transparent 45%, rgba(255,255,255,0.10));
        }

        .chart-box {
            height: 360px;
            position: relative;
            z-index: 2;
        }
    </style>
</head>

<body class="main-bg min-h-screen overflow-x-hidden">

    <div class="fixed top-16 left-72 w-52 h-52 bg-blue-200/40 rounded-full blur-3xl floating-blob pointer-events-none"></div>
    <div class="fixed bottom-12 right-10 w-72 h-72 bg-purple-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay: 1s;"></div>
    <div class="fixed top-1/3 right-1/4 w-44 h-44 bg-emerald-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay: 2s;"></div>

    <div class="min-h-screen flex relative z-10">

        <aside class="w-72 bg-slate-900/90 text-white p-6 shadow-2xl backdrop-blur-xl border-r border-white/10">

            <div class="mb-10">
                <div class="flex items-center gap-3 mb-3">
                    <div class="w-12 h-12 rounded-2xl bg-gradient-to-r from-blue-400 to-indigo-500 flex items-center justify-center text-xl shadow-lg pulse-glow">
                        <i class="fa-solid fa-user-shield text-white"></i>
                    </div>
                    <div>
                        <h2 class="text-2xl font-extrabold tracking-wide">Admin Panel</h2>
                        <p class="text-sm text-slate-300">Clinic Management</p>
                    </div>
                </div>

                <div class="mt-5 bg-white/10 rounded-2xl px-4 py-3 border border-white/10">
                    <p class="text-sm text-slate-300">Welcome back</p>
                    <p class="font-bold text-lg text-white mt-1"><%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Admin" %></p>
                </div>
            </div>

            <nav class="space-y-3">
                <a href="/admin/dashboard"
                   class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-gauge-high"></i>
                    <span>Dashboard</span>
                </a>

                <a href="/admin/add-doctor"
                   class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-user-doctor"></i>
                    <span>Add Doctor</span>
                </a>

                <a href="/admin/add-patient"
                   class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-user-plus"></i>
                    <span>Add Patient</span>
                </a>
				
				<a href="/admin/specializations"
				                   class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
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


                <a href="/admin/reports"
                   class="sidebar-link flex items-center gap-3 bg-gradient-to-r from-blue-500 to-indigo-500 px-4 py-3 rounded-2xl font-semibold shadow-lg">
                    <i class="fa-solid fa-chart-column"></i>
                    <span>Reports</span>
                </a>

                <a href="/admin/notifications"
                   class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-bell"></i>
                    <span>Notifications</span>
                </a>

                <a href="/admin/change-password"
                   class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-key"></i>
                    <span>Change Password</span>
                </a>

                <a href="/logout"
                   class="sidebar-link flex items-center justify-center gap-3 mt-8 bg-gradient-to-r from-rose-500 to-red-500 hover:from-rose-600 hover:to-red-600 px-4 py-3 rounded-2xl font-semibold shadow-lg">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    <span>Logout</span>
                </a>
            </nav>
        </aside>

        <main class="flex-1 p-8">

            <div class="hero-card glass-card soft-shadow rounded-[28px] p-8 mb-8 fade-up">
                <div class="flex flex-col xl:flex-row xl:items-center xl:justify-between gap-6">
                    <div>
                        <h1 class="text-4xl font-extrabold text-slate-800 leading-tight">
                            Monthly Reports - ${reportYear}
                        </h1>
                        <p class="text-slate-600 mt-3 text-lg">
                            Track monthly appointment bookings, completed appointments and clinic performance.
                        </p>

                    </div>

                    <div class="flex flex-wrap gap-3">
                        <a href="/admin/export/appointments/csv"
                           class="shine-btn action-btn inline-flex items-center gap-2 bg-gradient-to-r from-emerald-500 to-green-500 text-white px-5 py-3 rounded-2xl shadow-lg font-semibold">
                            <i class="fa-solid fa-file-csv"></i>
                            <span>Export CSV</span>
                        </a>

                        <a href="/admin/export/appointments/pdf"
                           class="shine-btn action-btn inline-flex items-center gap-2 bg-gradient-to-r from-red-500 to-rose-500 text-white px-5 py-3 rounded-2xl shadow-lg font-semibold">
                            <i class="fa-solid fa-file-pdf"></i>
                            <span>Export PDF</span>
                        </a>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6 mb-8">

                <div class="stat-card glass-card soft-shadow rounded-[28px] p-6 fade-up">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-500 font-medium">Total Appointments</p>
                            <h2 class="text-5xl font-extrabold text-slate-800 mt-3">${totalAppointments}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-blue-100 flex items-center justify-center text-blue-700 text-2xl shadow">
                            <i class="fa-solid fa-calendar-check"></i>
                        </div>
                    </div>

                    <div class="mt-5 h-2 rounded-full bg-blue-100 overflow-hidden">
                        <div class="h-full w-[88%] bg-gradient-to-r from-blue-400 to-cyan-400 rounded-full"></div>
                    </div>
                </div>

                <div class="stat-card glass-card soft-shadow rounded-[28px] p-6 fade-up">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-500 font-medium">Completed</p>
                            <h2 class="text-5xl font-extrabold text-green-600 mt-3">${completedAppointments}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-green-100 flex items-center justify-center text-green-700 text-2xl shadow">
                            <i class="fa-solid fa-check-double"></i>
                        </div>
                    </div>

                    <div class="mt-5 h-2 rounded-full bg-green-100 overflow-hidden">
                        <div class="h-full w-[82%] bg-gradient-to-r from-green-400 to-emerald-400 rounded-full"></div>
                    </div>
                </div>

                <div class="stat-card glass-card soft-shadow rounded-[28px] p-6 fade-up">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-500 font-medium">Pending</p>
                            <h2 class="text-5xl font-extrabold text-amber-600 mt-3">${pendingAppointments}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-amber-100 flex items-center justify-center text-amber-700 text-2xl shadow">
                            <i class="fa-solid fa-hourglass-half"></i>
                        </div>
                    </div>

                    <div class="mt-5 h-2 rounded-full bg-amber-100 overflow-hidden">
                        <div class="h-full w-[70%] bg-gradient-to-r from-amber-400 to-orange-400 rounded-full"></div>
                    </div>
                </div>

                <div class="stat-card glass-card soft-shadow rounded-[28px] p-6 fade-up">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-500 font-medium">Cancelled</p>
                            <h2 class="text-5xl font-extrabold text-red-600 mt-3">${cancelledAppointments}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-red-100 flex items-center justify-center text-red-700 text-2xl shadow">
                            <i class="fa-solid fa-ban"></i>
                        </div>
                    </div>

                    <div class="mt-5 h-2 rounded-full bg-red-100 overflow-hidden">
                        <div class="h-full w-[45%] bg-gradient-to-r from-red-400 to-rose-400 rounded-full"></div>
                    </div>
                </div>

            </div>

            <div class="grid grid-cols-1 xl:grid-cols-2 gap-8">

                <div class="chart-card glass-card soft-shadow rounded-[28px] p-8 fade-up">
                    <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-6 relative z-10">
                        <div>
                            <h2 class="text-2xl font-extrabold text-slate-800">Monthly Appointment Bookings</h2>
                            <p class="text-slate-500 mt-1">Total appointment bookings month-wise.</p>
                        </div>

                        <span class="mini-chip bg-blue-100 text-blue-700">
                            <i class="fa-solid fa-chart-simple"></i>
                            Bar Chart
                        </span>
                    </div>

                    <div class="chart-box">
                        <canvas id="appointmentChart"></canvas>
                    </div>
                </div>

                <div class="chart-card glass-card soft-shadow rounded-[28px] p-8 fade-up">
                    <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-6 relative z-10">
                        <div>
                            <h2 class="text-2xl font-extrabold text-slate-800">Monthly Completed Appointments</h2>
                            <p class="text-slate-500 mt-1">Completed appointment trend month-wise.</p>
                        </div>

                        <span class="mini-chip bg-emerald-100 text-emerald-700">
                            <i class="fa-solid fa-chart-line"></i>
                            Line Chart
                        </span>
                    </div>

                    <div class="chart-box">
                        <canvas id="completedChart"></canvas>
                    </div>
                </div>

            </div>

        </main>
    </div>

<script>
    const monthLabels = ${monthLabelsJson};
    const appointmentCounts = ${appointmentCountsJson};
    const completedCounts = ${completedCountsJson};

    const appointmentCtx = document.getElementById('appointmentChart').getContext('2d');

    const appointmentGradient = appointmentCtx.createLinearGradient(0, 0, 0, 360);
    appointmentGradient.addColorStop(0, 'rgba(59,130,246,0.85)');
    appointmentGradient.addColorStop(1, 'rgba(99,102,241,0.25)');

    new Chart(appointmentCtx, {
        type: 'bar',
        data: {
            labels: monthLabels,
            datasets: [{
                label: 'Appointments',
                data: appointmentCounts,
                backgroundColor: appointmentGradient,
                borderColor: 'rgba(59,130,246,1)',
                borderWidth: 1,
                borderRadius: 16,
                borderSkipped: false,
                hoverBackgroundColor: 'rgba(37,99,235,0.85)'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            animation: {
                duration: 1500,
                easing: 'easeOutQuart'
            },
            plugins: {
                legend: {
                    display: true,
                    labels: {
                        color: '#334155',
                        font: {
                            size: 13,
                            weight: '700'
                        },
                        padding: 18
                    }
                },
                tooltip: {
                    backgroundColor: '#0f172a',
                    titleColor: '#ffffff',
                    bodyColor: '#e2e8f0',
                    padding: 12,
                    cornerRadius: 12
                }
            },
            scales: {
                x: {
                    ticks: {
                        color: '#475569',
                        font: {
                            weight: '700'
                        }
                    },
                    grid: {
                        display: false
                    }
                },
                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0,
                        color: '#475569'
                    },
                    grid: {
                        color: 'rgba(148, 163, 184, 0.18)'
                    }
                }
            }
        }
    });

    const completedCtx = document.getElementById('completedChart').getContext('2d');

    const completedGradient = completedCtx.createLinearGradient(0, 0, 0, 360);
    completedGradient.addColorStop(0, 'rgba(34,197,94,0.25)');
    completedGradient.addColorStop(1, 'rgba(34,197,94,0.02)');

    new Chart(completedCtx, {
        type: 'line',
        data: {
            labels: monthLabels,
            datasets: [{
                label: 'Completed',
                data: completedCounts,
                fill: true,
                borderColor: 'rgba(34,197,94,1)',
                backgroundColor: completedGradient,
                tension: 0.38,
                borderWidth: 4,
                pointRadius: 5,
                pointHoverRadius: 8,
                pointBackgroundColor: '#22c55e',
                pointBorderColor: '#ffffff',
                pointBorderWidth: 3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            animation: {
                duration: 1600,
                easing: 'easeOutQuart'
            },
            plugins: {
                legend: {
                    display: true,
                    labels: {
                        color: '#334155',
                        font: {
                            size: 13,
                            weight: '700'
                        },
                        padding: 18
                    }
                },
                tooltip: {
                    backgroundColor: '#0f172a',
                    titleColor: '#ffffff',
                    bodyColor: '#e2e8f0',
                    padding: 12,
                    cornerRadius: 12
                }
            },
            scales: {
                x: {
                    ticks: {
                        color: '#475569',
                        font: {
                            weight: '700'
                        }
                    },
                    grid: {
                        display: false
                    }
                },
                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0,
                        color: '#475569'
                    },
                    grid: {
                        color: 'rgba(148, 163, 184, 0.18)'
                    }
                }
            }
        }
    });
</script>

</body>
</html>