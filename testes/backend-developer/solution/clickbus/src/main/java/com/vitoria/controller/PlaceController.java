package com.vitoria.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.vitoria.models.Place;
import com.vitoria.repositories.PlaceRepository;

@RestController
@RequestMapping("/place")
public class PlaceController {
	
	@Autowired
	private PlaceRepository repo;
	
	DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	
	
	@GetMapping("/{slug}")
	public ResponseEntity<Optional<Place>> getPlace(@PathVariable Integer slug){
		Optional<Place> place = repo.findById(slug);
		return ResponseEntity.ok().body(place);
	}
	
	@PostMapping("/save")
	public ResponseEntity<Place> savePlace(@RequestBody Place place){
		Place entity=place;
		entity.setCreatedAt(LocalDate.now());
		repo.save(entity);
		return ResponseEntity.ok().body(entity);
	}
	
	@PutMapping("update/{slug}")
	public ResponseEntity<Place> updatePlace(@PathVariable Integer slug, @RequestBody Place place){
		Place updatedPlace=repo.findById(slug).get();
		updatedPlace.setName(place.getName());
		updatedPlace.setCity(place.getCity());
		updatedPlace.setState(place.getState());
		updatedPlace.setUpdatedAt(LocalDate.now());
		repo.save(updatedPlace);
		return ResponseEntity.ok().body(updatedPlace);
	}
	
	@GetMapping("/all-filtered-by-name")
	public ResponseEntity<List<String>> findAll(){
		List<Place> places=repo.findAll();
		List<String> placesNames=new ArrayList<>();
		
		for(Place place : places) {
			String name=place.getName();
			placesNames.add(name);
		}
		
		return ResponseEntity.ok().body(placesNames);
	}
	
	
	
	
	
	
	
	

}
