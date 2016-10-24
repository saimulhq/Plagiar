
package com.plagiar;


import com.plagiar.entities.Directory;
import com.plagiar.entities.Groups;
import com.plagiar.entities.StudentInfo;
import com.plagiar.entities.TeacherInfo;
import com.plagiar.entities.Users;
import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Stateless
public class Plagiar implements PlagiarRemote {
    @PersistenceContext(unitName = "Plagiar-ejbPU")
    private EntityManager em;
    
    Users users;
    StudentInfo studentInfo;
    TeacherInfo teacherInfo;
    Groups groups;
    Directory directory;
    
    @Override
    public void addStudentAccountInDatabase (Users users, Groups groups, StudentInfo studentInfo) {
        em.persist(users);
        em.persist(groups);
        em.persist(studentInfo);
    }
    
    @Override
    public void addTeacherAccountInDatabase (Users users, Groups groups, TeacherInfo teacherInfo) {
        em.persist(users);
        em.persist(groups);
        em.persist(teacherInfo);
    }
    
    @Override
    public void addCategoryInDatabase(Directory directory){
        em.persist(directory);
    }
    
    @Override
    public void createDirectory(String category){
        String path = "G:/Repository/" + category; 
        File f = new File(path);

    if(!f.exists()){
        if(f.mkdirs()){
            System.out.println("Directory created: "+category);
        }
    }
    }
    
    @Override
    public String generateHashPassword(String password) {
         try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            md.update(password.getBytes());

            byte byteData[] = md.digest();

            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                String hex = Integer.toHexString(0xff & byteData[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            //System.out.println("Hex format : " + hexString.toString());
            return hexString.toString();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Plagiar.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
