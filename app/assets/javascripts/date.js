$(document).on("turbolinks:load", function (){
    $("#datetimepicker").kendoDateTimePicker({
        value: new Date(),
        dateInput: true
    });
});
