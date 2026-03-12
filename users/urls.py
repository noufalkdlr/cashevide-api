from django.urls import path
from .views import (
    OTPRequestView,
    OTPRequestView2,
    OTPVerificationView,
    UserSignupView,
    LoginView,
    LogoutView,
    CustomTokenRefreshView,
    UserProfileView,
    CheckFieldExistsView,
    PasswordChangeView,
    PasswordResetView,
    UserDeleteView,
)

urlpatterns = [
    path("request-otp/", OTPRequestView.as_view(), name="send_otp"),
    path("request-otp-2/", OTPRequestView2.as_view(), name="send_otp_2"),
    path("verify-otp/", OTPVerificationView.as_view(), name="verify_otp"),
    path("signup/", UserSignupView.as_view(), name="user_signup"),
    path("profile/me/", UserProfileView.as_view(), name="user_profile"),
    path("profile/delete/", UserDeleteView.as_view(), name="user_delete"),
    path("check-user/", CheckFieldExistsView.as_view(), name="check-user"),
    path("login/", LoginView.as_view(), name="login"),
    path("token/refresh/", CustomTokenRefreshView.as_view(), name="token_refresh"),
    path("change-password/", PasswordChangeView.as_view(), name="change_password"),
    path("reset-password/", PasswordResetView.as_view(), name="reset_password"),
    path("logout/", LogoutView.as_view(), name="logout"),
]
