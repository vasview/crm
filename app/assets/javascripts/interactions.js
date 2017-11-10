$(document).on('turbolinks:load',function() {

  var $interactionCategoryIds = $("#interaction_category_id");
  var $interactionCommitteeIds = $("#interaction_committee_id");
  var $interactionCompanyIds = $('#interaction_company_id');
  var $interactionRepresentativeId = $('#interaction_representative_id');
  var $submitButton = $('.form__btn-submit');
  var $resetButton = $('.form__btn-reset');

  $('#all_members_selected').change(function(){

    if ($(this).is(":checked")){
      $interactionCategoryIds.prop('disabled', 'disabled');
      $interactionCompanyIds.prop('disabled', 'disabled');
      $interactionCommitteeIds.prop('disabled', 'disabled');
      $interactionRepresentativeId.prop('disabled', 'disabled');
      $interactionCategoryIds.val('');
      $interactionCompanyIds.val('');
      $interactionCommitteeIds.val('');
      $interactionRepresentativeId.val('');
      $submitButton.prop('disabled', false);
    } else {
      $interactionCategoryIds.prop('disabled', false);
      $interactionCompanyIds.prop('disabled', false);
      $interactionCommitteeIds.prop('disabled', false);
      $submitButton.prop('disabled', 'disabled');
    }
  });

  $resetButton.on('click', function() {
    $interactionCategoryIds.prop('disabled', false);
    $interactionCommitteeIds.prop('disabled', false);
    $interactionCompanyIds.prop('disabled', false);
    $interactionRepresentativeId.prop('disabled', 'disabled');
    $interactionCategoryIds.val('');
    $submitButton.prop('disabled', 'disabled');
  });

  $('#interaction_category_id').change(function() {
    var URL = '/update_company_options';
    var send_data;
    var selectedVal = $(this).val();

    if (selectedVal > 0) {
      send_data = { id: selectedVal }
      $interactionCommitteeIds.prop('disabled', 'disabled');
      $interactionCompanyIds.prop('disabled', false);

    } else {
      $interactionCommitteeIds.prop('disabled', false);
      $interactionCompanyIds.prop('disabled', false);
    }

    $interactionRepresentativeId.val('');
    $interactionRepresentativeId.prop('disabled', 'disabled');
    $interactionCommitteeIds.val('');
    $submitButton.prop('disabled', 'disabled');

    sendAjaxRequest(URL, send_data, $interactionCompanyIds);

  });

  $("#interaction_committee_id").change(function() {
    var selectedVal = $(this).val();

    if (selectedVal > 0) {
      $interactionCompanyIds.val('');
      $interactionCompanyIds.prop('disabled', 'disabled');
      $interactionRepresentativeId.val('');
      $interactionRepresentativeId.prop('disabled', 'disabled');
      $submitButton.prop('disabled', false);
    } else {
      $interactionCompanyIds.prop('disabled', false);
      $interactionCompanyIds.val('');
      $interactionRepresentativeId.val('');
      $interactionRepresentativeId.prop('disabled', 'disabled');
      $submitButton.prop('disabled', 'disabled');
    }
  });

  $('#interaction_company_id').change(function() {
      var URL = '/update_representative_options';
      var selectedVal = $(this).val();
      var send_data = { id: selectedVal };

    if (selectedVal > 0) {
      $interactionRepresentativeId.prop('disabled', false);

      sendAjaxRequest(URL, send_data, $interactionRepresentativeId);
    } else {
      $interactionRepresentativeId.prop('disabled', 'disabled');
      $interactionRepresentativeId.val('');
    }

    $submitButton.prop('disabled', 'disabled');
  });

  $('#interaction_representative_id').on('change', function() {
    var selectedVal = $(this).val();

    if (selectedVal > 0) {
      $submitButton.prop('disabled', false);
    } else {
      $submitButton.prop('disabled', 'disabled');
    }
  })


  $('#interaction_start_date').on('change input paste', function() {
    var $interactionEndDate = $('#interaction_end_date');
    var enteredDate = $(this).val();

    $interactionEndDate.val(enteredDate);
  });

  $(document).on('click', "tr[data-link]", function() {
    window.location = $(this).data("link")
  });

});

function sendAjaxRequest(URL, send_data, parent_element) {
  $.ajax({
    type: 'GET',
    url: URL,
    data: send_data,
    success: function(data){
      parent_element.html(data)
    }

  })
};
