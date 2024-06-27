{ lib
, flexibenchSrc
, buildPythonPackage
, fetchPypi
, filelock
, requests
, tqdm
, setuptools
, six
, jsonschema
, simplejson
, psutil
, py-cpuinfo
  , pip
}:

buildPythonPackage rec {
  pname = "flexibench";
  version = "0.1";

  src = flexibenchSrc;

  propagatedBuildInputs = [ filelock requests tqdm setuptools six
                            jsonschema simplejson psutil py-cpuinfo pip
                          ];

  meta = with lib; {
    description = "A CLI tool for benchmarking software";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
