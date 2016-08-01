Date: Sun, 31 Jul 2016 23:29:32 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 12/17] reflink: test cross-mountpoint reflink and dedupe
Message-ID: <20160801062932.GN596@infradead.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914485237.11762.2526971565060691741.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146914485237.11762.2526971565060691741.stgit@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, eguan@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 04:47:32PM -0700, Darrick J. Wong wrote:
> Test sharing blocks via reflink and dedupe between two different
> mountpoints of the same filesystem.  This shouldn't work, since
> we don't allow cross-mountpoint functions.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
