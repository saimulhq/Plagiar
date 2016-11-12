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
@Table(name = "UNIVERSITY")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "University.findAll", query = "SELECT u FROM University u"),
    @NamedQuery(name = "University.findByUniversityName", query = "SELECT u FROM University u WHERE u.universityName = :universityName"),
    @NamedQuery(name = "University.findByAddress", query = "SELECT u FROM University u WHERE u.address = :address"),
    @NamedQuery(name = "University.findByCountry", query = "SELECT u FROM University u WHERE u.country = :country"),
    @NamedQuery(name = "University.findByState", query = "SELECT u FROM University u WHERE u.state = :state"),
    @NamedQuery(name = "University.findByEstablishedYear", query = "SELECT u FROM University u WHERE u.establishedYear = :establishedYear"),
    @NamedQuery(name = "University.findByUrl", query = "SELECT u FROM University u WHERE u.url = :url")})
public class University implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 60)
    @Column(name = "UNIVERSITY_NAME")
    private String universityName;
    @Size(max = 100)
    @Column(name = "ADDRESS")
    private String address;
    @Size(max = 30)
    @Column(name = "COUNTRY")
    private String country;
    @Size(max = 30)
    @Column(name = "STATE")
    private String state;
    @Size(max = 10)
    @Column(name = "ESTABLISHED_YEAR")
    private String establishedYear;
    @Size(max = 100)
    @Column(name = "URL")
    private String url;

    public University() {
    }

    public University(String universityName) {
        this.universityName = universityName;
    }

    public String getUniversityName() {
        return universityName;
    }

    public void setUniversityName(String universityName) {
        this.universityName = universityName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getEstablishedYear() {
        return establishedYear;
    }

    public void setEstablishedYear(String establishedYear) {
        this.establishedYear = establishedYear;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (universityName != null ? universityName.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof University)) {
            return false;
        }
        University other = (University) object;
        if ((this.universityName == null && other.universityName != null) || (this.universityName != null && !this.universityName.equals(other.universityName))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.plagiar.entities.University[ universityName=" + universityName + " ]";
    }
    
}
