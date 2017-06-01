Received: from mx1.redhat.com ([209.132.183.28]:54698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbdFADMh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 31 May 2017 23:12:37 -0400
Date: Thu, 1 Jun 2017 11:12:35 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 0/6] xfstests: remove most IRIX-specific code
Message-ID: <20170601031235.GV23805@eguan.usersys.redhat.com>
References: <20170531223655.130613-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531223655.130613-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, May 31, 2017 at 03:36:49PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> For some time xfstests has de facto not supported IRIX anymore.  The
> final release of IRIX was over 10 years ago and it seems no one has
> been running the latest xfstests releases on any IRIX system, as at
> the very least xfstests now assumes the existence of some util-linux
> binaries.  There are probably other examples of this bitrot too.
> 
> Therefore, this patchset simplifies things removing IRIX support from
> the xfstests tests, build system, and documentation.
> 
> It focuses on making larger, more obvious cleanups.  Of course,
> there's more to do if people want to spend more time going through
> some of the more intricate details, especially XFS-specific details.
> But this should be a good start.

Thanks a lot for doing this!! I didn't see patch #2 and #3 hit the list
(too big for the list?). Do you have a public git repo that I can pull
from?

Thanks again!

Eryu
