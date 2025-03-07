package com.vitoria.models;

import java.io.Serializable;
import java.time.LocalDate;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="place")
public class Place implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Column(name="name", unique=true)
	private String name;
	
	@Column(name="slug", unique=true)
	@Id
	private Integer slug;
	
	@Column(name="city")
	private String city;
	
	@Column(name="state")
	private String state;
	
	@Column(name="created_at")
	private LocalDate createdAt;
	
	@Column(name="updated_at")
	private LocalDate updatedAt;
	
	public Place() {
	}

	public Place(String name, Integer slug, String city, String state, LocalDate createdAt, LocalDate updatedAt) {
		this.name = name;
		this.slug = slug;
		this.city = city;
		this.state = state;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSlug() {
		return slug;
	}

	public void setSlug(Integer slug) {
		this.slug = slug;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public LocalDate getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDate localDate) {
		this.createdAt = localDate;
	}

	public LocalDate getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDate updatedAt) {
		this.updatedAt = updatedAt;
	}
}
