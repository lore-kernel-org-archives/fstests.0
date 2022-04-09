Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB5BC433F5
	for <linux-fstests@archiver.kernel.org>; Sat,  9 Apr 2022 04:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiDIEDG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 9 Apr 2022 00:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiDIEDF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 9 Apr 2022 00:03:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B89515B1
        for <fstests@vger.kernel.org>; Fri,  8 Apr 2022 21:00:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D472B82D5E
        for <fstests@vger.kernel.org>; Sat,  9 Apr 2022 04:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA1CC385A0;
        Sat,  9 Apr 2022 04:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649476856;
        bh=EV+EWoed3MBHPoctTABV3Rp649zTWyOsyNEd3JRVgDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urqcaIKqNF5o7TFOlUg+qvbcew8i7SxRCW1H2wkztP2WNc9/eS6ZEmux1fbLJ3ZDV
         Q5nUhZzQCeFZYIrZY3w4ZaxGaoOh83IzFB2gcNuTV7A1MgZOSXhsmSV4HA1rt1x/S2
         S2UHNXOBvqOLyPGBG/7OLMlu7MaezVlR4DmxhDLXe+6Zbcnia8iatXUGfKJUpejvVZ
         Mojlq9l3F2kw7OmNhItSTS88cJxsXheRV6CiOju3JEXvYeYM1f+Kq4eqs+Pzrshnyj
         TTCP3A/oidyDGagcS2m/I3GMDXal6LtLUa77cCYo/cbxpkJ0RTXygjfOVytGwBFeN7
         T7S8WibQktxmQ==
Date:   Fri, 8 Apr 2022 21:00:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfs: test xfsdump when an inode < root inode is
 present
Message-ID: <20220409040056.GA14099@magnolia>
References: <20220408170847.1088522-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408170847.1088522-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Apr 09, 2022 at 01:08:47AM +0800, Zorro Lang wrote:
> From: Eric Sandeen <sandeen@redhat.com>
> 
> This tests a longstanding bug where xfsdumps are not properly
> created when an inode is present on the filesytsem which has
> a lower number than the root inode.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Friendly ping for reviewing.
> 
> Thanks,
> Zorro
> 
>  common/dump       |  1 +
>  tests/xfs/543     | 63 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/543.out | 47 +++++++++++++++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
>  create mode 100755 tests/xfs/543
>  create mode 100644 tests/xfs/543.out
> 
> diff --git a/common/dump b/common/dump
> index ea16d442..ab48cd13 100644
> --- a/common/dump
> +++ b/common/dump
> @@ -219,6 +219,7 @@ _require_tape()
>  
>  _wipe_fs()
>  {
> +    [[ "$WIPE_FS" = "no" ]] && return

Is WIPE_FS intended as a general means to prevent wipefs -a between
tests?  If so, it ought to be in the README.

--D

>      _require_scratch
>  
>      _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
> diff --git a/tests/xfs/543 b/tests/xfs/543
> new file mode 100755
> index 00000000..4e3c823a
> --- /dev/null
> +++ b/tests/xfs/543
> @@ -0,0 +1,63 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Red Hat, Inc. All Rights Reserved.
> +#
> +# FS QA Test 543
> +#
> +# Create a filesystem which contains an inode with a lower number
> +# than the root inode. Ensure that xfsdump/xfsrestore handles this.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick dump
> +
> +# Import common functions.
> +. ./common/dump
> +
> +_supported_fs xfs
> +_require_scratch
> +
> +# A large stripe unit will put the root inode out quite far
> +# due to alignment, leaving free blocks ahead of it.
> +_scratch_mkfs_xfs -d sunit=1024,swidth=1024 > $seqres.full 2>&1
> +
> +# Mounting /without/ a stripe should allow inodes to be allocated
> +# in lower free blocks, without the stripe alignment.
> +_scratch_mount -o sunit=0,swidth=0
> +
> +root_inum=$(stat -c %i $SCRATCH_MNT)
> +
> +# Consume space after the root inode so that the blocks before
> +# root look "close" for the next inode chunk allocation
> +$XFS_IO_PROG -f -c "falloc 0 16m" $SCRATCH_MNT/fillfile
> +
> +# And make a bunch of inodes until we (hopefully) get one lower
> +# than root, in a new inode chunk.
> +echo "root_inum: $root_inum" >> $seqres.full
> +for i in $(seq 0 4096) ; do
> +	fname=$SCRATCH_MNT/$(printf "FILE_%03d" $i)
> +	touch $fname
> +	inum=$(stat -c "%i" $fname)
> +	[[ $inum -lt $root_inum ]] && break
> +done
> +
> +echo "created: $inum" >> $seqres.full
> +
> +[[ $inum -lt $root_inum ]] || _notrun "Could not set up test"
> +
> +# Now try a dump and restore. Cribbed from xfs/068
> +WIPE_FS="no"
> +_create_dumpdir_stress
> +
> +echo -n "Before: " >> $seqres.full
> +_count_dumpdir_files | tee $tmp.before >> $seqres.full
> +
> +# filter out the file count, it changes as fsstress adds new operations
> +_do_dump_restore | sed -e "/entries processed$/s/[0-9][0-9]*/NUM/g"
> +
> +echo -n "After: " >> $seqres.full
> +_count_restoredir_files | tee $tmp.after >> $seqres.full
> +diff -u $tmp.before $tmp.after
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/543.out b/tests/xfs/543.out
> new file mode 100644
> index 00000000..a5224aaf
> --- /dev/null
> +++ b/tests/xfs/543.out
> @@ -0,0 +1,47 @@
> +QA output created by 543
> +Creating directory system to dump using fsstress.
> +
> +-----------------------------------------------
> +fsstress : -f link=10 -f creat=10 -f mkdir=10 -f truncate=5 -f symlink=10
> +-----------------------------------------------
> +xfsdump|xfsrestore ...
> +xfsdump  -s DUMP_SUBDIR - SCRATCH_MNT | xfsrestore  - RESTORE_DIR
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 0
> +xfsrestore: session label: ""
> +xfsrestore: media label: ""
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: NUM directories and NUM entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: restoring non-directory files
> +xfsrestore: restore complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +xfsdump: using file dump (drive_simple) strategy
> +xfsdump: level 0 dump of HOSTNAME:SCRATCH_MNT
> +xfsdump: dump date: DATE
> +xfsdump: session id: ID
> +xfsdump: session label: ""
> +xfsdump: ino map <PHASES>
> +xfsdump: ino map construction complete
> +xfsdump: estimated dump size: NUM bytes
> +xfsdump: /var/xfsdump/inventory created
> +xfsdump: creating dump session media file 0 (media 0, file 0)
> +xfsdump: dumping ino map
> +xfsdump: dumping directories
> +xfsdump: dumping non-directory files
> +xfsdump: ending media file
> +xfsdump: media file size NUM bytes
> +xfsdump: dump size (non-dir files) : NUM bytes
> +xfsdump: dump complete: SECS seconds elapsed
> +xfsdump: Dump Status: SUCCESS
> -- 
> 2.31.1
> 
