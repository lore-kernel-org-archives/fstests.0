Received: from bombadil.infradead.org ([198.137.202.133]:49162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfFGFoN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jun 2019 01:44:13 -0400
Date: Thu, 6 Jun 2019 22:44:12 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] fstests: generic/260: Make it handle btrfs more
 gracefully
Message-ID: <20190607054412.GA15161@infradead.org>
References: <20190603064009.9891-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603064009.9891-1-wqu@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 03, 2019 at 02:40:09PM +0800, Qu Wenruo wrote:
> If a filesystem doesn't map its logical address space (normally the
> bytenr/blocknr returned by fiemap) directly to its devices(s), the
> following assumptions used in the test case is no longer true:
> - trim range start beyond the end of fs should fail
> - trim range start beyond the end of fs with len set should fail

All these assumptions seem generally bogus.  I don't think we can just
run this as a generic test.
