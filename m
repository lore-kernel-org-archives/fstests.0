Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:49327 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbfAUWxq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Jan 2019 17:53:46 -0500
Date: Tue, 22 Jan 2019 09:53:43 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 3/7] filter: add support for old filefrag -v
Message-ID: <20190121225343.GH4205@dastard>
References: <20190121163316.20616-1-jeffm@suse.com>
 <20190121163316.20616-3-jeffm@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121163316.20616-3-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: jeffm@suse.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 21, 2019 at 11:33:12AM -0500, jeffm@suse.com wrote:
> From: Jeff Mahoney <jeffm@suse.com>
> 
> e2fsprogs versions prior to v1.42.7 had a different format for
> filefrag -v that is incompatible with the regex in _filefrag_filter.
> 
> This patch adds support for the older format to test on older releases

Can you document what the two formats are in a comment just so it is
somewhat easier to check the regexes are, indeed, doing the right
thing?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
