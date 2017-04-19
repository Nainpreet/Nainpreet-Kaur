$ ->
  $(document).on 'change', '#departments_select', (evt) ->
    $.ajax 'update_doctors',
      type: 'GET'
      dataType: 'script'
      data: {
        department_id: $("#departments_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic Doctors Selected OK!")
