$.getJSON( "data.json" ).done(function(data) {
    $("#current").html(Math.round(data.current));
    $("#high").html(data.high);
    $("#low").html(data.low);
    $("#icon").attr("src",data.icon_url);
    $("#condition").html(data.condition);

    var pjs;
    if (data.low < 45) {
        pjs = "Winter PJs";
    } else if (data.low < 55) {
        pjs = "Long-sleeve PJs";
    } else {
        pjs = "Short PJs";
    }
    $("#pjs").html(pjs);

    var clothes;
    var HOT = "Shorts/short-sleeve shirt";
    var MODERATE = "Long pants/short-sleeve shirt";
    var COLD = "Fuzzy pants/long-sleeve shirt";
    if (data.high < 55) {
        clothes = COLD;
    }
    if (data.current < 50) {
        if (data.high > 60) {
            clothes = MODERATE;
        } else {
            clothes = COLD;
        }
    } else if (data.current < 55 && data.high < 65) {
        clothes = MODERATE;
    } else {
        clothes = HOT;
    }
    $("#clothes").html(clothes);
});
