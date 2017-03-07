Received: from mail-ua0-f172.google.com ([209.85.217.172]:34690 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbdCGA7D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Mar 2017 19:59:03 -0500
Received: by mail-ua0-f172.google.com with SMTP id f54so189414497uaa.1
        for <fstests@vger.kernel.org>; Mon, 06 Mar 2017 16:57:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170127211003.ypphb36xhsn4vczq@thunk.org>
References: <CAMHSBOWq5oFTgpZ1hT_Nd7ebVc2nEp8yLp3CFB146fPmizOkEQ@mail.gmail.com>
 <20170127034557.l6kzxxjh2md2rfgs@thunk.org> <CAAbOSckhztYa6q56rzATXOKHJS6o4WEZPicMEc9RdOUHuWELdQ@mail.gmail.com>
 <20170127163748.vhqizartavwa7vxt@thunk.org> <CAAbOScmd_j-HgZj929fbWzs3JjLkB817dJ_A-ghLyD7kHjh7GA@mail.gmail.com>
 <20170127211003.ypphb36xhsn4vczq@thunk.org>
From: Mike Frysinger <vapier@chromium.org>
Date: Mon, 6 Mar 2017 17:56:48 -0700
Message-ID: <CAAbOScn5FooUbgM59QH40tdZ5D6B3MoYpfM8mBqLMfbMgxk=5w@mail.gmail.com>
Subject: Re: xfstest and chromeos
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Gwendal Grignou <gwendal@chromium.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 27, 2017 at 2:10 PM, Theodore Ts'o wrote:
> On Fri, Jan 27, 2017 at 08:02:30AM -1000, Mike Frysinger wrote:
>> > Right, but I'm able to create libtool without any problems and messing
>> > with aclocal.m4 and acinclude.m4, et. al.  I probably am relying on
>> > libtoolize from the local Debian or Guubuntu build host, though.  Is
>> > that the issue you're having with ChromeOS?  That you're using a
>> > different version of the libtool/autoconf macros?
>>
>> if we wanted, we could do all this manually too, but i don't think it
>> makes sense to force every developer to learn autotools and how to set
>> up a local copy.  Gwendal's patch makes things "just work" w/out
>> having to learn anything new.  the overhead is, arguably, negligible.
>
> Most developers are forced to learn autotools, since it's generally
> considered good practice by people who use libtools at all to not
> check in build artifacts into the git tree.

i have no idea what you're trying to argue here.
(1) xfstests already uses autotools.  disliking autotools doesn't change that.
(2) developers don't need to learn anything new.  you always run
`autoreconf -fi`.  FIN.  there is no need to figure out which specific
sub-tools to run (autoheader, autoconf, libtoolize, whatever), or in
what order.  if you're worried about people not knowing how to run
this one command, then we can add an "autogen.sh" script to the root
to run `autoreconf -fi` for you.  that's a semi-common practice in
autotool based projects.
(3) no one (on the CrOS side) is arguing for committing generated
artifacts into git.  that's a terrible practice regardless of
autotools.

> Especially given that xfstests and xfsprogs only need to work on Linux
> these days (we have enough other Linixisms that it would be hopeless
> to get it to work on, say, BSD or Open Solaris), in my opinion the
> right thing to do would be to completely ditch automake and libtool;
> e2fsprogs autoconf mainly for things like "--enable-elf-shlibs" and
> using Makefile fragments included as part of the configure process is
> plenty to handle shared libraries.  But that's up to Darrick and Eryu
> to decide.  :-)

so we trade one pile of standard scripts/hacks that the rest of the
world uses for a pile of non-standard/unique scripts/hacks that only
one project uses ?  that doesn't sound like an improvement, it just
sounds like "this is the pile i know".  except in the case of
xfstests, it isn't something we know.
-mike
