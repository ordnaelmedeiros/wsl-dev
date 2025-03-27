./scripts/update.sh

echo "Install base..."
sudo apt install -y gnome-tweaks gnome-themes-extra wget neofetch jq lxappearance git htop

sudo mkdir /apps
sudo chmod 777 /apps

echo "Install podman..."
sudo apt install -y podman
echo 'unqualified-search-registries=["docker.io"]' | sudo tee -a /etc/containers/registries.conf
systemctl --user enable podman.socket --now
echo 'export DOCKER_HOST=unix://$(podman info --format '{{.Host.RemoteSocket.Path}}')' | sudo tee -a ~/.bashrc

echo "Install asdf..."
cd /apps
wget https://github.com/asdf-vm/asdf/releases/download/v0.16.5/asdf-v0.16.5-linux-amd64.tar.gz
tar -xvzf asdf-v0.16.5-linux-amd64.tar.gz
rm asdf-v0.16.5-linux-amd64.tar.gz
sudo mv asdf /usr/bin/
echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' | sudo tee -a ~/.bashrc
