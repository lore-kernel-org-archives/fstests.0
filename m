Received: from mail-pf0-f170.google.com ([209.85.192.170]:46110 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbeEDHGn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 May 2018 03:06:43 -0400
Received: by mail-pf0-f170.google.com with SMTP id p12so16710158pff.13
        for <fstests@vger.kernel.org>; Fri, 04 May 2018 00:06:43 -0700 (PDT)
Date: Fri, 4 May 2018 15:06:39 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] check: run auto test group by default
Message-ID: <20180504070639.GB8373@desktop>
References: <20180504000509.2498-1-david@fromorbit.com>
 <CAOQ4uxi8pv02TzQ0r9B-3c350ivHJyNkQ1o6a9GM2iPougbatQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi8pv02TzQ0r9B-3c350ivHJyNkQ1o6a9GM2iPougbatQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>, willy@infradead.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 04, 2018 at 08:55:37AM +0300, Amir Goldstein wrote:
> On Fri, May 4, 2018 at 3:05 AM, Dave Chinner <david@fromorbit.com> wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Everyone who starts using fstests runs "check" without parameters,
> > and then has problems with it running dangerous tests. most people
> > just want fstests to act as a regression test suite, not a fuzzer or
> > exercise known crash conditions. Hence make the default behaviour to
> > be "run the auto group" rather than "run every test".
> >
> > To enable people to run all tests easily (if they really want to)
> > add a special group keyword named "all". This wildcard will trigger
> > selecting all the tests in fstests as per the original "check
> > without parameters" behaviour.
> >
> > Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> 
> It's great that we are being more welcoming to xfstests newcomers!
> in that note, please update README.

Yeah, a line in README to describe this would be great.

Thanks,
Eryu

> 
> Thanks,
> Amir.
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
