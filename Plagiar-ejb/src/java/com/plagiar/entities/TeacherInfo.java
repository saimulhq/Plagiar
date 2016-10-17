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
@Table(name = "TEACHER_INFO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TeacherInfo.findAll", query = "SELECT t FROM TeacherInfo t"),
    @NamedQuery(name = "TeacherInfo.findByUsername", query = "SELECT t FROM TeacherInfo t WHERE t.username = :username"),
    @NamedQuery(name = "TeacherInfo.findByName", query = "SELECT t FROM TeacherInfo t WHERE t.name = :name"),
    @NamedQuery(name = "TeacherInfo.findByDepartment", query = "SELECT t FROM TeacherInfo t WHERE t.department = :department"),
    @NamedQuery(name = "TeacherInfo.findByDesignation", query = "SELECT t FROM TeacherInfo t WHERE t.designation = :designation"),
    @NamedQuery(name = "TeacherInfo.findByUniversity", query = "SELECT t FROM TeacherInfo t WHERE t.university = :university")})
public class TeacherInfo implements Serializable {

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
    @Size(max = 60)
    @Column(name = "DESIGNATION")
    private String designation;
    @Size(max = 80)
    @Column(name = "UNIVERSITY")
    private String university;

    public TeacherInfo() {
    }

    public TeacherInfo(String username) {
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

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getUniversity() {
        return university;
    }

    public void setUniversity(String university) {
        this.university = university;
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
        if (!(object instanceof TeacherInfo)) {
            return false;
        }
        TeacherInfo other = (TeacherInfo) object;
        if ((this.username == null && other.username != null) || (this.username != null && !this.username.equals(other.username))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.plagiar.entities.TeacherInfo[ username=" + username + " ]";
    }
    
}
