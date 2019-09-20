Received: from mail-yb1-f193.google.com ([209.85.219.193]:36929 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405551AbfITSva (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Sep 2019 14:51:30 -0400
Received: by mail-yb1-f193.google.com with SMTP id v5so3005991ybq.4
        for <fstests@vger.kernel.org>; Fri, 20 Sep 2019 11:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190920184846.18251-1-amir73il@gmail.com>
In-Reply-To: <20190920184846.18251-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Sep 2019 21:51:18 +0300
Message-ID: <CAOQ4uxh9A287mMnNiikFvOwqVem=PJMsifGgmb5nLo1YdDNO6g@mail.gmail.com>
Subject: Re: [PATCH][xfstests-bld] build-all: fix acl tools build
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>
List-ID: <fstests@vger.kernel.org>

CC: Eryu's correct email address

On Fri, Sep 20, 2019 at 9:48 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On a clean do-all buster image getfacl is dynamically
> linked with libacl.so.1, but the built library is not installed.
> The installed libacl.so.1 in the image is incompatible with the
> version of acl tools that we build:
>
> root@kvm-xfstests:~# getfacl -n -p xfstests/
> getfacl: symbol lookup error: getfacl: undefined symbol: walk_tree
>
> Fix this by linking acl tools with the static libacl library.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  build-all | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/build-all b/build-all
> index 217ae62..83a1394 100755
> --- a/build-all
> +++ b/build-all
> @@ -233,12 +233,15 @@ fi
>
>  if test -z "$SKIP_ACL" ; then
>      build_start "ACL library"
> +    # Specify NO_SOLIB=1 so that libacl is only built as a static
> +    # library.  Then acl tools will be statically linked to it, and we won't
> +    # have to install libacl1.so.
>      (cd acl; \
>       CPPFLAGS="-I$DESTDIR/include" \
>       CFLAGS="$LCF -I$DESTDIR/include" \
>       LDFLAGS="$LLF $EXEC_LDFLAGS -L$DESTDIR/lib" \
>       ./configure $cross --prefix=$DESTDIR --disable-nls; $MAKE_CLEAN ; \
> -     make $J LDFLAGS="$LLF $EXEC_LLDFLAGS -static -L$DESTDIR/lib" ; \
> +     make $J NO_SOLIB=1 LDFLAGS="$LLF $EXEC_LLDFLAGS -static -L$DESTDIR/lib" ; \
>       make $J install)
>  fi
>
> --
> 2.17.1
>
