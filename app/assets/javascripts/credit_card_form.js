$(document).on('ready turbolinks:load',function(){
  
  console.log('do jquery');
  
  console.log($("input[name=stripe_published_key]").val());
  
  var show_error, stripeResponseHandler, submitHandler;
  
  submitHandler = function(event){
    event.preventDefault();
    console.log('submitHandler');
    var $form = $(event.target);
    
    $form.find("input[type=submit]").prop("disabled", true);
    
    var key = $("input[name=stripe_published_key]").val();
    
    Stripe.setPublishableKey(key); 
    
    if(Stripe){
      Stripe.card.createToken($form, stripeResponseHandler);
    }
    else
     {
       show_error("Failed to load credit card processing functionality. Please reload this page in your browser");
     }
    
    return false;
  };
  
  $(".cc_form").on('submit', submitHandler);
  
  stripeResponseHandler = function(status, response){
    var token, $form;
    
    $form = $(".cc_form");
    
    if(response.error){
      console.log(response.error.message);
      show_error(response.error.message);
      $form.find('input[type="submit"]').prop("disabled",false);
    }
    else
    {
      token = response.id;
      $("input[name=token]").val(token);
      //$form.append($("<input type=\"text\" name=\"payment[token]\"/>").val(token));
      $("[data-stripe=number]").remove();
      $("[data-stripe=cvv]").remove();
      $("[data-stripe=exp-year]").remove();
      $("[data-stripe=exp-month]").remove();
      $("[data-stripe=label]").remove();
      $form.get(0).submit();
    }
    
    return false;
    
  };
  
  show_error = function(message){
    if($("#flash-messages").size() < 1){
      $("div.container.main div.first").prepand("<div id='flash-messages'></div>");
    }
    $("#flash-messages").html('<div class="alert alert-warning"><a class="close" data-dismiss="alert">x</a><div id="flash_alert">' + message + '</div></div>')
    $('.alert').delay(5000).fadeOut(3000);
    
    return false;
  };
  
});