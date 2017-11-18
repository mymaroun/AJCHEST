package ca.uqac.inf957.chess.aspect;

import ca.uqac.inf957.chess.Board;
import ca.uqac.inf957.chess.agent.Move;
import ca.uqac.inf957.chess.piece.Piece;
import ca.uqac.inf957.chess.agent.Player;
import java.io.File;
import java.io.FileWriter;

/**
 *
 */
public aspect LogAspectJ {
	//POINCUT



	pointcut LogAspectJ(Move mv, Board b):
			(
					target(b) && execution ( void ca.uqac.inf957.chess.Board.movePiece(Move))  && args(mv)
					);
	pointcut resetFichier():
			(
					execution (void ca.uqac.inf957.chess.Game.play())
					);

	//ADVICE
	after(Move mv, Board b): LogAspectJ(mv, b) {
		String positionXInit = "";
		String positionXFinal = "";
		int positionYInit;
		int positionYFinal;
		String coup = "";
		Board playground = b;


		try{
			File fichier = new File("logaspectj.txt"); //création du log et chemin vers celui-ci
			FileWriter ffw = new FileWriter(fichier, true); //on ecrit dans le fichier les coups joués
			Piece piece = playground.getGrid()[mv.xF][mv.yF].getPiece();
			for (int i = 0; i<9;i++){
				positionXInit = String.valueOf(mv.xI);
				positionXFinal = String.valueOf(mv.xF);
			}
			switch (positionXInit){
				case "0" : positionXInit = "a"; break;
				case "1" : positionXInit = "b"; break;
				case "2" : positionXInit = "c"; break;
				case "3" : positionXInit = "d"; break;
				case "4" : positionXInit = "e"; break;
				case "5" : positionXInit = "f"; break;
				case "6" : positionXInit = "g"; break;
				case "7" : positionXInit = "h"; break;
				default : positionXInit = "X";
			}
			switch (positionXFinal){
				case "0" : positionXFinal = "a"; break;
				case "1" : positionXFinal = "b"; break;
				case "2" : positionXFinal = "c"; break;
				case "3" : positionXFinal = "d"; break;
				case "4" : positionXFinal = "e"; break;
				case "5" : positionXFinal = "f"; break;
				case "6" : positionXFinal = "g"; break;
				case "7" : positionXFinal = "h"; break;
				default : positionXFinal = "X";
			}

			positionYInit = mv.yI+1;
			positionYFinal = mv.yF+1;
			if (piece.getPlayer() == 1){
				coup = "||   Human Player   || :" + " de " + " ["+positionXInit + positionYInit +"] "  + " --> " +" ["  + positionYInit + positionYFinal +"] "  + " \n ";
			}else{
				coup = "|| Stupid AI Player || :" + " de " + " ["+positionXInit + positionYInit +"] "  + " --> " +" ["  + positionYInit + positionYFinal +"] " + " \n ";
			}
			System.out.println(coup);
			try {
				ffw.write(coup);  //on ecrit une ligne dans le fichier logaspectj.txt a chaque coup joué
				ffw.write("\r\n");
			} finally {
				ffw.close(); //on ferme le fichier quand on a fini d'écrire
			}
		} catch (Exception e) {
			System.out.println("ERREUR ECRITURE - Coup non valide");  //si le coup est pas valide on enregistre pas
		}

	}

	before() : resetFichier(){
		try{
			File fichier = new File("logaspectj.txt"); //Chemin du fichier
			fichier.createNewFile();
			FileWriter fichierw = new FileWriter(fichier, false);
			System.out.println("CREATION FICHIER");
			try{
			} finally{
				fichierw.close();
			}
		} catch(Exception e){
			System.out.println("ERREUR CREATION FICHIER");
		}
	}
}