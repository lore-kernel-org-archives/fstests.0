Received: from bombadil.infradead.org ([65.50.211.133]:49512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754811AbdDMSRd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Apr 2017 14:17:33 -0400
Date: Thu, 13 Apr 2017 11:17:29 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] xfs/348: update error message when transmogrifying
 symlink into directory
Message-ID: <20170413181729.GA6909@infradead.org>
References: <20170413153942.GA5083@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413153942.GA5083@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 13, 2017 at 08:39:43AM -0700, Darrick J. Wong wrote:
> We introduced the inline directory verifier in 4.11 to prevent the
> system from trying to use corrupt inline directories.  This has the
> effect of changing the error message in one step of the i_mode fuzz
> tester, so update the test accordingly.
> 
> Note that prior to the existence of the verifier, this test would
> occasionally result in memory corruption that did not become evident
> until later.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
