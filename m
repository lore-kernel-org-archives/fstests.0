Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40723 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbfGFDk5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Jul 2019 23:40:57 -0400
Date: Fri, 5 Jul 2019 23:40:53 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 4/5] shared,generic: move shared/006 to generic/
Message-ID: <20190706034053.GB11665@mit.edu>
References: <20190628225910.17018-1-tytso@mit.edu>
 <20190628225910.17018-4-tytso@mit.edu>
 <20190705080757.GG7943@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705080757.GG7943@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 05, 2019 at 04:07:57PM +0800, Eryu Guan wrote:
> > +_require_scratch_inode_limits()
> > +{
> > +	_require_scratch
> > +	_scratch_mkfs > /dev/null 2>&1
> > +	_scratch_mount
> > +	if [ $(_get_free_inode $SCRATCH_MNT) -eq 0 ]; then
> > +		_notrun "$FSTYP does not have a fixed number of inodes available"
> > +	fi
> > +	_scratch_unmount
> > +}
> 
> I think testing against $TEST_DIR should be sufficient, so we could
> avoid the mkfs & mount & umount SCRATCH_DEV time.

I was following the pattern that I saw with other similar _require
tests (for example: _require_scratch_shutdown).  I *thought* the
reason why this is was done is because if the test only uses the
SCRATCH_DEV, there's no making it a requirement that TEST_DEV be
available --- since IIRC, we do support SCRATCH_DEV being available,
but not TEST_DEV.

I personally don't use xfstests in that way --- when I run xfstests,
TEST_DEV is always available and in some cases, SCRATCH_DEV won't be
present.  But I thought that's why _require_test exists --- so that
tests can be skipped if TEST_DEV does not exist.

      	     	     		      - Ted
