/* eslint-disable prettier/prettier */
//= require active_admin/base
//= require activeadmin/dynamic_fields

function fieldSelector(field) {
  var fieldSelectorClass = ".js-" + field + "-selector";
  var fieldOtherClass = ".js-" + field + "-other";
  var fieldAccessor = "site[" + field + "]";

  document.querySelectorAll(fieldSelectorClass).forEach(function(element) {
    element.addEventListener("change", function(e) {
      if (e.target.value === "Other") {
        document.querySelector(fieldOtherClass).name = fieldAccessor;
      } else {
        document.querySelector(fieldOtherClass).name = null;
      }
    });
  });
}

function toggleControls() {
  // Elements with conditional display
  var hospitalAndLaboratoriesPanel = document.getElementById("hospitalAndLaboratoriesPanel");
  var pharmaciesPanel = document.getElementById("pharmaciesPanel");
  var pharmaciesAndCmsPanel = document.getElementById("pharmaciesAndCmsPanel");
  var cmsPanel = document.getElementById("cmsPanel");
  var hasHospital = document.getElementById("site_has_hospital");
  var hasLaboratory = document.getElementById("site_has_laboratory");
  var hasPharmacy = document.getElementById("site_has_pharmacy");
  var hasCms = document.getElementById("site_has_cms");
  var isSpeciality = document.getElementById("site_is_specialty_hospital");
  var specialityMulti = document.getElementById("site_specialties_input");
  var specialityOther = document.getElementById("site_other_specialties_input");

  // Conditional display logic
  var toggleHospitalAndLaboratories = function() {
    hospitalAndLaboratoriesPanel.hidden = !hasHospital.checked && !hasLaboratory.checked;
  }

  var togglePharmacies = function() {
    pharmaciesPanel.hidden = !hasPharmacy.checked;
  }

  var togglePharmaciesAndCms = function() {
    pharmaciesAndCmsPanel.hidden = !hasPharmacy.checked && !hasCms.checked;
  }

  var toggleCms = function() {
    cmsPanel.hidden = !hasCms.checked
  }

  var toggleSpecialityControls = function() {
    specialityMulti.hidden = !isSpeciality.checked;
    specialityOther.hidden = !isSpeciality.checked;
  }

  var toggles = [
    toggleHospitalAndLaboratories,
    togglePharmacies,
    togglePharmaciesAndCms,
    toggleCms,
    toggleSpecialityControls
  ];

  var toggleAll = function() {
    toggles.forEach(function(t) { t.apply() });
  }

  // Subscription to change events in checkboxes which affect other controls
  hasHospital.addEventListener("change", toggleAll);
  hasLaboratory.addEventListener("change", toggleAll);
  hasPharmacy.addEventListener("change", toggleAll);
  hasCms.addEventListener("change", toggleAll);
  isSpeciality.addEventListener("change", toggleAll);

  // Properly set initial state
  toggleAll();
}

var init = function() {
  toggleControls();
  fieldSelector("ownership");
  fieldSelector("level");
};

document.addEventListener("DOMContentLoaded", init, false);
