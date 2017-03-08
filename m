Received: from mx1.redhat.com ([209.132.183.28]:40018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdCHFHP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 8 Mar 2017 00:07:15 -0500
Date: Wed, 8 Mar 2017 11:50:45 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: generic/411 clash with TEST_DIR=/mnt
Message-ID: <20170308035045.GN14075@dhcp12-143.nay.redhat.com>
References: <20170307165027.GA15724@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170307165027.GA15724@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 07, 2017 at 08:50:27AM -0800, Darrick J. Wong wrote:
> Hi Zorro,
> 
> I noticed that generic/411 creates some sort of directory structure
> involving $TEST_DIR/$seq/$$_mpA/mnt1/mnt2, then pipes the findmnt output
> through _filter_test_dir.
> 
> Unfortunately, on my test system I have TEST_DIR=/mnt, so the filtering
> produces this output:
> 
> QA output created by 411
> ------
> TEST_DIR/411 SCRATCH_DEV
> mpA SCRATCH_DEV
> mpATEST_DIR1 SCRATCH_DEV
> mpB SCRATCH_DEV
> mpBTEST_DIR1 SCRATCH_DEV
> mpBTEST_DIR1/TEST_DIR2 SCRATCH_DEV
> mpC SCRATCH_DEV
> mpCTESTDIR1 SCRATCH_DEV
> ======

Hmm, that's really a problem, thanks for finding it:) If someone
use "/mnt" as TEST_DIR, _filter_test_dir will change all "/mnt"
things to "TEST_DIR".

Except we recommend all cases shouldn't contain "/mnt"
in its test path name. Or we'd better change _filter_test_dir,
make it to be more picky.

I prefer the second way, except someone has a third way :)

> crash test passed
> 
> Which means that the golden output comparison fails. :(
> 
> I'm not sure what's a proper fix here: changing _filter_test_dir to be
> more picky about what gets sed'ed?
> 
> e.g. sed -e "s,\([[:space:]]\)$TEST_DIR,\1TEST_DIR,g/"

Except [[:space:]]$TEST_DIR, maybe we should think about "^$TEST_DIR" too,
e.g:

echo "/mnt/mnt1/mnt2     /mnt/mnt3/mnt4" | \
     sed -e "s,\([[:space:]]\)$TEST_DIR,\1TEST_DIR,g" | \
     sed -e "s,^$TEST_DIR,TEST_DIR,g"

(Is there a simpler way to do above things ^^ ? :)

But this change will affect lots of cases, we need to run full around
xfstests to make sure it won't change some cases' golden output. What
do you think?

Thanks,
Zorro

> 
> Or just to change the test to use directory names that are less likely to be
> mistaken for TEST_* and SCRATCH_*?
> 
> --D
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
