#!/bin/bash

set -e

echo "🔄 모든 서브모듈을 최신 상태로 업데이트합니다..."

# 루트 경로에서 실행하도록 체크
if [ ! -f .gitmodules ]; then
  echo "❌ .gitmodules 파일이 없습니다. 루트 디렉토리에서 실행해주세요."
  exit 1
fi

# 각 서브모듈 디렉토리 순회
git submodule foreach '
  echo "📁 [$name] 서브모듈 처리 중..."
  git checkout main || echo "⚠️ $name: main 브랜치 없음"
  git pull origin main || echo "⚠️ $name: pull 실패"
'

echo "✅ 서브모듈 업데이트 완료!"
