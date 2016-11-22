package com.plagiar;

import com.plagiar.entities.Department;
import com.plagiar.entities.Category;
import com.plagiar.entities.FilesPlagiar;
import com.plagiar.entities.Groups;
import com.plagiar.entities.Menu;
import com.plagiar.entities.PathsPlagiar;
import com.plagiar.entities.StudentInfo;
import com.plagiar.entities.Submissions;
import com.plagiar.entities.TeacherInfo;
import com.plagiar.entities.University;
import com.plagiar.entities.Users;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.ejb.Remote;
import org.apache.commons.math3.linear.RealVector;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.store.Directory;

@Remote
public interface PlagiarRemote {

    public void addStudentAccountInDatabase(Users users, Groups groups, StudentInfo studentInfo);

    public void addTeacherAccountInDatabase(Users users, Groups groups, TeacherInfo teacherInfo);
    
    public void addUniversityInDatabase(University university);
    
    public void deleteUserFromUserTable(String username, String role);
    
    public void deleteTeacher(String username);
    
    public void deleteStudent(String username);
    
    public List<Department> getDepartmentListByUniversity(String university);
    
    public List<Category> getCategoryListByUniversityAndDepartment(String university, String department);
    
    public List<TeacherInfo> getTeacherListByUniversityAndDepartment(String university, String department);
    
    public FilesPlagiar getFileDetails(String fileLocation);
    
    public List<FilesPlagiar> getSubmissions(String assignedto);
    
    public List<University> getUniversityList();
    
    public List<Category> getCategoryList();
    
    public void addDepartmentInDatabase(Department department);
    
    public List<Department> getDepartmentList();
    
    public List<Submissions> showCheckingHistory();

    public void addCategoryInDatabase(Category category);
    
    public List<Menu> getMenuByUsername(String username);
    
    public StudentInfo getStudentInfo(String username);
    
    public TeacherInfo getTeacherInfo(String username);
    
    public List<Users> getUserList();
    
    public Users getUserRole(String username);
    
    public Users getUserPassword(String username);
    
    public void changePassword(Users users);
    
    public void splitFile2(File file) throws IOException;
    
    public void splitFile1(File file) throws IOException;

    public void createDirectory(String serverPath, String university, String department, String category);
    
    public List<FilesPlagiar> search(String name);
    
    public List<FilesPlagiar> searchCategory(String uni, String dept, String searchCat);
    
    public List<FilesPlagiar> searchDocument(String type);

    //public List<DirectoryPlagiar> getDirectoryList();
    
    public void addFilesInDatabase(FilesPlagiar files);
    
    public void addResultsInDatabase(Submissions submissions);
    
    public List<FilesPlagiar> getFilesList(String uni, String dept, String cat);
    
    public void deleteFile(String fileName, String fileLocation);
    
    public void deleteCategoryFromCategoryTable(String uni, String dept, String cat);
    
    public void deleteCategoryFromFilesTable(String uni, String dept, String cat);
    
    public PathsPlagiar getDirectoryPath(String pathname);
    
    public void generateCosineSimilarity(String t1, String t2) throws IOException;
    
    public double getCosineSimilarity();

    public String generateHashPassword(String password);

}
