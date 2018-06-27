Received: from mail-yw0-f195.google.com ([209.85.161.195]:38233 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752859AbeF0LhX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 07:37:23 -0400
Received: by mail-yw0-f195.google.com with SMTP id w13-v6so574053ywa.5
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 04:37:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627082103.9662-8-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com> <20180627082103.9662-8-david@fromorbit.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Jun 2018 14:37:22 +0300
Message-ID: <CAOQ4uxh1i2jKFgmDVucm7LGWjN0Ez8LyaxZ61dULwKYbAvEgfQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] overlay: convert some tests to new setup preamble
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 11:21 AM, Dave Chinner <david@fromorbit.com> wrote:
> From: Dave Chinner <dchinner@redhat.com>
>
> Small initial batch to demonstrate conversion.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Looks fine.

I can convert the rest of overlayfs tests once this batch is merged.

Thanks,
Amir.
