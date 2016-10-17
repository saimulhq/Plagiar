/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.plagiar.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Saimul
 */
@Entity
@Table(name = "STUDENT_INFO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "StudentInfo.findAll", query = "SELECT s FROM StudentInfo s"),
    @NamedQuery(name = "StudentInfo.findByUsername", query = "SELECT s FROM StudentInfo s WHERE s.username = :username"),
    @NamedQuery(name = "StudentInfo.findByName", query = "SELECT s FROM StudentInfo s WHERE s.name = :name"),
    @NamedQuery(name = "StudentInfo.findByDepartment", query = "SELECT s FROM StudentInfo s WHERE s.department = :department"),
    @NamedQuery(name = "StudentInfo.findByUniversity", query = "SELECT s FROM StudentInfo s WHERE s.university = :university"),
    @NamedQuery(name = "StudentInfo.findByBatchName", query = "SELECT s FROM StudentInfo s WHERE s.batchName = :batchName"),
    @NamedQuery(name = "StudentInfo.findByBatchNumber", query = "SELECT s FROM StudentInfo s WHERE s.batchNumber = :batchNumber"),
    @NamedQuery(name = "StudentInfo.findByRollNumber", query = "SELECT s FROM StudentInfo s WHERE s.rollNumber = :rollNumber")})
public class StudentInfo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 60)
    @Column(name = "USERNAME")
    private String username;
    @Size(max = 80)
    @Column(name = "NAME")
    private String name;
    @Size(max = 80)
    @Column(name = "DEPARTMENT")
    private String department;
    @Size(max = 80)
    @Column(name = "UNIVERSITY")
    private String university;
    @Size(max = 60)
    @Column(name = "BATCH_NAME")
    private String batchName;
    @Size(max = 20)
    @Column(name = "BATCH_NUMBER")
    private String batchNumber;
    @Size(max = 20)
    @Column(name = "ROLL_NUMBER")
    private String rollNumber;

    public StudentInfo() {
    }

    public StudentInfo(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getUniversity() {
        return university;
    }

    public void setUniversity(String university) {
        this.university = university;
    }

    public String getBatchName() {
        return batchName;
    }

    public void setBatchName(String batchName) {
        this.batchName = batchName;
    }

    public String getBatchNumber() {
        return batchNumber;
    }

    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber;
    }

    public String getRollNumber() {
        return rollNumber;
    }

    public void setRollNumber(String rollNumber) {
        this.rollNumber = rollNumber;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (username != null ? username.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof StudentInfo)) {
            return false;
        }
        StudentInfo other = (StudentInfo) object;
        if ((this.username == null && other.username != null) || (this.username != null && !this.username.equals(other.username))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.plagiar.entities.StudentInfo[ username=" + username + " ]";
    }
    
}
