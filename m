Received: from mx1.redhat.com ([209.132.183.28]:59364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750734AbdCIDiV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 8 Mar 2017 22:38:21 -0500
Date: Thu, 9 Mar 2017 11:11:54 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/411: change sub-path name that's duplicate of
 TEST_DIR
Message-ID: <20170309031154.GG14226@eguan.usersys.redhat.com>
References: <1488957991-18194-1-git-send-email-zlang@redhat.com>
 <CAOQ4uxhq2h_WEKz1o+_AC8qFT6n6x40eUcBUpoe2eT1pfHAo7w@mail.gmail.com>
 <20170308115136.GF14226@eguan.usersys.redhat.com>
 <CAOQ4uxiJKouz9c=91Odd1CsrmkiKcnFuQT1r2V1Fa+UuOm9fxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiJKouz9c=91Odd1CsrmkiKcnFuQT1r2V1Fa+UuOm9fxw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 08, 2017 at 04:26:22PM +0200, Amir Goldstein wrote:
> On Wed, Mar 8, 2017 at 1:51 PM, Eryu Guan <eguan@redhat.com> wrote:
> > On Wed, Mar 08, 2017 at 12:01:33PM +0200, Amir Goldstein wrote:
> >> On Wed, Mar 8, 2017 at 9:26 AM, Zorro Lang <zlang@redhat.com> wrote:
> >> > Darrick found generic/411 golden output mismatch if use
> >> > TEST_DIR=/mnt. Because g/411 use some test path named
> >> > /mnt/XXXX/mnt1/mnt2, _filter_test_dir will replace all
> >> > "/mnt" things to "TEST_DIR".
> >> >
> >> > For stop this failure, change all directory names to be
> >> > "$seq-XXX", that's less likely to be mistaken for TEST_*
> >> > and SCRATCH_*.
> >> >
> >>
> >> Although you have a right to choose whichever names you
> >> want top use for your test, this is papering over a bug.
> >>
> >> I re-read the docuemtnation for \B:
> >> http://www.rexegg.com/regex-boundaries.html#bengines
> >>
> >> To my understanding, the expression "\B$TEST_DIR" will
> >> match every instance of $TEST_DIR, where preceding character
> >> is NOT a letter, number or underscore.
> >> This is because $TEST_DIR must start with '/', which is not
> >> a letter, number or underscore.
> >>
> >> I think it should be safe to fix _filter_test_dir and _filter_scratch.
> >
> > I agreed, according to the document above, \B matches all positions
> > where \b doesn't match. And \b matches positions where "one side is a
> > word character and the other side is not", so \B matches "neither side
> > is a word character" and "both sides are a word character".
> >
> > This is also because we canonicalized all mount points, there's no path
> > like //mnt/mnt1 is allowed in fstests. And this leads me to wonder if we
> > should canonicalize all test devices (if they're block device), to avoid
> > something like //dev/sda5? The double "/" will break the \B match.
> >
> 
> //dev/sda5 does to break \B match.
> \B$TEST_DEV match, as you wrote, means that character before
> $TEST_DEV *is not* a word character, because $TEST_DEV begins
> with a non-word character. it doesn't matter the the second character
> is a non-word as well.
> 
> Attached a patch that I tested -g quick on xfs and overlayfs
> and did not see any regressions, but you better test it with a wider
> variety of fs types and a larger group of tests.

Sure, I'll give it more tests. Thanks!

> 
> > Further more, if we decide to use \B to improve _filter_test_dir and
> > _filter_scratch, it appears to me that the fix from commit 4e965d8
> > ("fstests: fix test and scratch filters for overlapping DEV/MNT paths")
> > can be discarded, the order is not a problem anymore.
> >
> 
> Well, not exactly.
> 
> The case that commit 4e965d8 fixes is:
> TEST_DEV=/mnt
> TEST_DIR=/mnt/ovl-mnt
> 
> So \B$TEST_DEV will still match the prefix of $TEST_DIR and this is
> wrong.

You're right, I missed that.

Thanks,
Eryu
