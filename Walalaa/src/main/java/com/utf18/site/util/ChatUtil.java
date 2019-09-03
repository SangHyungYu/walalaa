package com.utf18.site.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ChatUtil {
	String type;
	String message;
	String list;

	public ChatUtil() {
	}

	public String split(List<String> mem) {
		String list = "";
		for (int i = 0; i < mem.size(); i++) {
			list += "<a href='#none' onclick=\"insertWisper('" + mem.get(i) + "')\">";
			list += mem.get(i);
			list += "</p>";
		}
		return list;
	}

	public ArrayList<String> FilterwordSave(String csvFile) {
		String line = "";
		String csvSplitBy = ",";
		FileInputStream fileInputStream;

		ArrayList<String> result = new ArrayList<>();
		try {
			fileInputStream = new FileInputStream("C:\\Users\\SangHyungYu\\Desktop\\BIT\\Walalaa\\" + csvFile);
			InputStreamReader inputStreamReader = new InputStreamReader(fileInputStream, "UTF-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			while ((line = bufferedReader.readLine()) != null) {
				String[] data = line.split(csvSplitBy);
				for (int i = 0; i < data.length; i++) {
					result.add(data[i]);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;

	}

	public int hohwanCho(int num) {
		switch (num) {
		case 0x3131:
			num = 0;
			break;
		case 0x3132:
			num = 1;
			break;
		case 0x3134:
			num = 2;
			break;
		case 0x3137:
			num = 3;
			break;
		case 0x3138:
			num = 4;
			break;
		case 0x3139:
			num = 5;
			break;
		case 0x3141:
			num = 6;
			break;
		case 0x3142:
			num = 7;
			break;
		case 0x3143:
			num = 8;
			break;
		case 0x3145:
			num = 9;
			break;
		case 0x3146:
			num = 10;
			break;
		case 0x3147:
			num = 11;
			break;
		case 0x3148:
			num = 12;
			break;
		case 0x3149:
			num = 13;
			break;
		case 0x314A:
			num = 14;
			break;
		case 0x314B:
			num = 15;
			break;
		case 0x314C:
			num = 16;
			break;
		case 0x314D:
			num = 17;
			break;
		case 0x314E:
			num = 18;
			break;
		default:
			num = num;
			break;
		}
		return num;
	}

	public int hohwanJun(int num) {
		switch (num) {
		case 0x314F:
			num = 0;
			break;
		case 0x3150:
			num = 1;
			break;
		case 0x3151:
			num = 2;
			break;
		case 0x3152:
			num = 3;
			break;
		case 0x3153:
			num = 4;
			break;
		case 0x3154:
			num = 5;
			break;
		case 0x3155:
			num = 6;
			break;
		case 0x3156:
			num = 7;
			break;
		case 0x3157:
			num = 8;
			break;
		case 0x3158:
			num = 9;
			break;
		case 0x3159:
			num = 10;
			break;
		case 0x315A:
			num = 11;
			break;
		case 0x315B:
			num = 12;
			break;
		case 0x315C:
			num = 13;
			break;
		case 0x315D:
			num = 14;
			break;
		case 0x315E:
			num = 15;
			break;
		case 0x315F:
			num = 16;
			break;
		case 0x3160:
			num = 17;
			break;
		case 0x3161:
			num = 18;
			break;
		case 0x3162:
			num = 19;
			break;
		case 0x3163:
			num = 20;
			break;
		default:
			num = num;
			break;
		}
		return num;
	}

	public int firstMatching(int num) {
		int afternum;
		switch (num) {
		case 0:
		case 1:
		case 15:
			afternum = 0;
			break;
		case 3:
		case 4:
		case 16:
			afternum = 3;
			break;
		case 7:
		case 8:
		case 17:
			afternum = 7;
			break;
		case 9:
		case 10:
			afternum = 9;
			break;
		case 12:
		case 13:
		case 14:
			afternum = 12;
			break;
		default:
			afternum = num;
			break;
		}
		return afternum;
	};

	public int secondMatching(int num) {
		int afternum;
		switch (num) {
		case 0:
		case 2:
			afternum = 0;
			break;
		case 1:
		case 3:
		case 5:
		case 7:
		case 10:
		case 11:
		case 14:
		case 15:
			afternum = 1;
			break;
		case 4:
		case 6:
			afternum = 4;
			break;
		case 8:
		case 12:
			afternum = 8;
			break;
		case 13:
		case 17:
			afternum = 13;
			break;
		case 16:
		case 19:
		case 20:
			afternum = 20;
			break;
		default:
			afternum = num;
			break;
		}
		return afternum;
	};

	public int lastMatching(int num) {
		int afternum;
		switch (num) {
		case 0:
			afternum = 0;
			break;
		case 1:
		case 2:
		case 24:
			afternum = 1;
			break;
		case 7:
		case 19:
		case 22:
		case 23:
		case 25:
			afternum = 7;
			break;
		case 17:
		case 26:
			afternum = 17;
			break;
		default:
			afternum = num;
			break;
		}
		return afternum;
	};

	// 초,중,종성 분리
	public int[] splitHangul(char c) {
		int sub[] = new int[3];
		sub[0] = (c - 0xAC00) / (21 * 28); // 초성의 위치
		sub[1] = ((c - 0xAC00) % (21 * 28)) / 28; // 중성의 위치
		sub[2] = (c - 0xAC00) % (28); // 종성의 위치
		return sub;
	}

	// 초,중,종성 결합
	public char[] combine(int[] sub) {
		char[] ch = new char[1];
		ch[0] = (char) (0xAC00 + (sub[0] * 21 * 28) + (sub[1] * 28) + sub[2]);
		return ch;
	}

	// 기획 1번(표준화)
	public static String standardize0(String str) {
		ChatUtil cu = new ChatUtil();
		int[] x = null;
		int loop = str.length();
		String cb_str = "";
		char c;
		for (int i = 0; i < loop; i++) {
			c = str.charAt(i);
			if (c >= 0xAC00 && c <= 0xD7A3) {
				int[] after_x = new int[3];
				x = cu.splitHangul(c);
				after_x[0] = cu.firstMatching(x[0]);
				after_x[1] = cu.secondMatching(x[1]);
				after_x[2] = cu.lastMatching(x[2]);
				cb_str += new String(cu.combine(after_x));
			}
		}
		return cb_str;
	}

	// 기획 5번(글자사이 특수문자,숫자,영어 제외하기 )
	public static String standardize1(String str) {
		int[] x = null;
		int loop = str.length();
		StringBuffer hangul = new StringBuffer();
		for (int i = 0; i < loop; i++) {
			if ((str.charAt(i)>=0xAC00 && str.charAt(i)<=0xD7A3)||(str.charAt(i)>=0x3131&&str.charAt(i)<=0x314E)) {
				hangul.append(str.charAt(i));
			}

		}
		return hangul.toString();
	}
	// 기획 5번(글자사이 특수문자,숫자,영어 제외하기 )
	public static String delspace(String str) {
		int[] x = null;
		int loop = str.length();
		StringBuffer hangul = new StringBuffer();
		for (int i = 0; i < loop; i++) {
			if (str.charAt(i)!=0x0020) {
				hangul.append(str.charAt(i));
			}
			
		}
		return hangul.toString();
	}

	// 기획 3번(받침 뺐을때 욕인지 판별)
	public static String standardize3(String str) {
		List<Map<String, Integer>> list = new ArrayList<Map<String, Integer>>();
		String delJong = "";
		int loop = str.length();

		for (int i = 0; i < loop; i++) {
			Map<String, Integer> map = new HashMap<String, Integer>();
			char c = str.charAt(i);
			if (c >= 0xAC00 && c <= 0xD743) {
				char cho = (char) ((c - 0xAC00) / (21 * 28));
				char jun = (char) ((c - 0xAC00) % (21 * 28) / 28);
				map.put("cho", (int) cho);
				map.put("jun", (int) jun);

				list.add(map);
			}
		}
		for (int i = 0; i < list.size(); i++) {
			int a = (int) (list.get(i).get("cho"));
			int b = (int) (list.get(i).get("jun"));

			char temp = (char) (0xAC00 + 28 * 21 * a + 28 * b);
			delJong = delJong.concat(String.valueOf(temp));
		}
		return delJong;
	}

	// 기획 6번(h,H->ㅐ)
	public static String standardize6(String str) {
		int loop = str.length();
		String cb_str = "";
		ChatUtil cu = new ChatUtil();
		int[] after_x = new int[3];
		char c;
		for (int i = 0; i < loop; i++) {
			c = str.charAt(i);
			if(loop>1) {
				if(i>=1) {
					if ((c == 0x0048 || c == 0x0068) && (str.charAt(i - 1) >= 0x3131 && str.charAt(i - 1) <= 0x314E)) { // h,H-> ㅐ
						char b = str.charAt(i - 1);
						after_x[0] = cu.hohwanCho((int) b);
						after_x[1] = cu.secondMatching(1);
						after_x[2] = cu.lastMatching(0);
						cb_str = cb_str.substring(0, cb_str.length()-1);
						cb_str += new String(cu.combine(after_x));
						System.out.println("h,H->ㅐ" + cb_str);
					} else {
						cb_str += String.valueOf(str.charAt(i));
					}
				}else if(i<1) {
					cb_str += String.valueOf(str.charAt(i));
				}
			}else if(loop<=1) {
				cb_str+=str;
				break;
			}
		}
		return cb_str;
	}

	// 기획 9번(ㄱㅐㅅㅐㄲㅣ, 모음 있을 경우 바로 앞에 자음 검사후 붙여서 욕인지 판별)
	public static String standardize9(String str) {
		   int loop = str.length();
	       String cb_str = "";
	       ChatUtil cu = new ChatUtil();
	       int[] after_x = new int[3];
	       char c;
	       for (int i=0; i< loop; i++) {
	          c = str.charAt(i);
	          	if(loop>1) {
	          		if(i>=1) {
	          			if((c>=0x314F && c<=0x3163)&&(str.charAt(i-1)>=0x3131 && str.charAt(i-1)<=0x314E)) {//ㄱㅐㅅㅐㄲㅣ
	          				after_x[0] = cu.hohwanCho((int)str.charAt(i-1));
	          				after_x[1] = cu.hohwanJun((int)c);
	          				after_x[2] = cu.lastMatching(0);
	          				cb_str = cb_str.substring(0, cb_str.length()-1);
	          				cb_str += new String(cu.combine(after_x));
	          			}else {
	          				cb_str+=String.valueOf(str.charAt(i));
	          			}
	          		}else if(i<1) {
	          			cb_str += String.valueOf(str.charAt(i));
	          		}
	          	}else if(loop<=1) {
	          		cb_str+=str;
	          		break;
	          	}
	       }
	       return cb_str;
	   }

	// 기획 10번(77ㅣ->끼)
	public static String standardize10(String str) {
		int loop = str.length();
		String cb_str = "";
		String cb_str2 = "";
		ChatUtil cu = new ChatUtil();
		int[] after_x = new int[3];
		char c;
		for (int i = 0; i < loop; i++) {
			c = str.charAt(i);
			if(loop>2) {
				if(i>=2) {
					if ((c >= 0x314F && c <= 0x3163) && (str.charAt(i - 1) == 0x0037 && str.charAt(i - 2) == 0x0037)) { // 77ㅣ
						after_x[0] = 1;
						char b = str.charAt(i);
						after_x[1] = cu.hohwanJun((int) b);
						after_x[2] = cu.lastMatching(0);
						cb_str += new String(cu.combine(after_x));
						cb_str = cb_str.substring(0, (i-2)) + cb_str.substring(i);
					}else {
						cb_str += String.valueOf(str.charAt(i));
					}
				}else if(i<2) {
					cb_str += String.valueOf(str.charAt(i));	
				}
			}else if(loop<=2) {
				cb_str += str;
	        	break;
			}
		}
		
		return cb_str;
	}

	// 기획 11번(r->ㅏ)
	public static String standardize11(String str) {
		int loop = str.length();
		String cb_str = "";
		ChatUtil cu = new ChatUtil();
		int[] after_x = new int[3];
		char c;
		for (int i = 0; i < loop; i++) {
			c = str.charAt(i);
			if (loop > 1) {
				if(i>=1) {
					if ((c == 0x0072) && (str.charAt(i-1) >= 0x3131 && str.charAt(i - 1) <= 0x314E)) {// r -> ㅏ
						char b = str.charAt(i-1);
						after_x[0] = cu.hohwanCho((int) b);
						c = 0;
						after_x[1] = cu.secondMatching(c);
						after_x[2] = cu.lastMatching(0);
						cb_str = cb_str.substring(0, cb_str.length()-1);
						cb_str += new String(cu.combine(after_x));
					}else {
						cb_str += String.valueOf(str.charAt(i));
					}
				}else if(i<1) {
					cb_str += String.valueOf(str.charAt(i));
				}
			}else if(loop<=1) {
				cb_str += str;
				break;
			}
		}
		return cb_str;
	}

	// 기획 12번(1,i,I,l->ㅣ)
	public static String standardize12(String str) {
		   int loop = str.length();
	       String cb_str = "";
	       ChatUtil cu = new ChatUtil();
	       int[] after_x = new int[3];
	       char c;
	       for (int i=0; i< loop; i++) {
	          c = str.charAt(i);
	          if(loop>1) {
	        	  if(i>=1) {
	        		  if((c==0x0031||c==0x0049||c==0x0069||c==0x006C)&&((str.charAt(i-1)>=0x3131)&&(str.charAt(i-1)<=0x314E))) { //1,i,I,l-> ㅣ
	        			  char b = str.charAt(i-1);
	        			  after_x[0] = cu.hohwanCho((int)b);
	        			  after_x[1] = cu.secondMatching(20);
	        			  after_x[2] = cu.lastMatching(0);
	        			  cb_str = cb_str.substring(0, cb_str.length()-1);
	        			  cb_str += new String(cu.combine(after_x));
	        		  }else {
	        			  cb_str += String.valueOf(str.charAt(i));
	        		  }
	        	  }else if(i<1){
	        		  cb_str += String.valueOf(str.charAt(i));
	        	  }
	          }else if(loop<=1) {
	        	  cb_str += str;
	        	  break;
	          }
	       }
	       return cb_str;
	}
	
	public String first_check(String str) {
		String check= "";
		check = standardize6(str);
		check = standardize9(check);
		check = standardize10(check);
		check = standardize11(check);
		check = standardize12(check);
		return check;
	}
	public String second_check(String str) {
		String check= "";
		check = standardize1(str);
		return check;
	}
	public String third_check(String str) {
		String check= "";
		check = standardize0(str);
		return check;
	}
}

/* standardize 6, 9, 10, 11, 12
->
standardize1
->
standardize0 */