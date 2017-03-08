Received: from mx1.redhat.com ([209.132.183.28]:34568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbdCHGly (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 8 Mar 2017 01:41:54 -0500
Date: Wed, 8 Mar 2017 14:29:15 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: generic/411 clash with TEST_DIR=/mnt
Message-ID: <20170308062915.GO14075@dhcp12-143.nay.redhat.com>
References: <20170307165027.GA15724@birch.djwong.org>
 <20170308035045.GN14075@dhcp12-143.nay.redhat.com>
 <20170308060959.GB14226@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308060959.GB14226@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 08, 2017 at 02:09:59PM +0800, Eryu Guan wrote:
> On Wed, Mar 08, 2017 at 11:50:45AM +0800, Zorro Lang wrote:
> > On Tue, Mar 07, 2017 at 08:50:27AM -0800, Darrick J. Wong wrote:
> > > Hi Zorro,
> > > 
> > > I noticed that generic/411 creates some sort of directory structure
> > > involving $TEST_DIR/$seq/$$_mpA/mnt1/mnt2, then pipes the findmnt output
> > > through _filter_test_dir.
> > > 
> > > Unfortunately, on my test system I have TEST_DIR=/mnt, so the filtering
> 
> Ah, that's a rare setup, I'm curious what you use for SCRATCH_MNT :)

me too :)

> 
> > > produces this output:
> > > 
> > > QA output created by 411
> > > ------
> > > TEST_DIR/411 SCRATCH_DEV
> > > mpA SCRATCH_DEV
> > > mpATEST_DIR1 SCRATCH_DEV
> > > mpB SCRATCH_DEV
> > > mpBTEST_DIR1 SCRATCH_DEV
> > > mpBTEST_DIR1/TEST_DIR2 SCRATCH_DEV
> > > mpC SCRATCH_DEV
> > > mpCTESTDIR1 SCRATCH_DEV
> > > ======
> > 
> > Hmm, that's really a problem, thanks for finding it:) If someone
> > use "/mnt" as TEST_DIR, _filter_test_dir will change all "/mnt"
> > things to "TEST_DIR".
> > 
> > Except we recommend all cases shouldn't contain "/mnt"
> > in its test path name. Or we'd better change _filter_test_dir,
> > make it to be more picky.
> > 
> > I prefer the second way, except someone has a third way :)
> > 
> > > crash test passed
> > > 
> > > Which means that the golden output comparison fails. :(
> > > 
> > > I'm not sure what's a proper fix here: changing _filter_test_dir to be
> > > more picky about what gets sed'ed?
> > > 
> > > e.g. sed -e "s,\([[:space:]]\)$TEST_DIR,\1TEST_DIR,g/"
> > 
> > Except [[:space:]]$TEST_DIR, maybe we should think about "^$TEST_DIR" too,
> > e.g:
> > 
> > echo "/mnt/mnt1/mnt2     /mnt/mnt3/mnt4" | \
> >      sed -e "s,\([[:space:]]\)$TEST_DIR,\1TEST_DIR,g" | \
> >      sed -e "s,^$TEST_DIR,TEST_DIR,g"
> > 
> > (Is there a simpler way to do above things ^^ ? :)
> > 
> > But this change will affect lots of cases, we need to run full around
> > xfstests to make sure it won't change some cases' golden output. What
> > do you think?
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Or just to change the test to use directory names that are less likely to be
> > > mistaken for TEST_* and SCRATCH_*?
> 
> I'd prefer this easier way :) IMO, getting the filters right is tricky
> (see Amir's recent patch for example, "4e965d8 fstests: fix test and
> scratch filters for overlapping DEV/MNT paths"), and, as you said, will
> affect more tests. Changing the directory names used in generic/411 is
> much easier, prefixing with $seq should do the work, e.g. ${seq}_mnt1

If we don't change the filter, we have a rule acquiescently, all sub-path
shouldn't contain $TEST_DIR or $SCRATCH_DIR. e.g:

TEST_DIR=/mnt/test; mkdir $TEST_DIR/mnt/test1
TEST_DIR=/mnt/1; mkdir $TEST_DIR/mnt/10

Thanks,
Zorro

> 
> Thanks,
> Eryu
