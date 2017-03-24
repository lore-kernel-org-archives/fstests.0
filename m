Received: from mx1.redhat.com ([209.132.183.28]:44824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbdCXEXt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 24 Mar 2017 00:23:49 -0400
Date: Fri, 24 Mar 2017 12:23:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] Code to allow cros-compilation on chromeOS
Message-ID: <20170324042347.GL14226@eguan.usersys.redhat.com>
References: <CAAbOScn5FooUbgM59QH40tdZ5D6B3MoYpfM8mBqLMfbMgxk=5w@mail.gmail.com>
 <20170320212045.4849-1-gwendal@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320212045.4849-1-gwendal@chromium.org>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Gwendal Grignou <gwendal@chromium.org>
Cc: tytso@mit.edu, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 20, 2017 at 02:20:45PM -0700, Gwendal Grignou wrote:
> - Request LIBTOOL to be used
> - Set topbuildir based on a Makefile variable to call libtool
> - Use /usr/local instead of /var for xfstest final location
> - Move macros from aclocal.m4 to acinclude.m4, aclocal.m4 is autogenerate=
d.
>=20
> TEST=3DCompile in chromeOS chroot.
> TEST=3DUsing a snippet of build-all at https://urldefense.proofpoint.com/=
v2/url?u=3Dhttps-3A__github.com_tytso_xfstests-2Dbld&d=3DDwIBAg&c=3DRoP1Yum=
CXCgaWHvlZYR8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixo=
R77aMeAHE&m=3DCfsgeRzY4RIPfAUQqWlSEu0A-gXQ3jhYRYWh8njYK1Q&s=3DwJL4qnWAA1n2e=
k4-DxvFWIGPw8HbXGuN7Pl2SSpK6No&e=3D=20
> After adding config.sub and config.guess with:
> cp /usr/share/misc/config.sub /usr/share/misc/config.guess
> Verified that compilation of xfstest works:
> ver=3D$(git describe --always --dirty); echo "xfstests       $ver ($(git =
log -1 --pretty=3D%cD))" > ../xfstests.ver ;
> autoheader ; autoconf ;
> CFLAGS=3D"$LCF -I$DESTDIR/include -fno-stack-protector"
> CPPFLAGS=3D"-I$DESTDIR/include"
> LDFLAGS=3D"$LLF -static -L$DESTDIR/lib"
> LIBS=3D-lpthread
> ./configure
> make -j40 LLDFLAGS=3D$EXEC_LLDFLAGS LIBTOOL=3D"/usr/bin/libtool --tag=3DC=
C" BUILD_VERBOSE=3D1
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

I'm not an autotools expert, and I really appreciate if someone could
help review build/packaging patches, thanks in advance!

But I did hit errors when "make" on default fedora25 and RHEL7 hosts
(which worked fine prior to this patch), I tried to "fix" them but
failed.

[root@bootp-73-5-211 fstests]# make
autoheader
autoconf
configure.ac:2: error: possibly undefined macro: AC_CONFIG_MACRO_DIRS
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
configure.ac:5: error: possibly undefined macro: AC_PACKAGE_GLOBALS
configure.ac:6: error: possibly undefined macro: AC_PACKAGE_UTILITIES
configure.ac:43: error: possibly undefined macro: AC_PACKAGE_NEED_UUIDCOMPA=
RE
...

Seems AC_CONFIG_MACRO_DIRS is only available starting from autoconf
2.70, but f25 and rhel7 ship autoconf 2.69 by default.

After changing AC_CONFIG_MACRO_DIRS to AC_CONFIG_MACRO_DIR, above error
is gone, but other errors remain.

[root@bootp-73-5-211 fstests]# make
autoheader
autoconf
configure.ac:5: error: possibly undefined macro: AC_PACKAGE_GLOBALS
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
configure.ac:6: error: possibly undefined macro: AC_PACKAGE_UTILITIES
configure.ac:43: error: possibly undefined macro: AC_PACKAGE_NEED_UUIDCOMPA=
RE
...

These macros are all defined in m4/ directory, so seems .m4 files are
not included correctly, because aclocal.m4 was not generated
automatically.

After doing this change to Makefile, I got 'configure' file generated,
but configure process failed again, because of missing config.sub file.

diff --git a/Makefile b/Makefile
index 30d8747..aa8db92 100644
--- a/Makefile
+++ b/Makefile
@@ -75,7 +75,7 @@ else
 clean:  # if configure hasn't run, nothing to clean
 endif
=20
-configure: configure.ac
+configure: aclocal.m4 configure.ac
        autoheader
        autoconf
=20
@@ -84,7 +84,7 @@ include/builddefs include/config.h: configure
                 --libexecdir=3D/usr/lib
=20
 aclocal.m4::
-       aclocal --acdir=3D`pwd`/m4 --output=3D$@
+       aclocal -I`pwd`/m4 --output=3D$@
=20
 depend: include/builddefs $(addsuffix -depend,$(SUBDIRS))
=20

[root@bootp-73-5-211 fstests]# make
aclocal -I`pwd`/m4 --output=3Daclocal.m4
autoheader
autoconf
./configure \=20=20=20
                --libexecdir=3D/usr/lib
configure: error: cannot run /bin/sh ./config.sub
Makefile:83: recipe for target 'include/builddefs' failed
make: *** [include/builddefs] Error 127


I noticed that you copied config.sub and config.guess manually to
xfstests directory, but this would break existing build process which
doesn't expect to do that. And forcing users to do manually copy files
to meet build requirements doesn't seem right to me either.

Can you please take a look at these issues?

Thanks,
Eryu
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DCfsgeRzY4RIPfAUQqWlSEu0A-gXQ3jhYRYWh8njYK1Q&s=3D59ruBSBPZdkktlllER_f54rd=
80OfRe1pqnP1pe02x0Y&e=3D=20
