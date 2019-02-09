document.getElementById("changepassword").style.display='none';
document.getElementById("editprofile").style.display='none';
document.getElementById("deleteacc").style.display='none';
function changepass() {
    document.getElementById("changepassword").style.display='block';
    document.getElementById("editprofile").style.display='none';
    document.getElementById("deleteacc").style.display='none';
}
function editprof() {
    document.getElementById("editprofile").style.display='block';
    document.getElementById("changepassword").style.display='none';
    document.getElementById("deleteacc").style.display='none';
}
function deleteaccount() {
    document.getElementById("editprofile").style.display='none';
    document.getElementById("changepassword").style.display='none';
    document.getElementById("deleteacc").style.display='block';
}
