<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="footer">
    <div class="container">
        <p>
            &copy; <span id="current-year"></span> FreshMart. Bản quyền đã được bảo hộ.
        </p>
    </div>
    <div id="authModal" class="modal">
        <div class="modal-content">
            <div id="modalIcon"></div>
            <p id="modalMessage"></p>
            <button class="btn btn-primary" onclick="closeModal()">Đồng ý</button>
        </div>
    </div>

    <style>
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); }
        .modal-content { background-color: var(--card-bg); margin: 15% auto; padding: 20px; border-radius: 12px; width: 300px; text-align: center; border: 1px solid var(--border-color); color: var(--text-color); }
        .close-modal { float: right; cursor: pointer; font-size: 20px; }
        .success-icon { color: var(--primary-green); font-size: 3rem; margin-bottom: 10px; }
        .error-icon { color: #f44336; font-size: 3rem; margin-bottom: 10px; }
        .username-display { font-family: var(--font-primary); font-weight: 600; color: var(--primary-green); margin-right: 10px; }
        .logout-link { font-size: 0.8rem; color: var(--earthy-brown); text-decoration: none; }
    </style>

</footer>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        let msg = "${authMessage}";
        let type = "${authType}";

        if (!msg || msg === "") {
            msg = "${sessionScope.authMessage}";
            type = "${sessionScope.authType}";
        }

        if (msg && msg !== "null" && msg !== "") {
            showModal(msg, type);
        }
    });

    function showModal(message, type) {
        const modal = document.getElementById("authModal");
        const modalMsg = document.getElementById("modalMessage");
        const modalIcon = document.getElementById("modalIcon");

        modalMsg.innerText = message;
        modalIcon.innerHTML = type === 'success'
            ? '<i class="fas fa-check-circle success-icon"></i>'
            : '<i class="fas fa-exclamation-circle error-icon"></i>';

        modal.style.display = "block";
    }

    function closeModal() {
        document.getElementById("authModal").style.display = "none";
    }
</script>
<%
    session.removeAttribute("authMessage");
    session.removeAttribute("authType");
%>
