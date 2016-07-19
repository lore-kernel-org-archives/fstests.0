Received: from mail-vk0-f47.google.com ([209.85.213.47]:35954 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbcGSMii (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 19 Jul 2016 08:38:38 -0400
Received: by mail-vk0-f47.google.com with SMTP id g1so9770406vkb.3
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2016 05:38:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160719103154.GQ27776@eguan.usersys.redhat.com>
References: <CADxRZqxz7XJ43i_Mn8kdnP7KPR2sK1wK5T2B-QAYj9_jCqUbCg@mail.gmail.com>
 <CADxRZqym3LQa0czmO0Ni5+qQ6R=U7s_7A7H9YWDeVcz8UtGqrg@mail.gmail.com> <20160719103154.GQ27776@eguan.usersys.redhat.com>
From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 19 Jul 2016 15:38:36 +0300
Message-ID: <CADxRZqx_=YocT+O3cWVMTQD+Gk7-=ev9t0nXWSUx1WT1=WsPiQ@mail.gmail.com>
Subject: Re: Fwd: xfstests: error: redefinition of 'struct fsxattr'
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 19, 2016 at 1:31 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Tue, Jul 19, 2016 at 01:24:53PM +0300, Anatoly Pugachev wrote:
>> Hello!
>>
>> Can someone help me to compile xfstests taken from
>> git://oss.sgi.com/xfs/cmds/xfstests
>
> This should have been fixed in latest xfstests. Does your tree contain
> commit ca7c8bcbe851 ("build: avoid struct fsxattr redefinition")?

Eryu,

my current HEAD is at 024bdae (as seen in the output of git describe) :

mator@windrunner:~/xfstests$ git describe
linux-v3.8-1104-g024bdae

mator@windrunner:~/xfstests$ git log -1
commit 024bdaea1c5741d37bf62b0fcb5a581ede5a5682
Author: Eric Whitney <enwlinux@gmail.com>
Date:   Thu Jul 7 16:12:02 2016 -0400

and your comment commit ca7c8bcbe851b2795357ce0137ead4199fe69808 is from:
Author: Jeffrey Bastian <jbastian@redhat.com>
Date:   Wed May 18 12:40:54 2016 -0500
    build: avoid struct fsxattr redefinition

and in between, there's 69 additional commits:

mator@windrunner:~/xfstests$ git log
ca7c8bcbe851b2795357ce0137ead4199fe69808..024bdaea1c5741d37bf62b0fcb5a581ede5a5682
--pretty=oneline  | wc -l
69


i'm running debian sid with 4.6.3 kernel installed :

mator@windrunner:~$ uname -a
Linux windrunner 4.6.0-1-amd64 #1 SMP Debian 4.6.3-1 (2016-07-04)
x86_64 GNU/Linux

mator@windrunner:~$ dpkg -l linux-image-4.6.0-1-amd64 linux-libc-dev
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                            Version              Architecture
       Description
+++-===============================-====================-====================
ii  linux-image-4.6.0-1-amd64       4.6.3-1              amd64
       Linux 4.6 for 64-bit PCs
ii  linux-libc-dev:amd64            4.6.3-1              amd64
       Linux support headers for userspace development


mator@windrunner:~$ rm -rf xfstests/
mator@windrunner:~$ git clone git://oss.sgi.com/xfs/cmds/xfstests
Cloning into 'xfstests'...
remote: Counting objects: 19617, done.
remote: Compressing objects: 100% (9493/9493), done.
remote: Total 19617 (delta 14867), reused 13480 (delta 9928)
Receiving objects: 100% (19617/19617), 5.21 MiB | 828.00 KiB/s, done.
Resolving deltas: 100% (14867/14867), done.
Checking connectivity... done.

mator@windrunner:~$ cd xfstests/
mator@windrunner:~/xfstests$ make
autoheader
autoconf
./configure \
                --libexecdir=/usr/lib
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking for gmake... no
checking for make... /usr/bin/make
checking for glibtool... no
checking for libtool... /usr/bin/libtool
checking for tar... /bin/tar
checking for gzip... /bin/gzip
checking whether gcc -MM is supported... yes
checking for awk... /usr/bin/awk
checking for sed... /bin/sed
checking for echo... /bin/echo
checking for sort... /usr/bin/sort
checking whether ln -s works... yes
checking for rpm... no
checking how to run the C preprocessor... gcc -E
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking assert.h usability... yes
checking assert.h presence... yes
checking for assert.h... yes
checking bstring.h usability... no
checking bstring.h presence... no
checking for bstring.h... no
checking libgen.h usability... yes
checking libgen.h presence... yes
checking for libgen.h... yes
checking dirent.h usability... yes
checking dirent.h presence... yes
checking for dirent.h... yes
checking errno.h usability... yes
checking errno.h presence... yes
checking for errno.h... yes
checking malloc.h usability... yes
checking malloc.h presence... yes
checking for malloc.h... yes
checking uuid.h usability... no
checking uuid.h presence... no
checking for uuid.h... no
checking uuid/uuid.h usability... yes
checking uuid/uuid.h presence... yes
checking for uuid/uuid.h... yes
checking sys/uuid.h usability... no
checking sys/uuid.h presence... no
checking for sys/uuid.h... no
checking sys/file.h usability... yes
checking sys/file.h presence... yes
checking for sys/file.h... yes
checking sys/fcntl.h usability... yes
checking sys/fcntl.h presence... yes
checking for sys/fcntl.h... yes
checking sys/syssgi.h usability... no
checking sys/syssgi.h presence... no
checking for sys/syssgi.h... no
checking sys/param.h usability... yes
checking sys/param.h presence... yes
checking for sys/param.h... yes
checking for sys/stat.h... (cached) yes
checking sys/statvfs.h usability... yes
checking sys/statvfs.h presence... yes
checking for sys/statvfs.h... yes
checking sys/time.h usability... yes
checking sys/time.h presence... yes
checking for sys/time.h... yes
checking sys/ioctl.h usability... yes
checking sys/ioctl.h presence... yes
checking for sys/ioctl.h... yes
checking sys/wait.h usability... yes
checking sys/wait.h presence... yes
checking for sys/wait.h... yes
checking for sys/types.h... (cached) yes
checking for strings.h... (cached) yes
checking err.h usability... yes
checking err.h presence... yes
checking for err.h... yes
checking linux/falloc.h usability... yes
checking linux/falloc.h presence... yes
checking for linux/falloc.h... yes
checking sys/fs/xfs_fsops.h usability... no
checking sys/fs/xfs_fsops.h presence... no
checking for sys/fs/xfs_fsops.h... no
checking sys/fs/xfs_itable.h usability... no
checking sys/fs/xfs_itable.h presence... no
checking for sys/fs/xfs_itable.h... no
checking xfs/platform_defs.h usability... no
checking xfs/platform_defs.h presence... no
checking for xfs/platform_defs.h... no
checking btrfs/ioctl.h usability... no
checking btrfs/ioctl.h presence... no
checking for btrfs/ioctl.h... no
checking cifs/ioctl.h usability... no
checking cifs/ioctl.h presence... no
checking for cifs/ioctl.h... no
checking for xfs/xfs_log_format.h... no
checking for uuid_compare... no
checking for uuid_compare in -luuid... yes
checking for xfs/xfs.h... yes
checking for xfs/libxfs.h... no
checking whether xlog_assign_lsn is declared... no
checking for xfs/xqm.h... yes
checking xfsctl from xfs/xfs.h... ok
checking xfs/handle.h usability... yes
checking xfs/handle.h presence... yes
checking for xfs/handle.h... yes
checking for attr_list_by_handle in -lhandle... yes
checking attr/xattr.h usability... yes
checking attr/xattr.h presence... yes
checking for attr/xattr.h... yes
checking attr/attributes.h usability... yes
checking attr/attributes.h presence... yes
checking for attr/attributes.h... yes
checking sys/attributes.h usability... no
checking sys/attributes.h presence... no
checking for sys/attributes.h... no
checking for attr_list in -lattr... yes
checking for getxattr in -lattr... yes
checking sys/acl.h usability... yes
checking sys/acl.h presence... yes
checking for sys/acl.h... yes
checking acl/libacl.h usability... yes
checking acl/libacl.h presence... yes
checking for acl/libacl.h... yes
checking for acl_init in -lacl... yes
checking gdbm-ndbm.h usability... yes
checking gdbm-ndbm.h presence... yes
checking for gdbm-ndbm.h... yes
checking for dbm_open in -lgdbm... no
checking for dbm_fetch in -lgdbm... no
checking for dbm_store in -lgdbm... no
checking for dbm_close in -lgdbm... no
checking for dbm_open in -lgdbm_compat... yes
checking for dbm_fetch in -lgdbm_compat... yes
checking for dbm_store in -lgdbm_compat... yes
checking for dbm_close in -lgdbm_compat... yes
checking libaio.h usability... yes
checking libaio.h presence... yes
checking for libaio.h... yes
checking for dm_make_handle in -ldm... no

WARNING: could not find a valid DMAPI base library.
If you want DMAPI support please install the data migration
API (dmapi) library package. Alternatively, run "make install"
from the dmapi source.

checking linux/fiemap.h usability... yes
checking linux/fiemap.h presence... yes
checking for linux/fiemap.h... yes
checking for fallocate... yes
checking sys/prctl.h usability... yes
checking sys/prctl.h presence... yes
checking for sys/prctl.h... yes
checking linux/fs.h usability... yes
checking linux/fs.h presence... yes
checking for linux/fs.h... yes
checking openssl/md5.h usability... yes
checking openssl/md5.h presence... yes
checking for openssl/md5.h... yes
checking for renameat2... no
configure: creating ./config.status
config.status: creating include/builddefs
config.status: creating include/config.h
Building include
Building lib
    [LTDEP]
    [CC] dataascii.lo
    [CC] databin.lo
    [CC] datapid.lo
    [CC] file_lock.lo
    [CC] forker.lo
    [CC] pattern.lo
    [CC] open_flags.lo
    [CC] random_range.lo
    [CC] string_to_tokens.lo
    [CC] str_to_bytes.lo
    [CC] tlibio.lo
    [CC] write_log.lo
    [CC] random.lo
    [LD]
ar: `u' modifier ignored since `D' is the default (see `U')
Building ltp
    [DEP]
    [CC]    doio
    [CC]    fsstress
In file included from /usr/include/xfs/xfs.h:58:0,
                 from ../src/global.h:25,
                 from fsstress.c:20:
/usr/include/xfs/xfs_fs.h:42:8: error: redefinition of 'struct fsxattr'
 struct fsxattr {
        ^
In file included from fsstress.c:19:0:
/usr/include/linux/fs.h:155:8: note: originally defined here
 struct fsxattr {
        ^
Makefile:42: recipe for target 'fsstress' failed
make[3]: *** [fsstress] Error 1
include/buildrules:30: recipe for target 'ltp' failed
make[2]: *** [ltp] Error 2
Makefile:66: recipe for target 'default' failed
make[1]: *** [default] Error 2
Makefile:64: recipe for target 'default' failed
make: *** [default] Error 2
mator@windrunner:~/xfstests$

mator@windrunner:~/xfstests$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/5/lto-wrapper
Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Debian
5.4.0-6' --with-bugurl=file:///usr/share/doc/gcc-5/README.Bugs
--enable-languages=c,ada,c++,java,go,d,fortran,objc,obj-c++
--prefix=/usr --program-suffix=-5 --enable-shared
--enable-linker-build-id --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --libdir=/usr/lib
--enable-nls --with-sysroot=/ --enable-clocale=gnu
--enable-libstdcxx-debug --enable-libstdcxx-time=yes
--with-default-libstdcxx-abi=new --enable-gnu-unique-object
--disable-vtable-verify --enable-libmpx --enable-plugin
--with-system-zlib --disable-browser-plugin --enable-java-awt=gtk
--enable-gtk-cairo
--with-java-home=/usr/lib/jvm/java-1.5.0-gcj-5-amd64/jre
--enable-java-home
--with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-5-amd64
--with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-5-amd64
--with-arch-directory=amd64
--with-ecj-jar=/usr/share/java/eclipse-ecj.jar --enable-objc-gc
--enable-multiarch --with-arch-32=i686 --with-abi=m64
--with-multilib-list=m32,m64,mx32 --enable-multilib
--with-tune=generic --enable-checking=release --build=x86_64-linux-gnu
--host=x86_64-linux-gnu --target=x86_64-linux-gnu
Thread model: posix
gcc version 5.4.0 20160609 (Debian 5.4.0-6)
