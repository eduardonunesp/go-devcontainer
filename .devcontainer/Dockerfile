FROM debian:12.7

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# The node image includes a non-root user with sudo access. Use the 
# "remoteUser" property in devcontainer.json to use it. On Linux, update 
# these values to ensure the container user's UID/GID matches your local values.
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends  \
    ca-certificates curl git sudo locales          \
    make build-essential                           \

    # User settings
    && groupadd --gid $USER_GID $USERNAME                                  \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME                \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME                                 \
    && chsh --shell /bin/bash $USERNAME                                    \

    # Clean up
    && apt-get autoremove -y && apt-get clean -y


# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Adding setup commands
COPY on-create.sh /on-create.sh
COPY post-create.sh /post-create.sh
RUN chmod +x /on-create.sh
RUN chmod +x /post-create.sh

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
USER $USERNAME

# Copy confs configuration
COPY bashrc /home/$USERNAME/.bashrc
