Date: Sun, 31 Jul 2016 23:25:28 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/17] xfs: use rmapbt-checking helper
Message-ID: <20160801062528.GD596@infradead.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914478956.11762.1523179302392973799.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146914478956.11762.1523179302392973799.stgit@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, eguan@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 04:46:29PM -0700, Darrick J. Wong wrote:
> Don't open-code _notrun checks for the rmapbt, just use the helper.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
