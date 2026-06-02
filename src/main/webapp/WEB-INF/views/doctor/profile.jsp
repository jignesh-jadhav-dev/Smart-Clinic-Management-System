<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor Profile</title>
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

        .profile-card {
            transition: all 0.28s ease;
        }

        .profile-card:hover {
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
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-size: 15px;
            z-index: 4;
            transition: all 0.25s ease;
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
            transform: translateY(-50%) scale(1.08);
        }

        .readonly-control {
            background: #f1f5f9 !important;
            cursor: not-allowed;
        }

        .select-wrap .form-control {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            padding-right: 44px;
        }

        .select-arrow {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            z-index: 4;
            pointer-events: none;
            font-size: 12px;
        }

        .file-control {
            padding-left: 16px;
        }

        .stat-mini {
            border-radius: 22px;
            padding: 16px;
            background: rgba(255,255,255,0.72);
            border: 1px solid rgba(148, 163, 184, 0.18);
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
                    <i class="fa-solid fa-gauge-high"></i><span>Dashboard</span>
                </a>

                <a href="/doctor/profile" class="sidebar-link flex items-center gap-3 bg-gradient-to-r from-green-500 to-emerald-500 px-4 py-3 rounded-2xl font-semibold shadow-lg">
                    <i class="fa-solid fa-user"></i><span>Profile</span>
                </a>

                <a href="/doctor/availability" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-clock"></i><span>Availability</span>
                </a>

                <a href="/doctor/leaves" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-calendar-xmark"></i><span>Leaves</span>
                </a>
				
				<a href="/doctor/appointments" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
				                    <i class="fa-solid fa-calendar-check"></i><span>Appointments</span>
				                </a>

                <a href="/doctor/feedbacks" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-star"></i><span>Feedbacks</span>
                </a>

                <a href="/doctor/notifications" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-bell"></i><span>Notifications</span>
                </a>

                <a href="/doctor/change-password" class="sidebar-link flex items-center gap-3 hover:bg-white/10 px-4 py-3 rounded-2xl">
                    <i class="fa-solid fa-key"></i><span>Change Password</span>
                </a>

                <a href="/logout" class="sidebar-link col-span-2 sm:col-span-3 lg:col-span-1 flex items-center justify-center gap-3 mt-1 lg:mt-8 bg-gradient-to-r from-rose-500 to-red-500 px-4 py-3 rounded-2xl font-semibold shadow-lg">
                    <i class="fa-solid fa-right-from-bracket"></i><span>Logout</span>
                </a>
            </nav>
        </aside>

        <main class="flex-1 p-4 sm:p-6 lg:p-8">

            <div class="hero-card glass-card soft-shadow rounded-[30px] p-6 sm:p-8 mb-8 fade-up">
                <div class="flex flex-col xl:flex-row xl:items-center xl:justify-between gap-6">
                    <div>
                        <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-800">Doctor Profile</h1>
                        <p class="text-slate-600 mt-3 text-base sm:text-lg">
                            Manage your personal details, professional details and profile photo.
                        </p>

                    </div>

                    <div class="bg-gradient-to-r from-green-500 to-emerald-500 text-white px-7 py-6 rounded-[26px] shadow-xl min-w-[250px]">
                        <div class="flex items-center justify-between gap-4">
                            <div>
                                <p class="text-sm uppercase tracking-widest text-green-100">Profile Status</p>
                                <p class="text-3xl font-extrabold mt-2">Updated</p>
                                <p class="mt-2 text-green-100">Keep your profile professional</p>
                            </div>
                            <i class="fa-solid fa-id-card text-3xl text-white/90"></i>
                        </div>
                    </div>
                </div>
            </div>

            <c:if test="${not empty success}">
                <div class="alert-box bg-green-50 border border-green-200 text-green-700 mb-5 fade-up">
                    <i class="fa-solid fa-circle-check text-lg mt-0.5"></i>
                    <div>
                        <p class="font-bold">Success</p>
                        <p>${success}</p>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert-box bg-red-50 border border-red-200 text-red-700 mb-5 fade-up">
                    <i class="fa-solid fa-circle-xmark text-lg mt-0.5"></i>
                    <div>
                        <p class="font-bold">Error</p>
                        <p>${error}</p>
                    </div>
                </div>
            </c:if>

            <div class="glass-card soft-shadow rounded-[30px] p-5 sm:p-7 lg:p-8 max-w-7xl mx-auto fade-up">
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

                    <div class="lg:col-span-1">
                        <div class="profile-card bg-white/65 rounded-[28px] border border-slate-200/60 p-6 text-center">
                            <c:choose>
                                <c:when test="${not empty doctor.profileImage}">
                                    <img src="/uploads/${doctor.profileImage}"
                                         class="w-36 h-36 sm:w-44 sm:h-44 rounded-full mx-auto object-cover border-4 border-green-200 shadow-lg">
                                </c:when>
                                <c:otherwise>
                                    <div class="w-36 h-36 sm:w-44 sm:h-44 rounded-full mx-auto bg-green-100 flex items-center justify-center text-5xl text-green-700 border-4 border-green-200 shadow-lg">
                                        <i class="fa-solid fa-user-doctor"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <p class="mt-5 text-2xl font-extrabold text-slate-800">${doctor.user.name}</p>
                            <p class="text-slate-500 mt-1">${doctor.user.email}</p>

                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-1 gap-3 mt-6 text-left">
                                <div class="stat-mini">
                                    <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Specialization</p>
                                    <p class="font-bold text-slate-800 mt-2">${doctor.specialization}</p>
                                </div>

                                <div class="stat-mini">
                                    <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Experience</p>
                                    <p class="font-bold text-slate-800 mt-2">${doctor.experience} Years</p>
                                </div>

                                <div class="stat-mini">
                                    <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">City</p>
                                    <p class="font-bold text-slate-800 mt-2">${doctor.city}</p>
                                </div>

                                <div class="stat-mini">
                                    <p class="text-xs uppercase tracking-wider text-slate-500 font-bold">Consultation Fee</p>
                                    <p class="font-bold text-slate-800 mt-2">₹ ${doctor.consultationFee}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="lg:col-span-2">
                        <div class="bg-white/65 rounded-[28px] border border-slate-200/60 p-6 sm:p-7">
                            <div class="mb-6">
                                <h2 class="text-2xl font-extrabold text-slate-800">Update Profile Details</h2>
                                <p class="text-slate-500 mt-1">Edit your personal and professional details below.</p>
                            </div>

                            <form action="/doctor/profile" method="post" enctype="multipart/form-data" class="grid grid-cols-1 md:grid-cols-2 gap-5">

                                <div>
                                    <label class="field-label">Name</label>
                                    <div class="input-shell">
                                        <i class="fa-solid fa-user input-icon"></i>
                                        <input type="text"
                                               name="name"
                                               value="${doctor.user.name}"
                                               required
                                               class="form-control">
                                    </div>
                                </div>

                                <div>
                                    <label class="field-label">Email</label>
                                    <div class="input-shell">
                                        <i class="fa-solid fa-envelope input-icon"></i>
                                        <input type="text"
                                               value="${doctor.user.email}"
                                               readonly
                                               class="form-control readonly-control">
                                    </div>
                                </div>

                                <div>
                                    <label class="field-label">Specialization</label>
                                    <div class="input-shell select-wrap">
                                        <i class="fa-solid fa-stethoscope input-icon"></i>
                                        <select name="specialization" required class="form-control">
                                            <option value="">Select specialization</option>
                                            <c:forEach var="spec" items="${specializations}">
                                                <option value="${spec.name}" ${doctor.specialization == spec.name ? 'selected' : ''}>${spec.name}</option>
                                            </c:forEach>
                                        </select>
                                        <i class="fa-solid fa-chevron-down select-arrow"></i>
                                    </div>
                                </div>

                                <div>
                                    <label class="field-label">Qualification</label>
                                    <div class="input-shell">
                                        <i class="fa-solid fa-graduation-cap input-icon"></i>
                                        <input type="text"
                                               name="qualification"
                                               value="${doctor.qualification}"
                                               required
                                               class="form-control">
                                    </div>
                                </div>

                                <div>
                                    <label class="field-label">Experience</label>
                                    <div class="input-shell">
                                        <i class="fa-solid fa-briefcase-medical input-icon"></i>
                                        <input type="number"
                                               name="experience"
                                               value="${doctor.experience}"
                                               required
                                               class="form-control">
                                    </div>
                                </div>

                                <div>
                                    <label class="field-label">Consultation Fee</label>
                                    <div class="input-shell">
                                        <i class="fa-solid fa-indian-rupee-sign input-icon"></i>
                                        <input type="number"
                                               step="0.01"
                                               name="consultationFee"
                                               value="${doctor.consultationFee}"
                                               required
                                               class="form-control">
                                    </div>
                                </div>

                                <div>
                                    <label class="field-label">City</label>
                                    <div class="input-shell">
                                        <i class="fa-solid fa-location-dot input-icon"></i>
                                        <input type="text"
                                               name="city"
                                               value="${doctor.city}"
                                               required
                                               class="form-control">
                                    </div>
                                </div>

                                <div>
                                    <label class="field-label">Profile Photo</label>
                                    <div class="input-shell">
                                        <i class="fa-solid fa-image input-icon"></i>
                                        <input type="file"
                                               name="profileImage"
                                               accept="image/*"
                                               class="form-control file-control bg-white">
                                    </div>
                                </div>

                                <div class="md:col-span-2 pt-2 flex flex-wrap gap-4">
                                    <button type="submit"
                                            class="shine-btn action-btn inline-flex items-center gap-2 bg-gradient-to-r from-green-500 to-emerald-500 text-white px-8 py-3 rounded-2xl shadow-lg font-semibold">
                                        <i class="fa-solid fa-floppy-disk"></i>
                                        <span>Update Profile</span>
                                    </button>

                                    <a href="/doctor/dashboard"
                                       class="shine-btn action-btn inline-flex items-center gap-2 bg-white text-slate-700 px-8 py-3 rounded-2xl border border-slate-200 shadow-sm font-semibold hover:bg-slate-50">
                                        <i class="fa-solid fa-arrow-left"></i>
                                        <span>Back</span>
                                    </a>
                                </div>

                            </form>
                        </div>
                    </div>

                </div>
            </div>

        </main>
    </div>

</body>
</html>