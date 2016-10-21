/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* global jq */

$(document).ready( function() {
    jq("#pharmaOrderViewWindow").hide();
});

function viewPharmaOrderView(orderId,patientId,patientName,patientDOB,patientAddress,startDate,drugName,route,dose,doseUnits,duration,durationUnits,quantity,quantityUnits,frequency,numRefills,lastDispatchDate,refillInterval,providerInfo,patientinstructions,pharmacistinstructions,diagnosis,isAllergic,associatedOrders){
    $("#pharma_order_id").val(orderId);
    $("#pharma_patient_id").val(patientId);
    $("#pharma_patient_name").val(patientName);
    $("#pharma_patient_dob").val(patientDOB);
    $("#pharma_patient_address").val(patientAddress);
    $("#pharma_start_date").val(startDate);
    $("#pharma_order_details").val(drugName +" "+dose+" "+doseUnits+" "+route+" "+duration+" "+durationUnits+" "+quantity+" "+quantityUnits+" "+frequency);
    $("#pharma_order_refill").val(numRefills);
    $("#pharma_last_dispatch_date").val(lastDispatchDate);
    $("#pharma_order_refillInterval").val(refillInterval);
    $("#order_provider").val(providerInfo);
    $("#pharma_patient_instructions").val(patientinstructions);
    $("#pharma_pharmacist_instructions").val(pharmacistinstructions);
    $("#pharma_order_diagnosis").val(diagnosis);
    if(isAllergic !== "null")
        $("#pharma_order_allergic").val(isAllergic);
    else
        $("#pharma_order_allergic").val("Nil");
    
    var associatedOrderList = associatedOrders.replace("[","").replace("]","").split(',');
    var orderList = "";
    $.each(associatedOrderList,function(index,value){
        if(!value.includes(drugName)){
            orderList = orderList + value;
        }
    });
    $("#associatedOrders").val(orderList);
    
    document.getElementById("pharmaOrderViewWindow").style.display = 'block';
    jq("#pharmaOrderViewWindow").show();
}

function hidePharmaOrderView(){
    jq("#pharmaOrderViewWindow").hide();
    jq("#additionalInformation").hide();
    jq(".icon-plus-sign.edit-action").show();
    jq(".icon-minus-sign.edit-action").hide();
}

function showPharmaActionWindow(){
    jq("#pharmaOrderViewWindow").hide();
}

function hidePharmaActionWindow(orderID,patientID,patientName,patientDOB,patientAddress,startDate,orderDetails,numRefill,lastDispatchDate,refillInterval,providerInfo,patientInst,pharmaInst,diagnosis,isAllergic,orderList){
    jq("#pharmaOrderActionWindow").hide();
    $("#pharma_order_id").val(orderID);
    $("#pharma_patient_id").val(patientID);
    $("#pharma_patient_name").val(patientName);
    $("#pharma_patient_dob").val(patientDOB);
    $("#pharma_patient_address").val(patientAddress);
    $("#pharma_start_date").val(startDate);
    $("#pharma_order_details").val(orderDetails);
    $("#pharma_order_refill").val(numRefill);
    $("#pharma_last_dispatch_date").val(lastDispatchDate);
    $("#pharma_order_refillInterval").val(refillInterval);
    $("#order_provider").val(providerInfo);
    $("#pharma_patient_instructions").val(patientInst);
    $("#pharma_pharmacist_instructions").val(pharmaInst);
    $("#pharma_order_diagnosis").val(diagnosis);
    if(isAllergic !== "Nil")
        $("#pharma_order_allergic").val(isAllergic);
    else
        $("#pharma_order_allergic").val("Nil");
    $("#associatedOrders").val(orderList);
    jq("#pharmaOrderViewWindow").show();
}

function closeSearchResultsWindow(){
    jq("#searchResultsWindow").hide();
}

function closeAssociatedOrdersWindow(){
    jq("#associatedOrdersTableWrapper").hide();
}

function autoCompletePatientName(patientNameList){
    var list = patientNameList.replace("[","").replace("]","").split(',');
    console.log(list);
    $("#patient_full_name").autocomplete({
       source : list,
       select : function( event , ui ) {
           $("#patient_full_name").val(ui.item.label);
           $("#searchByPatient").submit();
       }
    });
}