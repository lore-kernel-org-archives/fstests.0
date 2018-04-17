Received: from mail-pl0-f66.google.com ([209.85.160.66]:34425 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbeDQPXZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Apr 2018 11:23:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id z12-v6so4704084plo.1
        for <fstests@vger.kernel.org>; Tue, 17 Apr 2018 08:23:25 -0700 (PDT)
Date: Tue, 17 Apr 2018 23:23:18 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] README requirements for debian sid to enable build of
 src/dbtest.c
Message-ID: <20180417152318.GL2932@desktop>
References: <20180416140430.af246b2midlzetty@yogzotot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416140430.af246b2midlzetty@yogzotot>
Sender: fstests-owner@vger.kernel.org
To: Anatoly Pugachev <matorola@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 16, 2018 at 05:04:30PM +0300, Anatoly Pugachev wrote:
> Hello!
> 
> Please apply the following trivial patch to enable building of src/dbtest.c on
> debian sid. Without installing mentioned below devel package, xfstests could
> not be built, complaining:
> 
> xfstests-dev$ make
> Building include
> Building lib
> Building ltp
> Building src
>     [CC]    dbtest
> dbtest.c:28:5: error: expected '=', ',', ';', 'asm' or '__attribute__' before '!' token
>  bozo!
>      ^
> dbtest.c:41:3: warning: data definition has no type or storage class
>  } myDB;
>    ^~~~
> dbtest.c:41:3: warning: type defaults to 'int' in declaration of 'myDB' [-Wimplicit-int]

I don't see this build error if I have only libgdbm-dev installed on
debian sid, dbtest just doesn't get built.

But there's no such problem on debian stretch. It seems like that debian
sid moves dbm_(open|close|restore) symbols from package libgdbm to
package libgdbm-compat, which is a new package in sid and not available
in stretch.

> 
> Thanks.
> 
> Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
> ---
>  README | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/README b/README
> index 50c68afa..8b7849bc 100644
> --- a/README
> +++ b/README
> @@ -7,8 +7,8 @@ _______________________
>    For example, for Ubuntu:
>         sudo apt-get install xfslibs-dev uuid-dev libtool-bin \
>         e2fsprogs automake gcc libuuid1 quota attr libattr1-dev make \
> -       libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench \
> -       uuid-runtime python sqlite3
> +       libacl1-dev libaio-dev xfsprogs libgdbm-dev libgdbm-compat-dev \
> +       gawk fio dbench uuid-runtime python sqlite3

So this command will fail on debian stretch (or other earlier releases)
as there's no libgdbm-compat-dev package. Not a big problem, but a bit
annoying, I think.

I'm wondering if we just convert src/dbtest.c to use the gdbm_ functions
instead of the dbm_ ones (and perhaps we can simplify
m4/package_gdbmdev.m4 file too)? Though it's not a trivial replacement..

Thanks,
Eryu

>    For Fedora, RHEL, or CentOS:
>         yum install acl attr automake bc dbench dump e2fsprogs fio \
>         gawk gcc indent libtool lvm2 make psmisc quota sed \
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
