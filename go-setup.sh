#!/usr/bin/env zsh

# Dirty dirty dirty
VERSION="1.21.1" # Pengguna mungkin ingin memperbarui ini ke versi Go terbaru

# Baris 'source .bashrc' (atau .zshrc) dihapus karena tidak ideal dalam skrip instalasi.
# Pastikan PATH dan GOPATH diatur dengan benar di file .zshrc Anda.
wget https://storage.googleapis.com/golang/go$VERSION.linux-amd64.tar.gz
tar xvfz go$VERSION.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo mv go /usr/local/

# Menggunakan path absolut untuk memastikan biner Go yang baru diinstal yang digunakan.
# Pengguna mungkin ingin mempertimbangkan gopls sebagai alternatif modern untuk gocode.
/usr/local/go/bin/go install golang.org/x/tools/cmd/goimports@latest
/usr/local/go/bin/go install github.com/nsf/gocode@latest

rm go$VERSION.linux-amd64.tar.gz
