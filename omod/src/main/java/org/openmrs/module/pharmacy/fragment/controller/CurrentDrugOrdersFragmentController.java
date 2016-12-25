/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.ArrayList;
import java.util.List;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class CurrentDrugOrdersFragmentController {
    
    public void controller(PageModel model, @RequestParam("patientId") Patient patient){
        
        List<drugorders> allOrders = Context.getService(drugordersService.class).getDrugOrdersByPatient(patient);
        
        List<drugorders> patientOrders = new ArrayList<drugorders>();
        
        for(drugorders order : allOrders){
            if(order.getOrderstatus().equals("Active") || order.getOrderstatus().equals("Active-Group")){
                patientOrders.add(order);
            } 
        }
        
        model.addAttribute("patientOrders", patientOrders);
    }    
}
