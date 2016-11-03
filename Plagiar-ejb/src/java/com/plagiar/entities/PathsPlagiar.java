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
@Table(name = "PATHS_PLAGIAR")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PathsPlagiar.findAll", query = "SELECT p FROM PathsPlagiar p"),
    @NamedQuery(name = "PathsPlagiar.findByPathname", query = "SELECT p FROM PathsPlagiar p WHERE p.pathname = :pathname"),
    @NamedQuery(name = "PathsPlagiar.findByPath", query = "SELECT p FROM PathsPlagiar p WHERE p.path = :path")})
public class PathsPlagiar implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "PATHNAME")
    private String pathname;
    @Size(max = 100)
    @Column(name = "PATH")
    private String path;

    public PathsPlagiar() {
    }

    public PathsPlagiar(String pathname) {
        this.pathname = pathname;
    }

    public String getPathname() {
        return pathname;
    }

    public void setPathname(String pathname) {
        this.pathname = pathname;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (pathname != null ? pathname.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PathsPlagiar)) {
            return false;
        }
        PathsPlagiar other = (PathsPlagiar) object;
        if ((this.pathname == null && other.pathname != null) || (this.pathname != null && !this.pathname.equals(other.pathname))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.plagiar.entities.PathsPlagiar[ pathname=" + pathname + " ]";
    }
    
}
