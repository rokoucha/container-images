group "default" {
  targets = [
    "materia-agent",
    "materia-clusteragent",
    "materia-gateway",
  ]
}

target "docker-metadata-action" {}

target "materia-agent" {
  inherits = ["docker-metadata-action"]
  tags     = make_tags("materia-agent")
  args = {
    target = "materia-agent"
  }
  platforms = ["linux/amd64"]
}

target "materia-clusteragent" {
  inherits = ["docker-metadata-action"]
  tags     = make_tags("materia-clusteragent")
  args = {
    target = "materia-clusteragent"
  }
  platforms = ["linux/amd64"]
}

target "materia-gateway" {
  inherits = ["docker-metadata-action"]
  tags     = make_tags("materia-gateway")
  args = {
    target = "materia-gateway"
  }
  platforms = ["linux/amd64"]
}

variable "DOCKER_METADATA_OUTPUT_TAGS" {
  default = ""
}
function "make_tags" {
  params = [ns]
  result = split("\n", replace("${DOCKER_METADATA_OUTPUT_TAGS}", ":", "/${ns}:"))
}
