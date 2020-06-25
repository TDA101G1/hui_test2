$("div.front img").on("mouseenter", function(){
    $(this).addClass("turn_over");
$(this).closest("div").prev().find("img").removeClass("turn_over");
});
$("div.front img").on("mouseleave", function(){
    $(this).removeClass("turn_over");
    $(this).closest("div").prev().find("img").addClass("turn_over");
});



