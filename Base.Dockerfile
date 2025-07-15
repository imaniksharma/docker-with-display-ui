FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install package dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        software-properties-common \
        autoconf \
        automake \
        libtool \
        pkg-config \
        ca-certificates \
        locales \
        locales-all \
        wget && \
    apt-get clean

# System locale
# Important for UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Install Firefox and its dependencies
# https://www.mozilla.org/en-US/firefox/117.0/system-requirements/

RUN install -d -m 0755 /etc/apt/keyrings && \
    wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null && \
    gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}' && \
    echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null && \
    echo 'Package: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000' | tee /etc/apt/preferences.d/mozilla && \
    apt-get update && apt-get install -y --no-install-recommends \
        libpci-dev \
        libcanberra-gtk3-module \
        libgles2-mesa-dev \
        dbus-x11 \
        firefox && \
    apt-get clean


# Install fonts
RUN apt-get update && apt-get install -y --no-install-recommends \
        fonts-wqy-microhei && \
    apt-get clean
    
# Installing jupyter-lab and curl and python
RUN apt update && \
    apt install -y --no-install-recommends \
        curl \
        git \
        git-lfs \
        python3 \
        gcc \
        python3-dev \
        python3-pip \
        vim && \
    git lfs install && \
    python3 -m pip install --break-system-packages --no-cache-dir jupyterlab==4.0.7 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["bash"]
