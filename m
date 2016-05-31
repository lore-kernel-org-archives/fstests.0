Date: Tue, 31 May 2016 05:51:09 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 8/7] xfs/122: don't break on old xfsprogs
Message-ID: <20160531125109.GA17018@infradead.org>
References: <146424222237.6278.4174636124436241002.stgit@birch.djwong.org>
 <20160527180231.GB5050@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160527180231.GB5050@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, Xiao Yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Looks fine, but can't we also remove the workaround at the end of the
the test as well?
