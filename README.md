I use Vundle to management my vim plugins. You can refer to this link for more information: [Vundle]( https://github.com/gmarik/vundle )

#Install with:

    git clone https://github.com/andyque/dotvim.git ~/.vim

    cd ~/.vim

    ./install.sh
    
#Install plugins

open your vimrc file and run command 

    :BundleInstall

#Tips:
    if you want to use the full power of these vim plugins, you should install python,ruby ctags,jsctags


**Licence:**

Do What The Fuck You Want To Public License ([WTFPL](http://www.wtfpl.net/)).
安装说明：
第一步：先克隆版本
cd ~
git clone https://github.com/yuchao86/myvim.git
第二步：更新插件程序
cd myvim/vimfiles
./update.sh
第三步：建软连接
cd ../../
ln -s myvim/vimfiles .vim
ln -s myvim/_vimrc .vimrc
第四部：重启vim
