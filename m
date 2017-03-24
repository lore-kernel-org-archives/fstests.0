Received: from mail-it0-f43.google.com ([209.85.214.43]:38174 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932488AbdCXXxk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Mar 2017 19:53:40 -0400
Received: by mail-it0-f43.google.com with SMTP id y18so5383520itc.1
        for <fstests@vger.kernel.org>; Fri, 24 Mar 2017 16:53:39 -0700 (PDT)
In-Reply-To: <20170324042347.GL14226@eguan.usersys.redhat.com>
References: <CAAbOScn5FooUbgM59QH40tdZ5D6B3MoYpfM8mBqLMfbMgxk=5w@mail.gmail.com>
 <20170320212045.4849-1-gwendal@chromium.org> <20170324042347.GL14226@eguan.usersys.redhat.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Fri, 24 Mar 2017 16:53:17 -0700
Message-ID: <CAMHSBOXeiK1xOkiTRxX1+V97cS3z=Mpvt=_21R52ZCCZHXNnDw@mail.gmail.com>
Subject: Re: [PATCH] Code to allow cros-compilation on chromeOS
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Eryu Guan <eguan@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 23, 2017 at 9:23 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Mon, Mar 20, 2017 at 02:20:45PM -0700, Gwendal Grignou wrote:
>> - Request LIBTOOL to be used
>> - Set topbuildir based on a Makefile variable to call libtool
>> - Use /usr/local instead of /var for xfstest final location
>> - Move macros from aclocal.m4 to acinclude.m4, aclocal.m4 is autogenerat=
ed.
>>
>> TEST=3DCompile in chromeOS chroot.
>> TEST=3DUsing a snippet of build-all at https://urldefense.proofpoint.com=
/v2/url?u=3Dhttps-3A__github.com_tytso_xfstests-2Dbld&d=3DDwIBaQ&c=3DRoP1Yu=
mCXCgaWHvlZYR8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ix=
oR77aMeAHE&m=3DcWDBHwtFLpBlLHXoeZBA9cB2fFFnzyQQHiVoJWzLrKQ&s=3DVl5D6Bv5s825=
YH2xomziAfhfhQC318syauikRsaz3i4&e=3D=20
>> After adding config.sub and config.guess with:
>> cp /usr/share/misc/config.sub /usr/share/misc/config.guess
>> Verified that compilation of xfstest works:
>> ver=3D$(git describe --always --dirty); echo "xfstests       $ver ($(git=
 log -1 --pretty=3D%cD))" > ../xfstests.ver ;
>> autoheader ; autoconf ;
>> CFLAGS=3D"$LCF -I$DESTDIR/include -fno-stack-protector"
>> CPPFLAGS=3D"-I$DESTDIR/include"
>> LDFLAGS=3D"$LLF -static -L$DESTDIR/lib"
>> LIBS=3D-lpthread
>> ./configure
>> make -j40 LLDFLAGS=3D$EXEC_LLDFLAGS LIBTOOL=3D"/usr/bin/libtool --tag=3D=
CC" BUILD_VERBOSE=3D1
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> I'm not an autotools expert, and I really appreciate if someone could
> help review build/packaging patches, thanks in advance!
>
> But I did hit errors when "make" on default fedora25 and RHEL7 hosts
> (which worked fine prior to this patch), I tried to "fix" them but
> failed.
>
> [root@bootp-73-5-211 fstests]# make
> autoheader
> autoconf
> configure.ac:2: error: possibly undefined macro: AC_CONFIG_MACRO_DIRS
>       If this token and others are legitimate, please use m4_pattern_allo=
w.
>       See the Autoconf documentation.
> configure.ac:5: error: possibly undefined macro: AC_PACKAGE_GLOBALS
> configure.ac:6: error: possibly undefined macro: AC_PACKAGE_UTILITIES
> configure.ac:43: error: possibly undefined macro: AC_PACKAGE_NEED_UUIDCOM=
PARE
> ...
>
> Seems AC_CONFIG_MACRO_DIRS is only available starting from autoconf
> 2.70, but f25 and rhel7 ship autoconf 2.69 by default.
Fixed.
>
> After changing AC_CONFIG_MACRO_DIRS to AC_CONFIG_MACRO_DIR, above error
> is gone, but other errors remain.
>
> [root@bootp-73-5-211 fstests]# make
> autoheader
> autoconf
> configure.ac:5: error: possibly undefined macro: AC_PACKAGE_GLOBALS
>       If this token and others are legitimate, please use m4_pattern_allo=
w.
>       See the Autoconf documentation.
> configure.ac:6: error: possibly undefined macro: AC_PACKAGE_UTILITIES
> configure.ac:43: error: possibly undefined macro: AC_PACKAGE_NEED_UUIDCOM=
PARE
> ...
>
> These macros are all defined in m4/ directory, so seems .m4 files are
> not included correctly, because aclocal.m4 was not generated
> automatically.
>
> After doing this change to Makefile, I got 'configure' file generated,
> but configure process failed again, because of missing config.sub file.
>
> diff --git a/Makefile b/Makefile
> index 30d8747..aa8db92 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -75,7 +75,7 @@ else
>  clean:  # if configure hasn't run, nothing to clean
>  endif
>
> -configure: configure.ac
> +configure: aclocal.m4 configure.ac
>         autoheader
>         autoconf
>
> @@ -84,7 +84,7 @@ include/builddefs include/config.h: configure
>                  --libexecdir=3D/usr/lib
>
>  aclocal.m4::
> -       aclocal --acdir=3D`pwd`/m4 --output=3D$@
> +       aclocal -I`pwd`/m4 --output=3D$@
>
>  depend: include/builddefs $(addsuffix -depend,$(SUBDIRS))
>
>
> [root@bootp-73-5-211 fstests]# make
> aclocal -I`pwd`/m4 --output=3Daclocal.m4
> autoheader
> autoconf
> ./configure \
>                 --libexecdir=3D/usr/lib
> configure: error: cannot run /bin/sh ./config.sub
> Makefile:83: recipe for target 'include/builddefs' failed
> make: *** [include/builddefs] Error 127
>
>
> I noticed that you copied config.sub and config.guess manually to
> xfstests directory, but this would break existing build process which
> doesn't expect to do that. And forcing users to do manually copy files
> to meet build requirements doesn't seem right to me either.
>
> Can you please take a look at these issues?
Yes, I did not do enough changes. I replaced autoheader and autoconf
in Makefile with autoreconf and libtoolize (similar to how gentoo
would compile xfstests) and it produces a valid ./configure.
The drawback is install_sh is overwritten by libtoolize, to libtool
has now to be used.

I already sent a patch, but in response to a bounced email, sorry.

Gwendal.
>
> Thanks,
> Eryu
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DcWDBHwtFLpBlLHXoeZBA9cB2fFFnzyQQHiVoJWzLrKQ&s=3DwtkAuBYysOPpJn7-du-mZTQX=
HR-jotTqEgoe8hz1mSA&e=3D=20
