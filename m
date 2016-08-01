Date: Sun, 31 Jul 2016 23:27:39 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 07/17] xfs/128: cycle_mount the scratch device, not the
 test device
Message-ID: <20160801062739.GI596@infradead.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914482100.11762.3197784490090678443.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146914482100.11762.3197784490090678443.stgit@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, eguan@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 04:47:01PM -0700, Darrick J. Wong wrote:
> This test uses the scratch device, so cycle that, not the test dev.
> This is also a xfs_fsr test, so put it in the fsr group.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
