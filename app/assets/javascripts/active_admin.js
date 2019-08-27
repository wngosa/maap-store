//= require active_admin/base
//= require activeadmin/dynamic_fields

const init = function () {
  document.querySelectorAll('.js-ownership-selector').forEach(element => {
    element.addEventListener('change', e => {
      if(e.target.value === 'Other') {
        document.querySelector('.js-ownership-other').name = 'site[ownership]';
      } else { 
        document.querySelector('.js-ownership-other').name = null
      }
    })
  })
}

document.addEventListener('DOMContentLoaded', init, false);