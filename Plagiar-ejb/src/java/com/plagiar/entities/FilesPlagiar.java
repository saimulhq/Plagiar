/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.plagiar.entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Saimul
 */
@Entity
@Table(name = "FILES_PLAGIAR")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "FilesPlagiar.findAll", query = "SELECT f FROM FilesPlagiar f"),
    @NamedQuery(name = "FilesPlagiar.findByCategory", query = "SELECT f FROM FilesPlagiar f WHERE f.category = :category"),
    @NamedQuery(name = "FilesPlagiar.findByFilename", query = "SELECT f FROM FilesPlagiar f WHERE f.filename = :filename"),
    @NamedQuery(name = "FilesPlagiar.findByFilelocation", query = "SELECT f FROM FilesPlagiar f WHERE f.filelocation = :filelocation"),
    @NamedQuery(name = "FilesPlagiar.findByAddedby", query = "SELECT f FROM FilesPlagiar f WHERE f.addedby = :addedby"),
    @NamedQuery(name = "FilesPlagiar.findByTimeadded", query = "SELECT f FROM FilesPlagiar f WHERE f.timeadded = :timeadded"),
    @NamedQuery(name = "FilesPlagiar.findByTitle", query = "SELECT f FROM FilesPlagiar f WHERE f.title = :title"),
    @NamedQuery(name = "FilesPlagiar.findByAuthor", query = "SELECT f FROM FilesPlagiar f WHERE f.author = :author"),
    @NamedQuery(name = "FilesPlagiar.findByCategoryType", query = "SELECT f FROM FilesPlagiar f WHERE f.categoryType = :categoryType"),
    @NamedQuery(name = "FilesPlagiar.findByPublishedYear", query = "SELECT f FROM FilesPlagiar f WHERE f.publishedYear = :publishedYear"),
    @NamedQuery(name = "FilesPlagiar.findByDepartment", query = "SELECT f FROM FilesPlagiar f WHERE f.department = :department"),
    @NamedQuery(name = "FilesPlagiar.findByUniversity", query = "SELECT f FROM FilesPlagiar f WHERE f.university = :university"),
    @NamedQuery(name = "FilesPlagiar.findByAssignedto", query = "SELECT f FROM FilesPlagiar f WHERE f.assignedto = :assignedto")})
public class FilesPlagiar implements Serializable {

    private static final long serialVersionUID = 1L;
    @Size(max = 50)
    @Column(name = "CATEGORY")
    private String category;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "FILENAME")
    private String filename;
    @Size(max = 500)
    @Column(name = "FILELOCATION")
    private String filelocation;
    @Size(max = 50)
    @Column(name = "ADDEDBY")
    private String addedby;
    @Column(name = "TIMEADDED")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timeadded;
    @Size(max = 100)
    @Column(name = "TITLE")
    private String title;
    @Size(max = 60)
    @Column(name = "AUTHOR")
    private String author;
    @Size(max = 20)
    @Column(name = "CATEGORY_TYPE")
    private String categoryType;
    @Size(max = 20)
    @Column(name = "PUBLISHED_YEAR")
    private String publishedYear;
    @Size(max = 100)
    @Column(name = "DEPARTMENT")
    private String department;
    @Size(max = 60)
    @Column(name = "UNIVERSITY")
    private String university;
    @Size(max = 60)
    @Column(name = "ASSIGNEDTO")
    private String assignedto;

    public FilesPlagiar() {
    }

    public FilesPlagiar(String filename) {
        this.filename = filename;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getFilelocation() {
        return filelocation;
    }

    public void setFilelocation(String filelocation) {
        this.filelocation = filelocation;
    }

    public String getAddedby() {
        return addedby;
    }

    public void setAddedby(String addedby) {
        this.addedby = addedby;
    }

    public Date getTimeadded() {
        return timeadded;
    }

    public void setTimeadded(Date timeadded) {
        this.timeadded = timeadded;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getCategoryType() {
        return categoryType;
    }

    public void setCategoryType(String categoryType) {
        this.categoryType = categoryType;
    }

    public String getPublishedYear() {
        return publishedYear;
    }

    public void setPublishedYear(String publishedYear) {
        this.publishedYear = publishedYear;
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

    public String getAssignedto() {
        return assignedto;
    }

    public void setAssignedto(String assignedto) {
        this.assignedto = assignedto;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (filename != null ? filename.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof FilesPlagiar)) {
            return false;
        }
        FilesPlagiar other = (FilesPlagiar) object;
        if ((this.filename == null && other.filename != null) || (this.filename != null && !this.filename.equals(other.filename))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.plagiar.entities.FilesPlagiar[ filename=" + filename + " ]";
    }
    
}
