Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF13EC54EBC
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Jan 2023 08:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbjALIzh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Jan 2023 03:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbjALIyu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Jan 2023 03:54:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8661C3
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 00:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673513635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ojOJ5BUrjT5Xz6OnHI9uhKGXR8YxXvjmNgTkqYvEFRY=;
        b=hEPr8hAWOPcHH1MUJP8W5VkGWdjMFLuAlFYkAnjiXCcTJpjxE8zTYHU/WdqZ/GLdDp8Hl0
        b5IZshVdP1M2onwiuLLeDHxc/zdDKKQyfe/XdysLRxoBHi9cLy49NEBAD36r5yeKTzUQM3
        cs2Smk8QbP65fIedGybytn/5Kn0zuW8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-iy1VYDZ1OUGm0tDfDHDg6g-1; Thu, 12 Jan 2023 03:53:53 -0500
X-MC-Unique: iy1VYDZ1OUGm0tDfDHDg6g-1
Received: by mail-pl1-f197.google.com with SMTP id l17-20020a170902f69100b001928d6b3efcso12266669plg.2
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2023 00:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojOJ5BUrjT5Xz6OnHI9uhKGXR8YxXvjmNgTkqYvEFRY=;
        b=dYqB5QxeuJzg0XASbEPRUEQoZr75n2V79Ms/bnacViE1oWWRDjncB8iuSjRacetoxu
         PESddJh0eMiKwIVFPw7oC463+CYBWhF5easCujpCNSZsEk3+0FI+2VX36e5fX7miZiyq
         hVhBFcK5vH23j4xpFSHfqFpL7WezNXJjg8KtFnIlyWOInJLSgGFFqdpE1GNZvrfCN/zq
         saM2SHnsxxqiQ/gC/24WbHeZKIHqmZ4zMqtpqA1ih1Bv67hpA1Mca7Zo5rugYeUhSrg/
         zMmEWobipVd3xv2y2aydkwes+SIEJd1LfcWKdE/GSsq5NeTR0/vQtIaHYywOaO8d8Vjr
         znSA==
X-Gm-Message-State: AFqh2kqkdZT1K1bCZteq4BX9N5Aj1N4GrGUXH7VztbGRq15Lw1xhiM4H
        H/eey95nrOf56BhUYBfGU4XJYn0Hr/moGotmuLW5bIlnFRvoff8DOuxMJ+7W+CsQeQ5J/HCrNIp
        Hfm+0SiDVyflk2pvoFw==
X-Received: by 2002:a17:902:eb8a:b0:192:9dc5:54b6 with SMTP id q10-20020a170902eb8a00b001929dc554b6mr57228018plg.48.1673513632350;
        Thu, 12 Jan 2023 00:53:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsAM6uphnKrOMPfk1FBUgoezj67titc+SX3ydDqvOAsaz1NSCzhfD8OOvmc+cXm4CPJwLw6YQ==
X-Received: by 2002:a17:902:eb8a:b0:192:9dc5:54b6 with SMTP id q10-20020a170902eb8a00b001929dc554b6mr57227982plg.48.1673513631593;
        Thu, 12 Jan 2023 00:53:51 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902ce0700b001885d15e3c1sm11663269plg.26.2023.01.12.00.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 00:53:51 -0800 (PST)
Date:   Thu, 12 Jan 2023 16:53:46 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Hironori Shiina <shiina.hironori@gmail.com>
Cc:     fstests@vger.kernel.org,
        Hironori Shiina <shiina.hironori@fujitsu.com>
Subject: Re: [PATCH 2/2] xfs: test xfsrestore on multi-level dumpfiles with
 wrong root
Message-ID: <20230112085346.o3ooq4g2eprqgiej@zlang-mailbox>
References: <20230110220058.139131-1-shiina.hironori@fujitsu.com>
 <20230110220058.139131-3-shiina.hironori@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110220058.139131-3-shiina.hironori@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 10, 2023 at 05:00:58PM -0500, Hironori Shiina wrote:
> Test 'xfsrestore -x' to correct a wrong root in multi-level dump files.
> A root inode number can be wrong in a dump created by problematic
> xfsdump (v3.1.7 - v3.1.9) because of bulkstat misuse.
> 
> Signed-off-by: Hironori Shiina <shiina.hironori@fujitsu.com>
> ---
>  tests/xfs/560     |  125 ++++
>  tests/xfs/560.out | 1517 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 1642 insertions(+)
>  create mode 100644 tests/xfs/560
>  create mode 100644 tests/xfs/560.out
> 
> diff --git a/tests/xfs/560 b/tests/xfs/560
> new file mode 100644
> index 00000000..f4be8ef1
> --- /dev/null
> +++ b/tests/xfs/560
> @@ -0,0 +1,125 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Fujitsu Limited. All Rights Reserved.
> +#
> +# FS QA Test No. 560
> +#
> +# Create a filesystem which contains an inode with a lower number
> +# than the root inode. Set the lower number to dump files as the root inode
> +# and ensure that 'xfsrestore -x' handles this wrong inode for multi-level
> +# dumps. This procedure is cribbed from xfs/064

Better to explain what's the difference of this case with xfs/554. Due to you
nearly use the same comments, same git commit log and same _fixed_by_git_commit
with xfs/554. So what this test focus on? Any new issue can it uncover?

Thanks,
Zorro

> +
> +. ./common/preamble
> +_begin_fstest auto dump
> +
> +# Import common functions.
> +. ./common/dump
> +
> +_supported_fs xfs
> +_fixed_by_git_commit xfsdump \
> +	"XXXXXXXXXXXX xfsrestore: fix rootdir due to xfsdump bulkstat misuse"
> +_require_xfs_io_command "falloc"
> +_require_scratch
> +_require_xfsrestore_xflag
> +
> +# Create a filesystem which contains a fake root inode
> +inums=($(_xfs_create_fake_root))
> +root_inum=${inums[0]}
> +fake_inum=${inums[1]}
> +
> +# Remove unnecessary files
> +find $SCRATCH_MNT -not -inum $fake_inum -type f -delete
> +# Rename a file root file to the static filename
> +find $SCRATCH_MNT -inum $fake_inum -exec mv {} $SCRATCH_MNT/fakeroot \;
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	_cleanup_dump
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +_ls_size_filter()
> +{
> +	#
> +	# Print size ($5) and fname ($9).
> +	# The size is significant since we add to the file as part
> +	# of a file change for the incremental.
> +	#
> +	# Filter out the housekeeping files of xfsrestore
> +	#
> +	$AWK_PROG 'NF == 9 { print $5, $9 }' |\
> +	grep -E -v 'dumpdir|housekeeping|dirattr|dirextattr|namreg|state|tree'
> +}
> +
> +
> +_create_dumpdir_hardlinks 9
> +
> +echo "Do the incremental dumps"
> +i=0
> +while [ $i -le 9 ]; do
> +	if [ $i -gt 0 ]; then
> +		sleep 2
> +		_modify_level $i
> +	fi
> +
> +	_stable_fs
> +	sleep 2
> +
> +	echo "********* level $i ***********" >>$seqres.full
> +	date >>$seqres.full
> +	find $SCRATCH_MNT -exec $here/src/lstat64 {} \; | sed 's/(00.*)//' >$tmp.dates.$i
> +	if [ $i -gt 0 ]; then
> +		let level_1=$i-1
> +		diff -c $tmp.dates.$level_1 $tmp.dates.$i >>$seqres.full
> +	else
> +		cat $tmp.dates.$i >>$seqres.full
> +	fi
> +
> +	dump_file=$tmp.df.level$i
> +	_do_dump_file -f $dump_file -l $i
> +	# Set the wrong root inode number to the dump file
> +	# as problematic xfsdump used to do.
> +	$here/src/fake-dump-rootino $dump_file $fake_inum
> +
> +	let i=$i+1
> +done
> +
> +echo "Listing of what files we start with:"
> +ls -l $dump_dir | _ls_size_filter
> +
> +echo "Look at what files are contained in the inc. dump"
> +i=0
> +while [ $i -le 9 ]; do
> +	echo ""
> +	echo "restoring from df.level$i"
> +	_do_restore_toc -x -f $tmp.df.level$i | \
> +		sed -e "s/rootino #${fake_inum}/rootino #FAKENO/g" \
> +		-e "s/# to ${root_inum}/# to ROOTNO/g"
> +	let i=$i+1
> +done
> +
> +echo "Do the cumulative restores"
> +_prepare_restore_dir
> +i=0
> +while [ $i -le 9 ]; do
> +	if [ $i -eq 0 ]; then
> +		# The root inode is fixed at the first restore
> +		opt='-x'
> +	else
> +		opt=
> +	fi
> +	echo ""
> +	echo "restoring from df.level$i"
> +	_do_restore_file_cum $opt -f $tmp.df.level$i | \
> +		sed -e "s/rootino #${fake_inum}/rootino #FAKENO/g" \
> +		-e "s/# to ${root_inum}/# to ROOTNO/g"
> +	echo "ls -l restore_dir"
> +	ls -lR $restore_dir | _ls_size_filter | _check_quota_file
> +	let i=$i+1
> +done
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/560.out b/tests/xfs/560.out
> new file mode 100644
> index 00000000..0f2236a6
> --- /dev/null
> +++ b/tests/xfs/560.out
> @@ -0,0 +1,1517 @@
> +QA output created by 560
> +Creating directory system of hardlinks to incrementally dump.
> +creating hardlink file1_h1 to file1
> +creating hardlink file1_h2 to file1
> +creating hardlink file1_h3 to file1
> +creating hardlink file1_h4 to file1
> +creating hardlink file1_h5 to file1
> +creating hardlink file2_h1 to file2
> +creating hardlink file2_h2 to file2
> +creating hardlink file2_h3 to file2
> +creating hardlink file2_h4 to file2
> +creating hardlink file2_h5 to file2
> +creating hardlink file3_h1 to file3
> +creating hardlink file3_h2 to file3
> +creating hardlink file3_h3 to file3
> +creating hardlink file3_h4 to file3
> +creating hardlink file3_h5 to file3
> +creating hardlink file4_h1 to file4
> +creating hardlink file4_h2 to file4
> +creating hardlink file4_h3 to file4
> +creating hardlink file4_h4 to file4
> +creating hardlink file4_h5 to file4
> +creating hardlink file5_h1 to file5
> +creating hardlink file5_h2 to file5
> +creating hardlink file5_h3 to file5
> +creating hardlink file5_h4 to file5
> +creating hardlink file5_h5 to file5
> +creating hardlink file6_h1 to file6
> +creating hardlink file6_h2 to file6
> +creating hardlink file6_h3 to file6
> +creating hardlink file6_h4 to file6
> +creating hardlink file6_h5 to file6
> +creating hardlink file7_h1 to file7
> +creating hardlink file7_h2 to file7
> +creating hardlink file7_h3 to file7
> +creating hardlink file7_h4 to file7
> +creating hardlink file7_h5 to file7
> +creating hardlink file8_h1 to file8
> +creating hardlink file8_h2 to file8
> +creating hardlink file8_h3 to file8
> +creating hardlink file8_h4 to file8
> +creating hardlink file8_h5 to file8
> +creating hardlink file9_h1 to file9
> +creating hardlink file9_h2 to file9
> +creating hardlink file9_h3 to file9
> +creating hardlink file9_h4 to file9
> +creating hardlink file9_h5 to file9
> +Do the incremental dumps
> +Dumping to file...
> +xfsdump  -l0 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
> +xfsdump: using file dump (drive_simple) strategy
> +xfsdump: level 0 dump of HOSTNAME:SCRATCH_MNT
> +xfsdump: dump date: DATE
> +xfsdump: session id: ID
> +xfsdump: session label: "stress_560"
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
> +Dumping to file...
> +xfsdump  -l1 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
> +xfsdump: using file dump (drive_simple) strategy
> +xfsdump: level 1 incremental dump of HOSTNAME:SCRATCH_MNT based on level 0 dump begun DATE
> +xfsdump: dump date: DATE
> +xfsdump: session id: ID
> +xfsdump: session label: "stress_560"
> +xfsdump: ino map <PHASES>
> +xfsdump: ino map construction complete
> +xfsdump: estimated dump size: NUM bytes
> +xfsdump: creating dump session media file 0 (media 0, file 0)
> +xfsdump: dumping ino map
> +xfsdump: dumping directories
> +xfsdump: dumping non-directory files
> +xfsdump: ending media file
> +xfsdump: media file size NUM bytes
> +xfsdump: dump size (non-dir files) : NUM bytes
> +xfsdump: dump complete: SECS seconds elapsed
> +xfsdump: Dump Status: SUCCESS
> +Dumping to file...
> +xfsdump  -l2 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
> +xfsdump: using file dump (drive_simple) strategy
> +xfsdump: level 2 incremental dump of HOSTNAME:SCRATCH_MNT based on level 1 dump begun DATE
> +xfsdump: dump date: DATE
> +xfsdump: session id: ID
> +xfsdump: session label: "stress_560"
> +xfsdump: ino map <PHASES>
> +xfsdump: ino map construction complete
> +xfsdump: estimated dump size: NUM bytes
> +xfsdump: creating dump session media file 0 (media 0, file 0)
> +xfsdump: dumping ino map
> +xfsdump: dumping directories
> +xfsdump: dumping non-directory files
> +xfsdump: ending media file
> +xfsdump: media file size NUM bytes
> +xfsdump: dump size (non-dir files) : NUM bytes
> +xfsdump: dump complete: SECS seconds elapsed
> +xfsdump: Dump Status: SUCCESS
> +Dumping to file...
> +xfsdump  -l3 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
> +xfsdump: using file dump (drive_simple) strategy
> +xfsdump: level 3 incremental dump of HOSTNAME:SCRATCH_MNT based on level 2 dump begun DATE
> +xfsdump: dump date: DATE
> +xfsdump: session id: ID
> +xfsdump: session label: "stress_560"
> +xfsdump: ino map <PHASES>
> +xfsdump: ino map construction complete
> +xfsdump: estimated dump size: NUM bytes
> +xfsdump: creating dump session media file 0 (media 0, file 0)
> +xfsdump: dumping ino map
> +xfsdump: dumping directories
> +xfsdump: dumping non-directory files
> +xfsdump: ending media file
> +xfsdump: media file size NUM bytes
> +xfsdump: dump size (non-dir files) : NUM bytes
> +xfsdump: dump complete: SECS seconds elapsed
> +xfsdump: Dump Status: SUCCESS
> +Dumping to file...
> +xfsdump  -l4 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
> +xfsdump: using file dump (drive_simple) strategy
> +xfsdump: level 4 incremental dump of HOSTNAME:SCRATCH_MNT based on level 3 dump begun DATE
> +xfsdump: dump date: DATE
> +xfsdump: session id: ID
> +xfsdump: session label: "stress_560"
> +xfsdump: ino map <PHASES>
> +xfsdump: ino map construction complete
> +xfsdump: estimated dump size: NUM bytes
> +xfsdump: creating dump session media file 0 (media 0, file 0)
> +xfsdump: dumping ino map
> +xfsdump: dumping directories
> +xfsdump: dumping non-directory files
> +xfsdump: ending media file
> +xfsdump: media file size NUM bytes
> +xfsdump: dump size (non-dir files) : NUM bytes
> +xfsdump: dump complete: SECS seconds elapsed
> +xfsdump: Dump Status: SUCCESS
> +Dumping to file...
> +xfsdump  -l5 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
> +xfsdump: using file dump (drive_simple) strategy
> +xfsdump: level 5 incremental dump of HOSTNAME:SCRATCH_MNT based on level 4 dump begun DATE
> +xfsdump: dump date: DATE
> +xfsdump: session id: ID
> +xfsdump: session label: "stress_560"
> +xfsdump: ino map <PHASES>
> +xfsdump: ino map construction complete
> +xfsdump: estimated dump size: NUM bytes
> +xfsdump: creating dump session media file 0 (media 0, file 0)
> +xfsdump: dumping ino map
> +xfsdump: dumping directories
> +xfsdump: dumping non-directory files
> +xfsdump: ending media file
> +xfsdump: media file size NUM bytes
> +xfsdump: dump size (non-dir files) : NUM bytes
> +xfsdump: dump complete: SECS seconds elapsed
> +xfsdump: Dump Status: SUCCESS
> +Dumping to file...
> +xfsdump  -l6 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
> +xfsdump: using file dump (drive_simple) strategy
> +xfsdump: level 6 incremental dump of HOSTNAME:SCRATCH_MNT based on level 5 dump begun DATE
> +xfsdump: dump date: DATE
> +xfsdump: session id: ID
> +xfsdump: session label: "stress_560"
> +xfsdump: ino map <PHASES>
> +xfsdump: ino map construction complete
> +xfsdump: estimated dump size: NUM bytes
> +xfsdump: creating dump session media file 0 (media 0, file 0)
> +xfsdump: dumping ino map
> +xfsdump: dumping directories
> +xfsdump: dumping non-directory files
> +xfsdump: ending media file
> +xfsdump: media file size NUM bytes
> +xfsdump: dump size (non-dir files) : NUM bytes
> +xfsdump: dump complete: SECS seconds elapsed
> +xfsdump: Dump Status: SUCCESS
> +Dumping to file...
> +xfsdump  -l7 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
> +xfsdump: using file dump (drive_simple) strategy
> +xfsdump: level 7 incremental dump of HOSTNAME:SCRATCH_MNT based on level 6 dump begun DATE
> +xfsdump: dump date: DATE
> +xfsdump: session id: ID
> +xfsdump: session label: "stress_560"
> +xfsdump: ino map <PHASES>
> +xfsdump: ino map construction complete
> +xfsdump: estimated dump size: NUM bytes
> +xfsdump: creating dump session media file 0 (media 0, file 0)
> +xfsdump: dumping ino map
> +xfsdump: dumping directories
> +xfsdump: dumping non-directory files
> +xfsdump: ending media file
> +xfsdump: media file size NUM bytes
> +xfsdump: dump size (non-dir files) : NUM bytes
> +xfsdump: dump complete: SECS seconds elapsed
> +xfsdump: Dump Status: SUCCESS
> +Dumping to file...
> +xfsdump  -l8 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
> +xfsdump: using file dump (drive_simple) strategy
> +xfsdump: level 8 incremental dump of HOSTNAME:SCRATCH_MNT based on level 7 dump begun DATE
> +xfsdump: dump date: DATE
> +xfsdump: session id: ID
> +xfsdump: session label: "stress_560"
> +xfsdump: ino map <PHASES>
> +xfsdump: ino map construction complete
> +xfsdump: estimated dump size: NUM bytes
> +xfsdump: creating dump session media file 0 (media 0, file 0)
> +xfsdump: dumping ino map
> +xfsdump: dumping directories
> +xfsdump: dumping non-directory files
> +xfsdump: ending media file
> +xfsdump: media file size NUM bytes
> +xfsdump: dump size (non-dir files) : NUM bytes
> +xfsdump: dump complete: SECS seconds elapsed
> +xfsdump: Dump Status: SUCCESS
> +Dumping to file...
> +xfsdump  -l9 -f DUMP_FILE -M stress_tape_media -L stress_560 SCRATCH_MNT
> +xfsdump: using file dump (drive_simple) strategy
> +xfsdump: level 9 incremental dump of HOSTNAME:SCRATCH_MNT based on level 8 dump begun DATE
> +xfsdump: dump date: DATE
> +xfsdump: session id: ID
> +xfsdump: session label: "stress_560"
> +xfsdump: ino map <PHASES>
> +xfsdump: ino map construction complete
> +xfsdump: estimated dump size: NUM bytes
> +xfsdump: creating dump session media file 0 (media 0, file 0)
> +xfsdump: dumping ino map
> +xfsdump: dumping directories
> +xfsdump: dumping non-directory files
> +xfsdump: ending media file
> +xfsdump: media file size NUM bytes
> +xfsdump: dump size (non-dir files) : NUM bytes
> +xfsdump: dump complete: SECS seconds elapsed
> +xfsdump: Dump Status: SUCCESS
> +Listing of what files we start with:
> +12 file1
> +12 file1_h1
> +12 file1_h2
> +12 file1_h3
> +12 file1_h4
> +12 file1_h5
> +12 file2
> +12 file2_h1
> +12 file2_h2
> +12 file2_h3
> +12 file2_h4
> +12 file2_h5
> +12 file3
> +12 file3_h1
> +12 file3_h2
> +12 file3_h3
> +12 file3_h4
> +12 file3_h5
> +12 file4
> +12 file4_h1
> +12 file4_h2
> +12 file4_h3
> +12 file4_h4
> +12 file4_h5
> +12 file5
> +12 file5_h1
> +12 file5_h2
> +12 file5_h3
> +12 file5_h4
> +12 file5_h5
> +12 file6
> +12 file6_h1
> +12 file6_h2
> +12 file6_h3
> +12 file6_h4
> +12 file6_h5
> +12 file7
> +12 file7_h1
> +12 file7_h2
> +12 file7_h3
> +12 file7_h4
> +12 file7_h5
> +12 file8
> +12 file8_h1
> +12 file8_h2
> +12 file8_h3
> +12 file8_h4
> +12 file8_h5
> +12 file9
> +12 file9_h1
> +12 file9_h2
> +12 file9_h3
> +12 file9_h4
> +12 file9_h5
> +Look at what files are contained in the inc. dump
> +
> +restoring from df.level0
> +Contents of dump ...
> +xfsrestore  -x -f DUMP_FILE -t
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 0
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: found fake rootino #FAKENO, will fix.
> +xfsrestore: fix root # to ROOTNO (bind mount?)
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: reading non-directory files
> +xfsrestore: table of contents display complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +
> +dumpdir/file1
> +dumpdir/file1_h1
> +dumpdir/file1_h2
> +dumpdir/file1_h3
> +dumpdir/file1_h4
> +dumpdir/file1_h5
> +dumpdir/file2
> +dumpdir/file2_h1
> +dumpdir/file2_h2
> +dumpdir/file2_h3
> +dumpdir/file2_h4
> +dumpdir/file2_h5
> +dumpdir/file3
> +dumpdir/file3_h1
> +dumpdir/file3_h2
> +dumpdir/file3_h3
> +dumpdir/file3_h4
> +dumpdir/file3_h5
> +dumpdir/file4
> +dumpdir/file4_h1
> +dumpdir/file4_h2
> +dumpdir/file4_h3
> +dumpdir/file4_h4
> +dumpdir/file4_h5
> +dumpdir/file5
> +dumpdir/file5_h1
> +dumpdir/file5_h2
> +dumpdir/file5_h3
> +dumpdir/file5_h4
> +dumpdir/file5_h5
> +dumpdir/file6
> +dumpdir/file6_h1
> +dumpdir/file6_h2
> +dumpdir/file6_h3
> +dumpdir/file6_h4
> +dumpdir/file6_h5
> +dumpdir/file7
> +dumpdir/file7_h1
> +dumpdir/file7_h2
> +dumpdir/file7_h3
> +dumpdir/file7_h4
> +dumpdir/file7_h5
> +dumpdir/file8
> +dumpdir/file8_h1
> +dumpdir/file8_h2
> +dumpdir/file8_h3
> +dumpdir/file8_h4
> +dumpdir/file8_h5
> +dumpdir/file9
> +dumpdir/file9_h1
> +dumpdir/file9_h2
> +dumpdir/file9_h3
> +dumpdir/file9_h4
> +dumpdir/file9_h5
> +fakeroot
> +
> +restoring from df.level1
> +Contents of dump ...
> +xfsrestore  -x -f DUMP_FILE -t
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 1
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: found fake rootino #FAKENO, will fix.
> +xfsrestore: fix root # to ROOTNO (bind mount?)
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: reading non-directory files
> +xfsrestore: table of contents display complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +
> +dumpdir/file1
> +dumpdir/file1_h1
> +dumpdir/file1_h2
> +dumpdir/file1_h3
> +dumpdir/file1_h4
> +dumpdir/file1_h5
> +
> +restoring from df.level2
> +Contents of dump ...
> +xfsrestore  -x -f DUMP_FILE -t
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 2
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: found fake rootino #FAKENO, will fix.
> +xfsrestore: fix root # to ROOTNO (bind mount?)
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: reading non-directory files
> +xfsrestore: table of contents display complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +
> +dumpdir/file2
> +dumpdir/file2_h1
> +dumpdir/file2_h2
> +dumpdir/file2_h3
> +dumpdir/file2_h4
> +dumpdir/file2_h5
> +
> +restoring from df.level3
> +Contents of dump ...
> +xfsrestore  -x -f DUMP_FILE -t
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 3
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: found fake rootino #FAKENO, will fix.
> +xfsrestore: fix root # to ROOTNO (bind mount?)
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: reading non-directory files
> +xfsrestore: table of contents display complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +
> +dumpdir/file3
> +dumpdir/file3_h1
> +dumpdir/file3_h2
> +dumpdir/file3_h3
> +dumpdir/file3_h4
> +dumpdir/file3_h5
> +
> +restoring from df.level4
> +Contents of dump ...
> +xfsrestore  -x -f DUMP_FILE -t
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 4
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: found fake rootino #FAKENO, will fix.
> +xfsrestore: fix root # to ROOTNO (bind mount?)
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: reading non-directory files
> +xfsrestore: table of contents display complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +
> +dumpdir/file4
> +dumpdir/file4_h1
> +dumpdir/file4_h2
> +dumpdir/file4_h3
> +dumpdir/file4_h4
> +dumpdir/file4_h5
> +
> +restoring from df.level5
> +Contents of dump ...
> +xfsrestore  -x -f DUMP_FILE -t
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 5
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: found fake rootino #FAKENO, will fix.
> +xfsrestore: fix root # to ROOTNO (bind mount?)
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: reading non-directory files
> +xfsrestore: table of contents display complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +
> +dumpdir/file5
> +dumpdir/file5_h1
> +dumpdir/file5_h2
> +dumpdir/file5_h3
> +dumpdir/file5_h4
> +dumpdir/file5_h5
> +
> +restoring from df.level6
> +Contents of dump ...
> +xfsrestore  -x -f DUMP_FILE -t
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 6
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: found fake rootino #FAKENO, will fix.
> +xfsrestore: fix root # to ROOTNO (bind mount?)
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: reading non-directory files
> +xfsrestore: table of contents display complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +
> +dumpdir/file6
> +dumpdir/file6_h1
> +dumpdir/file6_h2
> +dumpdir/file6_h3
> +dumpdir/file6_h4
> +dumpdir/file6_h5
> +
> +restoring from df.level7
> +Contents of dump ...
> +xfsrestore  -x -f DUMP_FILE -t
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 7
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: found fake rootino #FAKENO, will fix.
> +xfsrestore: fix root # to ROOTNO (bind mount?)
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: reading non-directory files
> +xfsrestore: table of contents display complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +
> +dumpdir/file7
> +dumpdir/file7_h1
> +dumpdir/file7_h2
> +dumpdir/file7_h3
> +dumpdir/file7_h4
> +dumpdir/file7_h5
> +
> +restoring from df.level8
> +Contents of dump ...
> +xfsrestore  -x -f DUMP_FILE -t
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 8
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: found fake rootino #FAKENO, will fix.
> +xfsrestore: fix root # to ROOTNO (bind mount?)
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: reading non-directory files
> +xfsrestore: table of contents display complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +
> +dumpdir/file8
> +dumpdir/file8_h1
> +dumpdir/file8_h2
> +dumpdir/file8_h3
> +dumpdir/file8_h4
> +dumpdir/file8_h5
> +
> +restoring from df.level9
> +Contents of dump ...
> +xfsrestore  -x -f DUMP_FILE -t
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 9
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: found fake rootino #FAKENO, will fix.
> +xfsrestore: fix root # to ROOTNO (bind mount?)
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: reading non-directory files
> +xfsrestore: table of contents display complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +
> +dumpdir/file9
> +dumpdir/file9_h1
> +dumpdir/file9_h2
> +dumpdir/file9_h3
> +dumpdir/file9_h4
> +dumpdir/file9_h5
> +Do the cumulative restores
> +
> +restoring from df.level0
> +Restoring cumumlative from file...
> +xfsrestore  -x -f DUMP_FILE -r RESTORE_DIR
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 0
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: found fake rootino #FAKENO, will fix.
> +xfsrestore: fix root # to ROOTNO (bind mount?)
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: restoring non-directory files
> +xfsrestore: restore complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +ls -l restore_dir
> +0 fakeroot
> +0 file1
> +0 file1_h1
> +0 file1_h2
> +0 file1_h3
> +0 file1_h4
> +0 file1_h5
> +0 file2
> +0 file2_h1
> +0 file2_h2
> +0 file2_h3
> +0 file2_h4
> +0 file2_h5
> +0 file3
> +0 file3_h1
> +0 file3_h2
> +0 file3_h3
> +0 file3_h4
> +0 file3_h5
> +0 file4
> +0 file4_h1
> +0 file4_h2
> +0 file4_h3
> +0 file4_h4
> +0 file4_h5
> +0 file5
> +0 file5_h1
> +0 file5_h2
> +0 file5_h3
> +0 file5_h4
> +0 file5_h5
> +0 file6
> +0 file6_h1
> +0 file6_h2
> +0 file6_h3
> +0 file6_h4
> +0 file6_h5
> +0 file7
> +0 file7_h1
> +0 file7_h2
> +0 file7_h3
> +0 file7_h4
> +0 file7_h5
> +0 file8
> +0 file8_h1
> +0 file8_h2
> +0 file8_h3
> +0 file8_h4
> +0 file8_h5
> +0 file9
> +0 file9_h1
> +0 file9_h2
> +0 file9_h3
> +0 file9_h4
> +0 file9_h5
> +
> +restoring from df.level1
> +Restoring cumumlative from file...
> +xfsrestore  -f DUMP_FILE -r RESTORE_DIR
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 1
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: restoring non-directory files
> +xfsrestore: restore complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +ls -l restore_dir
> +0 fakeroot
> +12 file1
> +12 file1_h1
> +12 file1_h2
> +12 file1_h3
> +12 file1_h4
> +12 file1_h5
> +0 file2
> +0 file2_h1
> +0 file2_h2
> +0 file2_h3
> +0 file2_h4
> +0 file2_h5
> +0 file3
> +0 file3_h1
> +0 file3_h2
> +0 file3_h3
> +0 file3_h4
> +0 file3_h5
> +0 file4
> +0 file4_h1
> +0 file4_h2
> +0 file4_h3
> +0 file4_h4
> +0 file4_h5
> +0 file5
> +0 file5_h1
> +0 file5_h2
> +0 file5_h3
> +0 file5_h4
> +0 file5_h5
> +0 file6
> +0 file6_h1
> +0 file6_h2
> +0 file6_h3
> +0 file6_h4
> +0 file6_h5
> +0 file7
> +0 file7_h1
> +0 file7_h2
> +0 file7_h3
> +0 file7_h4
> +0 file7_h5
> +0 file8
> +0 file8_h1
> +0 file8_h2
> +0 file8_h3
> +0 file8_h4
> +0 file8_h5
> +0 file9
> +0 file9_h1
> +0 file9_h2
> +0 file9_h3
> +0 file9_h4
> +0 file9_h5
> +
> +restoring from df.level2
> +Restoring cumumlative from file...
> +xfsrestore  -f DUMP_FILE -r RESTORE_DIR
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 2
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: restoring non-directory files
> +xfsrestore: restore complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +ls -l restore_dir
> +0 fakeroot
> +12 file1
> +12 file1_h1
> +12 file1_h2
> +12 file1_h3
> +12 file1_h4
> +12 file1_h5
> +12 file2
> +12 file2_h1
> +12 file2_h2
> +12 file2_h3
> +12 file2_h4
> +12 file2_h5
> +0 file3
> +0 file3_h1
> +0 file3_h2
> +0 file3_h3
> +0 file3_h4
> +0 file3_h5
> +0 file4
> +0 file4_h1
> +0 file4_h2
> +0 file4_h3
> +0 file4_h4
> +0 file4_h5
> +0 file5
> +0 file5_h1
> +0 file5_h2
> +0 file5_h3
> +0 file5_h4
> +0 file5_h5
> +0 file6
> +0 file6_h1
> +0 file6_h2
> +0 file6_h3
> +0 file6_h4
> +0 file6_h5
> +0 file7
> +0 file7_h1
> +0 file7_h2
> +0 file7_h3
> +0 file7_h4
> +0 file7_h5
> +0 file8
> +0 file8_h1
> +0 file8_h2
> +0 file8_h3
> +0 file8_h4
> +0 file8_h5
> +0 file9
> +0 file9_h1
> +0 file9_h2
> +0 file9_h3
> +0 file9_h4
> +0 file9_h5
> +
> +restoring from df.level3
> +Restoring cumumlative from file...
> +xfsrestore  -f DUMP_FILE -r RESTORE_DIR
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 3
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: restoring non-directory files
> +xfsrestore: restore complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +ls -l restore_dir
> +0 fakeroot
> +12 file1
> +12 file1_h1
> +12 file1_h2
> +12 file1_h3
> +12 file1_h4
> +12 file1_h5
> +12 file2
> +12 file2_h1
> +12 file2_h2
> +12 file2_h3
> +12 file2_h4
> +12 file2_h5
> +12 file3
> +12 file3_h1
> +12 file3_h2
> +12 file3_h3
> +12 file3_h4
> +12 file3_h5
> +0 file4
> +0 file4_h1
> +0 file4_h2
> +0 file4_h3
> +0 file4_h4
> +0 file4_h5
> +0 file5
> +0 file5_h1
> +0 file5_h2
> +0 file5_h3
> +0 file5_h4
> +0 file5_h5
> +0 file6
> +0 file6_h1
> +0 file6_h2
> +0 file6_h3
> +0 file6_h4
> +0 file6_h5
> +0 file7
> +0 file7_h1
> +0 file7_h2
> +0 file7_h3
> +0 file7_h4
> +0 file7_h5
> +0 file8
> +0 file8_h1
> +0 file8_h2
> +0 file8_h3
> +0 file8_h4
> +0 file8_h5
> +0 file9
> +0 file9_h1
> +0 file9_h2
> +0 file9_h3
> +0 file9_h4
> +0 file9_h5
> +
> +restoring from df.level4
> +Restoring cumumlative from file...
> +xfsrestore  -f DUMP_FILE -r RESTORE_DIR
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 4
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: restoring non-directory files
> +xfsrestore: restore complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +ls -l restore_dir
> +0 fakeroot
> +12 file1
> +12 file1_h1
> +12 file1_h2
> +12 file1_h3
> +12 file1_h4
> +12 file1_h5
> +12 file2
> +12 file2_h1
> +12 file2_h2
> +12 file2_h3
> +12 file2_h4
> +12 file2_h5
> +12 file3
> +12 file3_h1
> +12 file3_h2
> +12 file3_h3
> +12 file3_h4
> +12 file3_h5
> +12 file4
> +12 file4_h1
> +12 file4_h2
> +12 file4_h3
> +12 file4_h4
> +12 file4_h5
> +0 file5
> +0 file5_h1
> +0 file5_h2
> +0 file5_h3
> +0 file5_h4
> +0 file5_h5
> +0 file6
> +0 file6_h1
> +0 file6_h2
> +0 file6_h3
> +0 file6_h4
> +0 file6_h5
> +0 file7
> +0 file7_h1
> +0 file7_h2
> +0 file7_h3
> +0 file7_h4
> +0 file7_h5
> +0 file8
> +0 file8_h1
> +0 file8_h2
> +0 file8_h3
> +0 file8_h4
> +0 file8_h5
> +0 file9
> +0 file9_h1
> +0 file9_h2
> +0 file9_h3
> +0 file9_h4
> +0 file9_h5
> +
> +restoring from df.level5
> +Restoring cumumlative from file...
> +xfsrestore  -f DUMP_FILE -r RESTORE_DIR
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 5
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: restoring non-directory files
> +xfsrestore: restore complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +ls -l restore_dir
> +0 fakeroot
> +12 file1
> +12 file1_h1
> +12 file1_h2
> +12 file1_h3
> +12 file1_h4
> +12 file1_h5
> +12 file2
> +12 file2_h1
> +12 file2_h2
> +12 file2_h3
> +12 file2_h4
> +12 file2_h5
> +12 file3
> +12 file3_h1
> +12 file3_h2
> +12 file3_h3
> +12 file3_h4
> +12 file3_h5
> +12 file4
> +12 file4_h1
> +12 file4_h2
> +12 file4_h3
> +12 file4_h4
> +12 file4_h5
> +12 file5
> +12 file5_h1
> +12 file5_h2
> +12 file5_h3
> +12 file5_h4
> +12 file5_h5
> +0 file6
> +0 file6_h1
> +0 file6_h2
> +0 file6_h3
> +0 file6_h4
> +0 file6_h5
> +0 file7
> +0 file7_h1
> +0 file7_h2
> +0 file7_h3
> +0 file7_h4
> +0 file7_h5
> +0 file8
> +0 file8_h1
> +0 file8_h2
> +0 file8_h3
> +0 file8_h4
> +0 file8_h5
> +0 file9
> +0 file9_h1
> +0 file9_h2
> +0 file9_h3
> +0 file9_h4
> +0 file9_h5
> +
> +restoring from df.level6
> +Restoring cumumlative from file...
> +xfsrestore  -f DUMP_FILE -r RESTORE_DIR
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 6
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: restoring non-directory files
> +xfsrestore: restore complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +ls -l restore_dir
> +0 fakeroot
> +12 file1
> +12 file1_h1
> +12 file1_h2
> +12 file1_h3
> +12 file1_h4
> +12 file1_h5
> +12 file2
> +12 file2_h1
> +12 file2_h2
> +12 file2_h3
> +12 file2_h4
> +12 file2_h5
> +12 file3
> +12 file3_h1
> +12 file3_h2
> +12 file3_h3
> +12 file3_h4
> +12 file3_h5
> +12 file4
> +12 file4_h1
> +12 file4_h2
> +12 file4_h3
> +12 file4_h4
> +12 file4_h5
> +12 file5
> +12 file5_h1
> +12 file5_h2
> +12 file5_h3
> +12 file5_h4
> +12 file5_h5
> +12 file6
> +12 file6_h1
> +12 file6_h2
> +12 file6_h3
> +12 file6_h4
> +12 file6_h5
> +0 file7
> +0 file7_h1
> +0 file7_h2
> +0 file7_h3
> +0 file7_h4
> +0 file7_h5
> +0 file8
> +0 file8_h1
> +0 file8_h2
> +0 file8_h3
> +0 file8_h4
> +0 file8_h5
> +0 file9
> +0 file9_h1
> +0 file9_h2
> +0 file9_h3
> +0 file9_h4
> +0 file9_h5
> +
> +restoring from df.level7
> +Restoring cumumlative from file...
> +xfsrestore  -f DUMP_FILE -r RESTORE_DIR
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 7
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: restoring non-directory files
> +xfsrestore: restore complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +ls -l restore_dir
> +0 fakeroot
> +12 file1
> +12 file1_h1
> +12 file1_h2
> +12 file1_h3
> +12 file1_h4
> +12 file1_h5
> +12 file2
> +12 file2_h1
> +12 file2_h2
> +12 file2_h3
> +12 file2_h4
> +12 file2_h5
> +12 file3
> +12 file3_h1
> +12 file3_h2
> +12 file3_h3
> +12 file3_h4
> +12 file3_h5
> +12 file4
> +12 file4_h1
> +12 file4_h2
> +12 file4_h3
> +12 file4_h4
> +12 file4_h5
> +12 file5
> +12 file5_h1
> +12 file5_h2
> +12 file5_h3
> +12 file5_h4
> +12 file5_h5
> +12 file6
> +12 file6_h1
> +12 file6_h2
> +12 file6_h3
> +12 file6_h4
> +12 file6_h5
> +12 file7
> +12 file7_h1
> +12 file7_h2
> +12 file7_h3
> +12 file7_h4
> +12 file7_h5
> +0 file8
> +0 file8_h1
> +0 file8_h2
> +0 file8_h3
> +0 file8_h4
> +0 file8_h5
> +0 file9
> +0 file9_h1
> +0 file9_h2
> +0 file9_h3
> +0 file9_h4
> +0 file9_h5
> +
> +restoring from df.level8
> +Restoring cumumlative from file...
> +xfsrestore  -f DUMP_FILE -r RESTORE_DIR
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 8
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: restoring non-directory files
> +xfsrestore: restore complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +ls -l restore_dir
> +0 fakeroot
> +12 file1
> +12 file1_h1
> +12 file1_h2
> +12 file1_h3
> +12 file1_h4
> +12 file1_h5
> +12 file2
> +12 file2_h1
> +12 file2_h2
> +12 file2_h3
> +12 file2_h4
> +12 file2_h5
> +12 file3
> +12 file3_h1
> +12 file3_h2
> +12 file3_h3
> +12 file3_h4
> +12 file3_h5
> +12 file4
> +12 file4_h1
> +12 file4_h2
> +12 file4_h3
> +12 file4_h4
> +12 file4_h5
> +12 file5
> +12 file5_h1
> +12 file5_h2
> +12 file5_h3
> +12 file5_h4
> +12 file5_h5
> +12 file6
> +12 file6_h1
> +12 file6_h2
> +12 file6_h3
> +12 file6_h4
> +12 file6_h5
> +12 file7
> +12 file7_h1
> +12 file7_h2
> +12 file7_h3
> +12 file7_h4
> +12 file7_h5
> +12 file8
> +12 file8_h1
> +12 file8_h2
> +12 file8_h3
> +12 file8_h4
> +12 file8_h5
> +0 file9
> +0 file9_h1
> +0 file9_h2
> +0 file9_h3
> +0 file9_h4
> +0 file9_h5
> +
> +restoring from df.level9
> +Restoring cumumlative from file...
> +xfsrestore  -f DUMP_FILE -r RESTORE_DIR
> +xfsrestore: using file dump (drive_simple) strategy
> +xfsrestore: searching media for dump
> +xfsrestore: examining media file 0
> +xfsrestore: dump description: 
> +xfsrestore: hostname: HOSTNAME
> +xfsrestore: mount point: SCRATCH_MNT
> +xfsrestore: volume: SCRATCH_DEV
> +xfsrestore: session time: TIME
> +xfsrestore: level: 9
> +xfsrestore: session label: "stress_560"
> +xfsrestore: media label: "stress_tape_media"
> +xfsrestore: file system ID: ID
> +xfsrestore: session id: ID
> +xfsrestore: media ID: ID
> +xfsrestore: using online session inventory
> +xfsrestore: searching media for directory dump
> +xfsrestore: reading directories
> +xfsrestore: 2 directories and 56 entries processed
> +xfsrestore: directory post-processing
> +xfsrestore: restoring non-directory files
> +xfsrestore: restore complete: SECS seconds elapsed
> +xfsrestore: Restore Status: SUCCESS
> +ls -l restore_dir
> +0 fakeroot
> +12 file1
> +12 file1_h1
> +12 file1_h2
> +12 file1_h3
> +12 file1_h4
> +12 file1_h5
> +12 file2
> +12 file2_h1
> +12 file2_h2
> +12 file2_h3
> +12 file2_h4
> +12 file2_h5
> +12 file3
> +12 file3_h1
> +12 file3_h2
> +12 file3_h3
> +12 file3_h4
> +12 file3_h5
> +12 file4
> +12 file4_h1
> +12 file4_h2
> +12 file4_h3
> +12 file4_h4
> +12 file4_h5
> +12 file5
> +12 file5_h1
> +12 file5_h2
> +12 file5_h3
> +12 file5_h4
> +12 file5_h5
> +12 file6
> +12 file6_h1
> +12 file6_h2
> +12 file6_h3
> +12 file6_h4
> +12 file6_h5
> +12 file7
> +12 file7_h1
> +12 file7_h2
> +12 file7_h3
> +12 file7_h4
> +12 file7_h5
> +12 file8
> +12 file8_h1
> +12 file8_h2
> +12 file8_h3
> +12 file8_h4
> +12 file8_h5
> +12 file9
> +12 file9_h1
> +12 file9_h2
> +12 file9_h3
> +12 file9_h4
> +12 file9_h5
> -- 
> 2.39.0
> 

