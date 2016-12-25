<%
    ui.decorateWith("appui", "standardEmrPage");
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "pharmacy.js")
    def isSelected = 0;
%>

<script type="text/javascript">
    var breadcrumbs = [
        { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
        { label: "${ ui.message("Pharmacy") }" }
    ];
</script>

<div>
    <h3>
        <i class="icon-medicine"></i>
        <strong>${ ui.message("ACTIVE DRUG ORDERS") } <label id="selectedPatient"></label>
            <span class="pageLinks pull-right" onclick="location.href='${ui.pageLink("pharmacy", "pharmacyGroup")}';">Display By Group >></span>
        </strong>
    </h3>
    Click on an order to view allowed <strong>Refills</strong> and <strong>Last-Dispatch-Date</strong>
</div><br/>

<div class="info-body">

    <div id="currentDrugOrdersWindow">
        <p class="fields">${ ui.includeFragment("pharmacy", "associatedOrderView") }</p>
                
        <div id="currentOrdersWindow">
            <p class="fields"><strong>ALL INDIVIDUAL DRUG ORDERS</strong></p><br/>
            ${ ui.includeFragment("pharmacy", "currentDrugOrders") } <br/>

            <p class="fields"><strong>ALL MEDICATION PLAN ORDERS</strong></p><br/>
            ${ ui.includeFragment("pharmacy", "currentMedPlans") } <br/>
        </div>
        
    </div>
    
    <div id="pharmaOrderViewWindow" class="dialog">
        ${ ui.includeFragment("pharmacy", "pharmaOrderView") }
    </div>

    <% if(!(pharma_order_id).equals("") && !order_status.equals("")) { %>
        <div id="pharmaOrderActionWindow" class="dialog">
            ${ ui.includeFragment("pharmacy", "pharmaActionWindow") }
        </div>
    <% } %>
</div>