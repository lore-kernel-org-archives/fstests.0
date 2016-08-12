Date: Fri, 12 Aug 2016 11:14:00 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfs: test attr_list_by_handle cursor iteration
Message-ID: <20160812031400.GR27776@eguan.usersys.redhat.com>
References: <20160802235251.GB8586@birch.djwong.org>
 <20160803225150.GC25565@birch.djwong.org>
 <20160804042448.GR27776@eguan.usersys.redhat.com>
 <20160811174855.GD31540@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160811174855.GD31540@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, david@fromorbit.com, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 11, 2016 at 10:48:55AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 04, 2016 at 12:24:48PM +0800, Eryu Guan wrote:
> > I have to replace false/true with 0/1 to build it on RHEL6. I can fix it
> > at commit time if there's no other major updates.
> 
> Simply including <stdbool.h> would fix that on RHEL6, wouldn't it?

Yes, including <stdbool.h> fixes the build failure on RHEL6, another
option is to replace all bool with int, as mentioned in my first review
email. And Darric chose the "int" way in v2 but only updated the
function definition and forgot to update the callers (still passing
true/false, not 1/0).

Thanks for the review!

Eryu
