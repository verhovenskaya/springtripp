package com.boots.controller;



import com.boots.entity.Order;
import com.boots.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping
    public String showOrderForm(Model model) {
        model.addAttribute("order", new Order());
        model.addAttribute("carTypes", Order.car_type.values());
        List<String> paymentMethods = Arrays.asList("cash", "card");
        model.addAttribute("paymentMethods", paymentMethods);
        return "index";
    }

    @PostMapping
    public String submitOrder(@Valid @ModelAttribute("order") Order order,
                              BindingResult bindingResult, RedirectAttributes redirectAttributes) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAuthenticated = authentication != null && !authentication.getName().equals("anonymousUser");

        if (bindingResult.hasErrors()) {
            // If validation fails, add error message and return to the order form
            redirectAttributes.addFlashAttribute("errorMessage", "Please fill in all required fields.");
            return "redirect:/";
        }

        if (!isAuthenticated) {
            return "redirect:/registration";
        }

        try {
            orderService.saveOrder(order);
            // If order is saved successfully, set a success message and redirect to order confirmation page
            redirectAttributes.addFlashAttribute("successMessage", "Order submitted successfully!");
            return "redirect:/order-confirmation";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "An error occurred while processing your order. Please try again later.");
            return "redirect:/";
        }
    }
}
/*@Controller
@RequestMapping("/")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping
    public String showOrderForm(Model model) {
        model.addAttribute("order", new Order());
        model.addAttribute("carTypes", Order.car_type.values()); // Access the CarType enum
        List<String> paymentMethods = Arrays.asList("cash", "card");
        model.addAttribute("paymentMethods", paymentMethods);


        //model.addAttribute("paymentMethods", Order.paymentMethod.values()); // Access the PaymentMethod enum
        return "index";
    }

    @PostMapping
    public String submitOrder(@Valid @ModelAttribute("order") Order order,
                              BindingResult bindingResult) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAuthenticated = authentication != null && !authentication.getName().equals("anonymousUser");

        if (bindingResult.hasErrors()) {
            return "index"; // Return to the order form if validation fails
        }

        if (!isAuthenticated) {
            return "redirect:/registration"; // Redirect to registration if not logged in
        }

        orderService.saveOrder(order);

        return "redirect:/order"; // Redirect back to order form
    }
}*/