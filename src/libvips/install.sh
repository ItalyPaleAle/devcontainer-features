#!/bin/sh
set -e

LIBVIPS_VERSION="${VERSION}"
LIBSPNG_VERSION="${LIBSPNGVERSION}"
LIBCGIF_VERSION="${LIBCGIFVERSION}"

export DEBIAN_FRONTEND=noninteractive

# Clean up
rm -rf /var/lib/apt/lists/*

# Install dependencies from apt
apt-get update -y
apt-get install --no-install-recommends -y \
    ca-certificates \
    automake build-essential meson curl \
    procps libopenexr25 libmagickwand-6.q16-6 libpango1.0-0 libmatio11 \
    libopenslide0 libjemalloc2 gobject-introspection gtk-doc-tools \
    libglib2.0-0 libglib2.0-dev libjpeg62-turbo libjpeg62-turbo-dev \
    libpng16-16 libpng-dev libwebp6 libwebpmux3 libwebpdemux2 libwebp-dev \
    libtiff5 libtiff5-dev libgif7 libgif-dev libexif12 libexif-dev \
    libxml2 libxml2-dev libpoppler-glib8 libpoppler-glib-dev \
    swig libmagickwand-dev libpango1.0-dev libmatio-dev libopenslide-dev \
    libcfitsio9 libcfitsio-dev libgsf-1-114 libgsf-1-dev fftw3 fftw3-dev \
    liborc-0.4-0 liborc-0.4-dev librsvg2-2 librsvg2-dev libimagequant0 \
    libimagequant-dev libheif1 libheif-dev
rm -rf /var/lib/apt/lists/*

# libspng
cd /tmp
curl -fsSL "https://github.com/randy408/libspng/archive/refs/tags/v${LIBSPNG_VERSION}.tar.gz" \
    -o "libspng-${LIBSPNG_VERSION}.tar.gz"
tar zvxf "libspng-${LIBSPNG_VERSION}.tar.gz"
rm "libspng-${LIBSPNG_VERSION}.tar.gz"
cd "/tmp/libspng-${LIBSPNG_VERSION}"
meson setup --prefix=/usr/local build --buildtype=release
meson install -C build

# libcgif
cd /tmp
curl -fsSL "https://github.com/dloebl/cgif/archive/refs/tags/V${LIBCGIF_VERSION}.tar.gz" \
    -o "cgif-${LIBCGIF_VERSION}.tar.gz"
tar zvxf "cgif-${LIBCGIF_VERSION}.tar.gz"
rm "cgif-${LIBCGIF_VERSION}.tar.gz"
cd "/tmp/cgif-${LIBCGIF_VERSION}"
meson setup --prefix=/usr/local build
meson install -C build

# libvips
cd /tmp
curl -fsSLO "https://github.com/libvips/libvips/releases/download/v${LIBVIPS_VERSION}/vips-${LIBVIPS_VERSION}.tar.gz"
tar zvxf "vips-${LIBVIPS_VERSION}.tar.gz"
rm "vips-${LIBVIPS_VERSION}.tar.gz"
cd /tmp/vips-${LIBVIPS_VERSION}
CFLAGS="-g -O3" CXXFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0 -g -O3" \
    ./configure \
        --disable-debug \
        --disable-dependency-tracking \
        --disable-introspection \
        --disable-static \
        --enable-gtk-doc-html=no \
        --enable-gtk-doc=no \
        --enable-pyvips8=no
make
make install
ldconfig
