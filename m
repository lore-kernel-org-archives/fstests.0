Received: from mail-yb1-f193.google.com ([209.85.219.193]:38408 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438303AbfIUPhR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 Sep 2019 11:37:17 -0400
Received: by mail-yb1-f193.google.com with SMTP id o18so3779473ybp.5
        for <fstests@vger.kernel.org>; Sat, 21 Sep 2019 08:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190920184846.18251-1-amir73il@gmail.com> <20190921141312.GA26913@mit.edu>
In-Reply-To: <20190921141312.GA26913@mit.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 21 Sep 2019 18:37:05 +0300
Message-ID: <CAOQ4uxjL7Ce+bnSuo8hxy8oEpz10FxF+9=jK7awoDAqLaW=k-g@mail.gmail.com>
Subject: Re: [PATCH][xfstests-bld] build-all: fix acl tools build
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, Sep 21, 2019 at 5:13 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Sep 20, 2019 at 09:48:46PM +0300, Amir Goldstein wrote:
> > On a clean do-all buster image getfacl is dynamically
> > linked with libacl.so.1, but the built library is not installed.
> > The installed libacl.so.1 in the image is incompatible with the
> > version of acl tools that we build:
>
> So I did a clean build of a4df7d7b3112: "Update the default version of
> quota and xfsprogs" in buster, and the resulting getfacl executable
> does not depend on libacl.so.1:
>
> <tytso@stretch-amd64-CHROOT.lambda> {/tmp/xfstests-bld}
> 1002% ldd xfstests/bin/getfacl
>         linux-vdso.so.1 (0x00007ffeafbc4000)
>         libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fd8cf9a0000)
>         /lib64/ld-linux-x86-64.so.2 (0x00007fd8cff47000)
>
> Is there something in your config.custom which is influencing the
> reseult?  I'm also not seeing any file in the acl directory, after the
> build, which contains NO_SOLIB:
>
> <tytso@stretch-amd64-CHROOT.lambda> {/tmp/xfstests-bld/acl}
> 1004% find . -type f -print | xargs grep NO_SOLIB
>
> The git repository for keyutils does respect NO_SOLIB, but that's
> because it's hard-coded into keyutils's Makefile.  So it doesn't
> appear to me how your change would make any difference to how the acl
> library is built.
>
> Can you take a closer look?
>

OK. You are right of course, that the change is wrong and not needed.
Sorry for the noise.
I now wonder how did libacl.so.1 end up in bld/lib the first time I built...

I did try a do-update build after do-all, which may have caused it.

There is one issue with update builds that has been bothering me forever
and has to do with xfstests and xfsprogs build, so while we are on fstests
list I will mention that and maybe you can advise.

Unlike do-all, do-update does 'make' without 'configure', but when
configure.ac changes, and that happens every xfsprogs release,
xfsprogs as well as xfstests Makefile runs an unsolicited ./configure
without all the config parameters that were used for the first
xfstests-bld build and then build fails.

Is there a standard way to run ./configure in "olddefconfig" mode, rather
than "defconfig" mode, for the case that configure.ac changes?

Thanks,
Amir.
