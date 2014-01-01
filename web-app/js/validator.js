$.fn.validate = function(container,position){
	if (position==undefined)
		position="top";
	if (container==undefined)
		container=$("#messages");
	if (container.length==0)
		container =$(".container");
	if (container.length==0)
		container =$("body");
	
	var hasErrors = {has:false};
	var emptyFields=[];	
	var nonNumericFields=[];
	var incorrectRangeFields=[];
	var validateableObjs = $(".validateable", this);
	validateableObjs.each(function(key,value){
		
		var fieldName = $(this).data('label')?$(this).data('label'):null;
		
		//Required fields (Max : 1 MSG)
		if ($(this).attr('nonempty')!=undefined)
			if (!doValidate($(this).val()=='',hasErrors,emptyFields,fieldName,$(this))) 
				return;
		
		
		
		
		//Mask fields
		if ($(this).attr('mask')!=undefined){
			var msg
			var regExp = new RegExp($(this).attr('mask'),'g');
			if (!regExp.test($(this).val())){
				hasErrors.has=true;
				printDefaultMsg("El campo","posee datos erroneos",fieldName,container,position);
				$(this).parent().addClass('has-error');
				return;
			}	
			else
				$(this).parent().removeClass('has-error');
		}
		
		//Numeric 
		if ($(this).attr('numeric')!=undefined){
			var integer = $(this).data('integer')=="yes";
			var range = $(this).data("range").split("..");
			var value = $(this).val();
			if (!doValidate(!$.isNumeric(value),hasErrors,nonNumericFields,fieldName,$(this)))
				return;
			
		//Numeric - Range
			value = parseFloat(value);
			if ($(range).size()==2){
				var start=parseFloat(range[0]);
				var end = parseFloat(range[1]);
				if (!doValidate(! (value>=start && value<=end),hasErrors,incorrectRangeFields,fieldName,$(this)))
					return;				
			}			
		}
			
	});
	
	
	//Required fields summary
	summary(emptyFields,"Debe completar el/los siguientes campos","Debe completar el/los campos requeridos.",container,position);
	
	//Numeric fields summary
	summary(nonNumericFields,"El/los siguientes campos deben ser numericos","El/los campos deben ser numericos.",container,position);
	
	// Numeric - IncorrectRange summary
	summary(incorrectRangeFields,"El/los siguientes campos deben estar dentro del rango determinado","El/los campos deben estar dentro del rango determinado.",container,position);

	return !hasErrors.has;
}

function addMessage(type,msg,container,position){
// type = success | info | warning | danger
   alertDiv = $('<div class="alert alert-dismissable alert-'+type+' "><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'+msg+'</div>');
   if (position=="top")
        alertDiv.prependTo(container);
    else    
        alertDiv.appendTo(container);
}

function printDefaultMsg(before,after,fieldName,container, position){
	var msg;
	if (fieldName)
		msg = before+' <i>'+fieldName+'</i> '+after;
	else
		msg = before+' '+after;
		addMessage('danger', msg, container, position);
}


function summary(array,detailedMsg,genericMsg,container,position){
	if ($(array).size()>0){
		if ($.inArray( null, array )==-1){
			var msg = '<b>'+detailedMsg+':</b> <ul>';
			$.each(array,function(key,value){
				msg+='<li>'+value+'</li>';
			});
			msg+='</ul>';
			addMessage('danger', msg, container, position);
		}
		else
			addMessage('danger',genericMsg ,container,position);
	}
}


function doValidate(hasErrors,hasErrorsVar,array,fieldName,field){
	if (hasErrors){
		hasErrorsVar.has=true;
		array.push(fieldName);
		field.parent().addClass('has-error');
		return false;
	}
	else{
		field.parent().removeClass('has-error');
		return true;
	}
}