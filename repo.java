RegRepo.java 
package com.batch2.artifact1.repository; 
import org.springframework.data.jpa.repository.JpaRepository; import org.springframework.stereotype.Repository; 
import com.batch2.artifact1.domain.Login; 
@Repository 
public interface RegRepo extends JpaRepository<Login, String> {  Login findByUsername(String username); 
} 
   LoginRepo.java 
package com.dp.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.dp.demo.domain.User;

@Repository
public interface Loginrepo extends JpaRepository<User, String> {
User findByUsernameAndPassword(String username , String password);
}
CourseRepo.java 
package com.batch2.artifact1.repository; 
import org.springframework.data.jpa.repository.JpaRepository; import com.batch2.artifact1.domain.Student;
public interface CourseRepo extends JpaRepository<Student, Long> { } 
