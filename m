Date: Sun, 31 Jul 2016 23:28:51 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 10/17] xfs/179: use scratch device helpers
Message-ID: <20160801062851.GL596@infradead.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914483981.11762.15707981777571396710.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146914483981.11762.15707981777571396710.stgit@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, eguan@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 04:47:19PM -0700, Darrick J. Wong wrote:
> Use the helper functions for scratch devices.  This fixes a problem
> where xfs/179 fails when there's a realtime device.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
