package Test;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;

import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;

import model.Myynti;
import model.dao.Dao;

class JUnit_testaa_myynnit {

	@Test
	@Order(1) 
	public void testPoistaKaikkiAutot() {
		//Poistetaan kaikki autot
		Dao dao = new Dao();
		dao.poistaKaikkiAutot("nimda");
		ArrayList<Myynti> myynnit = dao.listaaKaikki();
		assertEquals(0, myynnit.size());
	}
	
	@Test
	@Order(2) 
	public void testLisaaAuto() {		
		//Tehd‰‰n muutama uusi testiauto
		Dao dao = new Dao();
		Myynti myynti_1 = new Myynti(1, "James", "Bond", "234224", "james.bond@mi6.uk");
		Myynti myynti_2 = new Myynti(2, "Jane", "Doe", "234234", "jane.doe@gmail.com");
		Myynti myynti_3 = new Myynti(3, "John", "Doe", "46545645", "john.doe@gmail.com");
		Myynti myynti_4 = new Myynti(4, "Heli", "Kopteri", "789786", "heli.kopteri@boss.fi");
		Myynti myynti_5 = new Myynti(5, "Jack", "Rackham", "4564664", "jack.rackham@pirates.com");
		Myynti myynti_6 = new Myynti(6, "Matti", "Tavallinen", "456432", "matti.tavis@hotmail.com");
		assertEquals(true, dao.lisaaMyynti(myynti_1));
		assertEquals(true, dao.lisaaMyynti(myynti_2));
		assertEquals(true, dao.lisaaMyynti(myynti_3));
		assertEquals(true, dao.lisaaMyynti(myynti_4));
		assertEquals(true, dao.lisaaMyynti(myynti_5));
		assertEquals(true, dao.lisaaMyynti(myynti_6));
		
	}
	
}
