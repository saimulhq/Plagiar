/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.plagiar.entities;

import java.io.Serializable;
import java.math.BigDecimal;
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
@Table(name = "SUBMISSIONS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Submissions.findAll", query = "SELECT s FROM Submissions s"),
    @NamedQuery(name = "Submissions.findById", query = "SELECT s FROM Submissions s WHERE s.id = :id"),
    @NamedQuery(name = "Submissions.findByInputTitle", query = "SELECT s FROM Submissions s WHERE s.inputTitle = :inputTitle"),
    @NamedQuery(name = "Submissions.findByArchiveTitle", query = "SELECT s FROM Submissions s WHERE s.archiveTitle = :archiveTitle"),
    @NamedQuery(name = "Submissions.findByResult", query = "SELECT s FROM Submissions s WHERE s.result = :result"),
    @NamedQuery(name = "Submissions.findByTimestamp", query = "SELECT s FROM Submissions s WHERE s.timestamp = :timestamp")})
public class Submissions implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    private BigDecimal id;
    @Size(max = 300)
    @Column(name = "INPUT_TITLE")
    private String inputTitle;
    @Size(max = 300)
    @Column(name = "ARCHIVE_TITLE")
    private String archiveTitle;
    @Size(max = 20)
    @Column(name = "RESULT")
    private String result;
    @Column(name = "TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timestamp;

    public Submissions() {
    }

    public Submissions(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public String getInputTitle() {
        return inputTitle;
    }

    public void setInputTitle(String inputTitle) {
        this.inputTitle = inputTitle;
    }

    public String getArchiveTitle() {
        return archiveTitle;
    }

    public void setArchiveTitle(String archiveTitle) {
        this.archiveTitle = archiveTitle;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Submissions)) {
            return false;
        }
        Submissions other = (Submissions) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.plagiar.entities.Submissions[ id=" + id + " ]";
    }
    
}
