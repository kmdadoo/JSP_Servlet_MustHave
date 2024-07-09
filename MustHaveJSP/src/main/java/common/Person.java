package common;	// 기본 패키지 이외의 패키지(규약1번)

/*
	순수하게 데이터 저장 기능만 있는 클래스를 DTO(Data Transfer Object)
	혹은 VO(Value Object) 라고 부른다.
	자바빈즈(JavaBeans) 규약에 따라 작성한다.
	
	자바빈즈 규약
	1 자바빈즈는 기본(default) 패키지 이외의 패키지에 속해야합니다.
	2 멤버 변수(속성)의 접근 지정자는 private으로 선언합니다.
	3 기본생성자가 있어야 합니다.
	4 멤버 변수에 접근할 수 있는 게터setter/세터setter 메서드가 있어야 합니다.
	5 게터/세터 메서드의 접근 지정자는 public으로 선언합니다
*/
public class Person
{
	private String name;	// private 멤버 변수(규약 2번)
	private int age;		// private 멤버 변수(규약 2번)
	
	public Person()	{}		// 기본 생성자(규약 3번)

	public Person(String name, int age)
	{
		super();
		this.name = name;
		this.age = age;
	}

	// public 게터/세터 메서드들(규약 4번, 5번)
	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public int getAge()
	{
		return age;
	}

	public void setAge(int age)
	{
		this.age = age;
	}
}
