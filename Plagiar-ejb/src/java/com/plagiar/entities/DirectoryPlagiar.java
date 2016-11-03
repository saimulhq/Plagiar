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
@Table(name = "DIRECTORY_PLAGIAR")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "DirectoryPlagiar.findAll", query = "SELECT d FROM DirectoryPlagiar d"),
    @NamedQuery(name = "DirectoryPlagiar.findByCategory", query = "SELECT d FROM DirectoryPlagiar d WHERE d.category = :category"),
    @NamedQuery(name = "DirectoryPlagiar.findByDepartment", query = "SELECT d FROM DirectoryPlagiar d WHERE d.department = :department"),
    @NamedQuery(name = "DirectoryPlagiar.findByUniversity", query = "SELECT d FROM DirectoryPlagiar d WHERE d.university = :university"),
    @NamedQuery(name = "DirectoryPlagiar.findByType", query = "SELECT d FROM DirectoryPlagiar d WHERE d.type = :type")})
public class DirectoryPlagiar implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "CATEGORY")
    private String category;
    @Size(max = 100)
    @Column(name = "DEPARTMENT")
    private String department;
    @Size(max = 100)
    @Column(name = "UNIVERSITY")
    private String university;
    @Size(max = 30)
    @Column(name = "TYPE")
    private String type;

    public DirectoryPlagiar() {
    }

    public DirectoryPlagiar(String category) {
        this.category = category;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (category != null ? category.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DirectoryPlagiar)) {
            return false;
        }
        DirectoryPlagiar other = (DirectoryPlagiar) object;
        if ((this.category == null && other.category != null) || (this.category != null && !this.category.equals(other.category))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.plagiar.entities.DirectoryPlagiar[ category=" + category + " ]";
    }
    
}
