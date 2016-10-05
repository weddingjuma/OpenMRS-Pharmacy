/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.openmrs.module.pharmacy.fragment.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.openmrs.DrugOrder;
import org.openmrs.Person;
import org.openmrs.Provider;
import org.openmrs.api.APIException;
import org.openmrs.api.context.Context;
import org.openmrs.module.drugorders.api.drugordersService;
import org.openmrs.module.drugorders.drugorders;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author harini-geek
 */
public class SearchOrderViewFragmentController {
    
    
    public void controller(PageModel model,@RequestParam(value = "patient_first_name", required = false) String patient_first_name,
                            @RequestParam(value = "patient_last_name", required = false) String patient_last_name,
                            @RequestParam(value = "action", required = false) String action){
       
        String first_name = patient_first_name.replace(" ", "");
        String last_name = patient_last_name.replace(" ", "");
        model.addAttribute("patient_first_name", first_name);
        model.addAttribute("patient_last_name", last_name);
                                
        if(StringUtils.isNotBlank(action)){
            try {
                if("searchByPatient".equals(action)){
                    boolean patient_found = false;
                    Date patient_DOB = null;
                    String patient_address = null;
                    String patient_identifier = null;
                    String provider_identifier = null;
                    HashMap<Integer,String> providerIdentifiers = new HashMap<Integer,String>();
                    
                    List<Integer> orders = new ArrayList<Integer>();
                    ArrayList<DrugOrder> drugOrdersMain = new ArrayList<DrugOrder>();
                    ArrayList<drugorders> drugOrdersExtension = new ArrayList<drugorders>();
                                
                    if(!(first_name).equals("") && !(last_name).equals("")){
                        
                        List<drugorders> allOrders = Context.getService(drugordersService.class).getAllDrugOrders();
                        
                        for(drugorders order : allOrders){
                            Person person = Context.getPersonService().getPerson(Integer.parseInt(order.getPatientid()));
                            
                            if(person.getGivenName().equals(first_name) && person.getFamilyName().equals(last_name)){
                                patient_found = true;
                                model.addAttribute("PatientFound", patient_found);
                                orders.add(order.getOrderId());
                                patient_DOB = person.getBirthdate();
                                patient_address = person.getPersonAddress().getAddress1() + " " + person.getPersonAddress().getCityVillage() + " " + person.getPersonAddress().getStateProvince() + " Zipcode:" + person.getPersonAddress().getPostalCode() + " " + person.getPersonAddress().getCountry();
                                patient_identifier = Context.getPatientService().getPatient(Integer.parseInt(order.getPatientid())).getPatientIdentifier().toString();
                            }
                        }
                    }
                    
                    if(patient_found){
                        for(Integer order : orders){
                            DrugOrder drugOrderMain = (DrugOrder) Context.getOrderService().getOrder(order);
                            drugOrdersMain.add(drugOrderMain);
                            
                            drugorders drugOrderExtension = Context.getService(drugordersService.class).getDrugOrderByOrderID(drugOrderMain.getOrderId());
                            drugOrdersExtension.add(drugOrderExtension);
                            
                            Provider provider = Context.getOrderService().getOrder(drugOrderMain.getOrderId()).getOrderer();
                            provider_identifier = provider.getPerson().getGivenName() + " " + provider.getPerson().getFamilyName() + ", " + StringUtils.capitalize(provider.getIdentifier());
                            providerIdentifiers.put(order, provider_identifier);
                        }
                        
                        model.addAttribute("patient_DOB", patient_DOB);
                        model.addAttribute("patient_address", patient_address);
                        model.addAttribute("patient_identifier", patient_identifier);
                        model.addAttribute("providerIdentifiers",providerIdentifiers);
                        
                        model.addAttribute("drugOrdersMain", drugOrdersMain);
                        model.addAttribute("drugOrdersExtension", drugOrdersExtension);
                    }
                    
                    if(!patient_found){
                        model.addAttribute("PatientFound", patient_found);
                    }
                }
            }
            catch (NumberFormatException e){
                System.out.println(e.toString());
            } catch (APIException e) {
                System.out.println(e.toString());
            }
        }
    }
}