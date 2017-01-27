Received: from mail-io0-f179.google.com ([209.85.223.179]:36490 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdA0TcL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Jan 2017 14:32:11 -0500
Received: by mail-io0-f179.google.com with SMTP id j13so68122800iod.3
        for <fstests@vger.kernel.org>; Fri, 27 Jan 2017 11:32:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAbOScmd_j-HgZj929fbWzs3JjLkB817dJ_A-ghLyD7kHjh7GA@mail.gmail.com>
References: <CAMHSBOWq5oFTgpZ1hT_Nd7ebVc2nEp8yLp3CFB146fPmizOkEQ@mail.gmail.com>
 <20170127034557.l6kzxxjh2md2rfgs@thunk.org> <CAAbOSckhztYa6q56rzATXOKHJS6o4WEZPicMEc9RdOUHuWELdQ@mail.gmail.com>
 <20170127163748.vhqizartavwa7vxt@thunk.org> <CAAbOScmd_j-HgZj929fbWzs3JjLkB817dJ_A-ghLyD7kHjh7GA@mail.gmail.com>
From: Gwendal Grignou <gwendal@google.com>
Date: Fri, 27 Jan 2017 11:31:50 -0800
Message-ID: <CAMHSBOUOZC49wBpq0DC7oGtjp09i_m3HNcz_Me2+w8=QYMa7Sw@mail.gmail.com>
Subject: Re: xfstest and chromeos
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Mike Frysinger <vapier@chromium.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Gwendal Grignou <gwendal@chromium.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 27, 2017 at 10:02 AM, Mike Frysinger <vapier@chromium.org> wrote:
> On Fri, Jan 27, 2017 at 6:37 AM, Theodore Ts'o wrote:
>> On Thu, Jan 26, 2017 at 10:40:39PM -1000, Mike Frysinger wrote:
>> > On Thu, Jan 26, 2017 at 5:45 PM, Theodore Ts'o wrote:
>> > > On Mon, Jan 23, 2017 at 09:57:15AM -0800, Gwendal Grignou wrote:
>> > >> https://chromium-review.googlesource.com/#/c/424191
>> > >> - Chromeos needs libtool to (cross-)compile packages and put them at
>> > >> the right place. I needed to move archived aclocal.m4 to acinclude.m4.
>> > >> Does it make sense to require aclocal to run to compile xfstests?
>> > >
>> > > I'm kind of curious why you need libtool to be able to cross-compile
>> > > packages.
>> > >
>> > > I've been cross-compiling xfstests to armhf, ppcle, and arm64 without
>> > > any issues.
>> > >
>> > > See:   https://git.kernel.org/cgit/fs/ext2/xfstests-bld.git/tree/build-all
>> > >
>> > > Are you trying to build with shared libraries, or some such?
>> >
>> > it isn't about "needing" libtool, nor what we're attempting to do.  we
>> > don't care if xfstools uses libtool or plain automake rules or
>> > something else.  however, xfstests itself already utilizes `libtool`
>> > to compile+link things, and indeed to also create libs like libtest.la
>> > and libdmtest.la.
>>
>> Right, but I'm able to create libtool without any problems and messing
>> with aclocal.m4 and acinclude.m4, et. al.  I probably am relying on
>> libtoolize from the local Debian or Guubuntu build host, though.  Is
>> that the issue you're having with ChromeOS?  That you're using a
>> different version of the libtool/autoconf macros?

Without the patch described in c/424191, emerging xfstest fails during
the install phase with:

>>> Install xfstests-9999 into /build/cave/tmp/portage/app-benchmarks/xfstests-9999/image/ category app-benchmarks
make -j1 install
Building include
...
Building ...
/usr/bin/gmake --no-print-directory Q=@ -C include install
gmake[1]: Nothing to be done for 'install'.
/usr/bin/gmake --no-print-directory Q=@ -C lib install
gmake[1]: Nothing to be done for 'install'.
/usr/bin/gmake --no-print-directory Q=@ -C ltp install
../install-sh -o gwendal -g portage -m 755 -d /var/lib/xfstests/ltp
/usr/bin/libtool --quiet --mode=install ../install-sh -o gwendal -g
portage -m 755 doio fsstress fsx growfiles iogen aio-stress
/var/lib/xfstests/ltp
Usage: /usr/bin/libtool [OPTION]... [MODE-ARG]...
Try 'libtool --help' for more information.
libtool:   error:'/var/lib/xfstests/ltp' is not a directory


The problem is in include/builddefs.in with PKG_LIB_DIR     =
/var/lib/@pkg_name@
As we cross compile into /build/<board>/..., we don't want to put data
on the local machine in /var.

Just prefixing  PKG_LIB_DIR with $(DESTDIR) is not good enough,
Although DESTDIR is defined it points to the directory is compiled:
/build/cave/tmp/portage/app-benchmarks/xfstests-9999/image/.
we are still using the default libtool in (/usr/bin/libtool).
By using LT_INIT, we build a libtool tailored to the environment and use it.
Looking at the difference between local libtool.sh and the default
one, the default settings are not correct: wrong compiler, not using
clang, different compiler flags,...

Gwendal.


>
> if we wanted, we could do all this manually too, but i don't think it
> makes sense to force every developer to learn autotools and how to set
> up a local copy.  Gwendal's patch makes things "just work" w/out
> having to learn anything new.  the overhead is, arguably, negligible.
> -mike
