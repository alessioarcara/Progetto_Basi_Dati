const user__icon = document.querySelector('.headbar__user');
const user__role = document.querySelector('.headbar__role');
user__icon.addEventListener('mouseover', () => {
  const text = document.querySelector('.headbar__user p').textContent;
  user__role.style.marginLeft = `${text.length}em`; 
})
user__icon.addEventListener('mouseleave', () => {
  user__role.style.marginLeft = `0`; 
})