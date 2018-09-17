Received: from mail-yb1-f194.google.com ([209.85.219.194]:47050 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeIQKVx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Sep 2018 06:21:53 -0400
Received: by mail-yb1-f194.google.com with SMTP id y20-v6so7195665ybi.13
        for <fstests@vger.kernel.org>; Sun, 16 Sep 2018 21:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180916215011.31029-1-richard@nod.at>
In-Reply-To: <20180916215011.31029-1-richard@nod.at>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Sep 2018 07:56:01 +0300
Message-ID: <CAOQ4uxiU6WQLDQC9kh73c0JMX7Z7WY2ozrFmhV8ehYDSOtufuQ@mail.gmail.com>
Subject: Re: [PATCH] generic: Test whether xattrs work on unlinked files
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: fstests <fstests@vger.kernel.org>, koen.vandeputte@ncentric.com
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 17, 2018 at 12:55 AM Richard Weinberger <richard@nod.at> wrote:
>
> On UBIFS we had an embarrassing bug where xattr operations
> worked only for files with nlink > 0.
> Make sure this will never happen again.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Hi!
>
> I'm not sure whether this is worth a new test, maybe we can add it
> to an existing test? What about generic/020?

We usually add new tests, so existing test wont start failing
for unpatched kernels.

> Since xfs_io does not support xattrs, we need a new C test helper.t >

I could just as well write:

Since xfs_io does not support xattrs, we need to add xattrs support to xfs_io

but I won't be the one to insist on that.

What you did is you cloned attr_replace_test.c with the tiniest change
and did not even bother to mention that.

Please add -T flag support to attr_replace_test.c (following xfs_io -T)
instead of cloning the helper and use that in your new test.

Thanks,
Amir.
