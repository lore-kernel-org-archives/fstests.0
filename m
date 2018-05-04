Received: from mail-yw0-f174.google.com ([209.85.161.174]:37764 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbeEDFzi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 May 2018 01:55:38 -0400
Received: by mail-yw0-f174.google.com with SMTP id u83-v6so6368603ywc.4
        for <fstests@vger.kernel.org>; Thu, 03 May 2018 22:55:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504000509.2498-1-david@fromorbit.com>
References: <20180504000509.2498-1-david@fromorbit.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 May 2018 08:55:37 +0300
Message-ID: <CAOQ4uxi8pv02TzQ0r9B-3c350ivHJyNkQ1o6a9GM2iPougbatQ@mail.gmail.com>
Subject: Re: [PATCH] check: run auto test group by default
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>, willy@infradead.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 4, 2018 at 3:05 AM, Dave Chinner <david@fromorbit.com> wrote:
> From: Dave Chinner <dchinner@redhat.com>
>
> Everyone who starts using fstests runs "check" without parameters,
> and then has problems with it running dangerous tests. most people
> just want fstests to act as a regression test suite, not a fuzzer or
> exercise known crash conditions. Hence make the default behaviour to
> be "run the auto group" rather than "run every test".
>
> To enable people to run all tests easily (if they really want to)
> add a special group keyword named "all". This wildcard will trigger
> selecting all the tests in fstests as per the original "check
> without parameters" behaviour.
>
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>

It's great that we are being more welcoming to xfstests newcomers!
in that note, please update README.

Thanks,
Amir.
