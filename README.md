# 🌱 NSMM-submodule-service

**ESG 데이터 통합 분석 및 실시간 모니터링 플랫폼**의 MSA 기반 배포 리포지토리입니다.  
각 서비스는 개별 Git 레포지토리로 구성되며, 이 레포지토리는 **서브모듈 구조**로 전체 프로젝트를 통합 관리합니다.

---

## 📦 프로젝트 구조

```

NSMM-submodule-service/
├── auth-service/           → 인증 및 회원관리 (JWT 기반)
├── config-service/         → Spring Cloud Config 서버
├── csdd-service/           → 공급망 실사 응답 저장 및 위반 분석
├── dashboard-service/      → ESG 진행률 및 배출량 대시보드 API
├── discovery-service/      → Eureka 서비스 디스커버리 서버
├── frontend-service/       → Next.js 기반 ESG 통합 대시보드
├── gri-service/            → GRI 기준 항목 입력 및 진행률 계산
├── tcfd-service/           → TCFD 전략, 목표, 거버넌스, KPI 관리
├── .github/workflows/      → GitHub Actions CI/CD 구성
├── .gitmodules             → 모든 서브모듈 정의 파일
├── update-submodule.sh     → 서브모듈 일괄 업데이트 스크립트
└── README.md

```

---

## 🧱 MSA 기반 서비스 구성

| 서비스명                | 설명                                                                            |
| ----------------------- | ------------------------------------------------------------------------------- |
| **auth-service**        | 기업 회원가입, 로그인, 토큰 발급, 내 정보 조회 API 제공                         |
| **config-service**      | 공통 설정 관리 (`application.yml` → Git)                                        |
| **discovery-service**   | 서비스 등록/조회용 Eureka Server (포트: 8761)                                   |
| **tcfd-service**        | TCFD 전략(시나리오, 리스크), 목표(NetZero), 거버넌스(KPI, 회의, 교육) 기능 담당 |
| **csdd-service**        | 협력사 공급망 실사 응답 수집 및 위반 항목 자동 분석                             |
| **gri-service**         | GRI 2~400 기준 항목 관리 및 작성 진행률 반환 API                                |
| **dashboard-service**   | ESG 대시보드 통합 API, 진행률/배출량/NetZero 상태 제공                          |
| **frontend-service**    | `Next.js + Tailwind + Chart.js` 기반 ESG 관리 UI                                |
| **update-submodule.sh** | 모든 서브모듈 `main` 또는 `develop` 브랜치로 동기화 처리                        |

---

## ☁️ 배포 환경 및 기술 스택

- **배포 플랫폼**: AWS EKS + RDS + ECR + S3
- **서브모듈 통합**: GitHub 서브모듈 기반 멀티 레포 통합 운영
- **CI/CD**: GitHub Actions 기반 YAML 설정 (`.github/workflows`)
- **Infrastructure**:
  - `Spring Cloud` (Config, Eureka, Gateway)
  - `Kafka` 비동기 메시징
  - `Elasticsearch` 고속 조회 (선택)
  - `MySQL (Amazon RDS)` 데이터 저장
- **프론트엔드**:
  - `Next.js` (App Router) + Zustand 상태관리
  - `Chart.js`, `Recharts`, `TailwindCSS` 기반 ESG 시각화

---

## 📌 주요 특징

- **모든 서브모듈은 독립형 Spring Boot 서비스로 구성**
- 서브모듈별 로컬 개발 후 → 단일 리포에서 통합 테스트/배포 가능
- `update-submodule.sh` 실행 시 모든 서비스 최신 버전으로 자동 업데이트
- 백엔드와 프론트엔드가 완전히 분리되어 독립 배포 가능 (SPA + API 분리 구조)

---

## 🧪 실행 방법

### 1. 서브모듈 초기화

```bash
git clone --recurse-submodules https://github.com/NextSpringMysqlMSA/NSMM-submodule-service.git
```

### 2. 서브모듈 동기화

```bash
./update-submodule.sh
```

### 3. EKS 배포 또는 로컬 Docker 환경 실행

---

## ✍️ 개발 기여

- 전체 MSA 기반 아키텍처 설계 및 구성
- 각 서비스의 CI/CD, Config, Eureka 연동 설정
- Git 서브모듈 자동화 스크립트 및 관리 전략 수립
- TCFD, GRI, 공급망 실사, NetZero 로직 전체 구현
- Next.js 기반 ESG UI 설계 및 연동

---

## 📈 향후 확장 방향

- 실시간 공시 수신 기반 Slack 알림 시스템
- ESG 등급 자동 산출 로직 도입
- 배출량 기반 리스크 스코어링 기능 연동
- 다국어 대응 ESG 리포트 출력 기능
