Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:47022 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751537AbcK2Vev (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Nov 2016 16:34:51 -0500
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1cBq10-0002kQ-1y
        for fstests@vger.kernel.org; Wed, 30 Nov 2016 08:32:38 +1100
Received: from dave by discord.disaster.area with local (Exim 4.88)
        (envelope-from <david@fromorbit.com>)
        id 1cBq10-0002EY-0n
        for fstests@vger.kernel.org; Wed, 30 Nov 2016 08:32:38 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/2] common: make common/rc easier to manage
Date: Wed, 30 Nov 2016 08:32:31 +1100
Message-Id: <20161129213233.8462-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

common/rc has grown huge with lots of library functions, and it's
becoming hard to manage. The following two patches split the XFS and
btrfs specific functionality in common/rc into separate files which
are sourced directly from common/rc based on $FSTYP.

This moves a large chunk of code spread throughout common/rc into
smaller, more contained files where it is easier to see how the
filesystem specific pieces are put together. I'd like to see this
happen for other filesytems, and quite possibly other groups of
functionality that make sense to manage separately.

Thoughts and comments welcome!

-Dave.

