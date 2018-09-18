Received: from mail-yw1-f66.google.com ([209.85.161.66]:39275 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeISDrr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Sep 2018 23:47:47 -0400
MIME-Version: 1.0
References: <CAH2r5ms8Z8jU60MpjvG0bYNK4PKAkt55x_-W6WwrseBkYq2cuw@mail.gmail.com>
In-Reply-To: <CAH2r5ms8Z8jU60MpjvG0bYNK4PKAkt55x_-W6WwrseBkYq2cuw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 19 Sep 2018 01:12:56 +0300
Message-ID: <CAOQ4uxhoJ-WhL3Fw-PUMosrDmTp3wA=KxEFsPhjz9ioJNL8MVw@mail.gmail.com>
Subject: Re: xfstest warning on all tests when running with memory debugging
 in kernel config
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 19, 2018 at 12:55 AM Steve French <smfrench@gmail.com> wrote:
>
> Running with kmemdebug on in the kernel config  I get this warning
> before and after all non-skipped xfstests
>
> Any idea how to get rid of it?
>
> generic/001 4s ...
> ./common/rc: line 3491: echo: write error: Device or resource busy
> ./common/rc: line 3493: echo: write error: Device or resource busy
> ...
>
> Basically it is doing (which returns an error when debugging enabled
> in the kernel).  I am running xfstest as root
>
> echo "scan" > "${DEBUGFS_MNT}/kmemleak"
>
> Ideas?

Please try this patch to see if it works for you and if not, maybe you
can figure
out why not:
https://marc.info/?l=fstests&m=153726750413543&w=2

I ended up enabling kmemleak, which led to catching a memory leak,
so I'm happy with that :)

Thanks,
Amir.
