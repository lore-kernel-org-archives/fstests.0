Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:32241 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752132AbeFIBzq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jun 2018 21:55:46 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fRT6V-0007Xx-L5
        for fstests@vger.kernel.org; Sat, 09 Jun 2018 11:55:43 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fRT6V-0005Bj-Iw
        for fstests@vger.kernel.org; Sat, 09 Jun 2018 11:55:43 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/9] fstests: Conversion of tests to SPDX license tags
Date: Sat,  9 Jun 2018 11:55:31 +1000
Message-Id: <20180609015540.19385-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

I'm attempting to post this set of patches to the list now that
i've done the SPDX license tag conversion on Eryu's current
staging tree. I'm not sure it will all get through (it's a huge set
of patches), so after I've send this I'll push it all to a git tree
branch on kernel.org.

The conversion is described in detail in the commit message of the
first patch, so I won't repeat it here. It's all scripted, but
there's a few minor touchups that were needed to some files either
before or after the script was run due to non-standard formatting.

The patch is based on Eryu's staging tree, so the patches probably
won't apply to last week's released tree. fstests still appears to
run after the conversion, so I didn't completely break everything.

I'll follow up in the next couple of weeks with patches to convert
other remaining parts of fstests to use SPDX tags. That's a much
smaller job than converting all the tests, so I'll just send patches
for those conversions as I do them.

Cheers,

Dave.

