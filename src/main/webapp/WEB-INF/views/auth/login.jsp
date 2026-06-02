<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Smart Clinic Management</title>
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
                box-shadow: 0 0 0 0 rgba(59,130,246,0.22);
            }
            50% {
                box-shadow: 0 0 0 14px rgba(59,130,246,0);
            }
        }

        @keyframes shineMove {
            0% { transform: translateX(-140%) skewX(-22deg); }
            100% { transform: translateX(240%) skewX(-22deg); }
        }

        @keyframes borderGlow {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(96,165,250,0.00);
            }
            50% {
                box-shadow: 0 0 0 6px rgba(96,165,250,0.08);
            }
        }

        .auth-bg {
            background: linear-gradient(-45deg, #dbeafe, #eef2ff, #ecfdf5, #fef3c7, #f5f3ff);
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
            border-color: rgba(96,165,250,0.55);
            background: #ffffff;
            box-shadow: 0 10px 24px rgba(59,130,246,0.10);
            transform: translateY(-1px);
        }

        .form-control:focus {
            border-color: #60a5fa;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(96,165,250,0.18), 0 14px 30px rgba(59,130,246,0.12);
        }

        .input-shell:focus-within .input-icon,
        .input-shell:hover .input-icon {
            color: #2563eb;
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
            color: #2563eb;
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

        @media (min-width: 1024px) {
            .video-wrap {
                min-height: 760px;
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

    <div class="fixed top-10 left-8 sm:left-16 w-52 sm:w-64 h-52 sm:h-64 bg-blue-200/40 rounded-full blur-3xl floating-blob pointer-events-none"></div>
    <div class="fixed bottom-8 right-8 sm:right-16 w-64 sm:w-80 h-64 sm:h-80 bg-purple-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay:1s;"></div>
    <div class="fixed top-1/3 right-1/4 w-44 h-44 bg-emerald-200/40 rounded-full blur-3xl floating-blob pointer-events-none" style="animation-delay:2s;"></div>

    <div class="min-h-screen relative z-10 flex items-center justify-center px-4 py-8 sm:px-6 lg:px-8">
        <div class="w-full max-w-7xl">
            <div class="glass-card rounded-[34px] overflow-hidden grid grid-cols-1 lg:grid-cols-2 items-stretch">

                <div class="relative h-full">
                    <div class="video-wrap h-full">
                        <video
                            id="loginVideo"
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

                <div class="p-6 sm:p-8 lg:p-10 xl:p-12">
                    <div class="max-w-md mx-auto">

                        <div class="text-center mb-8 fade-up">
                            <div class="w-16 h-16 sm:w-20 sm:h-20 mx-auto rounded-[24px] bg-gradient-to-r from-blue-500 to-indigo-500 flex items-center justify-center shadow-2xl pulse-glow">
                                <i class="fa-solid fa-user-lock text-white text-2xl sm:text-3xl"></i>
                            </div>

                            <h2 class="text-3xl sm:text-4xl font-black text-slate-800 mt-5">Welcome Back</h2>
                            <p class="text-slate-500 mt-3 text-base sm:text-lg">
                                Login to access your clinic account securely
                            </p>
                        </div>

                        <% if (request.getAttribute("success") != null) { %>
                            <div class="fade-up bg-green-50 border border-green-200 text-green-700 px-4 py-4 rounded-2xl mb-5 flex items-start gap-3">
                                <i class="fa-solid fa-circle-check text-lg mt-0.5"></i>
                                <div><%= request.getAttribute("success") %></div>
                            </div>
                        <% } %>

                        <% if (request.getAttribute("error") != null) { %>
                            <div class="fade-up bg-red-50 border border-red-200 text-red-700 px-4 py-4 rounded-2xl mb-5 flex items-start gap-3">
                                <i class="fa-solid fa-circle-xmark text-lg mt-0.5"></i>
                                <div><%= request.getAttribute("error") %></div>
                            </div>
                        <% } %>

                        <form action="/login" method="post" class="space-y-5 fade-up">

                            <div>
                                <label class="block text-slate-700 mb-2 font-semibold">Email</label>
                                <div class="input-shell">
                                    <i class="fa-solid fa-envelope input-icon"></i>
                                    <input type="email"
                                           name="email"
                                           class="form-control"
                                           placeholder="Enter your email"
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
                                           placeholder="Enter your password"
                                           required>

                                    <button type="button" class="toggle-btn" onclick="togglePassword()">
                                        <i id="toggleIcon" class="fa-solid fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="flex items-center justify-between gap-4 text-sm">
                                <span class="text-slate-500 flex items-center gap-2">
                                    <i class="fa-solid fa-shield-halved text-emerald-500"></i>
                                    Secure login
                                </span>

                                <a href="/forgot-password" class="text-blue-600 font-semibold hover:underline">
                                    Forgot Password?
                                </a>
                            </div>

                            <button type="submit"
                                    class="shine-btn w-full bg-gradient-to-r from-blue-500 to-indigo-500 text-white py-3.5 rounded-2xl hover:scale-[1.02] transition duration-300 shadow-xl font-semibold text-base">
                                <i class="fa-solid fa-right-to-bracket mr-2"></i>
                                Login
                            </button>
                        </form>

                        <div class="mt-7 pt-6 border-t border-slate-200 fade-up">
                            <p class="text-slate-600 text-center mb-4 font-medium">Don't have an account?</p>

                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                                <a href="/register"
                                   class="link-card shine-btn flex items-center justify-center gap-2 rounded-2xl border border-blue-200 bg-blue-50 text-blue-700 px-4 py-3 font-semibold shadow-sm">
                                    <i class="fa-solid fa-user"></i>
                                    <span>Patient Register</span>
                                </a>

                                <a href="/doctor-register"
                                   class="link-card shine-btn flex items-center justify-center gap-2 rounded-2xl border border-emerald-200 bg-emerald-50 text-emerald-700 px-4 py-3 font-semibold shadow-sm">
                                    <i class="fa-solid fa-user-doctor"></i>
                                    <span>Doctor Register</span>
                                </a>
                            </div>
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
            const loginVideo = document.getElementById("loginVideo");

            function keepPlaying() {
                if (!loginVideo) return;
                const playPromise = loginVideo.play();
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