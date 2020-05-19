# to build image:  docker build -t sdk .
FROM mcr.microsoft.com/dotnet/core/sdk:5.0

RUN mkdir -p /opt/nvim /root/tmp /root/.config/nvim/autoload

#COPY my.cer /usr/local/share/ca-certificates/my.crt
#RUN update-ca-certificates
#ENV NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/my.crt

# neovim / powershell ise
RUN curl -Lo /root/tmp/nvim.tar.gz https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz
RUN curl -fLo /root/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
COPY init.vim /root/.config/nvim/init.vim
RUN tar xzf /root/tmp/nvim.tar.gz -C /opt/nvim --strip 1

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install python3-pip nodejs -y 
RUN pip3 install pynvim
#RUN yum install python3 -y && python3 -m pip install --user --upgrade pynvim
#ENV XDG_CONFIG_HOME=/opt/nvim/config
RUN ln -s /opt/nvim/bin/nvim /usr/bin/ise
#ENV NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/my.crt
RUN ise --headless +PlugInstall +qall > /dev/null 2>&1

RUN dotnet new --install FiftyProtons.Templates.PSCore::0.2.2

ENTRYPOINT [ "pwsh", "-i" ]