package com.plagiar;

import com.plagiar.entities.Directory;
import com.plagiar.entities.Files;
import com.plagiar.entities.Groups;
import com.plagiar.entities.Paths;
import com.plagiar.entities.StudentInfo;
import com.plagiar.entities.TeacherInfo;
import com.plagiar.entities.Users;
import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
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
    Paths paths;

    @Override
    public void addStudentAccountInDatabase(Users users, Groups groups, StudentInfo studentInfo) {
        em.persist(users);
        em.persist(groups);
        em.persist(studentInfo);
    }

    @Override
    public void addTeacherAccountInDatabase(Users users, Groups groups, TeacherInfo teacherInfo) {
        em.persist(users);
        em.persist(groups);
        em.persist(teacherInfo);
    }

    @Override
    public void addCategoryInDatabase(Directory directory) {
        em.persist(directory);
    }
    
    @Override
    public void addFilesInDatabase(Files files) {
        em.persist(files);
    }

    @Override
    public void createDirectory(String serverPath, String category) {
        String path = serverPath + category;
        File f = new File(path);

        if (!f.exists()) {
            if (f.mkdirs()) {
                System.out.println("Directory created: " + category);
            }
        }
    }

    @Override
    public List<Directory> getDirectoryList() {
        return em.createNativeQuery("select * from directory order by category asc", Directory.class).getResultList();
    }
    
    @Override
    public List<Files> getFilesList(String category){
        return em.createNativeQuery("select * from files where category=?1", Files.class).setParameter(1, category).getResultList();
    }
    
    @Override
    public Paths getDirectoryPath(String pathname){
        return (Paths) em.createNativeQuery("select * from paths where pathname=?1",Paths.class).setParameter(1, pathname).getSingleResult();
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
