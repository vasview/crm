$(document).on('turbolinks:load', function() {
  var $representativeFilterForm = $('#representative_filter_form');
  var $submitButton = $representativeFilterForm.find('.filter__btn-submit');
  var $cancelButton = $representativeFilterForm.find('.filter__btn-cancel');


  $cancelButton.on('click', function(e) {
    e.preventDefault();
    var $allFormInputs = $representativeFilterForm.find('input');
    form = e.toElement.form;
    form.reset();
    $submitButton.click();
  });

});
