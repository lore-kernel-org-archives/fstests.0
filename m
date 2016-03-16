Received: from mx1.redhat.com ([209.132.183.28]:46659 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222AbcCPOyU (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 16 Mar 2016 10:54:20 -0400
Date: Wed, 16 Mar 2016 22:54:18 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/073: filter out finobt warning from mkfs.xfs
Message-ID: <20160316145418.GT11419@eguan.usersys.redhat.com>
References: <1458129204-31882-1-git-send-email-eguan@redhat.com>
 <20160316120416.GA18030@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160316120416.GA18030@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 16, 2016 at 05:04:16AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 16, 2016 at 07:53:24PM +0800, Eryu Guan wrote:
> > When testing xfs/073 with MKFS_OPTIONS="-m crc=1,finobt=1" set, it fails
> > due to extra warning about disabling finobt feature:
> > 
> >  +warning: finobt not supported without CRC support, disabled.
> > 
> > Because xfs/073 disables crc unconditionally and finobt can not be
> > enabled either.
> 
> How about explicitly disabling finobt as well?

I think that's a cleaner way to fix it. Just that some extra work is
needed to let the test pass with old mkfs.xfs without metadata suport.

Will send v2 shortly. Thanks for the review!

Eryu
