<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
    def last_dispatch_date = "";
%>

<% if(!(patient_name).equals("")) { %>
    <div id="searchResultsWindow">
        
        <% if(PatientFound) { %>
            <span class="searchResults"><strong>SEARCH RESULTS - ${ patient_name }</strong>
            <i class="icon-remove-sign edit-action pull-right" onclick="closeSearchResultsWindow()" title="${ ui.message("Close") }"></i></span><br/><br/>

            <table id="searchOrdersTable">
                <thead>
                    <tr>
                        <th id="patientSort">Patient Name</th>
                        <th id="drugSort">Drug Name</th>
                        <th id="dateSort">Start Date</th>
                        <th id="prioritySort">Priority</th>
                    </tr>
                </thead>
                <tbody>
                    <% drugOrdersMain.each { dorder_main -> %>
                    
                        <% if(((drugOrdersExtension.get(dorder_main.key).orderstatus).equals("Active") || (drugOrdersExtension.get(dorder_main.key).orderstatus).equals("Active-Plan") || (drugOrdersExtension.get(dorder_main.key).orderstatus).equals("Active-Group") || (drugOrdersExtension.get(dorder_main.key).orderstatus).equals("Hold"))) { %>

                            <% def otherOrdersInGroup = "Nil" %>
                            <% if(drugOrdersExtension.get(dorder_main.key).orderstatus == "Active-Group" || drugOrdersExtension.get(dorder_main.key).orderstatus == "Active-Plan") { %>
                                <% otherOrdersInGroup = otherOrders.get(drugOrdersExtension.get(dorder_main.key).orderId) %>
                            <% } %>

                            <% if(drugOrdersExtension.get(dorder_main.key).lastdispatchdate != null) { %>
                                <% last_dispatch_date = drugOrdersExtension.get(dorder_main.key).lastdispatchdate.format('yyyy-MM-dd'); %>
                            <% } else { %>
                                <% last_dispatch_date = drugOrdersExtension.get(dorder_main.key).lastdispatchdate; %>
                            <% } %>
                            
                            <tr class="orderRow" onclick="viewPharmaOrderView('${ dorder_main.key }','${ patient_identifier }','${ patient_name }','${ patient_DOB.format('yyyy-MM-dd') }','${ patient_address }','${ drugOrdersExtension.get(dorder_main.key).startdate.format('yyyy-MM-dd') }','${ drugOrdersExtension.get(dorder_main.key).drugname.getDisplayString() }','${ dorder_main.value.route.getDisplayString() }','${ dorder_main.value.dose }','${ dorder_main.value.doseUnits.getDisplayString() }','${ dorder_main.value.duration }','${ dorder_main.value.durationUnits.getDisplayString() }','${ dorder_main.value.quantity }','${ dorder_main.value.quantityUnits.getDisplayString() }','${ dorder_main.value.frequency }','${ drugOrdersExtension.get(dorder_main.key).refill }','${ last_dispatch_date }','${ drugOrdersExtension.get(dorder_main.key).refillinterval }','${ providerIdentifiers.get(dorder_main.key) }','${ drugOrdersExtension.get(dorder_main.key).patientinstructions }','${ drugOrdersExtension.get(dorder_main.key).pharmacistinstructions }','${ drugOrdersExtension.get(dorder_main.key).associateddiagnosis.getDisplayString() }','${ drugOrdersExtension.get(dorder_main.key).isallergicorderreasons }','${ otherOrdersInGroup }')">
                                <td>${ patient_name }</td>
                                <td>${ drugOrdersExtension.get(dorder_main.key).drugname.getDisplayString() }</td>
                                <td>${ drugOrdersExtension.get(dorder_main.key).startdate.format('yyyy-MM-dd') }</td>
                                <td>${ drugOrdersExtension.get(dorder_main.key).priority.getDisplayString() }</td>
                            </tr>
                        <% } %>
                    <% } %>
                </tbody>
            </table>
            <br/><div id="line-break"></div>
            
        <% } else { %>
            <span class="searchResults"><strong>Search Results</strong>
            <i class="icon-remove-sign edit-action pull-right" onclick="closeSearchResultsWindow()" title="${ ui.message("Clear") }"></i></span><br/><br/>
            <span class="fields">No Orders Found</span>
        <% } %>
        
    </div><br/>
    
<% } %>

<script>
    jq('#searchOrdersTable').dataTable({
        "sPaginationType": "full_numbers",
        "bPaginate": true,
        "bAutoWidth": false,
        "bLengthChange": true,
        "bSort": true,
        "bJQueryUI": true,
        "bInfo": false,
        "bFilter": false

    });
</script>

<script type="text/javascript">    
    jq(".orderRow").click(function(){
        jq(this).css({"background": "#75b2f0","color": "white"});
    });
</script>