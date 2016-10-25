package com.plagiar;

import com.plagiar.entities.Directory;
import com.plagiar.entities.Files;
import com.plagiar.entities.Groups;
import com.plagiar.entities.Paths;
import com.plagiar.entities.StudentInfo;
import com.plagiar.entities.TeacherInfo;
import com.plagiar.entities.Users;
import java.util.List;
import javax.ejb.Remote;

@Remote
public interface PlagiarRemote {

    public void addStudentAccountInDatabase(Users users, Groups groups, StudentInfo studentInfo);

    public void addTeacherAccountInDatabase(Users users, Groups groups, TeacherInfo teacherInfo);

    public void addCategoryInDatabase(Directory directory);

    public void createDirectory(String serverPath, String category);

    public List<Directory> getDirectoryList();
    
    public void addFilesInDatabase(Files files);
    
    public List<Files> getFilesList(String category);
    
    public Paths getDirectoryPath(String pathname);

    public String generateHashPassword(String password);

}
