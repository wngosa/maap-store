//= require active_admin/base
//= require activeadmin/dynamic_fields

const init = function () {
  document.querySelectorAll('.js-site-type-selector').forEach(element => {
    element.addEventListener('change', e => {
      if(e.target.value === 'Other') {
        document.querySelector('.js-site-type-other').name = 'site[site_type]';
      } else { 
        document.querySelector('.js-site-type-other').name = null
      }
    })
  })
}

document.addEventListener('DOMContentLoaded', init, false);