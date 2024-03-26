$('.yes').on('click',function(e){
  e.preventDefault();
  $.post('http://vrp_barbershop/updateSkin',JSON.stringify({
    value: true,
    hairModel: $('#hair').val(),
    firstHairColor: $('#haircolor').val(),
    secondHairColor: $('#haircolor2').val(),
    makeupModel: $('#makeup').val(),
    makeupintensity: $('#makeupintensity').val(),
    makeupcolor: $('#makeupcolor').val(),
    lipstickModel: $('#lipstick').val(),
    lipstickintensity: $('#lipstickintensity').val(),
    lipstickColor: $('#lipstickcolor').val(),
    eyebrowsModel: $('#eyebrow').val(),
    eyebrowintensity: $('#eyebrowintensity').val(),
    eyebrowsColor: $('#eyebrowcolor').val(),
    beardModel: $('#beard').val(),
    beardintentisy: $('#beardintentisy').val(),
    beardColor: $('#beardcolor').val(),
    blushModel: $('#blush').val(),
    blushintentisy: $('#blushintentisy').val(),
    blushColor: $('#blushcolor').val(),
    eyesColor: $('#eyescolor').val(),
  }));
});

document.onkeydown = function (data) {
  if (data.which == 65) {
    $.post('http://vrp_barbershop/rotate', JSON.stringify('right'));
  }
  if (data.which == 68) {
    $.post('http://vrp_barbershop/rotate', JSON.stringify('left'));
  }
  if (data.which == 27) {
    $.post('http://vrp_barbershop/closeNui');
  }
};