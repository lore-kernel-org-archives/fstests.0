Date: Sun, 31 Jul 2016 23:27:19 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 06/17] xfs: run xfs_repair at the end of each test
Message-ID: <20160801062719.GH596@infradead.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914481474.11762.2741429828012981240.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146914481474.11762.2741429828012981240.stgit@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, eguan@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 04:46:54PM -0700, Darrick J. Wong wrote:
> Run xfs_repair twice at the end of each test -- once to rebuild
> the btree indices, and again with -n to check the rebuild work.

This looks fine to me in general, but shouldn't we have specific
tests that test the rebuilding in a normal auto run?
