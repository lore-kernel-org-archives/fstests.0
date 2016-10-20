Received: from mx1.redhat.com ([209.132.183.28]:51810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965113AbcJTOgC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 20 Oct 2016 10:36:02 -0400
Date: Thu, 20 Oct 2016 22:35:59 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3 2/3] fstests: strip quotes from "$XFS_IO_PROG" call
 sites
Message-ID: <20161020143559.GK27776@eguan.usersys.redhat.com>
References: <1476689014-384-1-git-send-email-amir73il@gmail.com>
 <1476689014-384-2-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476689014-384-2-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 17, 2016 at 10:23:33AM +0300, Amir Goldstein wrote:
> The value of "$XFS_IO_PROG" may contain extra flags after the
> binary path (e.g. -F), so it is wrong to use the variable inside
> quotes in xfs_io execution call sites.
> 
> This bug surfaced while testing the new xfs_io -M flag.
                                                ^^^ should be -i now? :)

I can fix it at commit time.

Thanks,
Eryu
