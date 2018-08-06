$(function () {
    // Pass token
    var csrf_token = $('meta[name=csrf-token]').attr('content');
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var params;
    if (csrf_param !== undefined && csrf_token !== undefined) {
      params = csrf_param + "=" + encodeURIComponent(csrf_token);
    }

    // Set global settings
    $R('.redactor', { 
        plugins: ['imagemanager'],
        //imageManagerJson: '/redactor2_rails/images.json',
        imageUpload: '/redactor2_rails/images?' + params,
        fileUpload: '/redactor2_rails/files?' + params,
        lang: 'zh_cn' }
    );
    
    // Initialize Redactor
    $('.redactor').redactor();
});