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
@Table(name = "GROUPS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Groups.findAll", query = "SELECT g FROM Groups g"),
    @NamedQuery(name = "Groups.findByUsername", query = "SELECT g FROM Groups g WHERE g.username = :username"),
    @NamedQuery(name = "Groups.findByRole", query = "SELECT g FROM Groups g WHERE g.role = :role")})
public class Groups implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 60)
    @Column(name = "USERNAME")
    private String username;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "ROLE")
    private String role;

    public Groups() {
    }

    public Groups(String username) {
        this.username = username;
    }

    public Groups(String username, String role) {
        this.username = username;
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
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
        if (!(object instanceof Groups)) {
            return false;
        }
        Groups other = (Groups) object;
        if ((this.username == null && other.username != null) || (this.username != null && !this.username.equals(other.username))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.plagiar.entities.Groups[ username=" + username + " ]";
    }
    
}
