Date: Wed, 30 Mar 2016 06:43:27 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] xfs/206: filter out reflink related outputs
Message-ID: <20160330134327.GA16392@infradead.org>
References: <1459324609-5531-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459324609-5531-1-git-send-email-eguan@redhat.com>
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 30, 2016 at 03:56:49PM +0800, Eryu Guan wrote:
> Commit 13717ffc96fe ("xfs/206: fix output when mkfs knows about
> reflink") added extra lines to xfs/206.out to fit the mkfs output with
> reflink support, but broke tests without reflink support.
> 
> Fix it by filtering out reflink related outputs, just like filtering out
> crc related outputs in the test.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
