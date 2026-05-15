# 📬 웹메일 시스템 유지보수 (Webmail System Maintenance)

## 📝 프로젝트 개요
기존 웹메일 시스템의 소스코드를 분석하고 새로운 요구사항에 맞춰 기능을 개선·확장한 유지보수 프로젝트입니다.

JSP 기반 환경에서 Apache Tomcat, MySQL, Apache James 메일 서버를 연동하여 메일 송·수신, 회원 관리, 비밀번호 변경, 다중 파일 첨부 기능을 구현했습니다. 또한 객체지향 원칙을 기반으로 기존 구조를 개선하여 유지보수성과 확장성을 높였습니다.


## 📅 프로젝트 기간
* 2019.04.11 ~ 2019.06.04


## 💻 기술 스택

### Language & Framework
* Java
* JSP

### Database
* MySQL

### Server & Environment
* Apache Tomcat 9
* Apache James 2.3.2

### Tools
* SmartGit
* SonarQube


# 🎯 프로젝트 목적 및 내용

## 1. 기존 웹메일 시스템 유지보수 및 기능 개선
기존 웹메일 시스템의 구조와 소스코드를 분석한 뒤, 사용자 요구사항에 맞춰 기능을 개선하고 유지보수를 수행했습니다.

기존 기능을 유지하면서 새로운 기능을 확장하는 방향으로 구조를 개선했으며, 메일 처리 흐름과 서버 연동 구조를 분석하여 시스템 동작 안정성을 높였습니다.


## 2. 메일 송·수신 기능 구현
JavaMail API를 활용하여 메일 송·수신 기능을 구현했습니다.

### 주요 기능
* 발신자 / 수신자 / 참조(CC) 정보 추출
* 메일 제목 및 발송일 처리
* multipart 메일 구조 분석
* 본문 및 첨부파일 분리 처리

### Envelope 정보 추출
```java
private void getEnvelope(Message message) throws Exception {

    fromAddress = message.getFrom()[0].toString();

    toAddress =
        getAddresses(
            message.getRecipients(
                Message.RecipientType.TO));

    Address[] addr =
        message.getRecipients(
            Message.RecipientType.CC);

    ccAddress =
        (addr != null)
            ? getAddresses(addr)
            : "";

    subject = message.getSubject();

    sentDate =
        message.getSentDate().toString();
}
```


## 3. 첨부파일 처리 및 다중 업로드 기능 구현
multipart 형식 메일을 재귀적으로 탐색하여 첨부파일을 분리 저장하도록 구현했습니다.

### 주요 기능
* 첨부파일 존재 여부 검사
* 서버 디렉터리 자동 생성
* 다중 파일 업로드 처리
* 첨부파일 경로 관리

### 첨부파일 처리
```java
private void getPart(Part p) throws Exception {

    String disp = p.getDisposition();

    if (disp != null &&
        (disp.equalsIgnoreCase(
            Part.ATTACHMENT) ||
         disp.equalsIgnoreCase(
            Part.INLINE))) {

        fileName =
            MimeUtility.decodeText(
                p.getFileName());

        String tempUserDir =
            "C:/temp/download/" + userid;

        File dir =
            new File(tempUserDir);

        if (!dir.exists()) {
            dir.mkdir();
        }

        DataHandler dh =
            p.getDataHandler();

        FileOutputStream fos =
            new FileOutputStream(
                tempUserDir + "/" + fileName);

        dh.writeTo(fos);

        fos.close();

    } else {

        if (p.isMimeType("text/*")) {

            body =
                (String) p.getContent();

            if (p.isMimeType("text/plain")) {

                body =
                    body.replaceAll(
                        "\r\n", "<br>");
            }

        } else if (
            p.isMimeType("multipart/*")) {

            Multipart mp =
                (Multipart) p.getContent();

            for (int i = 0;
                 i < mp.getCount();
                 i++) {

                getPart(
                    mp.getBodyPart(i));
            }
        }
    }
}
```

### 파일 업로드 처리
```java
if (!(fi.getName() == null ||
      fi.getName().equals(""))) {

    setFileName(
        uploadTargetDir +
        "/" +
        fi.getName());

    File file =
        new File(fileName);

    if (fileName != null) {
        fi.write(file);
    }
}
```


## 4. MySQL 기반 회원 관리 시스템 구현
JDBC를 활용하여 MySQL DB와 연동하고 회원가입 기능을 구현했습니다.

### 주요 기능
* 사용자 회원가입
* 사용자 정보 저장
* DB 기반 계정 관리
* Apache James 메일 계정 자동 생성

### DB 연결
```java
final String url =
    "jdbc:mysql://localhost:3306/webmail";

Class.forName(
    "com.mysql.jdbc.Driver");

Connection conn =
    DriverManager.getConnection(
        url,
        user,
        password);
```

### 사용자 데이터 저장
```java
String sql =
    "INSERT INTO webmail.join " +
    "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";

PreparedStatement pstmt =
    conn.prepareStatement(sql);

pstmt.setString(1, userid);
pstmt.setString(2, password);

pstmt.executeUpdate();
```

### Apache James 계정 생성
```java
String server = "127.0.0.1";

int port = 4555;

UserAdminAgent agent =
    new UserAdminAgent(server, port);

agent.addUser(userid, password);
```


## 5. 비밀번호 변경 기능 구현
사용자 입력값과 DB 정보를 비교하여 비밀번호 변경 기능을 구현했습니다.

```java
if (password.equals(dbPass) &&
    userid.equals(dbId)) {

    String sql =
        "UPDATE users " +
        "SET password = ? " +
        "WHERE userid = ? " +
        "AND password = ?";

    PreparedStatement pstmt =
        con.prepareStatement(sql);

    pstmt.setString(1, change_pw);
    pstmt.setString(2, userid);
    pstmt.setString(3, password);

    pstmt.executeUpdate();
}
```


# ⚠️ 프로젝트 문제점 및 한계

## 1. 기존 레거시 구조 분석의 어려움
기존 웹메일 시스템의 구조와 흐름에 대한 문서화가 부족하여 소스코드 의존적으로 기능을 분석해야 했습니다.

특히 메일 처리 로직과 서버 연동 구조가 복잡하게 구성되어 있어 유지보수 과정에서 전체 데이터 흐름을 파악하는 데 시간이 소요되었습니다.


## 2. 메일 서버 연동 및 정렬 문제
Apache James 메일 서버와 DB 연동 과정에서 메일 정렬 및 데이터 처리 순서가 일관되지 않는 문제가 발생했습니다.

메일 송·수신 처리 흐름을 분석하고 FIFO 기반 처리 구조를 검토하여 메일 처리 순서를 안정화하는 방향으로 개선했습니다.


## 3. DB 연결 지연 문제
JDBC 기반 DB 연결 과정에서 응답 지연이 발생하여 회원가입 및 사용자 정보 조회 속도가 저하되는 문제가 있었습니다.

DB 연결 흐름과 SQL 처리 구조를 점검하여 연결 안정성을 개선했습니다.


# ✅ 수정 및 보완 사항

* 기존 웹메일 시스템 구조를 분석하여 기능 추가 중심의 유지보수를 수행했습니다.
* 메일 송·수신 및 multipart 첨부파일 처리 기능을 개선했습니다.
* 비밀번호 변경 기능을 추가하여 계정 관리 기능을 보완했습니다.
* JDBC 기반 DB 처리 흐름을 점검하여 연결 안정성을 개선했습니다.
* 메일 처리 순서를 개선하여 수신 메일 정렬 안정성을 높였습니다.
* 첨부파일 업로드 및 저장 기능을 추가하여 사용자 편의성을 개선했습니다.


# 🖥️ 실행 결과

### 📎 다중 파일 첨부 기능 구현
* multipart 기반 첨부파일 처리 기능 구현
* 다중 파일 업로드 및 서버 저장 기능 구현
* 첨부파일 경로 관리 기능 구현

👉 <a href="docs" target="_blank">📄 다중 파일 첨부 실행 화면</a>


### 🗄️ 데이터베이스 연동 기능 구현
* JDBC 기반 MySQL DB 연동 구현
* 회원 정보 저장 및 조회 기능 구현
* Apache James 메일 서버 계정 생성 기능 구현

👉 <a href="docs" target="_blank">📄 데이터베이스 연동 실행 화면</a>


### 🔐 로그인 일치 / 불일치 검증 기능 구현
* 사용자 입력값과 DB 계정 정보 비교 기능 구현
* 로그인 성공 및 실패 처리 기능 구현
* 계정 검증 로직 기반 사용자 인증 처리

👉 <a href="docs" target="_blank">📄 로그인 검증 실행 화면</a>


### 📬 보낸 메일함 기능 구현
* 발신 메일 조회 기능 구현
* 메일 제목 / 수신자 / 발송일 정보 출력
* JavaMail API 기반 메일 데이터 처리

👉 <a href="docs" target="_blank">📄 보낸 메일함 실행 화면</a>


### 🔑 비밀번호 변경 기능 구현
* 사용자 계정 정보 검증 후 비밀번호 변경 처리
* JDBC 기반 UPDATE 쿼리 적용
* 계정 관리 기능 개선

👉 <a href="docs" target="_blank">📄 비밀번호 변경 실행 화면</a>

# ⚠️ 프로젝트 문제점 및 한계

### **1. 단일 첨부파일만 지원되는 문제**: 기존 웹메일 시스템은 한 개의 첨부파일만 업로드할 수 있도록 구현되어 있어 사용자 편의성이 제한되는 문제가 있었습니다.

특히 업무용 메일 환경에서는 여러 파일을 동시에 첨부해야 하는 상황이 많아 기능 확장이 필요했습니다.


### **2. 관리자 계정 생성 과정의 보안 문제**: 관리자 권한으로 사용자를 추가할 때 아이디와 비밀번호만 입력하면 바로 계정이 생성되는 구조였습니다.
비밀번호 재확인 절차가 없어 입력 실수나 보안 측면에서 문제가 발생할 수 있는 구조였습니다.


### **3. 사용자 편의 기능 부족**: 기존 시스템에는 주소록 관리, 비밀번호 변경, 회원가입 기능이 존재하지 않아 사용자 계정 관리 및 메일 사용 편의성이 제한적이었습니다.


### **4. 레거시 코드 구조의 한계**: 기존 프로젝트 구조에서 중복 코드와 유지보수성이 떨어지는 표현들이 존재했습니다.

기능 추가 과정에서 코드 구조를 분석하며 개선이 필요한 부분들을 확인했습니다.


# ✅ 수정 및 보완 사항

## 📎 다중 파일 첨부 기능 추가
* HTML `multiple` 속성을 활용하여 다중 파일 업로드 기능을 구현했습니다.
* multipart 기반 첨부파일 처리 로직을 개선하여 여러 파일을 동시에 저장할 수 있도록 수정했습니다.


## 🔐 사용자 계정 생성 검증 강화
* 관리자 권한으로 사용자 추가 시 비밀번호 재입력 검증 기능을 추가했습니다.
* 사용자 입력값 비교를 통해 계정 생성 과정의 안정성과 보안성을 개선했습니다.


## 📒 주소록 관리 기능 추가
* 주소록 보기 메뉴를 추가했습니다.
* 주소록 목록 관리 기능 구현
* 주소록 추가 및 삭제 기능 구현


## 🔑 비밀번호 변경 기능 추가
* 사용자 계정 비밀번호 변경 기능을 추가했습니다.
* DB 기반 사용자 검증 후 UPDATE 쿼리를 수행하도록 구현했습니다.


## 👤 회원가입 기능 추가
* 사용자가 직접 회원가입을 통해 새로운 계정을 생성할 수 있도록 기능을 구현했습니다.
* 회원가입 시 MySQL DB 저장과 Apache James 메일 계정 생성을 함께 처리했습니다.


## 🛠️ SonarQube 기반 코드 품질 개선
* SonarQube를 활용하여 코드 중복 및 잘못된 표현을 분석했습니다.
* 정적 분석 결과를 기반으로 유지보수성과 코드 구조 개선 방향을 검토했습니다.
* 기존 구조에서 발견하지 못했던 코드 결함 및 개선 포인트를 확인할 수 있었습니다.
