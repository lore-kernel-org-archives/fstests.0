Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:49495 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752784AbeFTCEV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jun 2018 22:04:21 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0006Pv-5R
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0003tY-2S
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/6] fstests: SPDX license conversion round 2
Date: Wed, 20 Jun 2018 12:04:11 +1000
Message-Id: <20180620020417.14581-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

This is a smaller set of patches that convert the remaining GPLv2
license templates in the fstests tree to SPDX tags. The patches
should all be small enough to make it through to the list this time.

Mostly it was straight forward conversions with a little bit of
manual cleanup, but there's a couple of things we need clarification
on:

- src/log-writes has no copyright or license statements in either
  the code or in the upstream repository, so I haven't tagged it.

- src/perf has not copyright or license statements, but fstests is
  the upstream repository so I've tagged them as GPLv2.0

In both cases, we need Josef to add the correct copyrights and SPDX
tags to these files, and in future we should not accept code that
does not have either copyright or license statements in them.

There are some remaining files without tags. There are various
different reasons for that - not GPLv2, license statement didn't
match the scripts, no license statement to begin with, etc. These
will be addressed in a future patch set.

Comments?

-Dave.

