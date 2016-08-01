Received: from userp1040.oracle.com ([156.151.31.81]:23178 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbcHARIy (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 1 Aug 2016 13:08:54 -0400
Date: Mon, 1 Aug 2016 10:08:15 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 06/17] xfs: run xfs_repair at the end of each test
Message-ID: <20160801170814.GA8590@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914481474.11762.2741429828012981240.stgit@birch.djwong.org>
 <20160801062719.GH596@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160801062719.GH596@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: david@fromorbit.com, eguan@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Sun, Jul 31, 2016 at 11:27:19PM -0700, Christoph Hellwig wrote:
> On Thu, Jul 21, 2016 at 04:46:54PM -0700, Darrick J. Wong wrote:
> > Run xfs_repair twice at the end of each test -- once to rebuild
> > the btree indices, and again with -n to check the rebuild work.
> 
> This looks fine to me in general, but shouldn't we have specific
> tests that test the rebuilding in a normal auto run?

We do have specific tests that examine the outputs of rebuilding the
indices (all the fuzzer group tests do this too); this patch enables a
test runner to expand that coverage to all tests.  Running a
rebuilding xfs_repair for all the tests shook out some bugs in the
xfs_repair rmap handling code that only triggered under some of the
non-rmap non-reflink stressor tests.

--D
