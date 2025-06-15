# 🌱 NSMM-submodule-service

**ESG 데이터 통합 분석 모니터링 플랫폼**의 MSA 기반 배포 리포지토리입니다.  
각 서비스는 개별 Git 레포지토리로 구성되며, 이 레포지토리는 **서브모듈 구조**로 전체 프로젝트를 통합 관리합니다.

---

## 📦 프로젝트 구조

```
NSMM-submodule-service/
├── auth-service/           → 인증 및 회원관리 (JWT 기반)
├── config-service/         → Spring Cloud Config 서버
├── csdd-service/           → 공급망 실사 응답 저장 및 위반 분석
├── dashboard-service/      → ESG 진행률 및 배출량 대시보드 API
├── dart-service/           → DART 기업 정보 및 공시 데이터 수집/분석
├── discovery-service/      → Eureka 서비스 디스커버리 서버
├── frontend/               → Next.js 기반 ESG 통합 대시보드
├── gateway-service/        → API Gateway (라우팅, 인증, 로드밸런싱)
├── gri-service/            → GRI 기준 항목 입력 및 진행률 계산
├── news-crawl-service/     → ESG 뉴스 크롤링 및 분석 서비스
├── tcfd-service/           → TCFD 전략, 목표, 거버넌스, KPI 관리
├── .github/workflows/      → GitHub Actions CI/CD 구성
├── .gitmodules             → 모든 서브모듈 정의 파일
├── update-submodule.sh     → 서브모듈 일괄 업데이트 스크립트
└── README.md
```

---

## 🧱 MSA 기반 서비스 구성

| 서비스명               | 설명                                                                            | 포트 |
| ---------------------- | ------------------------------------------------------------------------------- | ---- |
| **auth-service**       | 기업 회원가입, 로그인, 토큰 발급, 내 정보 조회 API 제공                         | 8081 |
| **config-service**     | 공통 설정 관리 (`application.yml` → Git)                                        | 8888 |
| **discovery-service**  | 서비스 등록/조회용 Eureka Server                                                | 8761 |
| **gateway-service**    | API Gateway (라우팅, 인증, 로드밸런싱, CORS 처리)                               | 8080 |
| **tcfd-service**       | TCFD 전략(시나리오, 리스크), 목표(NetZero), 거버넌스(KPI, 회의, 교육) 기능 담당 | 8082 |
| **csdd-service**       | 협력사 공급망 실사 응답 수집 및 위반 항목 자동 분석                             | 8083 |
| **gri-service**        | GRI 2~400 기준 항목 관리 및 작성 진행률 반환 API                                | 8084 |
| **dashboard-service**  | ESG 대시보드 통합 API, 진행률/배출량/NetZero 상태 제공                          | 8085 |
| **dart-service**       | DART 기업 정보 수집, 공시 데이터 분석, 기업 재무정보 제공                       | 8086 |
| **news-crawl-service** | ESG 관련 뉴스 크롤링, 감정 분석, 키워드 추출                                    | 8087 |
| **frontend**           | `Next.js + Tailwind + Chart.js` 기반 ESG 관리 UI (메인)                         | 3000 |

---

## ☁️ 배포 환경 및 기술 스택

### 🏗️ 인프라

- **배포 플랫폼**: AWS EKS + RDS + ECR + S3
- **서브모듈 통합**: GitHub 서브모듈 기반 멀티 레포 통합 운영
- **CI/CD**: GitHub Actions 기반 YAML 설정 (`.github/workflows`)

### 🔧 백엔드 기술 스택

- **Spring Boot 3.4.5** + **Java 17**
- **Spring Cloud** (Config, Eureka, Gateway)
- **Spring Security** + **JWT** 인증
- **Spring Data JPA** + **MySQL (Amazon RDS)**
- **Kafka** 비동기 메시징
- **Elasticsearch** 고속 조회 (선택)
- **Resilience4j** 서킷브레이커
- **Swagger/OpenAPI** 문서화

### 🎨 프론트엔드 기술 스택

- **Next.js** (App Router) + **TypeScript**
- **Zustand** 상태관리
- **TailwindCSS** 스타일링
- **Chart.js**, **Recharts** 데이터 시각화
- **React Query** 서버 상태 관리

---

## 📌 주요 특징

- **모든 서브모듈은 독립형 Spring Boot 서비스로 구성**
- 서브모듈별 로컬 개발 후 → 단일 리포에서 통합 테스트/배포 가능
- `update-submodule.sh` 실행 시 모든 서비스 최신 버전으로 자동 업데이트
- 백엔드와 프론트엔드가 완전히 분리되어 독립 배포 가능 (SPA + API 분리 구조)
- **DART API 연동**으로 실시간 기업 정보 및 공시 데이터 수집
- **ESG 뉴스 크롤링** 및 감정 분석 기능
- **TCFD, GRI, CSDD** 등 다양한 ESG 프레임워크 지원

---

## 🧪 실행 방법

### 1. 서브모듈 초기화

```bash
# 전체 서브모듈과 함께 클론
git clone --recurse-submodules https://github.com/NextSpringMysqlMSA/NSMM-submodule-service.git

# 또는 기존 클론 후 서브모듈 초기화
git submodule update --init --recursive
```

### 2. 서브모듈 동기화

```bash
# 모든 서브모듈을 최신 상태로 업데이트
./update-submodule.sh
```

### 3. 개별 서비스 실행

```bash
# Config Service (먼저 실행)
cd config-service
./gradlew bootRun

# Discovery Service
cd discovery-service
./gradlew bootRun

# Gateway Service
cd gateway-service
./gradlew bootRun

# 기타 서비스들...
```

### 4. 프론트엔드 실행

```bash
# 메인 프론트엔드
cd frontend
npm install
npm run dev

# 또는 서비스용 프론트엔드
cd frontend-service
npm install
npm run dev
```

---

## 🔄 서브모듈 관리

### 서브모듈 업데이트

```bash
# 모든 서브모듈을 main 브랜치로 업데이트
./update-submodule.sh

# 특정 서브모듈만 업데이트
git submodule update --remote dart-service
```

### 서브모듈 추가

```bash
# 새로운 서브모듈 추가
git submodule add https://github.com/username/repo-name.git service-name
```

---

## ✍️ 개발 기여

- 전체 MSA 기반 아키텍처 설계 및 구성
- 각 서비스의 CI/CD, Config, Eureka 연동 설정
- Git 서브모듈 자동화 스크립트 및 관리 전략 수립
- TCFD, GRI, CSDD, DART API 연동 로직 전체 구현
- Next.js 기반 ESG UI 설계 및 연동
- ESG 뉴스 크롤링 및 분석 시스템 구축

---
