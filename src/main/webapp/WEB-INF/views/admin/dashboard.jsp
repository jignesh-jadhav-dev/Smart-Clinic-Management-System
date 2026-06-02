<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
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
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        @keyframes pulseGlow {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(59, 130, 246, 0.22);
            }
            50% {
                box-shadow: 0 0 0 12px rgba(59, 130, 246, 0);
            }
        }

        .fade-up {
            animation: fadeUp 0.9s ease forwards;
        }

        .fade-delay-1 { animation-delay: 0.1s; opacity: 0; }
        .fade-delay-2 { animation-delay: 0.2s; opacity: 0; }
        .fade-delay-3 { animation-delay: 0.3s; opacity: 0; }
        .fade-delay-4 { animation-delay: 0.4s; opacity: 0; }
        .fade-delay-5 { animation-delay: 0.5s; opacity: 0; }
        .fade-delay-6 { animation-delay: 0.6s; opacity: 0; }
        .fade-delay-7 { animation-delay: 0.7s; opacity: 0; }
        .fade-delay-8 { animation-delay: 0.8s; opacity: 0; }
        .fade-delay-9 { animation-delay: 0.9s; opacity: 0; }

        .glass-card {
            background: rgba(255, 255, 255, 0.80);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.45);
        }

        .floating-blob {
            animation: floatY 6s ease-in-out infinite;
        }

        .main-bg {
            background: linear-gradient(-45deg, #eef7ff, #f7f5ff, #effdf7, #fff8eb);
            background-size: 400% 400%;
            animation: gradientMove 12s ease infinite;
        }

        .sidebar-link {
            transition: all 0.28s ease;
        }

        .sidebar-link:hover {
            transform: translateX(8px);
        }

        .soft-shadow {
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.10);
        }

        .pulse-glow {
            animation: pulseGlow 2.6s infinite;
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
                   class="sidebar-link flex items-center gap-3 bg-gradient-to-r from-blue-500 to-indigo-500 px-4 py-3 rounded-2xl font-semibold shadow-lg">
                    <i class="fa-solid fa-gauge-high"></i>
                    <span>Dashboard</span>
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
				
				<a href="/admin/notifications" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
				    <i class="fa-solid fa-bell"></i>
				    <span>Notifications</span>
				</a>
				
				<a href="/admin/change-password" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
				     <i class="fa-solid fa-key"></i>
					 <span>Change Password</span>
				</a>

                <a href="/logout"
                   class="sidebar-link flex items-center justify-center gap-3 mt-8 bg-gradient-to-r from-rose-500 to-red-500 hover:from-rose-600 hover:to-red-600 px-4 py-3 rounded-2xl font-semibold text-center shadow-lg">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    <span>Logout</span>
                </a>
            </nav>
        </aside>

        <main class="flex-1 p-8">

            <div class="glass-card soft-shadow rounded-[28px] p-8 mb-8 fade-up">
                <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">
                    <div>
                        <h1 class="text-4xl font-extrabold text-slate-800 leading-tight">
                            Smart Clinic Dashboard
                        </h1>
                        <p class="text-slate-600 mt-3 text-lg">
                            Doctors, patients, appointments and reports all in one dashboard.
                        </p>

                    </div>

                    <div class="bg-gradient-to-r from-blue-500 via-indigo-500 to-purple-500 text-white px-7 py-6 rounded-[26px] shadow-xl min-w-[260px]">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-sm uppercase tracking-widest text-blue-100">Quick Summary</p>
                                <p class="text-4xl font-extrabold mt-2">${totalAppointments}</p>
                                <p class="mt-2 text-blue-100">Total appointments recorded</p>
                            </div>
                            <i class="fa-solid fa-chart-line text-3xl text-white/90"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6 mb-8">

                <div class="fade-up fade-delay-1 glass-card soft-shadow rounded-[28px] p-6 hover:-translate-y-2 transition duration-300">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-500 font-medium">Total Doctors</p>
                            <h2 class="text-5xl font-extrabold text-slate-800 mt-3">${totalDoctors}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-blue-100 flex items-center justify-center text-2xl text-blue-700 shadow">
                            <i class="fa-solid fa-user-doctor"></i>
                        </div>
                    </div>
                    <div class="mt-5 h-2 rounded-full bg-blue-100 overflow-hidden">
                        <div class="h-full w-[85%] bg-gradient-to-r from-blue-400 to-cyan-400 rounded-full"></div>
                    </div>
                </div>

                <div class="fade-up fade-delay-2 glass-card soft-shadow rounded-[28px] p-6 hover:-translate-y-2 transition duration-300">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-500 font-medium">Total Patients</p>
                            <h2 class="text-5xl font-extrabold text-slate-800 mt-3">${totalPatients}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-emerald-100 flex items-center justify-center text-2xl text-emerald-700 shadow">
                            <i class="fa-solid fa-users"></i>
                        </div>
                    </div>
                    <div class="mt-5 h-2 rounded-full bg-emerald-100 overflow-hidden">
                        <div class="h-full w-[90%] bg-gradient-to-r from-emerald-400 to-green-400 rounded-full"></div>
                    </div>
                </div>

                <div class="fade-up fade-delay-3 glass-card soft-shadow rounded-[28px] p-6 hover:-translate-y-2 transition duration-300">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-500 font-medium">Appointments</p>
                            <h2 class="text-5xl font-extrabold text-slate-800 mt-3">${totalAppointments}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-purple-100 flex items-center justify-center text-2xl text-purple-700 shadow">
                            <i class="fa-solid fa-calendar-check"></i>
                        </div>
                    </div>
                    <div class="mt-5 h-2 rounded-full bg-purple-100 overflow-hidden">
                        <div class="h-full w-[88%] bg-gradient-to-r from-purple-400 to-fuchsia-400 rounded-full"></div>
                    </div>
                </div>

                <div class="fade-up fade-delay-4 glass-card soft-shadow rounded-[28px] p-6 hover:-translate-y-2 transition duration-300">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-slate-500 font-medium">Feedbacks</p>
                            <h2 class="text-5xl font-extrabold text-slate-800 mt-3">${totalFeedbacks}</h2>
                        </div>
                        <div class="w-16 h-16 rounded-2xl bg-amber-100 flex items-center justify-center text-2xl text-amber-700 shadow">
                            <i class="fa-solid fa-star"></i>
                        </div>
                    </div>
                    <div class="mt-5 h-2 rounded-full bg-amber-100 overflow-hidden">
                        <div class="h-full w-[78%] bg-gradient-to-r from-amber-400 to-orange-400 rounded-full"></div>
                    </div>
                </div>

            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-5 gap-5 mb-8">

                <div class="fade-up fade-delay-5 glass-card soft-shadow rounded-[24px] p-5 hover:scale-[1.02] transition duration-300">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 rounded-xl bg-yellow-100 flex items-center justify-center text-yellow-700 text-xl">
                            <i class="fa-solid fa-hourglass-half"></i>
                        </div>
                        <div>
                            <p class="text-slate-500 text-sm">Pending</p>
                            <p class="text-3xl font-extrabold text-slate-800">${pendingAppointments}</p>
                        </div>
                    </div>
                </div>

                <div class="fade-up fade-delay-6 glass-card soft-shadow rounded-[24px] p-5 hover:scale-[1.02] transition duration-300">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 rounded-xl bg-green-100 flex items-center justify-center text-green-700 text-xl">
                            <i class="fa-solid fa-circle-check"></i>
                        </div>
                        <div>
                            <p class="text-slate-500 text-sm">Approved</p>
                            <p class="text-3xl font-extrabold text-slate-800">${approvedAppointments}</p>
                        </div>
                    </div>
                </div>

                <div class="fade-up fade-delay-7 glass-card soft-shadow rounded-[24px] p-5 hover:scale-[1.02] transition duration-300">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 rounded-xl bg-blue-100 flex items-center justify-center text-blue-700 text-xl">
                            <i class="fa-solid fa-file-circle-check"></i>
                        </div>
                        <div>
                            <p class="text-slate-500 text-sm">Completed</p>
                            <p class="text-3xl font-extrabold text-slate-800">${completedAppointments}</p>
                        </div>
                    </div>
                </div>

                <div class="fade-up fade-delay-8 glass-card soft-shadow rounded-[24px] p-5 hover:scale-[1.02] transition duration-300">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 rounded-xl bg-red-100 flex items-center justify-center text-red-700 text-xl">
                            <i class="fa-solid fa-circle-xmark"></i>
                        </div>
                        <div>
                            <p class="text-slate-500 text-sm">Rejected</p>
                            <p class="text-3xl font-extrabold text-slate-800">${rejectedAppointments}</p>
                        </div>
                    </div>
                </div>

                <div class="fade-up fade-delay-9 glass-card soft-shadow rounded-[24px] p-5 hover:scale-[1.02] transition duration-300">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 rounded-xl bg-slate-200 flex items-center justify-center text-slate-700 text-xl">
                            <i class="fa-solid fa-ban"></i>
                        </div>
                        <div>
                            <p class="text-slate-500 text-sm">Cancelled</p>
                            <p class="text-3xl font-extrabold text-slate-800">${cancelledAppointments}</p>
                        </div>
                    </div>
                </div>

            </div>

            <div class="grid grid-cols-1 xl:grid-cols-2 gap-8 mb-8">

                <div class="fade-up fade-delay-8 glass-card soft-shadow rounded-[28px] p-8 hover:-translate-y-1 transition duration-300">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-2xl font-extrabold text-slate-800">System Overview</h2>
                        <span class="bg-blue-100 text-blue-700 px-4 py-2 rounded-full text-sm font-semibold">
                            Doughnut
                        </span>
                    </div>

                    <div class="h-[350px]">
                        <canvas id="overviewChart"></canvas>
                    </div>
                </div>

                <div class="fade-up fade-delay-9 glass-card soft-shadow rounded-[28px] p-8 hover:-translate-y-1 transition duration-300">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-2xl font-extrabold text-slate-800">Appointment Status</h2>
                        <span class="bg-emerald-100 text-emerald-700 px-4 py-2 rounded-full text-sm font-semibold">
                            Bar Chart
                        </span>
                    </div>

                    <div class="h-[350px]">
                        <canvas id="statusChart"></canvas>
                    </div>
                </div>

            </div>

            <div class="fade-up fade-delay-9 glass-card soft-shadow rounded-[28px] p-8">
                <h2 class="text-2xl font-extrabold text-slate-800 mb-6">Quick Actions</h2>

                <div class="flex flex-wrap gap-4">
                    <a href="/admin/add-doctor"
                       class="flex items-center gap-2 bg-gradient-to-r from-blue-500 to-cyan-500 text-white px-6 py-3 rounded-2xl hover:scale-105 transition duration-300 shadow-lg font-semibold">
                        <i class="fa-solid fa-user-plus"></i>
                        <span>Add Doctor</span>
                    </a>

                    <a href="/admin/view-doctors"
                       class="flex items-center gap-2 bg-gradient-to-r from-emerald-500 to-green-500 text-white px-6 py-3 rounded-2xl hover:scale-105 transition duration-300 shadow-lg font-semibold">
                        <i class="fa-solid fa-user-doctor"></i>
                        <span>View Doctors</span>
                    </a>

                    <a href="/admin/view-patients"
                       class="flex items-center gap-2 bg-gradient-to-r from-purple-500 to-fuchsia-500 text-white px-6 py-3 rounded-2xl hover:scale-105 transition duration-300 shadow-lg font-semibold">
                        <i class="fa-solid fa-users"></i>
                        <span>View Patients</span>
                    </a>

                    <a href="/admin/appointments"
                       class="flex items-center gap-2 bg-gradient-to-r from-amber-400 to-orange-500 text-white px-6 py-3 rounded-2xl hover:scale-105 transition duration-300 shadow-lg font-semibold">
                        <i class="fa-solid fa-calendar-days"></i>
                        <span>View Appointments</span>
                    </a>
                </div>
            </div>

        </main>
    </div>

<script>
    const totalDoctors = ${totalDoctors};
    const totalPatients = ${totalPatients};
    const totalAppointments = ${totalAppointments};
    const totalFeedbacks = ${totalFeedbacks};

    const pendingAppointments = ${pendingAppointments};
    const approvedAppointments = ${approvedAppointments};
    const completedAppointments = ${completedAppointments};
    const rejectedAppointments = ${rejectedAppointments};
    const cancelledAppointments = ${cancelledAppointments};

    const overviewCtx = document.getElementById('overviewChart').getContext('2d');
    new Chart(overviewCtx, {
        type: 'doughnut',
        data: {
            labels: ['Doctors', 'Patients', 'Appointments', 'Feedbacks'],
            datasets: [{
                data: [totalDoctors, totalPatients, totalAppointments, totalFeedbacks],
                backgroundColor: [
                    '#60a5fa',
                    '#34d399',
                    '#a78bfa',
                    '#fbbf24'
                ],
                borderColor: '#ffffff',
                borderWidth: 4,
                hoverOffset: 12
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '68%',
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        color: '#334155',
                        padding: 18,
                        font: {
                            size: 13,
                            weight: '600'
                        }
                    }
                }
            }
        }
    });

    const statusCtx = document.getElementById('statusChart').getContext('2d');
    new Chart(statusCtx, {
        type: 'bar',
        data: {
            labels: ['Pending', 'Approved', 'Completed', 'Rejected', 'Cancelled'],
            datasets: [{
                data: [
                    pendingAppointments,
                    approvedAppointments,
                    completedAppointments,
                    rejectedAppointments,
                    cancelledAppointments
                ],
                backgroundColor: [
                    '#fde68a',
                    '#86efac',
                    '#93c5fd',
                    '#fca5a5',
                    '#cbd5e1'
                ],
                borderRadius: 16,
                borderSkipped: false
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            animation: {
                duration: 1500
            },
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                x: {
                    ticks: {
                        color: '#475569',
                        font: {
                            weight: '600'
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