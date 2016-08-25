Received: from bombadil.infradead.org ([198.137.202.9]:44756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933084AbcHYIGe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Aug 2016 04:06:34 -0400
Date: Thu, 25 Aug 2016 01:06:31 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] xfs/033: source mkfs output again if isize less than 512
Message-ID: <20160825080631.GD28747@infradead.org>
References: <1471790859-26077-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471790859-26077-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Sun, Aug 21, 2016 at 10:47:39PM +0800, Zorro Lang wrote:
> I moved the mkfs_xfs output to /dev/null, because:
>   1. I think it's not necessary.
>   2. The case maybe do and output mkfs once or twice(not sure). So it'll be
>   hard to keep consistent golden image.

I agree.  If for some reaoson we care about the info we should just
do a xfs_info later, but I can't see one.

But with this change I think we can also consolidate the output files
into a single 033.out file, can't we?
