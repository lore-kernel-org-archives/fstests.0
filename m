Received: from imap.thunk.org ([74.207.234.97]:60978 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751155AbdA0VK0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Jan 2017 16:10:26 -0500
Date: Fri, 27 Jan 2017 16:10:03 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: xfstest and chromeos
Message-ID: <20170127211003.ypphb36xhsn4vczq@thunk.org>
References: <CAMHSBOWq5oFTgpZ1hT_Nd7ebVc2nEp8yLp3CFB146fPmizOkEQ@mail.gmail.com>
 <20170127034557.l6kzxxjh2md2rfgs@thunk.org>
 <CAAbOSckhztYa6q56rzATXOKHJS6o4WEZPicMEc9RdOUHuWELdQ@mail.gmail.com>
 <20170127163748.vhqizartavwa7vxt@thunk.org>
 <CAAbOScmd_j-HgZj929fbWzs3JjLkB817dJ_A-ghLyD7kHjh7GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAbOScmd_j-HgZj929fbWzs3JjLkB817dJ_A-ghLyD7kHjh7GA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Mike Frysinger <vapier@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 27, 2017 at 08:02:30AM -1000, Mike Frysinger wrote:
> > Right, but I'm able to create libtool without any problems and messing
> > with aclocal.m4 and acinclude.m4, et. al.  I probably am relying on
> > libtoolize from the local Debian or Guubuntu build host, though.  Is
> > that the issue you're having with ChromeOS?  That you're using a
> > different version of the libtool/autoconf macros?
> 
> if we wanted, we could do all this manually too, but i don't think it
> makes sense to force every developer to learn autotools and how to set
> up a local copy.  Gwendal's patch makes things "just work" w/out
> having to learn anything new.  the overhead is, arguably, negligible.

Most developers are forced to learn autotools, since it's generally
considered good practice by people who use libtools at all to not
check in build artifacts into the git tree.  And developers can also
check out my xfstests-bld git tree if they wanted something completely
turnkey.   Not that it's all that hard:

if test -z "$SKIP_XFSTESTS" ; then
    build_start "xfstests"
    (cd xfstests-dev; \
     ver=$(git describe --always --dirty); echo "xfstests	$ver ($(git log -1 --pretty=%cD))" > ../xfstests.ver ; \
     autoheader ; autoconf ; \
     CFLAGS="$LCF -I$DESTDIR/include -fno-stack-protector" \
     CPPFLAGS="-I$DESTDIR/include" \
     LDFLAGS="$LLF -static -L$DESTDIR/lib" \
     LIBS=-lpthread \
     ./configure $cross ; \
     make $J LLDFLAGS=$EXEC_LLDFLAGS PLDLIBS="$android_compat" \
	  LIBTOOL="/usr/bin/libtool --tag=CC" BUILD_VERBOSE=1)
fi

I personally don't mind checking in generated build artificats such as
"configure" into the git tree --- see how I do things with e2fsprogs
--- but I also have the good taste to absolutely consider libtool
and automake as abominations from hell.  :-)

If you want to try to convince Darrin and From: Theodore Ts'o <tytso@mit.edu>
To: Mike Frysinger <vapier@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, fstests@vger.kernel.org
Bcc: tytso@mit.edu
Subject: Re: xfstest and chromeos
Reply-To: 
In-Reply-To: <CAAbOScmd_j-HgZj929fbWzs3JjLkB817dJ_A-ghLyD7kHjh7GA@mail.gmail.com>

On Fri, Jan 27, 2017 at 08:02:30AM -1000, Mike Frysinger wrote:
> > Right, but I'm able to create libtool without any problems and messing
> > with aclocal.m4 and acinclude.m4, et. al.  I probably am relying on
> > libtoolize from the local Debian or Guubuntu build host, though.  Is
> > that the issue you're having with ChromeOS?  That you're using a
> > different version of the libtool/autoconf macros?
> 
> if we wanted, we could do all this manually too, but i don't think it
> makes sense to force every developer to learn autotools and how to set
> up a local copy.  Gwendal's patch makes things "just work" w/out
> having to learn anything new.  the overhead is, arguably, negligible.

Most developers are forced to learn autotools, since it's generally
considered good practice by people who use libtools at all to not
check in build artifacts into the git tree.  And developers can also
check out my xfstests-bld git tree if they wanted something completely
turnkey.   Not that it's all that hard:

if test -z "$SKIP_XFSTESTS" ; then
    build_start "xfstests"
    (cd xfstests-dev; \
     autoheader ; autoconf ; \
     CFLAGS="$LCF -I$DESTDIR/include -fno-stack-protector" \
     CPPFLAGS="-I$DESTDIR/include" \
     LDFLAGS="$LLF -static -L$DESTDIR/lib" \
     LIBS=-lpthread \
     ./configure $cross ; \
     make $J LLDFLAGS=$EXEC_LLDFLAGS PLDLIBS="$android_compat" \
	  LIBTOOL="/usr/bin/libtool --tag=CC" BUILD_VERBOSE=1)
fi

At least for xfstests, "autoheader ; autoconf ; configure ; make"
should be sufficient.  It's really not that hard.  And for cross
compilations, it's just:

    cross="--build=$(config.guess) --host=$CROSS_COMPILE"

and then using "configure $cross" instead.  I guess I'm not
understanding why it's considered tricky.

						- Ted

P.S.  I personally don't mind checking in generated build artificats
such as "configure" into the git tree --- see how I do things with
e2fsprogs --- but I also have the good taste to absolutely consider
libtool and automake as abominations from hell.  :-)

Especially given that xfstests and xfsprogs only need to work on Linux
these days (we have enough other Linixisms that it would be hopeless
to get it to work on, say, BSD or Open Solaris), in my opinion the
right thing to do would be to completely ditch automake and libtool;
e2fsprogs autoconf mainly for things like "--enable-elf-shlibs" and
using Makefile fragments included as part of the configure process is
plenty to handle shared libraries.  But that's up to Darrick and Eryu
to decide.  :-)

