<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MediCare Clinic</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>

    <style>
        html {
            scroll-behavior: smooth;
        }

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
                transform: translateY(-16px);
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
                box-shadow: 0 0 0 0 rgba(59,130,246,0.22);
            }
            50% {
                box-shadow: 0 0 0 14px rgba(59,130,246,0);
            }
        }

        .fade-up {
            animation: fadeUp 0.9s ease forwards;
        }

        .main-bg {
            background: linear-gradient(-45deg, #dbeafe, #eef2ff, #ecfeff, #fdf2f8, #fff7ed);
            background-size: 400% 400%;
            animation: gradientMove 14s ease infinite;
        }

        .floating-blob {
            animation: floatY 7s ease-in-out infinite;
        }

        .glass-nav {
            background: rgba(255,255,255,0.72);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            border: 1px solid rgba(255,255,255,0.45);
        }

        .glass-card {
            background: rgba(255,255,255,0.80);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            border: 1px solid rgba(255,255,255,0.50);
        }

        .soft-shadow {
            box-shadow: 0 22px 55px rgba(15, 23, 42, 0.12);
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
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.38), transparent);
        }

        .shine-btn:hover::before {
            animation: shineMove 0.9s ease;
        }

        .action-btn {
            transition: all 0.28s ease;
        }

        .action-btn:hover {
            transform: translateY(-3px) scale(1.02);
        }

        .pulse-glow {
            animation: pulseGlow 2.8s infinite;
        }

        .feature-card {
            transition: all 0.28s ease;
        }

        .feature-card:hover {
            transform: translateY(-6px);
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
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.30), transparent);
            animation: shineMove 5s linear infinite;
        }

        .nav-link {
            transition: all 0.25s ease;
        }

        .nav-link:hover {
            color: #2563eb;
            transform: translateY(-1px);
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

        .section-title {
            font-size: 2rem;
            font-weight: 900;
            color: #1e293b;
        }

        .icon-box {
            width: 56px;
            height: 56px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body class="main-bg min-h-screen overflow-x-hidden text-slate-800">

    <div class="fixed top-8 left-6 sm:left-16 w-52 sm:w-72 h-52 sm:h-72 bg-blue-200/40 rounded-full blur-3xl floating-blob pointer-events-none"></div>
    <div class="fixed bottom-10 right-6 sm:right-16 w-64 sm:w-80 h-64 sm:h-80 bg-pink-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay:1s;"></div>
    <div class="fixed top-1/3 right-1/4 w-44 h-44 bg-cyan-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay:2s;"></div>

    <div class="relative z-10">

        <!-- NAVBAR -->
        <header class="sticky top-0 z-50 px-4 sm:px-6 lg:px-8 pt-4">
            <div class="max-w-7xl mx-auto glass-nav soft-shadow rounded-[24px] px-5 sm:px-6 py-4">
                <div class="flex items-center justify-between gap-4">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 rounded-2xl bg-gradient-to-r from-blue-500 to-indigo-500 flex items-center justify-center shadow-lg pulse-glow">
                            <i class="fa-solid fa-heart-pulse text-white text-xl"></i>
                        </div>
                        <div>
                            <h1 class="text-xl sm:text-2xl font-black text-slate-800">MediCare Clinic</h1>
                            <p class="text-xs sm:text-sm text-slate-500">Appointment Booking System</p>
                        </div>
                    </div>

                    <nav class="hidden lg:flex items-center gap-6 font-semibold text-slate-700">
                        <a href="#home" class="nav-link">Home</a>
                        <a href="#about" class="nav-link">About</a>
                        <a href="#services" class="nav-link">Services</a>
                        <a href="#contact" class="nav-link">Contact</a>
                    </nav>

                    <div class="hidden md:flex items-center gap-3">
                        <a href="/login"
                           class="shine-btn action-btn bg-gradient-to-r from-blue-500 to-indigo-500 text-white px-5 py-3 rounded-2xl shadow-lg font-semibold">
                            Login
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <!-- HERO -->
        <section id="home" class="px-4 sm:px-6 lg:px-8 pt-8 pb-12">
            <div class="max-w-7xl mx-auto">
                <div class="glass-card soft-shadow hero-card rounded-[34px] overflow-hidden">
                    <div class="grid grid-cols-1 lg:grid-cols-2">
                        <div class="p-8 sm:p-10 lg:p-12 xl:p-14 fade-up">
                            <div class="w-16 h-16 sm:w-20 sm:h-20 rounded-[24px] bg-gradient-to-r from-blue-500 to-indigo-500 flex items-center justify-center shadow-2xl pulse-glow">
                                <i class="fa-solid fa-hospital-user text-white text-3xl sm:text-4xl"></i>
                            </div>

                            <h2 class="text-4xl sm:text-5xl xl:text-6xl font-black leading-tight mt-6 text-slate-800">
                                Smart Clinic
                                <span class="block text-blue-600">Management</span>
                            </h2>

                            <p class="text-slate-600 text-base sm:text-lg leading-8 mt-5 max-w-xl">
                                Book appointments, manage doctors, track prescriptions and make healthcare access simple, modern and fast.
                            </p>

                            <div class="flex flex-wrap gap-3 mt-6">
                                <span class="mini-chip bg-blue-100 text-blue-700">
                                    <i class="fa-solid fa-user-doctor"></i>
                                    Doctors
                                </span>
                                <span class="mini-chip bg-green-100 text-green-700">
                                    <i class="fa-solid fa-calendar-check"></i>
                                    Booking
                                </span>
                                <span class="mini-chip bg-purple-100 text-purple-700">
                                    <i class="fa-solid fa-file-prescription"></i>
                                    Prescription
                                </span>
                            </div>

                            <div class="flex flex-col sm:flex-row gap-4 mt-8">
                                <a href="/login"
                                   class="shine-btn action-btn inline-flex items-center justify-center gap-2 bg-gradient-to-r from-blue-500 to-indigo-500 text-white px-8 py-4 rounded-2xl shadow-xl font-semibold">
                                    <i class="fa-solid fa-right-to-bracket"></i>
                                    <span>Login</span>
                                </a>

                                <a href="/register"
                                   class="shine-btn action-btn inline-flex items-center justify-center gap-2 bg-gradient-to-r from-green-500 to-emerald-500 text-white px-8 py-4 rounded-2xl shadow-xl font-semibold">
                                    <i class="fa-solid fa-user-plus"></i>
                                    <span>Patient Register</span>
                                </a>
                            </div>

                            <div class="mt-4">
                                <a href="/doctor-register"
                                   class="shine-btn action-btn inline-flex items-center justify-center gap-2 bg-gradient-to-r from-amber-500 to-orange-500 text-white px-8 py-4 rounded-2xl shadow-xl font-semibold">
                                    <i class="fa-solid fa-user-doctor"></i>
                                    <span>Doctor Register</span>
                                </a>
                            </div>
                        </div>

                        <div class="p-8 sm:p-10 lg:p-12 xl:p-14 bg-gradient-to-br from-blue-600 via-indigo-600 to-cyan-500 text-white">
                            <div class="grid grid-cols-1 gap-4 h-full">
                                <div class="bg-white/10 border border-white/15 rounded-3xl p-6 fade-up">
                                    <p class="text-white/75 text-sm">Fast Appointment Booking</p>
                                    <h3 class="text-3xl font-black mt-2">24/7 Access</h3>
                                    <p class="text-white/85 mt-3">Patients can easily find doctors and book appointments online anytime.</p>
                                </div>

                                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                    <div class="bg-white/10 border border-white/15 rounded-3xl p-6 fade-up">
                                        <p class="text-white/75 text-sm">Secure Login</p>
                                        <h3 class="text-2xl font-black mt-2">Safe</h3>
                                    </div>

                                    <div class="bg-white/10 border border-white/15 rounded-3xl p-6 fade-up">
                                        <p class="text-white/75 text-sm">Modern UI</p>
                                        <h3 class="text-2xl font-black mt-2">Smart</h3>
                                    </div>
                                </div>

                                <div class="bg-white/10 border border-white/15 rounded-3xl p-6 fade-up">
                                    <p class="text-white/75 text-sm">Complete Workflow</p>
                                    <h3 class="text-2xl font-black mt-2">Booking → Approval → Prescription</h3>
                                    <p class="text-white/85 mt-3">Everything is managed in one beautiful system for patient and doctor.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ABOUT -->
        <section id="about" class="px-4 sm:px-6 lg:px-8 py-8">
            <div class="max-w-7xl mx-auto">
                <div class="glass-card soft-shadow rounded-[34px] p-8 sm:p-10 lg:p-12">
                    <div class="max-w-3xl mx-auto text-center fade-up">
                        <h2 class="section-title">About MediCare Clinic</h2>
                        <p class="text-slate-600 text-base sm:text-lg leading-8 mt-5">
                            MediCare Clinic is an online clinic appointment booking system designed to connect patients and doctors on one platform. Patients can register, search doctors, book appointments, view prescriptions and give feedback. Doctors can manage appointments, availability, prescriptions and patient care.
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <!-- SERVICES -->
        <section id="services" class="px-4 sm:px-6 lg:px-8 py-8">
            <div class="max-w-7xl mx-auto">
                <div class="text-center mb-8 fade-up">
                    <h2 class="section-title">Our Services</h2>
                    <p class="text-slate-600 text-base sm:text-lg mt-3">Everything you need in one clinic system.</p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">
                    <div class="feature-card glass-card soft-shadow rounded-[30px] p-6 fade-up">
                        <div class="icon-box bg-blue-100 text-blue-700 text-2xl mb-4">
                            <i class="fa-solid fa-calendar-plus"></i>
                        </div>
                        <h3 class="text-xl font-extrabold text-slate-800">Online Booking</h3>
                        <p class="text-slate-500 mt-3 leading-7">Patients can quickly book appointments using available slots.</p>
                    </div>

                    <div class="feature-card glass-card soft-shadow rounded-[30px] p-6 fade-up">
                        <div class="icon-box bg-green-100 text-green-700 text-2xl mb-4">
                            <i class="fa-solid fa-user-doctor"></i>
                        </div>
                        <h3 class="text-xl font-extrabold text-slate-800">Doctor Management</h3>
                        <p class="text-slate-500 mt-3 leading-7">Doctors can manage profile, availability, leaves and appointments.</p>
                    </div>

                    <div class="feature-card glass-card soft-shadow rounded-[30px] p-6 fade-up">
                        <div class="icon-box bg-purple-100 text-purple-700 text-2xl mb-4">
                            <i class="fa-solid fa-file-prescription"></i>
                        </div>
                        <h3 class="text-xl font-extrabold text-slate-800">Prescription</h3>
                        <p class="text-slate-500 mt-3 leading-7">Doctors can add prescription and patients can view it easily.</p>
                    </div>

                    <div class="feature-card glass-card soft-shadow rounded-[30px] p-6 fade-up">
                        <div class="icon-box bg-amber-100 text-amber-700 text-2xl mb-4">
                            <i class="fa-solid fa-bell"></i>
                        </div>
                        <h3 class="text-xl font-extrabold text-slate-800">Notifications</h3>
                        <p class="text-slate-500 mt-3 leading-7">Users receive updates for approvals, changes and actions.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- CONTACT -->
        <section id="contact" class="px-4 sm:px-6 lg:px-8 py-8 pb-14">
            <div class="max-w-7xl mx-auto">
                <div class="glass-card soft-shadow rounded-[34px] p-8 sm:p-10 lg:p-12">
                    <div class="text-center fade-up">
                        <h2 class="section-title">Contact</h2>
                        <p class="text-slate-600 text-base sm:text-lg mt-4">
                            Need help? Contact clinic administration or login to continue using the system.
                        </p>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mt-8">
                            <div class="feature-card bg-white/70 border border-slate-200 rounded-3xl p-6 shadow-sm">
                                <div class="icon-box bg-blue-100 text-blue-700 text-2xl mx-auto mb-4">
                                    <i class="fa-solid fa-envelope"></i>
                                </div>
                                <h3 class="text-lg font-extrabold text-slate-800">Email</h3>
                                <p class="text-slate-500 mt-2">medicareclinic@example.com</p>
                            </div>

                            <div class="feature-card bg-white/70 border border-slate-200 rounded-3xl p-6 shadow-sm">
                                <div class="icon-box bg-green-100 text-green-700 text-2xl mx-auto mb-4">
                                    <i class="fa-solid fa-phone"></i>
                                </div>
                                <h3 class="text-lg font-extrabold text-slate-800">Phone</h3>
                                <p class="text-slate-500 mt-2">+91 9876543210</p>
                            </div>

                            <div class="feature-card bg-white/70 border border-slate-200 rounded-3xl p-6 shadow-sm">
                                <div class="icon-box bg-purple-100 text-purple-700 text-2xl mx-auto mb-4">
                                    <i class="fa-solid fa-location-dot"></i>
                                </div>
                                <h3 class="text-lg font-extrabold text-slate-800">Address</h3>
                                <p class="text-slate-500 mt-2">Mumbai, Maharashtra</p>
                            </div>
                        </div>

                        <div class="mt-8">
                            <a href="/login"
                               class="shine-btn action-btn inline-flex items-center justify-center gap-2 bg-gradient-to-r from-blue-500 to-indigo-500 text-white px-8 py-4 rounded-2xl shadow-xl font-semibold">
                                <i class="fa-solid fa-right-to-bracket"></i>
                                <span>Go to Login</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </div>

</body>
</html>