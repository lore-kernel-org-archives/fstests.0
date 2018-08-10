Received: from mail-pg1-f193.google.com ([209.85.215.193]:32808 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeHJMMD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Aug 2018 08:12:03 -0400
Date: Fri, 10 Aug 2018 17:42:50 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: btrfs: Add test for corrupted orphan qgroup
 numbers
Message-ID: <20180810094250.GD2791@desktop>
References: <20180809074540.2588-1-wqu@suse.com>
 <CAL3q7H5vTyZ8BMBEi-S=1kP+88hXt-YeiK5cF=9bFKJ+89aHKw@mail.gmail.com>
 <b93343a4-fc4d-72fe-3c99-09bc2f8a1327@gmx.com>
 <CAL3q7H5Os74KDtUBJem-KwX2Pmd=ZCbTz1H2iN5a5goRjXeG3w@mail.gmail.com>
 <99946b5e-ea21-d963-7137-47284a6e8cb1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99946b5e-ea21-d963-7137-47284a6e8cb1@gmx.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 10, 2018 at 05:10:29PM +0800, Qu Wenruo wrote:
> 
> 
> On 8/10/18 4:54 PM, Filipe Manana wrote:
> > On Fri, Aug 10, 2018 at 9:46 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >> On 8/9/18 5:26 PM, Filipe Manana wrote:
> >>> On Thu, Aug 9, 2018 at 8:45 AM, Qu Wenruo <wqu@suse.com> wrote:
> >>>> This bug is exposed by populating a high level qgroup, and then make it
> >>>> orphan (high level qgroup without child)
> >>>
> >>> Same comment as in the kernel patch:
> >>>
> >>> "That sentence is confusing. An orphan, by definition [1], is someone
> >>> (or something in this case) without parents.
> >>> But you mention a group without children, so that should be named
> >>> "childless" or simply say "without children".
> >>> So one part of the sentence is wrong, either what is in parenthesis or
> >>> what comes before them.
> >>>
> >>> [1] https://www.thefreedictionary.com/orphan
> >>> "
> >>>
> >>>> with old qgroup numbers, and
> >>>> finally do rescan.
> >>>>
> >>>> Normally rescan should zero out all qgroups' accounting number, but due
> >>>> to a kernel bug which won't mark orphan qgroups dirty, their on-disk
> >>>> data is not updated, thus old numbers remain and cause qgroup
> >>>> corruption.
> >>>>
> >>>> Fixed by the following kernel patch:
> >>>> "btrfs: qgroup: Dirty all qgroups before rescan"
> >>>>
> >>>> Reported-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> >>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>> ---
> >>>>  tests/btrfs/170     | 82 +++++++++++++++++++++++++++++++++++++++++++++
> >>>>  tests/btrfs/170.out |  3 ++
> >>>>  tests/btrfs/group   |  1 +
> >>>>  3 files changed, 86 insertions(+)
> >>>>  create mode 100755 tests/btrfs/170
> >>>>  create mode 100644 tests/btrfs/170.out
> >>>>
> >>>> diff --git a/tests/btrfs/170 b/tests/btrfs/170
> >>>> new file mode 100755
> >>>> index 000000000000..bcf8b5c0e4f3
> >>>> --- /dev/null
> >>>> +++ b/tests/btrfs/170
> >>>> @@ -0,0 +1,82 @@
> >>>> +#! /bin/bash
> >>>> +# SPDX-License-Identifier: GPL-2.0
> >>>> +# Copyright (c) 2018 SUSE Linux Products GmbH.  All Rights Reserved.
> >>>> +#
> >>>> +# FS QA Test 170
> >>>> +#
> >>>> +# Test if btrfs can clear orphan (high level qgroup without child) qgroup's
> >>>> +# accounting numbers during rescan.
> >>>> +# Fixed by the following kernel patch:
> >>>> +# "btrfs: qgroup: Dirty all qgroups before rescan"
> >>>> +#
> >>>> +seq=`basename $0`
> >>>> +seqres=$RESULT_DIR/$seq
> >>>> +echo "QA output created by $seq"
> >>>> +
> >>>> +here=`pwd`
> >>>> +tmp=/tmp/$$
> >>>> +status=1       # failure is the default!
> >>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
> >>>> +
> >>>> +_cleanup()
> >>>> +{
> >>>> +       cd /
> >>>> +       rm -f $tmp.*
> >>>> +}
> >>>> +
> >>>> +# get standard environment, filters and checks
> >>>> +. ./common/rc
> >>>> +. ./common/filter
> >>>> +
> >>>> +# remove previous $seqres.full before test
> >>>> +rm -f $seqres.full
> >>>> +
> >>>> +# real QA test starts here
> >>>> +
> >>>> +# Modify as appropriate.
> >>>> +_supported_fs btrfs
> >>>> +_supported_os Linux
> >>>> +_require_scratch
> >>>> +
> >>>> +_scratch_mkfs > /dev/null 2>&1
> >>>> +_scratch_mount
> >>>> +
> >>>> +
> >>>> +# Populate the fs
> >>>> +_run_btrfs_util_prog subvolume create "$SCRATCH_MNT/subvol"
> >>>> +_pwrite_byte 0xcdcd 0 1M "$SCRATCH_MNT/subvol/file1" | _filter_xfs_io > /dev/null
> >>>> +
> >>>> +# Ensure that file reach disk, so it will also appear in snapshot
> >>>
> >>> # Ensure that buffered file data is persisted, so we won't have an
> >>> empty file in the snapshot.
> >>>> +sync
> >>>> +_run_btrfs_util_prog subvolume snapshot "$SCRATCH_MNT/subvol" "$SCRATCH_MNT/snapshot"
> >>>> +
> >>>> +
> >>>> +_run_btrfs_util_prog quota enable "$SCRATCH_MNT"
> >>>> +_run_btrfs_util_prog quota rescan -w "$SCRATCH_MNT"
> >>>> +
> >>>> +# Create high level qgroup
> >>>> +_run_btrfs_util_prog qgroup create 1/0 "$SCRATCH_MNT"
> >>>> +
> >>>> +# Don't use _run_btrfs_util_prog here, as it can return 1 to info user
> >>>> +# that qgroup is marked inconsistent, this is a bug in btrfs-progs, but
> >>>> +# to ensure it will work, we just ignore the return value.
> >>>
> >>> Comment should go away IMHO. The preferred way is to call
> >>> $BTRFS_UTIL_PROG and have failures noticed
> >>> through differences in the golden output. There's no point in
> >>> mentioning something that currently doesn't work
> >>> if it's not used here.
> >>
> >> In this case, I think we still need to mention why we don't use
> >> _run_btrfs_util_progs, in fact if we use _run_btrfs_util_progs, the test
> >> will just fail due to the return value.
> >>
> >> In fact, it's a workaround and worthy noting IIRC.
> > 
> > Still disagree, because we are not checking the return value and rely
> > on errors printing something to stderr/stdout.
> 
> OK, either way I'll introduce a new filter here for filtering out either
> "Quota data changed, rescan scheduled" or "quotas may be inconsistent,
> rescan needed".
> 
> As there is patch floating around to change the default behavior of
> "btrfs qgroup assign" to schedule rescan automatically.
> 
> The test needs to handle both cases anyway.
> 
> > 
> >>
> >>>
> >>>> +$BTRFS_UTIL_PROG qgroup assign "$SCRATCH_MNT/snapshot" 1/0 "$SCRATCH_MNT"
> >>>> +
> >>>> +# Above assign will mark qgroup inconsistent due to the shared extents
> >>>
> >>> assign -> assignment
> >>>
> >>>> +# between subvol/snapshot/high level qgroup, do rescan here
> >>>> +_run_btrfs_util_prog quota rescan -w "$SCRATCH_MNT"
> >>>
> >>> Use $BTRFS_UTIL_PROG directly instead, and adjust the golden output if needed.
> >>
> >> There is nothing special needed in "quota rescan".
> >>
> >> Only qgroup assign/remove could return 1 instead of 0.
> > 
> > And why not use $BTRFS_UTIL_PROG?
> > Not only that's the preferred way to do nowadays (I know many older
> > tests use _run_btrfs_util_prog), but it will
> > make this test consistent as right now it uses both.
> 
> The standard is not that clear.

That's part of my fault, I didn't make it clear. Even more, I let one
new test sneaked in recently.

> Not only a lot of old test cases use _run_btrfs_util_prog, but almost
> everywhere we don't care the output and don't expect the command to
> fail, we just call _run_btrfs_util_prog.
> (like snapshot/subvolume creation and quota enabling)

If we don't care about the output, just throw them away, i.e. redirect
to /dev/null.

> 
> If there is any official doc about the standard, I would follow.

Indeed, there're a lot of undocumented implicit rules like use tab not
spaces for indention. But we do review patches and give review comments.
IIRC, we've talked about this _run_btrfs_util_prog thing several times,
and I always prefer avoiding using it, because..

> 
> But according to above stated use case, we don't expect "btrfs quota
> rescan -w" to fail, neither do we care about the output, thus
> _run_btrfs_util_prog here still makes sense.

it fails the test immediately and implicitly, but we want test continue
to run even if there's a test failure, this will exercise some code
paths that are not commonly tested. It also prints nothing useful,
because the diff only tells there's a failure, you have to check
$seq_res.full file for details, but in most cases we could know why the
test fails just from the diff output. Also, checking return value is
against fstests' methodology, we catch failures by comparing the test
output with the golden image, and yes, sometimes we may need more
filters, but that's the methodology we use.

So please drop run_check/_run_btrfs_util_prog usages as Filipe
suggested, and I won't let new run_check/_run_btrfs_util_prog users in
in the future.

Thanks,
Eryu

> 
> Thanks,
> Qu
> 
> > 
> >>
> >>>
> >>>> +
> >>>> +# Now remove the qgroup relationship and make 1/0 orphan
> >>>> +# Due to the shared extent outside of 1/0, we will mark qgroup inconsistent
> >>>> +# and keep the number of qgroup 1/0
> >>>
> >>> Missing "." at the end of the sentences.
> >>>
> >>>> +$BTRFS_UTIL_PROG qgroup remove "$SCRATCH_MNT/snapshot" 1/0 "$SCRATCH_MNT"
> >>>> +
> >>>> +# Above removal also marks qgroup inconsistent, rescan again
> >>>> +_run_btrfs_util_prog quota rescan -w "$SCRATCH_MNT"
> >>>
> >>> Use $BTRFS_UTIL_PROG directly instead, and adjust the golden output if needed.
> >>
> >> The extra warning is not outputted by rescan, it's caused by qgroup
> >> assign/remove as mentioned above.
> > 
> > That still doesn't answer why not using  $BTRFS_UTIL_PROG, and I don't
> > see why it can't be used.
> > 
> > thanks
> > 
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> Thanks.
> >>>
> >>>> +
> >>>> +# After the test, btrfs check will verify qgroup numbers to catch any
> >>>> +# corruption.
> >>>> +
> >>>> +# success, all done
> >>>> +status=0
> >>>> +exit
> >>>> diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
> >>>> new file mode 100644
> >>>> index 000000000000..9002199e48ed
> >>>> --- /dev/null
> >>>> +++ b/tests/btrfs/170.out
> >>>> @@ -0,0 +1,3 @@
> >>>> +QA output created by 170
> >>>> +WARNING: quotas may be inconsistent, rescan needed
> >>>> +WARNING: quotas may be inconsistent, rescan needed
> >>>> diff --git a/tests/btrfs/group b/tests/btrfs/group
> >>>> index b616c73d09bf..339c977135c0 100644
> >>>> --- a/tests/btrfs/group
> >>>> +++ b/tests/btrfs/group
> >>>> @@ -172,3 +172,4 @@
> >>>>  167 auto quick replace volume
> >>>>  168 auto quick send
> >>>>  169 auto quick send
> >>>> +170 auto quick qgroup
> >>>> --
> >>>> 2.18.0
> >>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> >>>
> >>
> > 
> > 
> > 
> 
