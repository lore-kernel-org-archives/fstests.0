Received: from bombadil.infradead.org ([198.137.202.133]:60474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfHXXFw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 24 Aug 2019 19:05:52 -0400
Date: Sat, 24 Aug 2019 16:05:50 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] generic: test for failure to unlock inode after chgrp
 fails with EDQUOT
Message-ID: <20190824230550.GA5494@infradead.org>
References: <20190823035528.GH1037422@magnolia>
 <20190823035734.GH1037350@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823035734.GH1037350@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: xfs <linux-xfs@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, Salvatore Bonaccorso <carnil@debian.org>, Security Officers <security@kernel.org>, Debian Security Team <team@security.debian.org>, benjamin.moody@gmail.com, Ben Hutchings <benh@debian.org>, Christoph Hellwig <hch@infradead.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

> diff --git a/tests/generic/group b/tests/generic/group
> index e998d1d5..bb93bccc 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -572,3 +572,4 @@
>  716 dangerous_norepair
>  717 auto quick rw swap
>  718 auto quick rw swap
> +719 dangerous

+ quota + metadata?  

Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

and after a while we should add it to auto.  I'm not even sure if we
shouldn't do that ASAP.  It's not that dangerous and we should test
for this everywhere..
