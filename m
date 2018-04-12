Received: from mail-pf0-f193.google.com ([209.85.192.193]:42680 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeDLNAo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Apr 2018 09:00:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id o16so3633828pfk.9
        for <fstests@vger.kernel.org>; Thu, 12 Apr 2018 06:00:44 -0700 (PDT)
Date: Thu, 12 Apr 2018 21:00:38 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] xfs/444: add check for xfs_db write bno array
Message-ID: <20180412130038.GE2932@desktop>
References: <1523527230-6394-1-git-send-email-xuyang.jy@cn.fujitsu.com>
 <20180412120952.GM729@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412120952.GM729@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, yang xu <xuyang.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 12, 2018 at 10:09:52PM +1000, Dave Chinner wrote:
> On Thu, Apr 12, 2018 at 06:00:30PM +0800, yang xu wrote:
> > On RHEL7.5Alpha, the test case can trigger an xfsprogs bug that xfs_db
> > writes bno array failed ,such as:
> >   $ xfs_db -x -c "agfl 0" -c "write bno[32] 78" /dev/sda9
> >     bno[32] = 32:null 33:null 34:null 35:null 36:null 37:null ...
> > 
> > the correct result as below:
> >     bno[32] = 78
> > 
> > On xfs/444 the following code triggers this bug:
> >     cat $tmp.remap | while read dest_pos bno junk; do
> >           _scratch_xfs_set_metadata_field "bno[$dest_pos]" "$bno" \
> >           "agfl 0" >> $seqres.full
> >        done
> > 
> > It is because xfs_db on RHEL7.5Alpha doesn't support write via array
> > indexing.  The problem has been fixed since xfprogs commit 4222d000ed
> > ("db: write via array indexing doesn't work").  But the fix patch has
> > not been merged into RHEL7.5Alpha.
> > 
> > For users, they should know the reason for the failure of the test is
> > a filesystem bug or an xfsprogs bug.  So, we add check for xfs_db
> > write bno array.
> > 
> > Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>

(Please cc xfs list too for xfs-specific test cases in future. I didn't
add xfs list in this thread as Dave already replied).

> > ---
> >  tests/xfs/444 | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/tests/xfs/444 b/tests/xfs/444
> > index 141be52..fe80502 100755
> > --- a/tests/xfs/444
> > +++ b/tests/xfs/444
> > @@ -58,6 +58,22 @@ _require_test_program "punch-alternating"
> >  # This is only a v5 filesystem problem
> >  _require_scratch_xfs_crc
> >  
> > +check_xfs_db_write_bno_array() {
> 
> _require_xfs_db_write_array(), and move to common/xfs.
> 
> > +	_scratch_xfs_set_metadata_field "bno[32]" "78" "agfl 0" >> $seqres.full
> > +
> > +	# Before xfsprogs commit 0ebbf1d58898 ("db: limit AGFL bno
> > +	# arrayi printing), When asking for a single agfl entry,
> > +	# the result outputs the entire remainder of the array
> > +	# starting at the given index.
> > +	# It is difficult to extract single entry values.
> > +	# So filter them.
> > +	bno2=$(_scratch_xfs_get_metadata_field "bno[32]" \
> > +		"agfl 0" |sed -e 's/ .*$//g' | sed -e 's/^.*://g')
> > +	echo "bno[32] set 78 get $bno2" >> $seqres.full
> > +
> > +	[ "${bno2}" != "78" ] && _fail "xfs_db write can't support bno array"
> 
> test should _notrun is db doesn't have therequired support, not
> _fail.

If xfsprogs commit 4222d000ed ("db: write via array indexing doesn't
work") introduced a new feature, I agreed that we need the _require rule
and _notrun the test.

But this issue looks like a bug in xfsprogs to me, not a missing feature
in xfsprogs on RHEL7, so I tend to fail the test instead of adding a new
_require rule & _notrun the test. And in this case, IMHO, I don't think
it's necessary to do any update to the test, just leave the test as it
is and file a new bug in Red Hat bugzilla.

> 
> > +#Before xfsprogs commit 4222d000ed("db: write via array indexing doesn't work").
> > +#xfs_db command to write a specific AGFL index doesn't work. We should check it.
> > +check_xfs_db_write_bno_array
> 
> This comment belongs with the function, not the caller.

Agreed.

Thanks,
Eryu

> 
> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
