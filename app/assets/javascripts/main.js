$(document).on('turbolinks:load', function() {
  $('.form__input-error-prone').on('change keyup', function(){
    var $parentFormRow = $(this).parent().parent();
    var $errorField = $parentFormRow.find('.form-errors span');
      $parentFormRow.removeClass('form__row-errors');
      $errorField.html('');
  });
});
