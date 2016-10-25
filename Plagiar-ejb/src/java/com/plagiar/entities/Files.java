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
@Table(name = "FILES")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Files.findAll", query = "SELECT f FROM Files f"),
    @NamedQuery(name = "Files.findByCategory", query = "SELECT f FROM Files f WHERE f.category = :category"),
    @NamedQuery(name = "Files.findByFilename", query = "SELECT f FROM Files f WHERE f.filename = :filename"),
    @NamedQuery(name = "Files.findByFilelocation", query = "SELECT f FROM Files f WHERE f.filelocation = :filelocation"),
    @NamedQuery(name = "Files.findByAddedby", query = "SELECT f FROM Files f WHERE f.addedby = :addedby"),
    @NamedQuery(name = "Files.findByTimeadded", query = "SELECT f FROM Files f WHERE f.timeadded = :timeadded")})
public class Files implements Serializable {

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

    public Files() {
    }

    public Files(String filename) {
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (filename != null ? filename.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Files)) {
            return false;
        }
        Files other = (Files) object;
        if ((this.filename == null && other.filename != null) || (this.filename != null && !this.filename.equals(other.filename))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.plagiar.entities.Files[ filename=" + filename + " ]";
    }
    
}
