
package com.plagiar;

import com.plagiar.entities.Directory;
import com.plagiar.entities.Groups;
import com.plagiar.entities.StudentInfo;
import com.plagiar.entities.TeacherInfo;
import com.plagiar.entities.Users;
import javax.ejb.Remote;

@Remote
public interface PlagiarRemote {

    public void addStudentAccountInDatabase (Users users, Groups groups, StudentInfo studentInfo);
    
    public void addTeacherAccountInDatabase (Users users, Groups groups, TeacherInfo teacherInfo);
    
    public void addCategoryInDatabase(Directory directory);
    
    public void createDirectory(String category);
    
    public String generateHashPassword(String password);
    
}
