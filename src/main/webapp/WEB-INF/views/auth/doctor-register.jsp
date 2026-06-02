<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor Register - Smart Clinic Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>

    <style>
        @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        @keyframes floatY {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-14px); }
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(26px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes pulseGlow {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(34,197,94,0.22);
            }
            50% {
                box-shadow: 0 0 0 14px rgba(34,197,94,0);
            }
        }

        @keyframes shineMove {
            0% { transform: translateX(-140%) skewX(-22deg); }
            100% { transform: translateX(240%) skewX(-22deg); }
        }

        @keyframes borderGlow {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(34,197,94,0.00);
            }
            50% {
                box-shadow: 0 0 0 6px rgba(34,197,94,0.08);
            }
        }

        .auth-bg {
            background: linear-gradient(-45deg, #dcfce7, #dbeafe, #ede9fe, #fef3c7, #ecfdf5);
            background-size: 400% 400%;
            animation: gradientMove 14s ease infinite;
        }

        .floating-blob {
            animation: floatY 7s ease-in-out infinite;
        }

        .fade-up {
            animation: fadeUp 0.85s ease forwards;
        }

        .glass-card {
            background: rgba(255,255,255,0.80);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            border: 1px solid rgba(255,255,255,0.50);
            box-shadow: 0 24px 60px rgba(15, 23, 42, 0.16);
        }

        .light-panel {
            background: rgba(255,255,255,0.70);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255,255,255,0.40);
            box-shadow: 0 18px 35px rgba(15, 23, 42, 0.08);
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
            padding: 15px 46px 15px 46px;
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

        .toggle-btn {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            background: transparent;
            border: none;
            cursor: pointer;
            z-index: 4;
            transition: all 0.25s ease;
        }

        .toggle-btn:hover {
            color: #16a34a;
            transform: translateY(-50%) scale(1.08);
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

        .pulse-glow {
            animation: pulseGlow 2.8s infinite;
        }

        .link-card {
            transition: all 0.28s ease;
        }

        .link-card:hover {
            transform: translateY(-3px);
        }

        .video-wrap {
            position: relative;
            min-height: 360px;
            height: 100%;
            background: linear-gradient(180deg, #f8fbff, #eef4ff);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .video-wrap video {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: contain;
            object-position: center center;
            pointer-events: none;
            user-select: none;
            -webkit-user-drag: none;
            background: transparent;
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

        @media (min-width: 1024px) {
            .video-wrap {
                min-height: 860px;
            }
        }

        @media (max-width: 1023px) {
            .video-wrap {
                min-height: 320px;
            }
        }
    </style>
</head>
<body class="auth-bg min-h-screen overflow-x-hidden">

    <div class="fixed top-10 left-8 sm:left-16 w-52 sm:w-64 h-52 sm:h-64 bg-green-200/40 rounded-full blur-3xl floating-blob pointer-events-none"></div>
    <div class="fixed bottom-8 right-8 sm:right-16 w-64 sm:w-80 h-64 sm:h-80 bg-blue-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay:1s;"></div>
    <div class="fixed top-1/3 right-1/4 w-44 h-44 bg-purple-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay:2s;"></div>

    <div class="min-h-screen relative z-10 flex items-center justify-center px-4 py-8 sm:px-6 lg:px-8">
        <div class="w-full max-w-7xl">
            <div class="glass-card rounded-[34px] overflow-hidden grid grid-cols-1 lg:grid-cols-2 items-stretch">

                <!-- LEFT VIDEO PANEL -->
                <div class="relative h-full">
                    <div class="video-wrap h-full">
                        <video
                            id="doctorRegisterVideo"
                            autoplay
                            muted
                            loop
                            playsinline
                            preload="auto"
                            disablePictureInPicture
                            disableRemotePlayback
                            controlsList="nodownload nofullscreen noremoteplayback noplaybackrate"
                            poster="https://images.pexels.com/photos/263402/pexels-photo-263402.jpeg">
                            <source src="/videos/clinic-login.mp4" type="video/mp4">
                        </video>
                    </div>
                </div>

                <!-- RIGHT REGISTER PANEL -->
                <div class="p-6 sm:p-8 lg:p-10 xl:p-12">
                    <div class="max-w-xl mx-auto">

                        <div class="text-center mb-8 fade-up">
                            <div class="w-16 h-16 sm:w-20 sm:h-20 mx-auto rounded-[24px] bg-gradient-to-r from-green-500 to-emerald-500 flex items-center justify-center shadow-2xl pulse-glow">
                                <i class="fa-solid fa-user-doctor text-white text-2xl sm:text-3xl"></i>
                            </div>

                            <h2 class="text-3xl sm:text-4xl font-black text-slate-800 mt-5">Doctor Registration</h2>
                            <p class="text-slate-500 mt-3 text-base sm:text-lg">
                                Fill your professional details for self registration
                            </p>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="fade-up bg-red-50 border border-red-200 text-red-700 px-4 py-4 rounded-2xl mb-5 flex items-start gap-3">
                                <i class="fa-solid fa-circle-xmark text-lg mt-0.5"></i>
                                <div>${error}</div>
                            </div>
                        </c:if>

                        <c:if test="${not empty success}">
                            <div class="fade-up bg-green-50 border border-green-200 text-green-700 px-4 py-4 rounded-2xl mb-5 flex items-start gap-3">
                                <i class="fa-solid fa-circle-check text-lg mt-0.5"></i>
                                <div>${success}</div>
                            </div>
                        </c:if>

                        <form action="/doctor-register" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-5 fade-up">

                            <div>
                                <label class="block text-slate-700 mb-2 font-semibold">Doctor Name</label>
                                <div class="input-shell">
                                    <i class="fa-solid fa-user-doctor input-icon"></i>
                                    <input type="text"
                                           name="name"
                                           class="form-control"
                                           placeholder="Enter doctor name"
                                           required>
                                </div>
                            </div>

                            <div>
                                <label class="block text-slate-700 mb-2 font-semibold">Email</label>
                                <div class="input-shell">
                                    <i class="fa-solid fa-envelope input-icon"></i>
                                    <input type="email"
                                           name="email"
                                           class="form-control"
                                           placeholder="Enter email"
                                           required>
                                </div>
                            </div>

                            <div>
                                <label class="block text-slate-700 mb-2 font-semibold">Password</label>
                                <div class="input-shell">
                                    <i class="fa-solid fa-lock input-icon"></i>
                                    <input type="password"
                                           id="passwordField"
                                           name="password"
                                           class="form-control"
                                           placeholder="Enter password"
                                           required>
                                    <button type="button" class="toggle-btn" onclick="togglePassword()">
                                        <i id="toggleIcon" class="fa-solid fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <div>
                                <label class="block text-slate-700 mb-2 font-semibold">Specialization</label>
                                <div class="input-shell select-wrap">
                                    <i class="fa-solid fa-stethoscope input-icon"></i>
                                    <select name="specialization" class="form-control" required>
                                        <option value="">Select Specialization</option>
                                        <c:forEach var="spec" items="${specializations}">
                                            <option value="${spec.name}">${spec.name}</option>
                                        </c:forEach>
                                    </select>
                                    <i class="fa-solid fa-chevron-down select-arrow"></i>
                                </div>
                            </div>

                            <div>
                                <label class="block text-slate-700 mb-2 font-semibold">Qualification</label>
                                <div class="input-shell">
                                    <i class="fa-solid fa-graduation-cap input-icon"></i>
                                    <input type="text"
                                           name="qualification"
                                           class="form-control"
                                           placeholder="MBBS, MD, BDS"
                                           required>
                                </div>
                            </div>

                            <div>
                                <label class="block text-slate-700 mb-2 font-semibold">Experience</label>
                                <div class="input-shell">
                                    <i class="fa-solid fa-briefcase-medical input-icon"></i>
                                    <input type="number"
                                           name="experience"
                                           class="form-control"
                                           placeholder="Years of experience"
                                           required>
                                </div>
                            </div>

                            <div>
                                <label class="block text-slate-700 mb-2 font-semibold">Consultation Fee</label>
                                <div class="input-shell">
                                    <i class="fa-solid fa-indian-rupee-sign input-icon"></i>
                                    <input type="number"
                                           step="0.01"
                                           name="consultationFee"
                                           class="form-control"
                                           placeholder="Consultation fee"
                                           required>
                                </div>
                            </div>

                            <div>
                                <label class="block text-slate-700 mb-2 font-semibold">City</label>
                                <div class="input-shell">
                                    <i class="fa-solid fa-location-dot input-icon"></i>
                                    <input type="text"
                                           name="city"
                                           class="form-control"
                                           placeholder="Enter city"
                                           required>
                                </div>
                            </div>

                            <div class="md:col-span-2">
                                <div class="light-panel rounded-2xl px-4 py-4 mb-5">
                                    <div class="flex items-start gap-3">
                                        <i class="fa-solid fa-circle-info text-emerald-600 mt-1"></i>
                                        <div>
                                            <p class="font-bold text-slate-800">Approval Required</p>
                                            <p class="text-slate-600 text-sm mt-1">
                                                After doctor self registration, admin approval लागेल. Approval नंतरच doctor patient booking list मध्ये दिसेल.
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <button type="submit"
                                        class="shine-btn w-full bg-gradient-to-r from-green-500 to-emerald-500 text-white py-3.5 rounded-2xl hover:scale-[1.02] transition duration-300 shadow-xl font-semibold text-base">
                                    <i class="fa-solid fa-file-circle-plus mr-2"></i>
                                    Submit Doctor Registration
                                </button>
                            </div>
                        </form>

                        <div class="mt-7 pt-6 border-t border-slate-200 fade-up">
                            <p class="text-slate-600 text-center mb-4 font-medium">Already have an account?</p>

                            <a href="/login"
                               class="link-card shine-btn flex items-center justify-center gap-2 rounded-2xl border border-blue-200 bg-blue-50 text-blue-700 px-4 py-3 font-semibold shadow-sm">
                                <i class="fa-solid fa-right-to-bracket"></i>
                                <span>Back to Login</span>
                            </a>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordField = document.getElementById("passwordField");
            const toggleIcon = document.getElementById("toggleIcon");

            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleIcon.className = "fa-solid fa-eye-slash";
            } else {
                passwordField.type = "password";
                toggleIcon.className = "fa-solid fa-eye";
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            const doctorRegisterVideo = document.getElementById("doctorRegisterVideo");

            function keepPlaying() {
                if (!doctorRegisterVideo) return;
                const playPromise = doctorRegisterVideo.play();
                if (playPromise !== undefined) {
                    playPromise.catch(() => {});
                }
            }

            keepPlaying();

            document.addEventListener("visibilitychange", function () {
                if (!document.hidden) {
                    keepPlaying();
                }
            });
        });
    </script>

</body>
</html>