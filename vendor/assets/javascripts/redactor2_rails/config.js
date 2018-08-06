$(function () {
    // Pass authenticity_token
    var csrf_token = $('meta[name=csrf-token]').attr('content');
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var params;
    if (csrf_param !== undefined && csrf_token !== undefined) {
      params = csrf_param + "=" + encodeURIComponent(csrf_token);
    }
    $R('.redactor', { 
         //plugins: ['video', 'fullscreen', 'textdirection', 'clips'],
        imageUpload: '/redactor2_rails/images',
        imageUploadFields: params,
        fileUpload: '/redactor2_rails/files',
        fileUploadFields: params,
        lang:'zh_cn' }
    );
    $R.options = {
        buttonsTextLabeled: true
    };
    $('.redactor').redactor();


    // Pass authenticity_token
    var params = '[name="authenticity_token"]';
    // Set global settings
    $.Redactor.settings = {
        //plugins: ['source', 'fullscreen', 'textdirection', 'clips'],
        imageUpload: '/redactor2_rails/images',
        imageUploadFields: params,
        fileUpload: '/redactor2_rails/files',
        fileUploadFields: params
    };
    // Initialize Redactor
    $('.redactor').redactor();
});