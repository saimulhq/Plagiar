package com.plagiar;

import com.plagiar.entities.Category;
import com.plagiar.entities.Department;
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
import java.util.Scanner;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.apache.commons.io.FileUtils;
import org.apache.commons.math3.linear.*;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.analysis.util.CharArraySet;
import org.apache.lucene.document.*;
import org.apache.lucene.index.*;
import org.apache.lucene.store.*;
import org.apache.lucene.util.*;
import org.apache.pdfbox.multipdf.Splitter; 
import org.apache.pdfbox.pdmodel.PDDocument;

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
    Submissions submissions;

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
    public Users getUserPassword(String username) {
        return (Users) em.createNativeQuery("select * from users where username=?1", Users.class).setParameter(1, username).getSingleResult();
    }
    
    @Override
    public List<Users> getUserList() {
        return em.createNativeQuery("select * from users", Users.class).getResultList();
    }
    
    @Override
    public void changePassword(Users users){
        em.merge(users);
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
    public void addResultsInDatabase(Submissions submissions) {
        em.persist(submissions);
    }

    @Override
    public void createDirectory(String serverPath, String university, String department, String category) {
        String path = serverPath + university + "\\" + department + "\\" + category + "\\" + "Assignment" + "\\";
        File f = new File(path);

        if (!f.exists()) {
            if (f.mkdirs()) {
                System.out.println("Directory created: " + category);
            }
        }
        
        String path1 = serverPath + university + "\\" + department + "\\" + category + "\\" + "Project" + "\\";
        File f1 = new File(path1);

        if (!f1.exists()) {
            if (f1.mkdirs()) {
                System.out.println("Directory created: " + category);
            }
        }
        
        String path2 = serverPath + university + "\\" + department + "\\" + category + "\\" + "Thesis" + "\\";
        File f2 = new File(path2);

        if (!f2.exists()) {
            if (f2.mkdirs()) {
                System.out.println("Directory created: " + category);
            }
        }
    }
    
    @Override
    public void splitFile1(File file) throws IOException {

      //Loading an existing PDF document
      //File file = new File("C:\\Users\\Saimul\\Desktop\\split\\lesson2.pdf");
      PDDocument document = PDDocument.load(file);

      //Instantiating Splitter class
      Splitter splitter = new Splitter();

      //splitting the pages of a PDF document
      List<PDDocument> Pages = splitter.split(document);

      //Creating an iterator 
      Iterator<PDDocument> iterator = Pages.listIterator();
      
      paths=getDirectoryPath("SplitDirPath1");
      String path1 = paths.getPath();
      
      //Saving each page as an individual document
      int i = 1;
      while(iterator.hasNext()) {
         PDDocument pd = iterator.next();
         pd.save(path1+"split"+ i++ +".pdf");
      }
      System.out.println("Multiple PDF’s created");
      document.close();   
   }
   
   @Override 
   public void splitFile2(File file) throws IOException {

      //Loading an existing PDF document
      //File file = new File("C:\\Users\\Saimul\\Desktop\\split\\lesson2.pdf");
      PDDocument document = PDDocument.load(file); 

      //Instantiating Splitter class
      Splitter splitter = new Splitter();

      //splitting the pages of a PDF document
      List<PDDocument> Pages = splitter.split(document);

      //Creating an iterator 
      Iterator<PDDocument> iterator = Pages.listIterator();
      
      paths=getDirectoryPath("SplitDirPath2");
      String path2 = paths.getPath();
      //Saving each page as an individual document
      int i = 1;
      while(iterator.hasNext()) {
         PDDocument pd = iterator.next();
         pd.save(path2+"split"+ i++ +".pdf");
      }
      System.out.println("Multiple PDF’s created");
      document.close();  
   }
    
    @Override
    public List<FilesPlagiar> search(String title) {
            String baseQuery = "select * from files_plagiar where filename is not null";

        if (title != "") {
            String array[]=title.split(" ");
            baseQuery = baseQuery + " and";
            for(String search:array){
                baseQuery = baseQuery + " lower(title) like '%" + search + "%' or";
            }
            baseQuery = baseQuery + " lower(title)='true'";
        }

        return em.createNativeQuery(baseQuery, FilesPlagiar.class).getResultList();
    }
    
    @Override
    public List<FilesPlagiar> searchCategory(String uni, String dept, String searchCat) {
            String baseQuery = "select * from files_plagiar where filename is not null";

        if (uni != "") {
            baseQuery = baseQuery + " and university='" + uni + "'";
        }
        
        if (dept != "") {
            baseQuery = baseQuery + " and department='" + dept + "'";
        }
        
        if (searchCat != "") {
            baseQuery = baseQuery + " and category='" + searchCat + "'";
        }

        return em.createNativeQuery(baseQuery, FilesPlagiar.class).getResultList();
    }
    
    @Override
    public List<FilesPlagiar> searchDocument(String type) {
            String baseQuery = "select * from files_plagiar where filename is not null";

        if (type != "") {
            baseQuery = baseQuery + " and category_type='" + type + "'";
        }
        
        return em.createNativeQuery(baseQuery, FilesPlagiar.class).getResultList();
    }

    @Override
    public List<FilesPlagiar> getFilesList(String uni, String dept, String cat) {
        return em.createNativeQuery("select * from files_plagiar where university=?1 and department=?2 and category=?3", FilesPlagiar.class).setParameter(1, uni).setParameter(2, dept).setParameter(3, cat).getResultList();
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
    public List<Submissions> showCheckingHistory() {
        return em.createNativeQuery("select * from submissions order by timestamp desc", Submissions.class).getResultList();
    }
    
    @Override
    public FilesPlagiar getFileDetails(String fileLocation) {
        return (FilesPlagiar) em.createNativeQuery("select * from files_plagiar where filelocation=?1", FilesPlagiar.class).setParameter(1, fileLocation).getSingleResult();
    }
    
    @Override
    public List<Department> getDepartmentList() {
        return em.createNativeQuery("select * from department order by department_name asc", Department.class).getResultList();
    }
    
    @Override
    public List<Category> getCategoryList() {
        return em.createNativeQuery("select * from category order by category asc", Category.class).getResultList();
    }
    
    @Override
    public List<FilesPlagiar> getSubmissions(String assignedto) {
        return em.createNativeQuery("select * from files_plagiar where assignedto=?1", FilesPlagiar.class).setParameter(1, assignedto).getResultList();
    }
    
    @Override
    public void deleteFile(String fileName, String fileLocation) {
        String query = "delete from files_plagiar where filename=?1";
        em.createNativeQuery(query).setParameter(1, fileName).executeUpdate();
        File file = new File(fileLocation);
        file.delete();
    }
    
    @Override
    public void deleteCategoryFromCategoryTable(String uni, String dept, String cat){
        String query = "delete from category where university=?1 and department=?2 and category=?3";
        em.createNativeQuery(query).setParameter(1, uni).setParameter(2, dept).setParameter(3, cat).executeUpdate();
        paths = getDirectoryPath("CatPath");
        String path = paths.getPath();
        File file = new File(path + uni+ "\\"+dept+"\\"+cat);
        try {
            //file.delete();
            FileUtils.deleteDirectory(file);
        } catch (IOException ex) {
            Logger.getLogger(Plagiar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    public void deleteCategoryFromFilesTable(String uni, String dept, String cat) {
        String query = "delete from files_plagiar where university=?1 and department=?2 and category=?3";
        em.createNativeQuery(query).setParameter(1, uni).setParameter(2, dept).setParameter(3, cat).executeUpdate();
    }
    
    @Override
    public void deleteUserFromUserTable(String username, String role) {
        String query = "delete from users where username=?1 and role=?2";
        em.createNativeQuery(query).setParameter(1, username).setParameter(2, role).executeUpdate();
    }
    
    @Override
    public void deleteTeacher(String username) {
        String query = "delete from teacher_info where username=?1";
        em.createNativeQuery(query).setParameter(1, username).executeUpdate();
    }
    
    @Override
    public void deleteStudent(String username) {
        String query = "delete from student_info where username=?1";
        em.createNativeQuery(query).setParameter(1, username).executeUpdate();
    }
    
    @Override
    public void generateCosineSimilarity(String t1, String t2) throws IOException {
        Directory directory = createIndex(t1, t2);
        
        IndexReader reader = DirectoryReader.open(directory);
        m1 = getTermFrequencies(reader, 0);
        m2 = getTermFrequencies(reader, 1);
        reader.close();
        
        v1 = toRealVector(m1);
        v2 = toRealVector(m2);
        //getMatchWords(m1, m2);
    }

    public Directory createIndex(String t1, String t2) throws IOException {
        Directory directory = new RAMDirectory();
        paths=getDirectoryPath("StopWordsPath");
        String wordPath = paths.getPath();
        //System.out.println(wordPath);
        File file = new File(wordPath);
        Scanner input = new Scanner(file);
        List<String> words = new ArrayList<String>();
        while (input.hasNext()) {
            String word = input.next();
            //System.out.println(word);
            words.add(word);
        }
        CharArraySet stopSet = new CharArraySet(Version.LUCENE_CURRENT, words, true);
        Analyzer analyzer = new StandardAnalyzer(stopSet);
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
            
            if ((String) pair.getKey() != null) {
                key = (String) pair.getKey();
            } else {
                key = "";
            }
            int flag = 0;
            try {
                flag = (int) m2.get(key);
            } catch (Exception e) {
        
            }
            if (flag > 0) {
                System.out.println(pair.getKey());
            }
            it.remove();
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
        int value;
        for (String term : terms) {
            if(map.containsKey(term)){
                value=map.get(term);
            }
            else{
                value=0;
            }
            vector.setEntry(i++, value);
        }
        return vector;
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
