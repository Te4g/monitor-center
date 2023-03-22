terraform {
  cloud {
    organization = "rourou-test"

    workspaces {
      tags = ["networking", "source:cli"]
    }
  }
}
