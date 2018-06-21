Received: from mail-pg0-f67.google.com ([74.125.83.67]:41500 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754186AbeFUBzm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jun 2018 21:55:42 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so639938pgl.8
        for <fstests@vger.kernel.org>; Wed, 20 Jun 2018 18:55:42 -0700 (PDT)
Date: Thu, 21 Jun 2018 09:55:37 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 0/6] fstests: SPDX license conversion round 2
Message-ID: <20180621015537.GI2780@desktop>
References: <20180620020417.14581-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620020417.14581-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 20, 2018 at 12:04:11PM +1000, Dave Chinner wrote:
> Hi folks,
> 
> This is a smaller set of patches that convert the remaining GPLv2
> license templates in the fstests tree to SPDX tags. The patches
> should all be small enough to make it through to the list this time.
> 
> Mostly it was straight forward conversions with a little bit of
> manual cleanup, but there's a couple of things we need clarification
> on:
> 
> - src/log-writes has no copyright or license statements in either
>   the code or in the upstream repository, so I haven't tagged it.
> 
> - src/perf has not copyright or license statements, but fstests is
>   the upstream repository so I've tagged them as GPLv2.0
> 
> In both cases, we need Josef to add the correct copyrights and SPDX
> tags to these files, and in future we should not accept code that
> does not have either copyright or license statements in them.

Yeah, I'll pay more attentions to copyright statements. (I have a 'git
am' hook to make sure new tests have 'x' permission set, it shouldn't be
hard to extend the hook to check SPDX tags too. Or even further, write a
script like 'checkpatch.pl' in tools/ dir so everyone benefits from it).

> 
> There are some remaining files without tags. There are various
> different reasons for that - not GPLv2, license statement didn't
> match the scripts, no license statement to begin with, etc. These
> will be addressed in a future patch set.

Thanks a lot, Dave!

Eryu

> 
> Comments?
> 
> -Dave.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
