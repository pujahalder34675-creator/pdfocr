# Standalone pdfocr change: build the CLI and install PDFium for runtime discovery.
# Stage 1: Build from source
FROM rust:1-bookworm AS builder

RUN apt-get update && apt-get install -y \
    libclang-dev \
    libtesseract-dev \
    libleptonica-dev \
    cmake \
    g++ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build
COPY Cargo.toml Cargo.lock ./
COPY crates/ ./crates/

RUN cargo build --release -p liteparse

# Stage 2: Minimal runtime image
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    libtesseract5 \
    liblept5 \
    tesseract-ocr-eng \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/target/release/lit /usr/local/bin/lit
COPY --from=builder /root/.cache/pdfium-rs/*/*/lib/libpdfium.so /usr/local/lib/pdfium-rs/
ENV PDFIUM_LIB_PATH="/usr/local/lib/pdfium-rs"
ENV TESSDATA_PREFIX="/usr/share/tesseract-ocr/5/tessdata"

RUN ln -s /usr/local/bin/lit /usr/local/bin/liteparse

CMD ["/bin/sh"]
