Received: from mail-it0-f48.google.com ([209.85.214.48]:33637 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbdA0SK5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Jan 2017 13:10:57 -0500
Received: by mail-it0-f48.google.com with SMTP id d9so10670192itc.0
        for <fstests@vger.kernel.org>; Fri, 27 Jan 2017 10:10:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170127163748.vhqizartavwa7vxt@thunk.org>
References: <CAMHSBOWq5oFTgpZ1hT_Nd7ebVc2nEp8yLp3CFB146fPmizOkEQ@mail.gmail.com>
 <20170127034557.l6kzxxjh2md2rfgs@thunk.org> <CAAbOSckhztYa6q56rzATXOKHJS6o4WEZPicMEc9RdOUHuWELdQ@mail.gmail.com>
 <20170127163748.vhqizartavwa7vxt@thunk.org>
From: Mike Frysinger <vapier@chromium.org>
Date: Fri, 27 Jan 2017 08:02:30 -1000
Message-ID: <CAAbOScmd_j-HgZj929fbWzs3JjLkB817dJ_A-ghLyD7kHjh7GA@mail.gmail.com>
Subject: Re: xfstest and chromeos
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Gwendal Grignou <gwendal@chromium.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 27, 2017 at 6:37 AM, Theodore Ts'o wrote:
> On Thu, Jan 26, 2017 at 10:40:39PM -1000, Mike Frysinger wrote:
> > On Thu, Jan 26, 2017 at 5:45 PM, Theodore Ts'o wrote:
> > > On Mon, Jan 23, 2017 at 09:57:15AM -0800, Gwendal Grignou wrote:
> > >> https://chromium-review.googlesource.com/#/c/424191
> > >> - Chromeos needs libtool to (cross-)compile packages and put them at
> > >> the right place. I needed to move archived aclocal.m4 to acinclude.m4.
> > >> Does it make sense to require aclocal to run to compile xfstests?
> > >
> > > I'm kind of curious why you need libtool to be able to cross-compile
> > > packages.
> > >
> > > I've been cross-compiling xfstests to armhf, ppcle, and arm64 without
> > > any issues.
> > >
> > > See:   https://git.kernel.org/cgit/fs/ext2/xfstests-bld.git/tree/build-all
> > >
> > > Are you trying to build with shared libraries, or some such?
> >
> > it isn't about "needing" libtool, nor what we're attempting to do.  we
> > don't care if xfstools uses libtool or plain automake rules or
> > something else.  however, xfstests itself already utilizes `libtool`
> > to compile+link things, and indeed to also create libs like libtest.la
> > and libdmtest.la.
>
> Right, but I'm able to create libtool without any problems and messing
> with aclocal.m4 and acinclude.m4, et. al.  I probably am relying on
> libtoolize from the local Debian or Guubuntu build host, though.  Is
> that the issue you're having with ChromeOS?  That you're using a
> different version of the libtool/autoconf macros?

if we wanted, we could do all this manually too, but i don't think it
makes sense to force every developer to learn autotools and how to set
up a local copy.  Gwendal's patch makes things "just work" w/out
having to learn anything new.  the overhead is, arguably, negligible.
-mike
