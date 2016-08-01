Date: Sun, 31 Jul 2016 23:25:09 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 01/17] xfs/26[34]: remove duplicate tests
Message-ID: <20160801062509.GC596@infradead.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914478187.11762.1309628175021637188.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146914478187.11762.1309628175021637188.stgit@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, eguan@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 04:46:21PM -0700, Darrick J. Wong wrote:
> These two tests were accidentally double-added as xfs/30[78], but the
> newer versions have fixed up helper usage and fewer whitespace
> problems, so nuke the old tests.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
