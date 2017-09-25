$(document).ready(function() { 
  var $companyFilterForm = $('#company_filter_form');
  var $periodRadioButtons = $companyFilterForm.find("input[type='radio']");
  var $submitButton = $companyFilterForm.find('.filter__btn-submit');
  var $cancelButton = $companyFilterForm.find('.filter__btn-cancel');
  
  $($periodRadioButtons).on('change', function() {
    var $filterInputPeriod = $('.filter__input-period')

    if ( $(this).val() == 'period') {
      $filterInputPeriod.show();
    } else {
      $filterInputPeriod.hide();
      $filterInputPeriod.val('');
    }
  });

  $cancelButton.on('click', function(e) {
    e.preventDefault();
    var $allFormInputs = $companyFilterForm.find('input');
    form = e.toElement.form;
    form.reset();
    $submitButton.click();
  });

});  