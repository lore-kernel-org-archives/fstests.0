Date: Sun, 31 Jul 2016 23:27:55 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 08/17] xfs/129: fix post-metadump remounting idiocy
Message-ID: <20160801062755.GJ596@infradead.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914482728.11762.13650586482755819412.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146914482728.11762.13650586482755819412.stgit@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, eguan@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 04:47:07PM -0700, Darrick J. Wong wrote:
> Use the standard _scratch_mount to mount the filesystem from the restored
> image, instead of trying to call mount directly.  This is needed in case
> we had custom mount options (like rtdev).
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
