const alertSuccess = document.querySelector('.alert-success')
const alertWarning = document.querySelector('.alert-warning')

setTimeout(() => {
  alertSuccess.classList.add('.hide')
  alertWarning.classList.add('.hide')
}, 300)