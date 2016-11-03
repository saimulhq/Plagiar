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
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
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
    DirectoryPlagiar directory;
    PathsPlagiar paths;
    Menu menu;
    
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
    public Users getUserRole(String username){
        return (Users) em.createNativeQuery("select * from users where username=?1",Users.class).setParameter(1, username).getSingleResult();
    }
    
    @Override
    public StudentInfo getStudentInfo(String username){
        return (StudentInfo) em.createNativeQuery("select * from student_info where username=?1",StudentInfo.class).setParameter(1, username).getSingleResult();
    }
    
    @Override
    public TeacherInfo getTeacherInfo(String username){
        return (TeacherInfo) em.createNativeQuery("select * from teacher_info where username=?1",TeacherInfo.class).setParameter(1, username).getSingleResult();
    }

    @Override
    public void addTeacherAccountInDatabase(Users users, Groups groups, TeacherInfo teacherInfo) {
        em.persist(users);
        em.persist(groups);
        em.persist(teacherInfo);
    }

    @Override
    public void addCategoryInDatabase(DirectoryPlagiar directory) {
        em.persist(directory);
    }
    
    @Override
    public void addFilesInDatabase(FilesPlagiar files) {
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
    public List<DirectoryPlagiar> getDirectoryList() {
        return em.createNativeQuery("select * from directory_plagiar order by category asc", DirectoryPlagiar.class).getResultList();
    }
    
    @Override
    public List<FilesPlagiar> getFilesList(String category){
        return em.createNativeQuery("select * from files_plagiar where category=?1", FilesPlagiar.class).setParameter(1, category).getResultList();
    }
    
    @Override
    public PathsPlagiar getDirectoryPath(String pathname){
        return (PathsPlagiar) em.createNativeQuery("select * from paths_plagiar where pathname=?1",PathsPlagiar.class).setParameter(1, pathname).getSingleResult();
    }
    
    @Override
    public void CosineDocumentSimilarity(String t1, String t2) throws IOException {
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
