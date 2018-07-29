// Grab elements, create settings, etc.
var video = document.getElementById('video');

// Get access to the camera!
if(navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
    // Not adding `{ audio: true }` since we only want video now
    navigator.mediaDevices.getUserMedia({ video: true }).then(function(stream) {
        video.src = window.URL.createObjectURL(stream);
        video.play();
    });
}

var $video = $("video");
$video.hide();

var $avail = $(".btn-success");
var $booked = $(".btn-warning");
$booked.hide();

function getStatus(){
    $.get('get_status', function(data) {
    	if (data == 'available') {
	        setTimeout(getStatus, 500);
	    } else if (data == 'booked') {
	    	$avail.hide();
	    	$booked.show();
	        setTimeout(function () {
	        	$booked.hide();
	        	$video.show();
	        }, 15000);
	    }
    });
}

function displayModal() {
	$(".modal").modal();
	//setTimeout() move to the next page
}


function sendPhotoToServer() {
	var canvas = document.getElementById("canvas");
	var context = canvas.getContext("2d");
	context.drawImage(video, 0, 0, 640, 480);
	var dataUrl = canvas.toDataURL("image/jpeg", 0.85);
	var formData = new FormData();
	formData.append('imageData', dataUrl);

	$.ajax({
		type: "POST",
		url: "/upload_pic",
		data: { 
			imgBase64: dataUrl
		},
		processData: false,
		contentType: false,
		success: function(data){
			if (data == '') {

			} else {

			}
		},
		error: function(data){
			sendPhotoToServer()
		}
	});
}

//getStatus()

$avail.hide();
$video.show();
setTimeout(sendPhotoToServer, 2000);