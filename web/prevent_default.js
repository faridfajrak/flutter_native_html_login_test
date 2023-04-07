function savePassword(){
// Get form's DOM object
var form = document.querySelector('#my-form');
form.addEventListener('submit', (e) => {
  // Stop submitting form by itself
  e.preventDefault();

  if (window.PasswordCredential) {
         var c = new PasswordCredential(form);
         return navigator.credentials.store(c);
       } else {
         return Promise.resolve(profile);
       }
});
}
