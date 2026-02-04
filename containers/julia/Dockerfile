#╔════════════════════════════════════════════════════════════════════════════════╗
#║                        N01D JULIA CONTAINER                                    ║
#║                  Julia Security Research | bad-antics                         ║
#╚════════════════════════════════════════════════════════════════════════════════╝

FROM julia:1.10

LABEL maintainer="bad-antics"
LABEL description="N01D Julia - Security research with Julia"

# Install Julia packages
RUN julia -e 'using Pkg; Pkg.add(["SHA", "HTTP", "JSON3", "CSV", "DataFrames"])'

WORKDIR /data

CMD ["julia"]
