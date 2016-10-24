/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.plagiar.entities;

import java.io.Serializable;
import java.math.BigDecimal;
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
@Table(name = "DIRECTORY")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Directory.findAll", query = "SELECT d FROM Directory d"),
    @NamedQuery(name = "Directory.findByCategoryId", query = "SELECT d FROM Directory d WHERE d.categoryId = :categoryId"),
    @NamedQuery(name = "Directory.findByCategory", query = "SELECT d FROM Directory d WHERE d.category = :category"),
    @NamedQuery(name = "Directory.findByDepartment", query = "SELECT d FROM Directory d WHERE d.department = :department"),
    @NamedQuery(name = "Directory.findByUniversity", query = "SELECT d FROM Directory d WHERE d.university = :university"),
    @NamedQuery(name = "Directory.findByType", query = "SELECT d FROM Directory d WHERE d.type = :type")})
public class Directory implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "CATEGORY_ID")
    private BigDecimal categoryId;
    @Size(max = 50)
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

    public Directory() {
    }

    public Directory(BigDecimal categoryId) {
        this.categoryId = categoryId;
    }

    public BigDecimal getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(BigDecimal categoryId) {
        this.categoryId = categoryId;
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
        hash += (categoryId != null ? categoryId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Directory)) {
            return false;
        }
        Directory other = (Directory) object;
        if ((this.categoryId == null && other.categoryId != null) || (this.categoryId != null && !this.categoryId.equals(other.categoryId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.plagiar.entities.Directory[ categoryId=" + categoryId + " ]";
    }
    
}
