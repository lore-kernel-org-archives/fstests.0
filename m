Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:56470 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753095AbeDLXAj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Apr 2018 19:00:39 -0400
Date: Fri, 13 Apr 2018 09:00:35 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/444: add check for xfs_db write bno array
Message-ID: <20180412230035.GB5572@dastard>
References: <1523527230-6394-1-git-send-email-xuyang.jy@cn.fujitsu.com>
 <20180412120952.GM729@dastard>
 <20180412130038.GE2932@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412130038.GE2932@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: yang xu <xuyang.jy@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 12, 2018 at 09:00:38PM +0800, Eryu Guan wrote:
> On Thu, Apr 12, 2018 at 10:09:52PM +1000, Dave Chinner wrote:
> > On Thu, Apr 12, 2018 at 06:00:30PM +0800, yang xu wrote:
> > > ---
> > >  tests/xfs/444 | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/tests/xfs/444 b/tests/xfs/444
> > > index 141be52..fe80502 100755
> > > --- a/tests/xfs/444
> > > +++ b/tests/xfs/444
> > > @@ -58,6 +58,22 @@ _require_test_program "punch-alternating"
> > >  # This is only a v5 filesystem problem
> > >  _require_scratch_xfs_crc
> > >  
> > > +check_xfs_db_write_bno_array() {
> > 
> > _require_xfs_db_write_array(), and move to common/xfs.
> > 
> > > +	_scratch_xfs_set_metadata_field "bno[32]" "78" "agfl 0" >> $seqres.full
> > > +
> > > +	# Before xfsprogs commit 0ebbf1d58898 ("db: limit AGFL bno
> > > +	# arrayi printing), When asking for a single agfl entry,
> > > +	# the result outputs the entire remainder of the array
> > > +	# starting at the given index.
> > > +	# It is difficult to extract single entry values.
> > > +	# So filter them.
> > > +	bno2=$(_scratch_xfs_get_metadata_field "bno[32]" \
> > > +		"agfl 0" |sed -e 's/ .*$//g' | sed -e 's/^.*://g')
> > > +	echo "bno[32] set 78 get $bno2" >> $seqres.full
> > > +
> > > +	[ "${bno2}" != "78" ] && _fail "xfs_db write can't support bno array"
> > 
> > test should _notrun is db doesn't have therequired support, not
> > _fail.
> 
> If xfsprogs commit 4222d000ed ("db: write via array indexing doesn't
> work") introduced a new feature, I agreed that we need the _require rule
> and _notrun the test.

_require* rules are not for "new features" - they are for defining
the support needed to run the test correctly. This is no different
to detecting the mkfs binary version we are running to determine
if a certain fix is present or not:

# Skip the test if all calls passed - mkfs accepts invalid input
_require_xfs_mkfs_validation()
{
        _xfs_mkfs_validation_check
        if [ "$?" -eq 0 ]; then
                _notrun "Requires newer mkfs with stricter input checks: the oldest supported version of xfsprogs is 4.7."
        fi
}

This is exactly the same sort of situation, because....

> But this issue looks like a bug in xfsprogs to me, not a missing feature
> in xfsprogs on RHEL7, so I tend to fail the test instead of adding a new
> _require rule & _notrun the test. And in this case, IMHO, I don't think
> it's necessary to do any update to the test, just leave the test as it
> is and file a new bug in Red Hat bugzilla.

... this isn't a RHEL specific issue - it's an xfsprogs version
issue.  i.e.  any older distro that has a binary with a broken
"write array" command will fail this test. None of them are going to
get updated xfsprogs packages, so like having an old mkfs.xfs
binary, this test should run conditionally on having a version of
xfs_db that actually works correctly....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
