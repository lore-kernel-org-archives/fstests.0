Received: from mx1.redhat.com ([209.132.183.28]:43122 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbcCGDEs (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 6 Mar 2016 22:04:48 -0500
Date: Mon, 7 Mar 2016 11:04:44 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/259: disable CRC if testing with 512 bytes block size
Message-ID: <20160307030444.GA11419@eguan.usersys.redhat.com>
References: <1456937518-20505-1-git-send-email-eguan@redhat.com>
 <20160305204517.GA10065@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160305204517.GA10065@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Sat, Mar 05, 2016 at 12:45:17PM -0800, Christoph Hellwig wrote:
> This will force crcs off for all the blocksizes.  We should
> either always skip 512 bytes, or disable crcs only for the 512 byte
> inode size case.  The first seems either, but the second would give
> better test coverage.

Thanks for the review! I think the test itself has already disabled crc
for 512 block size fs, and this patch disables crc only if the TEST_DEV
has no crc, so it just fixes a corner case in this crc detecting, and
doesn't reduce the test coverage.

Thanks,
Eryu
