package study;

import java.util.Random;
import java.util.Scanner;

public class Baseball {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int regame;
		do {
		int a, b, c, d;
		int uNum = 0;
		int ua = 0;
		int ub = 0;
		int uc = 0;
		int ud = 0;
		int count =0;
		boolean check = true;

	
		// 난수생성
		do {
			Random rd = new Random();
			a = 1 + rd.nextInt(9);
			b = rd.nextInt(10);
			c = rd.nextInt(10);
			d = rd.nextInt(10);

		} while (a == b || a == c || a == d || b == c || b == d || c == d);
//		System.out.print(">>>>>>");
//		System.out.print(a);
//		System.out.print(b);
//		System.out.print(c);
//		System.out.println(d);
//		System.out.println();
		// 사용사 숫자 입력
		do {
			do {
				System.out.print(">>>>>>");
				
				uNum = sc.nextInt();
				ud = uNum % 10;
				uc = (uNum / 10) % 10;
				ub = (uNum / 100) % 10;
				ua = (uNum / 1000) % 10;
			} while (uNum >= 10000 || uNum < 999);
			int Scount = 0;
			int Bcount = 0;
			// StrikeChecking
			if (a == ua) {
				Scount++;
			}
			if (b == ub) {
				Scount++;
			}
			if (c == uc) {
				Scount++;
			}
			if (d == ud) {
				Scount++;
			}
			// BallChecking
			if (a == ub || a == uc || a == ud)
				Bcount++;
			if (b == ua || b == uc || b == ud)
				Bcount++;
			if (c == ua || c == ub || c == ud)
				Bcount++;
			if (d == ua || d == ub || d == uc)
				Bcount++;
			count++;
			System.out.print(count+"번째 : ");
			System.out.print(Scount + "S");
			System.out.println(Bcount + "B");
			if (Scount == 4)
				check = false;
		} while (check);
		System.out.println("☆★☆★☆★☆★성공☆★☆★☆★☆★");
		System.out.print(" 한 판 더 하려면 0☞");
	    regame = sc.nextInt();
		}while(regame==0);
	}
}
