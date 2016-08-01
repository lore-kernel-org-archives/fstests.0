Date: Sun, 31 Jul 2016 23:26:25 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 05/17] common/reflink: actually test dedupe on scratch
 device
Message-ID: <20160801062625.GG596@infradead.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914480842.11762.9490852645886489605.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146914480842.11762.9490852645886489605.stgit@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, eguan@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 04:46:48PM -0700, Darrick J. Wong wrote:
> In _require_scratch_dedupe, test the scratch device, not the testdev.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
