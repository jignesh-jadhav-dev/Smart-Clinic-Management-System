<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Prescription</title>
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

        @keyframes borderGlow {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(34,197,94,0.00);
            }
            50% {
                box-shadow: 0 0 0 6px rgba(34,197,94,0.08);
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
            top: 18px;
            color: #64748b;
            font-size: 15px;
            z-index: 4;
            transition: all 0.25s ease;
        }

        .date-icon {
            top: 50%;
            transform: translateY(-50%);
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
            border-color: rgba(34,197,94,0.55);
            background: #ffffff;
            box-shadow: 0 10px 24px rgba(34,197,94,0.10);
            transform: translateY(-1px);
        }

        .form-control:focus {
            border-color: #4ade80;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(74,222,128,0.18), 0 14px 30px rgba(34,197,94,0.12);
        }

        .input-shell:focus-within .input-icon,
        .input-shell:hover .input-icon {
            color: #16a34a;
            transform: scale(1.08);
        }

        .date-wrap:focus-within .date-icon,
        .date-wrap:hover .date-icon {
            transform: translateY(-50%) scale(1.08);
        }

        .textarea-control {
            min-height: 120px;
            resize: vertical;
            padding-top: 16px;
        }

        .info-box {
            border-radius: 22px;
            padding: 18px;
            background: rgba(255,255,255,0.72);
            border: 1px solid rgba(148, 163, 184, 0.18);
        }

        .detail-pill {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 14px;
            border-radius: 16px;
            font-size: 13px;
            font-weight: 700;
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
                        <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-800">Add Prescription</h1>
                        <p class="text-slate-600 mt-3 text-base sm:text-lg">
                            Add medicine details, advice and next visit date for the patient appointment.
                        </p>

                        <div class="flex flex-wrap gap-3 mt-5">
                            <span class="mini-chip bg-green-100 text-green-700">
                                <i class="fa-solid fa-file-prescription"></i>
                                Prescription Entry
                            </span>
                            <span class="mini-chip bg-blue-100 text-blue-700">
                                <i class="fa-solid fa-notes-medical"></i>
                                Treatment Advice
                            </span>
                            <span class="mini-chip bg-purple-100 text-purple-700">
                                <i class="fa-solid fa-calendar-plus"></i>
                                Next Visit Planning
                            </span>
                        </div>
                    </div>

                    <div class="bg-gradient-to-r from-green-500 to-emerald-500 text-white px-7 py-6 rounded-[26px] shadow-xl min-w-[250px]">
                        <div class="flex items-center justify-between gap-4">
                            <div>
                                <p class="text-sm uppercase tracking-widest text-green-100">Prescription Mode</p>
                                <p class="text-3xl font-extrabold mt-2">Ready</p>
                                <p class="mt-2 text-green-100">Complete patient consultation</p>
                            </div>
                            <i class="fa-solid fa-prescription-bottle-medical text-3xl text-white/90"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="glass-card soft-shadow rounded-[30px] p-5 sm:p-7 lg:p-8 max-w-7xl mx-auto fade-up">

                <div class="mb-8">
                    <h2 class="text-2xl font-extrabold text-slate-800">Appointment Summary</h2>
                    <p class="text-slate-500 mt-1">Verify patient and appointment details before saving prescription.</p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-5 gap-4 mb-8">
                    <div class="info-box">
                        <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Patient</p>
                        <p class="font-bold text-slate-800 mt-2">${appointment.patient.user.name}</p>
                    </div>

                    <div class="info-box">
                        <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Date</p>
                        <p class="font-bold text-slate-800 mt-2">${appointment.appointmentDate}</p>
                    </div>

                    <div class="info-box">
                        <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Time</p>
                        <p class="font-bold text-slate-800 mt-2">${appointment.appointmentTime}</p>
                    </div>

                    <div class="info-box">
                        <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Reason</p>
                        <p class="font-bold text-slate-800 mt-2">${appointment.reason}</p>
                    </div>

                    <div class="info-box">
                        <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Status</p>
                        <div class="mt-2">
                            <span class="status-pill bg-green-100 text-green-700">
                                <i class="fa-solid fa-circle-check"></i>
                                ${appointment.status}
                            </span>
                        </div>
                    </div>
                </div>

                <% if (request.getAttribute("success") != null) { %>
                    <div class="alert-box bg-green-50 border border-green-200 text-green-700 mb-5">
                        <i class="fa-solid fa-circle-check text-lg mt-0.5"></i>
                        <div>
                            <p class="font-bold">Success</p>
                            <p><%= request.getAttribute("success") %></p>
                        </div>
                    </div>
                <% } %>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert-box bg-red-50 border border-red-200 text-red-700 mb-5">
                        <i class="fa-solid fa-circle-xmark text-lg mt-0.5"></i>
                        <div>
                            <p class="font-bold">Error</p>
                            <p><%= request.getAttribute("error") %></p>
                        </div>
                    </div>
                <% } %>

                <form action="/doctor/prescription" method="post" class="space-y-6">

                    <input type="hidden" name="appointmentId" value="${appointment.id}">

                    <div>
                        <label class="field-label">Medicine</label>
                        <div class="input-shell">
                            <i class="fa-solid fa-capsules input-icon"></i>
                            <textarea name="medicine"
                                      rows="5"
                                      required
                                      class="form-control textarea-control"
                                      placeholder="Example: Paracetamol 500mg - 2 times daily&#10;Vitamin C - once after lunch"></textarea>
                        </div>
                    </div>

                    <div>
                        <label class="field-label">Advice</label>
                        <div class="input-shell">
                            <i class="fa-solid fa-notes-medical input-icon"></i>
                            <textarea name="advice"
                                      rows="5"
                                      required
                                      class="form-control textarea-control"
                                      placeholder="Example: Take rest, drink more water, avoid cold food, complete the medicine course"></textarea>
                        </div>
                    </div>

                    <div class="max-w-md">
                        <label class="field-label">Next Visit Date</label>
                        <div class="input-shell date-wrap">
                            <i class="fa-solid fa-calendar-plus input-icon date-icon"></i>
                            <input type="date"
                                   name="nextVisitDate"
                                   class="form-control">
                        </div>
                    </div>

                    <div class="pt-2 flex flex-wrap gap-4">
                        <button type="submit"
                                class="shine-btn action-btn inline-flex items-center gap-2 bg-gradient-to-r from-green-500 to-emerald-500 text-white px-8 py-3 rounded-2xl shadow-lg font-semibold">
                            <i class="fa-solid fa-file-prescription"></i>
                            <span>Save Prescription</span>
                        </button>

                        <a href="/doctor/appointments"
                           class="shine-btn action-btn inline-flex items-center gap-2 bg-white text-slate-700 px-8 py-3 rounded-2xl border border-slate-200 shadow-sm font-semibold hover:bg-slate-50">
                            <i class="fa-solid fa-arrow-left"></i>
                            <span>Back to Appointments</span>
                        </a>
                    </div>

                </form>

            </div>

        </main>
    </div>

</body>
</html>