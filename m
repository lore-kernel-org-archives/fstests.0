Received: from mail-yb1-f194.google.com ([209.85.219.194]:32876 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLCHbO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Dec 2018 02:31:14 -0500
MIME-Version: 1.0
References: <20181203064256.26768-1-david@fromorbit.com> <20181203064256.26768-3-david@fromorbit.com>
In-Reply-To: <20181203064256.26768-3-david@fromorbit.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Dec 2018 09:30:58 +0200
Message-ID: <CAOQ4uxgqadtGXDU3UJAJeFGwNKOW1d4Ti8bmVZ3_ycMeK-CAow@mail.gmail.com>
Subject: Re: [PATCH 2/3] generic/43[014]: copy_range beyond source EOF should fail
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>, linux-api@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 3, 2018 at 8:43 AM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> As per the copy_file_range() man page:
>
> EINVAL
>         Requested range extends beyond the end of the source file;
> .....
>
> These tests actually attempt to copy beyond the end of the source
> file and so should fail with EINVAL. The kernel does not check this
> and so needs fixing. These operations should fail, so fix the tests.
>

[cc: linux-api]

Probably better to discuss this on the kernel patch itself, but well...

How confident are you about this change not breaking existing programs?

Thanks,
Amir.
