Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D59C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Apr 2022 05:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiDZFcp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Apr 2022 01:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiDZFco (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Apr 2022 01:32:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA4B12AD6
        for <fstests@vger.kernel.org>; Mon, 25 Apr 2022 22:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5933F60F1F
        for <fstests@vger.kernel.org>; Tue, 26 Apr 2022 05:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F335C385A4;
        Tue, 26 Apr 2022 05:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650950973;
        bh=r6yWKQhQXBt6CNv29EIfWOzxd5ND4uaEIIUlXLSPUSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUSDdUCpgbtxLoRC1r8L99QHKojWmFLvDBwFT4wTDiA6XUb73PTN4E0AN9TyN2FCa
         eHq/B5DvBIzyY9wdeVUE8DnMta6f7VQBnXGmdRMX4/Lix3RTY1Msgnr/VyQAqObd6T
         NQrcMcU8wpE/iAJyqQznmXcHHluH51sXkIi9VD/hIMQD4rM0QukVA8g+Azk/LedIiP
         c3YLnHf0RDSVkT+uhkQdCuiSoth+DpaNE87ixjBln6pFDr1U+gW1x/p30ydwXwkC6H
         Fx21Rv57vzRbWRmh0R3A7PY3lSZzYD/yTlYmTRXWxHHiOvh9sQpWNPc/wU8wgX2bhB
         7H+B/LDqX3ghA==
Date:   Tue, 26 Apr 2022 13:29:28 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org, david@fromorbit.com
Subject: Re: [PATCH] fstests: remove xfs/144
Message-ID: <20220426052928.tzcpujagipsurm4h@zlang-mailbox>
Mail-Followup-To: Eric Sandeen <sandeen@redhat.com>,
        fstests@vger.kernel.org, djwong@kernel.org, david@fromorbit.com
References: <1650950094-18453-1-git-send-email-sandeen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650950094-18453-1-git-send-email-sandeen@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 26, 2022 at 12:14:53AM -0500, Eric Sandeen wrote:
> This test was designed to validate the quota warning limit, which in
> theory was supposed to migrate from a soft quota to hard enforcement
> after a certain number of warnings. However, the xfs kernel commit
> which incremented the warning counter was reverted; see:
> 
> xfs: revert "xfs: actually bump warning counts when we send warnings"
> 
> in the kernel tree for an explanation of why. Due to that revert,
> which removed this functionality, remove this test.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

And as we've talked, I'll write a new one case:
2022-04-14 23:26 < sandeen> so you're suggesting that another test which exceeds soft quota with many writes is a good idea, and would have caught the quota warning /limit/ problem - right?
2022-04-14 23:26 < sandeen> that sounds reasonable to me

Thanks,
Zorro

>  tests/xfs/144     | 128 ---------------------------------------------
>  tests/xfs/144.out | 151 ------------------------------------------------------
>  2 files changed, 279 deletions(-)
>  delete mode 100755 tests/xfs/144
>  delete mode 100644 tests/xfs/144.out
> 
> diff --git a/tests/xfs/144 b/tests/xfs/144
> deleted file mode 100755
> index 5abec9a..0000000
> --- a/tests/xfs/144
> +++ /dev/null
> @@ -1,128 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) 2021 Oracle.  All Rights Reserved.
> -#
> -# FS QA Test No. 144
> -#
> -# Check that quota softlimit warnings work the way they should.  This means
> -# that we can disobey the softlimit up to warnlimit times before it turns into
> -# hard(er) enforcement.  This is a functional test for quota warnings, but
> -# since the functionality has been broken for decades, this is also a
> -# regression test for commit 4b8628d57b72 ("xfs: actually bump warning counts
> -# when we send warnings").
> -
> -. ./common/preamble
> -_begin_fstest auto quick quota
> -
> -# Import common functions.
> -. ./common/filter
> -. ./common/quota
> -
> -# real QA test starts here
> -_supported_fs xfs
> -_require_xfs_quota
> -_require_scratch
> -
> -exercise() {
> -	_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> -	cat $tmp.mkfs >>$seqres.full
> -
> -	# keep the blocksize and data size for dd later
> -	. $tmp.mkfs
> -
> -	_qmount
> -
> -	_qsetup $1
> -
> -	echo "Using type=$type id=$id" >>$seqres.full
> -
> -	echo
> -	echo "*** report initial settings" | tee -a $seqres.full
> -	$XFS_QUOTA_PROG -x \
> -		-c "limit -$type isoft=3 ihard=500000 $id" \
> -		-c "warn -$type -i -d 13" \
> -		$SCRATCH_DEV
> -	$XFS_QUOTA_PROG -x \
> -		-c "state -$type" >> $seqres.full
> -	$XFS_QUOTA_PROG -x \
> -		-c "repquota -birnN -$type" $SCRATCH_DEV |
> -		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> -
> -	echo
> -	echo "*** push past the soft inode limit" | tee -a $seqres.full
> -	_file_as_id $SCRATCH_MNT/softok1 $id $type $bsize 0
> -	_file_as_id $SCRATCH_MNT/softok2 $id $type $bsize 0
> -	_file_as_id $SCRATCH_MNT/softok3 $id $type $bsize 0
> -	_file_as_id $SCRATCH_MNT/softwarn1 $id $type $bsize 0
> -	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> -		-c "repquota -birnN -$type" $SCRATCH_DEV |
> -		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> -
> -	echo
> -	echo "*** push further past the soft inode limit" | tee -a $seqres.full
> -	for warn_nr in $(seq 2 5); do
> -		_file_as_id $SCRATCH_MNT/softwarn$warn_nr $id $type $bsize 0
> -	done
> -	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> -		-c "repquota -birnN -$type" $SCRATCH_DEV |
> -		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> -
> -	echo
> -	echo "*** push past the soft inode warning limit" | tee -a $seqres.full
> -	for warn_nr in $(seq 6 15); do
> -		_file_as_id $SCRATCH_MNT/softwarn$warn_nr $id $type $bsize 0
> -	done
> -	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> -		-c "repquota -birnN -$type" $SCRATCH_DEV |
> -		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> -
> -	echo
> -	echo "*** unmount"
> -	_scratch_unmount
> -}
> -
> -_scratch_mkfs > $seqres.full
> -_scratch_mount >> $seqres.full
> -
> -chmod a+rwx $SCRATCH_MNT $seqres.full	# arbitrary users will write here
> -bsize=$(_get_file_block_size $SCRATCH_MNT)
> -_scratch_unmount
> -
> -cat >$tmp.projects <<EOF
> -1:$SCRATCH_MNT
> -EOF
> -
> -cat >$tmp.projid <<EOF
> -root:0
> -scratch:1
> -EOF
> -
> -projid_file="$tmp.projid"
> -
> -echo "*** user"
> -_qmount_option "uquota"
> -exercise u
> -
> -echo "*** group"
> -_qmount_option "gquota"
> -exercise g
> -
> -echo "*** uqnoenforce"
> -_qmount_option "uqnoenforce"
> -exercise uno
> -
> -echo "*** gqnoenforce"
> -_qmount_option "gqnoenforce"
> -exercise gno
> -
> -echo "*** pquota"
> -_qmount_option "pquota"
> -exercise p
> -
> -echo "*** pqnoenforce"
> -_qmount_option "pqnoenforce"
> -exercise pno
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/xfs/144.out b/tests/xfs/144.out
> deleted file mode 100644
> index 963eb80..0000000
> --- a/tests/xfs/144.out
> +++ /dev/null
> @@ -1,151 +0,0 @@
> -QA output created by 144
> -*** user
> -meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
> -data     = bsize=XXX blocks=XXX, imaxpct=PCT
> -         = sunit=XXX swidth=XXX, unwritten=X
> -naming   =VERN bsize=XXX
> -log      =LDEV bsize=XXX blocks=XXX
> -realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
> -
> -*** report initial settings
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 0 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** push past the soft inode limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 4 3 500000 01 [7 days] 0 0 0 00 [--------]
> -
> -*** push further past the soft inode limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 8 3 500000 05 [7 days] 0 0 0 00 [--------]
> -
> -*** push past the soft inode warning limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 16 3 500000 13 [7 days] 0 0 0 00 [--------]
> -
> -*** unmount
> -*** group
> -meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
> -data     = bsize=XXX blocks=XXX, imaxpct=PCT
> -         = sunit=XXX swidth=XXX, unwritten=X
> -naming   =VERN bsize=XXX
> -log      =LDEV bsize=XXX blocks=XXX
> -realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
> -
> -*** report initial settings
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 0 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** push past the soft inode limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 4 3 500000 01 [7 days] 0 0 0 00 [--------]
> -
> -*** push further past the soft inode limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 8 3 500000 05 [7 days] 0 0 0 00 [--------]
> -
> -*** push past the soft inode warning limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 16 3 500000 13 [7 days] 0 0 0 00 [--------]
> -
> -*** unmount
> -*** uqnoenforce
> -meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
> -data     = bsize=XXX blocks=XXX, imaxpct=PCT
> -         = sunit=XXX swidth=XXX, unwritten=X
> -naming   =VERN bsize=XXX
> -log      =LDEV bsize=XXX blocks=XXX
> -realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
> -
> -*** report initial settings
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 0 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** push past the soft inode limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 4 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** push further past the soft inode limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 8 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** push past the soft inode warning limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 18 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** unmount
> -*** gqnoenforce
> -meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
> -data     = bsize=XXX blocks=XXX, imaxpct=PCT
> -         = sunit=XXX swidth=XXX, unwritten=X
> -naming   =VERN bsize=XXX
> -log      =LDEV bsize=XXX blocks=XXX
> -realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
> -
> -*** report initial settings
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 0 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** push past the soft inode limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 4 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** push further past the soft inode limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 8 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** push past the soft inode warning limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 18 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** unmount
> -*** pquota
> -meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
> -data     = bsize=XXX blocks=XXX, imaxpct=PCT
> -         = sunit=XXX swidth=XXX, unwritten=X
> -naming   =VERN bsize=XXX
> -log      =LDEV bsize=XXX blocks=XXX
> -realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
> -
> -*** report initial settings
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 0 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** push past the soft inode limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 4 3 500000 02 [7 days] 0 0 0 00 [--------]
> -
> -*** push further past the soft inode limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 8 3 500000 06 [7 days] 0 0 0 00 [--------]
> -
> -*** push past the soft inode warning limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 15 3 500000 13 [7 days] 0 0 0 00 [--------]
> -
> -*** unmount
> -*** pqnoenforce
> -meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
> -data     = bsize=XXX blocks=XXX, imaxpct=PCT
> -         = sunit=XXX swidth=XXX, unwritten=X
> -naming   =VERN bsize=XXX
> -log      =LDEV bsize=XXX blocks=XXX
> -realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
> -
> -*** report initial settings
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 0 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** push past the soft inode limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 4 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** push further past the soft inode limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 8 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** push past the soft inode warning limit
> -[ROOT] 0 0 0 00 [--------] 3 0 0 13 [--------] 0 0 0 00 [--------]
> -[NAME] 0 0 0 00 [--------] 18 3 500000 00 [--------] 0 0 0 00 [--------]
> -
> -*** unmount
> -- 
> 1.8.3.1
> 
