Received: from mail-pf1-f195.google.com ([209.85.210.195]:38268 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfGGMv0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Jul 2019 08:51:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so6259218pfn.5
        for <fstests@vger.kernel.org>; Sun, 07 Jul 2019 05:51:26 -0700 (PDT)
Date: Sun, 7 Jul 2019 20:51:19 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2 4/5] shared,generic: move shared/006 to generic/
Message-ID: <20190707125119.GI7943@desktop>
References: <20190628225910.17018-1-tytso@mit.edu>
 <20190628225910.17018-4-tytso@mit.edu>
 <20190705080757.GG7943@desktop>
 <20190706034053.GB11665@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706034053.GB11665@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 05, 2019 at 11:40:53PM -0400, Theodore Ts'o wrote:
> On Fri, Jul 05, 2019 at 04:07:57PM +0800, Eryu Guan wrote:
> > > +_require_scratch_inode_limits()
> > > +{
> > > +	_require_scratch
> > > +	_scratch_mkfs > /dev/null 2>&1
> > > +	_scratch_mount
> > > +	if [ $(_get_free_inode $SCRATCH_MNT) -eq 0 ]; then
> > > +		_notrun "$FSTYP does not have a fixed number of inodes available"
> > > +	fi
> > > +	_scratch_unmount
> > > +}
> > 
> > I think testing against $TEST_DIR should be sufficient, so we could
> > avoid the mkfs & mount & umount SCRATCH_DEV time.
> 
> I was following the pattern that I saw with other similar _require
> tests (for example: _require_scratch_shutdown).  I *thought* the
> reason why this is was done is because if the test only uses the
> SCRATCH_DEV, there's no making it a requirement that TEST_DEV be
> available --- since IIRC, we do support SCRATCH_DEV being available,
> but not TEST_DEV.
> 
> I personally don't use xfstests in that way --- when I run xfstests,
> TEST_DEV is always available and in some cases, SCRATCH_DEV won't be
> present.  But I thought that's why _require_test exists --- so that
> tests can be skipped if TEST_DEV does not exist.

xfstests assumes TEST_DEV is always present and SCRATCH_DEV is optional
(but recommended). _require_test not only checks if TEST_DEV is avaiable
& properly mounted but also implies we should do fsck against TEST_DEV
after test, as _require_test does "touch ${RESULT_DIR}/require_test" as
well.

Regarding to _require_scratch_xxx, that's usually because the
requirement being checked might change when mkfs with different options.
But a filesystem will always have a fixed number of inodes no matter
what mkfs options it uses (the same is true for not having a fixed
number of inodes). So in this case, I think check against
TEST_DEV/TEST_DIR should be fine.

Thanks,
Eryu
