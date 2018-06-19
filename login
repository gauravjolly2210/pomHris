package com.qait.automation.pomTatoc;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

public class hris {
	WebDriver driver;
	LoginObject login;
	
	@Test
	public void Login_With_Invalid_Credentials() {
		login.loginWithInvalidCredentials("gauravjolly","Invalid_Password");
		Assert.assertTrue(driver.findElement(By.className("loginTxt"))
				.getText().contains("Invalid Login"));
	}
	@Test(dependsOnMethods="Login_With_Invalid_Credentials")
	public void Login_without_Passsword() {
		login.loginWithInvalidCredentials("gauravjolly","");
		Assert.assertTrue(driver.findElement(By.id("txtPassword")).getAttribute("style").contains("red"));
	}
	
	@Test(dependsOnMethods="Login_without_Passsword")
	public void Login_Successful() throws InterruptedException{
		WebDriverWait wait = new WebDriverWait(driver, 10);
		login.loginWithInvalidCredentials("gauravjolly", "/*enter-password*/");	
		Assert.assertNotEquals(driver.getCurrentUrl(), "https://hris.qainfotech.com/login.php");
		Thread.sleep(2000);
		List<WebElement> li = driver.findElements(By.className("topbar-list"));
		li.get(0).click();
		
		WebElement logout = driver.findElement(By.xpath("//li//a//span[text()='Logout']"));
		Thread.sleep(3000);
		logout.click();
	   
		
	}
	
	@BeforeClass
	public void launchBrowser() {
		System.setProperty("webdriver.chrome.driver","/home/qainfotech/Downloads/chromedriver");
		driver=new ChromeDriver();
		driver.get("https://hris.qainfotech.com");
		login=new LoginObject(driver);
		
	}
	@AfterClass
	public void closeBrowser() {
		driver.quit();
	}
}
