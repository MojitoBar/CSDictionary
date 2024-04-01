# CSDictionary

## 데이터 추가하기

1. Google Sheet에서 데이터를 수정한다.
2. 해당 파일을 csv로 뽑는다.
3. csv를 python 파일을 통해 md 파일들로 변환한다.
4. 이를 json으로 변환한다.
5. `firestore-import --accountCredentials {credential json} --backupFile {백업 json}` 를 통해 firestore에 올린다.
