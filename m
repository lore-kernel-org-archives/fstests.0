Received: from mail-io0-f175.google.com ([209.85.223.175]:36572 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbdA0IlR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Jan 2017 03:41:17 -0500
Received: by mail-io0-f175.google.com with SMTP id j13so55851570iod.3
        for <fstests@vger.kernel.org>; Fri, 27 Jan 2017 00:41:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170127034557.l6kzxxjh2md2rfgs@thunk.org>
References: <CAMHSBOWq5oFTgpZ1hT_Nd7ebVc2nEp8yLp3CFB146fPmizOkEQ@mail.gmail.com>
 <20170127034557.l6kzxxjh2md2rfgs@thunk.org>
From: Mike Frysinger <vapier@chromium.org>
Date: Thu, 26 Jan 2017 22:40:39 -1000
Message-ID: <CAAbOSckhztYa6q56rzATXOKHJS6o4WEZPicMEc9RdOUHuWELdQ@mail.gmail.com>
Subject: Re: xfstest and chromeos
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Gwendal Grignou <gwendal@chromium.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 26, 2017 at 5:45 PM, Theodore Ts'o wrote:
> On Mon, Jan 23, 2017 at 09:57:15AM -0800, Gwendal Grignou wrote:
>> https://chromium-review.googlesource.com/#/c/424191
>> - Chromeos needs libtool to (cross-)compile packages and put them at
>> the right place. I needed to move archived aclocal.m4 to acinclude.m4.
>> Does it make sense to require aclocal to run to compile xfstests?
>
> I'm kind of curious why you need libtool to be able to cross-compile
> packages.
>
> I've been cross-compiling xfstests to armhf, ppcle, and arm64 without
> any issues.
>
> See:   https://git.kernel.org/cgit/fs/ext2/xfstests-bld.git/tree/build-all
>
> Are you trying to build with shared libraries, or some such?

it isn't about "needing" libtool, nor what we're attempting to do.  we
don't care if xfstools uses libtool or plain automake rules or
something else.  however, xfstests itself already utilizes `libtool`
to compile+link things, and indeed to also create libs like libtest.la
and libdmtest.la.

the host `libtool` is specifically generated with settings that target
the host system only.  just grep for your tuple in there (e.g. `grep
x86_64 /usr/bin/libtool`) to see.  for simpler builds, the differences
might go unnoticed as a happy accident.

by using LT_INIT in autoconf, it'll include a libtool script that
configure will create & use automatically tailored for the current
target.
-mike
