Date: Thu, 11 Aug 2016 10:48:55 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] xfs: test attr_list_by_handle cursor iteration
Message-ID: <20160811174855.GD31540@infradead.org>
References: <20160802235251.GB8586@birch.djwong.org>
 <20160803225150.GC25565@birch.djwong.org>
 <20160804042448.GR27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160804042448.GR27776@eguan.usersys.redhat.com>
To: Eryu Guan <eguan@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, david@fromorbit.com, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com, Christoph Hellwig <hch@infradead.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 04, 2016 at 12:24:48PM +0800, Eryu Guan wrote:
> I have to replace false/true with 0/1 to build it on RHEL6. I can fix it
> at commit time if there's no other major updates.

Simply including <stdbool.h> would fix that on RHEL6, wouldn't it?
