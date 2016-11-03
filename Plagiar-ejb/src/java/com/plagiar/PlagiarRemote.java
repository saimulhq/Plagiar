package com.plagiar;

import com.plagiar.entities.DirectoryPlagiar;
import com.plagiar.entities.FilesPlagiar;
import com.plagiar.entities.Groups;
import com.plagiar.entities.Menu;
import com.plagiar.entities.PathsPlagiar;
import com.plagiar.entities.StudentInfo;
import com.plagiar.entities.TeacherInfo;
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

    public void addCategoryInDatabase(DirectoryPlagiar directory);
    
    public List<Menu> getMenuByUsername(String username);
    
    public StudentInfo getStudentInfo(String username);
    
    public TeacherInfo getTeacherInfo(String username);
    
    public Users getUserRole(String username);

    public void createDirectory(String serverPath, String category);

    public List<DirectoryPlagiar> getDirectoryList();
    
    public void addFilesInDatabase(FilesPlagiar files);
    
    public List<FilesPlagiar> getFilesList(String category);
    
    public PathsPlagiar getDirectoryPath(String pathname);
    
    public void CosineDocumentSimilarity(String t1, String t2) throws IOException;
    
    public double getCosineSimilarity();

    public String generateHashPassword(String password);

}
