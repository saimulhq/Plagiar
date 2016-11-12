package com.plagiar;

import com.plagiar.entities.Category;
import com.plagiar.entities.Department;
import com.plagiar.entities.FilesPlagiar;
import com.plagiar.entities.Groups;
import com.plagiar.entities.Menu;
import com.plagiar.entities.PathsPlagiar;
import com.plagiar.entities.StudentInfo;
import com.plagiar.entities.TeacherInfo;
import com.plagiar.entities.University;
import com.plagiar.entities.Users;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import org.apache.commons.math3.linear.*;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.*;
import org.apache.lucene.index.*;
import org.apache.lucene.store.*;
import org.apache.lucene.util.*;

@Stateless
public class Plagiar implements PlagiarRemote {

    @PersistenceContext(unitName = "Plagiar-ejbPU")
    private EntityManager em;

    Users users;
    StudentInfo studentInfo;
    TeacherInfo teacherInfo;
    Groups groups;
    Category category;
    PathsPlagiar paths;
    Menu menu;
    University university;
    Department department;

    String CONTENT = "Content";
    Set<String> terms = new HashSet<>();
    RealVector v1;
    RealVector v2;
    Map<String, Integer> m1;
    Map<String, Integer> m2;

    @Override
    public List<Menu> getMenuByUsername(String username) {
        return em.createNativeQuery("select * from menu where menu_id in (select menu_id from role_mapping where role in (select role from groups where username=?1)) order by menu_id", Menu.class).setParameter(1, username).getResultList();
    }

    @Override
    public void addStudentAccountInDatabase(Users users, Groups groups, StudentInfo studentInfo) {
        em.persist(users);
        em.persist(groups);
        em.persist(studentInfo);
    }

    @Override
    public Users getUserRole(String username) {
        return (Users) em.createNativeQuery("select * from users where username=?1", Users.class).setParameter(1, username).getSingleResult();
    }

    @Override
    public StudentInfo getStudentInfo(String username) {
        return (StudentInfo) em.createNativeQuery("select * from student_info where username=?1", StudentInfo.class).setParameter(1, username).getSingleResult();
    }

    @Override
    public TeacherInfo getTeacherInfo(String username) {
        return (TeacherInfo) em.createNativeQuery("select * from teacher_info where username=?1", TeacherInfo.class).setParameter(1, username).getSingleResult();
    }

    @Override
    public void addTeacherAccountInDatabase(Users users, Groups groups, TeacherInfo teacherInfo) {
        em.persist(users);
        em.persist(groups);
        em.persist(teacherInfo);
    }

    @Override
    public void addUniversityInDatabase(University university) {
        em.persist(university);
    }
    
    @Override
    public void addDepartmentInDatabase(Department department) {
        em.persist(department);
    }

    @Override
    public void addCategoryInDatabase(Category category) {
        em.persist(category);
    }

    @Override
    public void addFilesInDatabase(FilesPlagiar files) {
        em.persist(files);
    }

    @Override
    public void createDirectory(String serverPath, String university, String department, String category) {
        String path = serverPath + university + "\\" + department + "\\" + category;
        File f = new File(path);

        if (!f.exists()) {
            if (f.mkdirs()) {
                System.out.println("Directory created: " + category);
            }
        }
    }

//    @Override
//    public List<DirectoryPlagiar> getDirectoryList() {
//        return em.createNativeQuery("select * from directory_plagiar order by category asc", DirectoryPlagiar.class).getResultList();
//    }

    @Override
    public List<FilesPlagiar> getFilesList(String category) {
        return em.createNativeQuery("select * from files_plagiar where category=?1", FilesPlagiar.class).setParameter(1, category).getResultList();
    }
    
    @Override
    public List<Department> getDepartmentListByUniversity(String university) {
        return em.createNativeQuery("select * from department where university_name=?1", Department.class).setParameter(1, university).getResultList();
    }
    
    @Override
    public List<Category> getCategoryListByUniversityAndDepartment(String university, String department){
        return em.createNativeQuery("select * from category where university=?1 and department=?2",Category.class).setParameter(1, university).setParameter(2, department).getResultList();
    }
    
    @Override
    public List<TeacherInfo> getTeacherListByUniversityAndDepartment(String university, String department){
        return em.createNativeQuery("select * from teacher_info where university=?1 and department=?2",TeacherInfo.class).setParameter(1, university).setParameter(2, department).getResultList();
    }
    
    @Override
    public PathsPlagiar getDirectoryPath(String pathname) {
        return (PathsPlagiar) em.createNativeQuery("select * from paths_plagiar where pathname=?1", PathsPlagiar.class).setParameter(1, pathname).getSingleResult();
    }
    
    @Override
    public List<University> getUniversityList() {
        return em.createNativeQuery("select * from university order by university_name asc", University.class).getResultList();
    }
    
    @Override
    public List<Department> getDepartmentList() {
        return em.createNativeQuery("select * from department order by department_name asc", Department.class).getResultList();
    }
    
    @Override
    public List<Category> getCategoryList() {
        return em.createNativeQuery("select * from category order by category asc", Category.class).getResultList();
    }

//    @Override
//    public University checkUniInDb(String university) {
//        try {
//            return (University) em.createNativeQuery("select * from university where university_name=?1", University.class).setParameter(1, university).getSingleResult();
//        } catch (NoResultException e) {
//            return null;
//        }
////        try{
////            System.out.println("testing....");
////            return null;
////        }catch(NullPointerException nl){
//            
//        }

    
    
    @Override
    public void generateCosineSimilarity(String t1, String t2) throws IOException {
        Directory directory = createIndex(t1, t2);
        //createIndex(s1, s2);
        IndexReader reader = DirectoryReader.open(directory);
        m1 = getTermFrequencies(reader, 0);
//        keysInM1 = new HashSet<String>(m1.keySet());
        m2 = getTermFrequencies(reader, 1);
//        keysInM2 = new HashSet<String>(m2.keySet());
//        commonKeys = new HashSet<String>(keysInM1);
//        commonKeys.retainAll(keysInM2);
//        System.out.println(commonKeys.retainAll(keysInM2));
//        System.out.println("\n");
        reader.close();
        v1 = toRealVector(m1);
        v2 = toRealVector(m2);
        getMatchWords(m1, m2);
    }

    public Directory createIndex(String t1, String t2) throws IOException {
        Directory directory = new RAMDirectory();
        Analyzer analyzer = new StandardAnalyzer();
        IndexWriterConfig iwc = new IndexWriterConfig(Version.LUCENE_CURRENT,
                analyzer);
        IndexWriter writer = new IndexWriter(directory, iwc);
        addDocument(writer, t1);
        addDocument(writer, t2);
        writer.close();
        return directory;
    }

    private void getMatchWords(Map m1, Map m2) {
        Iterator it = m1.entrySet().iterator();
        String key;
        while (it.hasNext()) {
            Map.Entry pair = (Map.Entry) it.next();
            //System.out.println(pair.getKey() + " = " + pair.getValue());
            // String key = (String)pair.getKey()!=null?(String)pair.getKey():"";
            if ((String) pair.getKey() != null) {
                key = (String) pair.getKey();
            } else {
                key = "";
            }
            int flag = 0;
            try {
                flag = (int) m2.get(key);
            } catch (Exception e) {
                //System.out.println("");
            }
            if (flag > 0) {
                System.out.println(pair.getKey());
            }
            it.remove(); // avoids a ConcurrentModificationException
        }
    }

    public void addDocument(IndexWriter writer, String fileContent) throws IOException {
        Document doc = new Document();
        FieldType fieldType = new FieldType();
        fieldType.setIndexed(true);
        fieldType.setStored(true);
        fieldType.setStoreTermVectors(true);
        fieldType.setTokenized(true);
        Field field = new Field(CONTENT, fileContent, fieldType);
        doc.add(field);
        writer.addDocument(doc);
    }

//    public String getAllText(File f) throws FileNotFoundException, IOException {
//        String textFileContent = "";
//
//        for (String line : Files.readAllLines(Paths.get(f.getAbsolutePath()))) {
//            textFileContent += line;
//        }
//        //System.out.println(textFileContent);
//        return textFileContent;
//    }
    @Override
    public double getCosineSimilarity() {
        return (v1.dotProduct(v2)) / (v1.getNorm() * v2.getNorm());
    }

    public Map<String, Integer> getTermFrequencies(IndexReader reader, int docId)
            throws IOException {
        Terms vector = reader.getTermVector(docId, CONTENT);
        TermsEnum termsEnum = null;
        termsEnum = vector.iterator(termsEnum);
        Map<String, Integer> frequencies = new HashMap<>();
        BytesRef text = null;
        while ((text = termsEnum.next()) != null) {
            String term = text.utf8ToString();
            //System.out.println(text.utf8ToString());
            //strings.add(text.utf8ToString());
            int freq = (int) termsEnum.totalTermFreq();
            frequencies.put(term, freq);
            terms.add(term);
        }
        return frequencies;
    }

    public RealVector toRealVector(Map<String, Integer> map) {
        RealVector vector = new ArrayRealVector(terms.size());
        int i = 0;
        for (String term : terms) {
            int value = map.containsKey(term) ? map.get(term) : 0;
            vector.setEntry(i++, value);
        }
        return (RealVector) vector.mapDivide(vector.getL1Norm());
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
