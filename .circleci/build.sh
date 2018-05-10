git clone https://github.com/pelias/dockerfiles.git

cp pelias.json dockerfiles/pelias.json

cd dockerfiles
./build.sh


cd ..
git clone https://github.com/pelias/acceptance-tests.git
cd acceptance-tests
npm i
npm test -- -e local test_cases/portland/*.json
