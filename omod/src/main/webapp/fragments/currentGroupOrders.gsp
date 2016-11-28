<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
%>

<div id="activeOrdersWindow">
    <table id="currentGroupOrdersTable">
        <thead>
            <tr>
                <th id="patientSort">Patient Name</th>
                <th id="patientSort">Patient DOB</th>
                <th id="detailsSort">Drug Name <span class="pull-right">Start Date</span></th>
            </tr>
        </thead>
        <tbody>
            <% patientPlanOrders.each { patientPlanOrder -> %>
                <% patientPlanOrder.value.each { order -> %>
                    <tr class="groupRow">
                        <td>${ patientName.get(patientPlanOrder.key) }</td>
                        
                        <td>${ patientDOB.get(patientPlanOrder.key).format('yyyy-MM-dd') }</td>
                                                
                        <td>
                            <% order.value.each { o -> %>
                          
                                <div>
                                    <span>${ o.drugname.getDisplayString().toUpperCase() }</span>
                                    <span class="pull-right">${ o.startdate.format('yyyy-MM-dd') }</span>
                                </div>
                            <% } %>
                        </td>
                    </tr>   
                <% } %>
            <% } %>
            
            <% patientSingleOrders.each { patientSingleOrder -> %>
                <tr class="groupRow">
                    <td>${ patientName.get(patientSingleOrder.key) }</td>

                    <td>${ patientDOB.get(patientSingleOrder.key).format('yyyy-MM-dd') }</td>

                    <td>
                        <% patientSingleOrder.value.each { o -> %>

                            <div>
                                <span>${ o.drugname.getDisplayString().toUpperCase() }</span>
                                <span class="pull-right">${ o.startdate.format('yyyy-MM-dd') }</span>
                            </div>
                        <% } %>
                    </td>
                </tr> 
            <% } %>
            
        </tbody>
    </table>
</div>

<script>
    jq('#currentGroupOrdersTable').dataTable({
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
    jq(".groupRow").click(function(){
        jq(this).css({"background": "#75b2f0","color": "white"});
    });
</script>