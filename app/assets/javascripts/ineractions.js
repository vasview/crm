$(document).ready(function() {

  $('#all_members_selected').change(function(){
    var $interactionCategoryIds = $("#interaction_category_id");
    var $interactionCommitteeIds = $("#interaction_committee_id");
    var $interactionCompanyIds = $('#interaction_company_id');

    if ($(this).is(":checked")){
      console.log('checkbox is checked');
      $interactionCategoryIds.prop('disabled', 'disabled')
      $interactionCompanyIds.prop('disabled', 'disabled')
      $interactionCommitteeIds.prop('disabled', 'disabled')
    } else {
      $interactionCategoryIds.prop('disabled', false)
      $interactionCompanyIds.prop('disabled', false)
      $interactionCommitteeIds.prop('disabled', false)
    }
  });

  $('#interaction_category_id').change(function() {
    var $interactionCommitteeIds = $("#interaction_committee_id");
    var $interactionCompanyIds = $('#interaction_company_id');
    var selectedVal = $(this).val();

    if (selectedVal > 0) {
      $interactionCommitteeIds.prop('disabled', 'disabled')
      $interactionCompanyIds.prop('disabled', false)
    } else {
      $interactionCommitteeIds.prop('disabled', false)
      $interactionCompanyIds.prop('disabled', 'disabled')
    }
  });

  $('#interaction_start_date').on('change input paste', function () {
    var $interactionEndDate = $('#interaction_end_date');
    var enteredDate = $(this).val();

    $interactionEndDate.val(enteredDate);
  });

})
