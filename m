Received: from mx2.suse.de ([195.135.220.15]:57460 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbcCXMNT (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 24 Mar 2016 08:13:19 -0400
Date: Thu, 24 Mar 2016 13:13:47 +0100
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] generic/338: Add mmap race test
Message-ID: <20160324121347.GD4025@quack.suse.cz>
References: <1458740555-3512-1-git-send-email-jack@suse.cz>
 <20160324114934.GU11419@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160324114934.GU11419@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>
List-ID: <fstests@vger.kernel.org>

On Thu 24-03-16 19:49:34, Eryu Guan wrote:
> On Wed, Mar 23, 2016 at 02:42:35PM +0100, Jan Kara wrote:
> > Add test which spawns two threads racing to write to file via mmap and
> > checks the result. This is mainly interesting to uncover races in DAX
> > fault handling.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  src/Makefile          |   5 +-
> >  src/holetest.c        | 342 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/338     |  57 +++++++++
> >  tests/generic/338.out |  73 +++++++++++
> >  tests/generic/group   |   1 +
> >  5 files changed, 476 insertions(+), 2 deletions(-)
> >  create mode 100644 src/holetest.c
> >  create mode 100755 tests/generic/338
> >  create mode 100644 tests/generic/338.out
> 
> 338 is taken, 340 is free now :)

OK, will update.

> [snip]
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment and checks
> > +. ./common/rc
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch
> 
> Need to make sure "holetest" is built here, and there's a new helper to
> do it now
> 
> _require_test_program "holetest"

OK, thanks.

> And test fails when I tested on ext3/2/NFS/CIFS, because they have no
> fallocate support, so need to test for fallocate support as well
> 
> _require_xfs_io_command "falloc"

Actually, I have modified the test program not to use fallocate(2) but
instead just use posix_fallocate(3). That uses fallocate(2) when available
and falls back to write when not which is what we wanted and using both was
just duplicating effort needlessly. Thanks for review.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
