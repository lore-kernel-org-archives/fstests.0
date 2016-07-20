Received: from bombadil.infradead.org ([198.137.202.9]:37030 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbcGTTAK (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2016 15:00:10 -0400
Date: Wed, 20 Jul 2016 12:00:09 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] btrfs: test whether fallocate(2) can preallocate half of
 the whole fs space
Message-ID: <20160720190009.GA13348@infradead.org>
References: <20160720073450.8952-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160720073450.8952-1-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 20, 2016 at 03:34:50PM +0800, Wang Xiaoguang wrote:
> Currently in btrfs, there is something wrong with data space reservation.
> For example, if we try to preallocate more than haf of whole fs space,
> ENOSPC will occur, but indeed fs still has free space to satisfy this
> request.
> 
> To easily reproduce this bug, this test case needs fs is mixed mode(btrfs
> specific), so put this test case in btrfs group, not generic group.

But the actual test isn't btrfs specific, and other file systems might
have issues in this area as well.  Please add it to the generic group
instead.
