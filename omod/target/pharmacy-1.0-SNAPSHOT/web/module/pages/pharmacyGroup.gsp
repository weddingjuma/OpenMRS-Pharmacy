<%
    ui.decorateWith("appui", "standardEmrPage");
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "pharmacy.js")
%>

<script type="text/javascript">
    var breadcrumbs = [
        { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
        { label: "${ ui.message("Pharmacy") }" , link: '${ui.pageLink("pharmacy", "pharmacyPatient")}'},
        { label: "${ ui.format(patient.familyName) }, ${ ui.format(patient.givenName) }"}
    ];
     
    var patient = { id: ${ patient.id } };

</script>
 
${ ui.includeFragment("coreapps", "patientHeader", [ patient: patient ]) }

<div class="info-body">
    
    <div id="allergyList">
        <strong>Drug Allergies:</strong>
        <% if (allergies.allergyStatus != "See list") { %>
            ${ ui.message(allergies.allergyStatus) }
        <% } else { %>
            <% allergies.each { allergy -> %>
                ${ allergy.allergen }
            <% } %>
        <% } %>

    </div> <br/>
    
    <div>
        <div id="line-break"></div>
        <h3>
            <i class="icon-medicine"></i>
            <strong>${ ui.message("ACTIVE DRUG ORDERS") }
                <span class="pageLinks pull-right" onclick="location.href='${ui.pageLink("pharmacy", "pharmacySingle", [patientId: patient.patientId])}';">DISPLAY BY ORDER >></span>
            </strong>
        </h3>
        <div id="line-break"></div>
    </div> <br/>

    <div id="currentDrugOrdersWindow">
        <div id="currentOrdersWindow">
            <br/> ${ ui.includeFragment("pharmacy", "currentGroupOrders") } <br/>
        </div>
    </div>
    
    <div id="pharmaGroupViewWindow">
        ${ ui.includeFragment("pharmacy", "pharmaGroupView") }
    </div>

</div>