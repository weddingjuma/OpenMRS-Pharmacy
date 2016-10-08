/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* global jq */

$(document).ready( function() {
    jq("#pharmaOrderViewWindow").hide();
});

function viewPharmaOrderView(orderId,patientId,patientName,patientDOB,patientAddress,startDate,drugName,route,dose,doseUnits,duration,durationUnits,quantity,quantityUnits,frequency,numRefills,refillInterval,providerInfo,patientinstructions,pharmacistinstructions){
    $("#pharma_order_id").val(orderId);
    $("#pharma_patient_id").val(patientId);
    $("#pharma_patient_name").val(patientName);
    $("#pharma_patient_dob").val(patientDOB);
    $("#pharma_patient_address").val(patientAddress);
    $("#pharma_start_date").val(startDate);
    $("#pharma_order_details").val(drugName +" "+dose+" "+doseUnits+" "+route+" "+duration+" "+durationUnits+" "+quantity+" "+quantityUnits+" "+frequency);
    $("#pharma_order_refill").val(numRefills);
    $("#pharma_order_refillInterval").val(refillInterval);
    $("#order_provider").val(providerInfo);
    $("#pharma_patient_instructions").val(patientinstructions);
    $("#pharma_pharmacist_instructions").val(pharmacistinstructions);
    jq("#pharmaOrderViewWindow").show();
}

function hidePharmaOrderView(){
    jq("#pharmaOrderViewWindow").hide();
}

function showPharmaActionWindow(){
    jq("#pharmaOrderViewWindow").hide();
}

function hidePharmaActionWindow(orderID,patientID,patientName,patientDOB,patientAddress,startDate,orderDetails,numRefill,refillInterval,providerInfo,patientInst,pharmaInst){
    jq("#pharmaOrderActionWindow").hide();
    $("#pharma_order_id").val(orderID);
    $("#pharma_patient_id").val(patientID);
    $("#pharma_patient_name").val(patientName);
    $("#pharma_patient_dob").val(patientDOB);
    $("#pharma_patient_address").val(patientAddress);
    $("#pharma_start_date").val(startDate);
    $("#pharma_order_details").val(orderDetails);
    $("#pharma_order_refill").val(numRefill);
    $("#pharma_order_refillInterval").val(refillInterval);
    $("#order_provider").val(providerInfo);
    $("#pharma_patient_instructions").val(patientInst);
    $("#pharma_pharmacist_instructions").val(pharmaInst);
    jq("#pharmaOrderViewWindow").show();
}

function closeSearchResultsWindow(){
    jq("#searchResultsWindow").hide();
}

function autoCompleteFirstName(firstNameList){
    var list = firstNameList.replace("[","").replace("]","").split(',');
    console.log(list);
    $("#patient_first_name").autocomplete({
       source : list
    });
}

function autoCompleteLastName(lastNameList){
    var list = lastNameList.replace("[","").replace("]","").split(',');
    console.log(list);
    $("#patient_last_name").autocomplete({
       source : list
    });
}