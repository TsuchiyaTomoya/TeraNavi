/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ttc.exception.integration;

/**
 *
 * @author Masaki
 */
public class NoMemberException extends IntegrationException{
	public NoMemberException(String mess,Throwable t){
		super(mess,t);
	}
}
