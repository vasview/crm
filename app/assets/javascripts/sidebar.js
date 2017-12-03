$(document).on('turbolinks:load turbolinks:render', function() {
  var $companyFilterForm = $('.filter_form');
  var $periodRadioButtons = $companyFilterForm.find("input[type='radio']");
  var $submitButton = $companyFilterForm.find('.filter__btn-submit');
  var $cancelButton = $companyFilterForm.find('.filter__btn-cancel');

  $('input[name="filter[period]"]').data('datepicker');

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
    var target = e.target;

    form = target.form;
    form.reset();
    $('.filter__input-period').hide();
    $submitButton.click();
  });

});
