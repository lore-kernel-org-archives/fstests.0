Received: from [198.137.202.9] ([198.137.202.9]:39106 "EHLO
	bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965880AbcCPMFH (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 16 Mar 2016 08:05:07 -0400
Date: Wed, 16 Mar 2016 05:04:16 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] xfs/073: filter out finobt warning from mkfs.xfs
Message-ID: <20160316120416.GA18030@infradead.org>
References: <1458129204-31882-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458129204-31882-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 16, 2016 at 07:53:24PM +0800, Eryu Guan wrote:
> When testing xfs/073 with MKFS_OPTIONS="-m crc=1,finobt=1" set, it fails
> due to extra warning about disabling finobt feature:
> 
>  +warning: finobt not supported without CRC support, disabled.
> 
> Because xfs/073 disables crc unconditionally and finobt can not be
> enabled either.

How about explicitly disabling finobt as well?
