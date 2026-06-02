<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Patient</title>
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

        .form-card {
            position: relative;
            overflow: hidden;
        }

        .form-card::before {
            content: "";
            position: absolute;
            inset: 0;
            pointer-events: none;
            border-radius: 28px;
            background: linear-gradient(135deg, rgba(255,255,255,0.14), transparent 45%, rgba(255,255,255,0.10));
        }

        .field-wrap {
            transition: all 0.25s ease;
        }

        .field-wrap:hover {
            transform: translateY(-2px);
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

        .textarea-icon {
            top: 20px;
            transform: none;
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

        .input-shell.textarea-wrap:focus-within .textarea-icon {
            transform: scale(1.08);
        }

        .select-control {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            padding-right: 42px;
        }

        .select-arrow {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            pointer-events: none;
            font-size: 13px;
        }

        .textarea-control {
            min-height: 120px;
            resize: vertical;
            padding-top: 16px;
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
            transition: none;
        }

        .shine-btn:hover::before {
            animation: shineMove 0.9s ease;
        }

        .action-btn {
            transition: all 0.28s ease;
        }

        .action-btn:hover {
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 16px 28px rgba(59, 130, 246, 0.18);
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
                   class="sidebar-link flex items-center gap-3 bg-gradient-to-r from-blue-500 to-indigo-500 px-4 py-3 rounded-2xl font-semibold shadow-lg">
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
                   class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
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
                   class="sidebar-link flex items-center justify-center gap-3 mt-8 bg-gradient-to-r from-rose-500 to-red-500 hover:from-rose-600 hover:to-red-600 px-4 py-3 rounded-2xl font-semibold text-center shadow-lg">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    <span>Logout</span>
                </a>
            </nav>
        </aside>

        <main class="flex-1 p-8">

            <div class="hero-card glass-card soft-shadow rounded-[28px] p-8 mb-8 fade-up">
                <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">
                    <div>
                        <h1 class="text-4xl font-extrabold text-slate-800 leading-tight">
                            Add New Patient
                        </h1>
                        <p class="text-slate-600 mt-3 text-lg">
                            Create patient account with personal details, contact information and address.
                        </p>

                    </div>

                    <a href="/admin/view-patients"
                       class="shine-btn action-btn inline-flex items-center gap-3 bg-gradient-to-r from-emerald-500 to-green-500 text-white px-6 py-4 rounded-[22px] shadow-xl font-semibold">
                        <i class="fa-solid fa-users"></i>
                        <span>View Patients</span>
                    </a>
                </div>
            </div>

            <div class="form-card glass-card soft-shadow rounded-[28px] p-8 fade-up">
                <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-7">
                    <div>
                        <h2 class="text-2xl font-extrabold text-slate-800">Patient Registration Form</h2>
                        <p class="text-slate-500 mt-1">Fill all basic details to create a patient account.</p>
                    </div>

                    <a href="/admin/view-patients"
                       class="shine-btn action-btn inline-flex items-center gap-2 bg-white text-slate-700 px-5 py-3 rounded-2xl border border-slate-200 shadow-sm font-semibold hover:bg-slate-50">
                        <i class="fa-solid fa-eye"></i>
                        <span>View Patients</span>
                    </a>
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

                <form action="/admin/add-patient" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-6">

                    <div class="field-wrap">
                        <label class="field-label">Patient Name</label>
                        <div class="input-shell">
                            <i class="fa-solid fa-user input-icon"></i>
                            <input type="text" name="name" required class="form-control" placeholder="Enter patient full name">
                        </div>
                    </div>

                    <div class="field-wrap">
                        <label class="field-label">Email</label>
                        <div class="input-shell">
                            <i class="fa-solid fa-envelope input-icon"></i>
                            <input type="email" name="email" required class="form-control" placeholder="Enter patient email">
                        </div>
                    </div>

                    <div class="field-wrap">
                        <label class="field-label">Password</label>
                        <div class="input-shell">
                            <i class="fa-solid fa-lock input-icon"></i>
                            <input type="password" name="password" required class="form-control" placeholder="Enter secure password">
                        </div>
                    </div>

                    <div class="field-wrap">
                        <label class="field-label">Phone</label>
                        <div class="input-shell">
                            <i class="fa-solid fa-phone input-icon"></i>
                            <input type="text" name="phone" required class="form-control" placeholder="Enter phone number">
                        </div>
                    </div>

                    <div class="field-wrap">
                        <label class="field-label">Age</label>
                        <div class="input-shell">
                            <i class="fa-solid fa-cake-candles input-icon"></i>
                            <input type="number" name="age" class="form-control" placeholder="Enter age">
                        </div>
                    </div>

                    <div class="field-wrap">
                        <label class="field-label">Gender</label>
                        <div class="input-shell">
                            <i class="fa-solid fa-venus-mars input-icon"></i>
                            <select name="gender" class="form-control select-control">
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                            <i class="fa-solid fa-chevron-down select-arrow"></i>
                        </div>
                    </div>

                    <div class="field-wrap md:col-span-2">
                        <label class="field-label">Address</label>
                        <div class="input-shell textarea-wrap">
                            <i class="fa-solid fa-location-dot input-icon textarea-icon"></i>
                            <textarea name="address" rows="4" class="form-control textarea-control" placeholder="Enter patient address"></textarea>
                        </div>
                    </div>

                    <div class="md:col-span-2 pt-2 flex flex-wrap gap-4">
                        <button type="submit"
                                class="shine-btn action-btn inline-flex items-center gap-2 bg-gradient-to-r from-blue-500 to-indigo-500 text-white px-8 py-3 rounded-2xl shadow-lg font-semibold">
                            <i class="fa-solid fa-user-plus"></i>
                            <span>Add Patient</span>
                        </button>

                        <a href="/admin/view-patients"
                           class="shine-btn action-btn inline-flex items-center gap-2 bg-gradient-to-r from-emerald-500 to-green-500 text-white px-8 py-3 rounded-2xl shadow-lg font-semibold">
                            <i class="fa-solid fa-users"></i>
                            <span>Patients List</span>
                        </a>
                    </div>
                </form>
            </div>

        </main>
    </div>

</body>
</html>