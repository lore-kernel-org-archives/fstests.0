Date: Sun, 31 Jul 2016 23:25:46 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/17] xfs/310: fix the size calculation for the huge
 device
Message-ID: <20160801062546.GE596@infradead.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914479586.11762.2725828627113169692.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146914479586.11762.2725828627113169692.stgit@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, eguan@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 04:46:35PM -0700, Darrick J. Wong wrote:
> Fix the calculation of the dmhuge size.  The previous calculation
> tried to calculate the size correctly, but got it wrong for 1k
> block sizes.  Therefore, clean the whole mess up.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
