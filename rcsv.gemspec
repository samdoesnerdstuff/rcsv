Gem::Specification.new do |spec|
    spec.name          = "rcsv"
    spec.version       = "0.1.3"
    spec.summary       = "An easy to use CSV parser and text formatter."
    spec.authors       = ["Sam Watson"]
    spec.email         = ["user@mail.com"]

    spec.files         = Dir["lib/**/*.rb", "exe/*", "README.md", "LICENSE*", "CODE_OF_CONDUCT.md"]
    spec.bindir        = "exe"
    spec.executables   = ["rcsv"]
    spec.require_paths = ["lib"]
    spec.license       = "BSD-2-Clause"
end