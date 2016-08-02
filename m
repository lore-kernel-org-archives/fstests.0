Date: Tue, 2 Aug 2016 05:24:01 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 06/17] xfs: run xfs_repair at the end of each test
Message-ID: <20160802122401.GA31492@infradead.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914481474.11762.2741429828012981240.stgit@birch.djwong.org>
 <20160801062719.GH596@infradead.org>
 <20160801170814.GA8590@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160801170814.GA8590@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org, eguan@redhat.com, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

> We do have specific tests that examine the outputs of rebuilding the
> indices (all the fuzzer group tests do this too); this patch enables a
> test runner to expand that coverage to all tests.  Running a
> rebuilding xfs_repair for all the tests shook out some bugs in the
> xfs_repair rmap handling code that only triggered under some of the
> non-rmap non-reflink stressor tests.

Ok, looks fine then:

Reviewed-by: Christoph Hellwig <hch@lst.de>
