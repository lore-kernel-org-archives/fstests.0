Received: from mail-pf0-f196.google.com ([209.85.192.196]:40023 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeDRE3m (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Apr 2018 00:29:42 -0400
Received: by mail-pf0-f196.google.com with SMTP id y66so268277pfi.7
        for <fstests@vger.kernel.org>; Tue, 17 Apr 2018 21:29:42 -0700 (PDT)
Date: Wed, 18 Apr 2018 12:29:38 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v3] common/xfs: Add require_xfs_db_write_array function
Message-ID: <20180418042938.GM2932@desktop>
References: <20180417040641.GA5210@magnolia>
 <1523945500-10819-1-git-send-email-xuyang.jy@cn.fujitsu.com>
 <20180417175917.GD5201@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417175917.GD5201@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>, xuyang.jy@cn.fujitsu.com
Cc: david@fromorbit.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 17, 2018 at 10:59:17AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 17, 2018 at 02:11:40PM +0800, yang xu wrote:
> > xfsprogs commit 4222d00("db: write via array indexing doesn't
> > work") fixes a bug that xfs_db write can't support array indexing.
> > This function will check whether the bug is fixed on the current
> > xfsprogs.
> > 
> > xfs/444 applies the function, and skips if this bug exists.
> > 
> > Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
> > ---
> >  common/xfs    | 17 +++++++++++++++++
> >  tests/xfs/444 |  1 +
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/common/xfs b/common/xfs
> > index 3169f87..0b59994 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -701,3 +701,20 @@ _scratch_xfs_set_sb_field()
> >  {
> >  	_scratch_xfs_set_metadata_field "$1" "$2" "sb 0"
> >  }
> > +
> > +#Before xfsprogs commit 4222d000ed("db: write via array indexing doesn't work"),
> > +##xfs_db command to write a specific AGFL index doesn't work.

I'll add more comments here to explain why we require a bug fix instead
of exposing the bug to users, e.g.

"It's a bug in a diagnostic tool that is only used by XFS developers as
a test infrastructure, so we can treat it as a infrastructure dependency
as all other _require rules."

> > +_require_xfs_db_write_array()
> > +{
> > +	local supported=0
> > +
> > +	_require_test
> > +	touch $TEST_DIR/$seq.img
> > +	$MKFS_XFS_PROG -d file,name=$TEST_DIR/$seq.img,size=512m >/dev/null 2>&1
> > +	$XFS_DB_PROG -x -c "agfl 0" -c "write bno[32] 78" $TEST_DIR/$seq.img \
> > +		>/dev/null 2>&1
> > +	$XFS_DB_PROG -x -c "agfl 0" -c "print bno[32]" $TEST_DIR/$seq.img \
> > +		| grep -q "bno\[32\] = 78" && supported=1
> > +	rm -f $TEST_DIR/$seq.img
> > +	[ $supported -eq 0 ] && _notrun "xfs_db write can't support array"
> > +}
> > diff --git a/tests/xfs/444 b/tests/xfs/444
> > index 141be52..9700422 100755
> > --- a/tests/xfs/444
> > +++ b/tests/xfs/444
> > @@ -54,6 +54,7 @@ _supported_os Linux
> >  _require_check_dmesg
> >  _require_scratch
> >  _require_test_program "punch-alternating"
> > +_require_xfs_db_write_array
> 
> Looks ok,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks for the review!

Eryu

> 
> --D
> 
> >  
> >  # This is only a v5 filesystem problem
> >  _require_scratch_xfs_crc
> > -- 
> > 1.8.3.1
> > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
