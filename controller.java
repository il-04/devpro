package com.dp.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller

public class Logincontroller {
@GetMapping("/")
public String homepage () {
    return "home.html";
}

}

   CourseController.java 
package com.batch2.artifact1.controller; 
import org.springframework.beans.factory.annotation.Autowired; import org.springframework.stereotype.Controller; 
import org.springframework.ui.Model; 
import org.springframework.web.bind.annotation.GetMapping; import org.springframework.web.bind.annotation.ModelAttribute; import org.springframework.web.bind.annotation.PathVariable; import org.springframework.web.bind.annotation.PostMapping; import com.batch2.artifact1.domain.Student; 
import com.batch2.artifact1.service.CourseService; 
@Controller 
public class CourseController { 
 @Autowired 
 private CourseService service; 
 @GetMapping("welcome") 
 public String viewHomePage(Model model) { 
 model.addAttribute("liststudent", service.listAll());  return "welcome"; 
 } 
 @GetMapping("new") 
 public String addStudentForm(Model model) { 
 model.addAttribute("student", new Student()); 
 return "new"; 
 } 
 @PostMapping("save") 
 public String saveStudent(@ModelAttribute Student student) {  service.save(student); 
 return "redirect:/welcome"; 
 } 
 @GetMapping("edit/{id}") 
 public String showEditForm(@PathVariable long id, Model model) {
 model.addAttribute("student", service.get(id));  return "new"; 
 } 
 @GetMapping("delete/{id}") 
 public String deleteStudent(@PathVariable long id) {  service.delete(id); 
 return "redirect:/welcome"; 
 } 
 @GetMapping("/logout") 
 public String logout() { 
 return "login"; 
 } 
}
