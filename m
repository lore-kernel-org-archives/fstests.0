Received: from mail-yw0-f169.google.com ([209.85.161.169]:35130 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeEEGzz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 5 May 2018 02:55:55 -0400
Received: by mail-yw0-f169.google.com with SMTP id z198-v6so3097402ywa.2
        for <fstests@vger.kernel.org>; Fri, 04 May 2018 23:55:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180505001951.5665-1-david@fromorbit.com>
References: <20180505001951.5665-1-david@fromorbit.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 May 2018 09:55:54 +0300
Message-ID: <CAOQ4uxgJ4+R05wfkgCA6DUEoQbPPJEhTGiE=5QDqoX5hjE7D7A@mail.gmail.com>
Subject: Re: [PATCH] README: document the new default run mode
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Sat, May 5, 2018 at 3:19 AM, Dave Chinner <david@fromorbit.com> wrote:
> From: Dave Chinner <dchinner@redhat.com>
>
> Also document the new way to run all tests (i.e. check -g all) and
> clean up all the stray whitespace in the readme file.
>
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>
[...]
> +      and it excludes tests that exercise conditions known to cause machine
> +      failures (i.e. the "dangerous" tests).

That would have been nice.. if it was implemented...

I counted 22 dangerous tests, 20 of which are in auto group, unlike the
87 dangerous_* tests, none of which are in auto group.

If running ./check would exclude 'dangerous' tests by default, should it
also exclude dangerous_* tests? Or should we just remove the 20
'dangerous' tests from auto group and try not to add new auto&dangerous
tests in the future?

Thanks,
Amir.
