function login(){
    const username = document.getElementById("input_username").value;
    const password = document.getElementById("input_password").value;
    window.location.href="http://localhost:8080/SpringDemo/account/login?username=" + username + "&password=" + password;
}

function register(){
    const username = document.getElementById("re_username").value;
    const password = document.getElementById("re_password").value;
    const confirm = document.getElementById("re_password_confirm").value;
    if(password!=null){
        if(!password.match(/^[a-zA-Z][\da-zA-Z]{5,11}/)){
            alert("密码不符合要求：字母开头，字母数字组合，长度6-12")
            return;
        }
    }
    if(password!==confirm){
        alert("两次输出密码不一致！")
        return;
    }
    window.location.href="http://localhost:8080/SpringDemo/account/register?username=" + username + "&password=" + password;
}

function changePassword(){
    const username = document.getElementById("cg_username").value;
    const password = document.getElementById("cg_password").value;
    const newPassword = document.getElementById("cg_new_password").value;
    if(username==null || password==null || newPassword==null){
        alert("未全部输入！")
        return;
    }
    if(!newPassword.match(/^[a-zA-Z][\da-zA-Z]{5,11}/)){
        alert("密码不符合要求：字母开头，字母数字组合，长度6-12")
        return;
    }
    window.location.href="http://localhost:8080/SpringDemo/account/updatepassword?username=" + username +
        "&password=" + password + "&newPassword=" + newPassword;
}