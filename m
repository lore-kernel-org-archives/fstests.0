Received: from bombadil.infradead.org ([198.137.202.9]:57256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933425AbcKOI5l (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Nov 2016 03:57:41 -0500
Date: Tue, 15 Nov 2016 00:57:41 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fstests: Block btrfs from test case generic/372
Message-ID: <20161115085741.GA25495@infradead.org>
References: <20161115081410.6779-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115081410.6779-1-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 15, 2016 at 04:14:10PM +0800, Qu Wenruo wrote:
> Since btrfs always return the whole extent even part of it is shared
> with other files, so the hole/extent counts differs for "file1" in this
> test case.

This would need an extremly detailed comment in the test case on why
btrfs is skipped IFF we decide to apply it.  That being siad I think
reporing shared extents incorrectly is a bug independent of how they
are implemented internally.
