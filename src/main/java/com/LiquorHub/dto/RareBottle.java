package com.LiquorHub.dto;

/**
 * Curated rare-collection lot (showcase dossier — not a Product table row).
 */
public class RareBottle {

	private String id;
	private String name;
	private String brand;
	private String spiritType;
	private String origin;
	private String age;
	private String vintage;
	private String abv;
	private String tastingNotes;
	private String story;
	private double priceInr;
	private String limited;
	private String imageUrl;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getSpiritType() {
		return spiritType;
	}

	public void setSpiritType(String spiritType) {
		this.spiritType = spiritType;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getVintage() {
		return vintage;
	}

	public void setVintage(String vintage) {
		this.vintage = vintage;
	}

	public String getAbv() {
		return abv;
	}

	public void setAbv(String abv) {
		this.abv = abv;
	}

	public String getTastingNotes() {
		return tastingNotes;
	}

	public void setTastingNotes(String tastingNotes) {
		this.tastingNotes = tastingNotes;
	}

	public String getStory() {
		return story;
	}

	public void setStory(String story) {
		this.story = story;
	}

	public double getPriceInr() {
		return priceInr;
	}

	public void setPriceInr(double priceInr) {
		this.priceInr = priceInr;
	}

	public String getLimited() {
		return limited;
	}

	public void setLimited(String limited) {
		this.limited = limited;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
}
