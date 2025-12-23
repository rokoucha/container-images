group "default" {
  targets = ["materia-gateway"]
}

target "docker-metadata-action" {}

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
