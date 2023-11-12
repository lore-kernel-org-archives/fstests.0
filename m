Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209E01840
	for <fstests@vger.kernel.org>; Sun, 12 Nov 2023 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIRIY8nz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462BB2D59
	for <fstests@vger.kernel.org>; Sat, 11 Nov 2023 18:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699756936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hIE1jCEx1uXfBJkFmuks9m4bZnhcLd04Zrntu/lp20=;
	b=HIRIY8nzFjWfr9GnOQtUlID5xshfp/M6rs0SIA1CZPaNobbFxvtNDP3wZE6aEJKkIcBgDq
	vqUNchS4+Hs3gRF0wmHmyA2GIdsVhcfdWsR7iuU7yxZ1lJzWGUuH8H5W/9bMgimYXgYcPf
	EPE0xRPxKWjANoSNlqKFjPt9matBCzQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-YYq_CIIYO82kONXHJ4v7Tw-1; Sat, 11 Nov 2023 21:42:14 -0500
X-MC-Unique: YYq_CIIYO82kONXHJ4v7Tw-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d6483f974eso1773339a34.1
        for <fstests@vger.kernel.org>; Sat, 11 Nov 2023 18:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699756933; x=1700361733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hIE1jCEx1uXfBJkFmuks9m4bZnhcLd04Zrntu/lp20=;
        b=EDHFCRFBIqL9xdCtnA/EqBgENuuScjsBzBKv/HvIpvkjPLwLoZF6b1g3YPNIKpfq7F
         gr3QsUjiFNHGQ2Pqy7XZOshuiQQ0BYRhpBXAqx+LEb1Mt1q7iOLM1xyekgGyfha/b/dq
         KmH0exFyHnt7p7ocwviij/onbIxarQdBfnUMWLBKBxf/HzfVmBIu7KRvKMScqXoN7Cvg
         96804WPJiPzZ4v0aOxPeyO79ZjFoZtQx44z2zDUSEdzPixspnLE6YtAkPPINSPDI+Xg4
         cqj6h5wNo2UEIQEiHVqjeC1Ct6Tv73sFTFIUIXwCaasMJhpJ3QCdIxIuXxuylh9f2IKB
         zUYw==
X-Gm-Message-State: AOJu0YwdDcePqtaLFUF/MguxEn7ACP/qheIufK6omAYfS2VyPOqSKU79
	u6d22WT7+N/xi9l3KLjcRDsQdv2nunPRcjDYLf3g/NF1HUEJPHe2tNDVmzhmnq1iK5TSgOcU+6I
	lkwMxf/W/PETnSQymgLBZaBpnSrdP
X-Received: by 2002:a05:6830:2b21:b0:6be:c1b:ded4 with SMTP id l33-20020a0568302b2100b006be0c1bded4mr4022013otv.3.1699756933440;
        Sat, 11 Nov 2023 18:42:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYssx7hWCXUw8lNP7kcOVLEogT9M8IzoznfDN17GQ6J87fYC5r6RO34t9PpNFD2pq1eL/zJQ==
X-Received: by 2002:a05:6830:2b21:b0:6be:c1b:ded4 with SMTP id l33-20020a0568302b2100b006be0c1bded4mr4022000otv.3.1699756933070;
        Sat, 11 Nov 2023 18:42:13 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b001c771740da4sm1895866plb.195.2023.11.11.18.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 18:42:12 -0800 (PST)
Date: Sun, 12 Nov 2023 10:42:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/1] generic: test reads racing with slow reflink
 operations
Message-ID: <20231112024209.4lxcoozrxsngld7u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <169947896328.203781.17647180888752123384.stgit@frogsfrogsfrogs>
 <169947896885.203781.13438458222742566484.stgit@frogsfrogsfrogs>
 <20231111222257.GB36175@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111222257.GB36175@frogsfrogsfrogs>

On Sat, Nov 11, 2023 at 02:22:57PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> XFS has a rather slow reflink operation.  While a reflink operation is
> running, other programs cannot read the contents of the source file,
> which is causing latency spikes.  Catherine Hoang wrote a patch to
> permit reads, since the source file contents do not change.  This is a
> functionality test for that patch.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Catherine Hoang <catherine.hoang@oracle.com>
> ---
> v2: fix a couple of things pointed out by zorro
> ---
>  configure.ac              |    1 
>  include/builddefs.in      |    1 
>  m4/package_libcdev.m4     |   13 ++
>  src/Makefile              |    4 +
>  src/t_reflink_read_race.c |  339 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/1953        |   75 ++++++++++
>  tests/generic/1953.out    |    6 +
>  tests/xfs/1872            |   10 +
>  tests/xfs/1873            |   10 +

This xfs/1953 looks good to me, but about the changes on xfs/1872 and 1873, I think
those might be another patch :)

>  9 files changed, 447 insertions(+), 12 deletions(-)
>  create mode 100644 src/t_reflink_read_race.c
>  create mode 100755 tests/generic/1953
>  create mode 100644 tests/generic/1953.out
> 

[snip]

> diff --git a/tests/generic/1953 b/tests/generic/1953
> new file mode 100755
> index 0000000000..70aefc736b
> --- /dev/null
> +++ b/tests/generic/1953
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023, Oracle and/or its affiliates.  All Rights Reserved.
> +#
> +# FS QA Test No. 1953
> +#
> +# Race file reads with a very slow reflink operation to see if the reads
> +# actually complete while the reflink is ongoing.  This is a functionality
> +# test for XFS commit f3ba4762fa56 "xfs: allow read IO and FICLONE to run
> +# concurrently".
> +#
> +. ./common/preamble
> +_begin_fstest auto clone punch
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/attr
> +. ./common/reflink
> +
> +# real QA test starts here
> +_require_scratch_reflink
> +_require_cp_reflink
> +_require_xfs_io_command "fpunch"
> +_require_test_program "punch-alternating"
> +_require_test_program "t_reflink_read_race"
> +_require_command "$TIMEOUT_PROG" timeout
> +
> +rm -f "$seqres.full"
> +
> +echo "Format and mount"
> +_scratch_mkfs > "$seqres.full" 2>&1
> +_scratch_mount >> "$seqres.full" 2>&1
> +
> +testdir="$SCRATCH_MNT/test-$seq"
> +mkdir "$testdir"
> +
> +calc_space() {
> +	blocks_needed=$(( 2 ** (fnr + 1) ))
> +	space_needed=$((blocks_needed * blksz * 5 / 4))
> +}
> +
> +# Figure out the number of blocks that we need to get the reflink runtime above
> +# 1 seconds
> +echo "Create a many-block file"
> +for ((fnr = 1; fnr < 40; fnr++)); do
> +	free_blocks=$(stat -f -c '%a' "$testdir")
> +	blksz=$(_get_file_block_size "$testdir")
> +	space_avail=$((free_blocks * blksz))
> +	calc_space
> +	test $space_needed -gt $space_avail && \
> +		_notrun "Insufficient space for stress test; would only create $blocks_needed extents."
> +
> +	off=$(( (2 ** fnr) * blksz))
> +	$XFS_IO_PROG -f -c "pwrite -S 0x61 -b 4194304 $off $off" "$testdir/file1" >> "$seqres.full"
> +	"$here/src/punch-alternating" "$testdir/file1" >> "$seqres.full"
> +
> +	timeout 1s cp --reflink=always "$testdir/file1" "$testdir/garbage" || break

As there's `_require_command "$TIMEOUT_PROG" timeout`, so better to use $TIMEOUT_PROG
at here. I can help to change this, but the 1872 and 1873 need to be removed, they
block the patch merging.

Thanks,
Zorro

> +done
> +echo "fnr=$fnr" >> $seqres.full
> +
> +echo "Reflink the big file"
> +$here/src/t_reflink_read_race "$testdir/file1" "$testdir/file2" \
> +	"$testdir/outcome" &>> $seqres.full
> +
> +if [ ! -e "$testdir/outcome" ]; then
> +	echo "Could not set up program"
> +elif grep -q "finished read early" "$testdir/outcome"; then
> +	echo "test completed successfully"
> +else
> +	cat "$testdir/outcome"
> +fi
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/1953.out b/tests/generic/1953.out
> new file mode 100644
> index 0000000000..8eaacb7ff0
> --- /dev/null
> +++ b/tests/generic/1953.out
> @@ -0,0 +1,6 @@
> +QA output created by 1953
> +Format and mount
> +Create a many-block file
> +Reflink the big file
> +Terminated
> +test completed successfully
> diff --git a/tests/xfs/1872 b/tests/xfs/1872
> index 004e99176e..289fc99612 100755
> --- a/tests/xfs/1872
> +++ b/tests/xfs/1872
> @@ -10,15 +10,13 @@
>  . ./common/preamble
>  _begin_fstest auto quick unlink
>  
> -# Import common functions.
> -source ./common/filter
> -source ./common/fuzzy
> -source ./common/quota
> +. ./common/filter
> +. ./common/fuzzy
> +. ./common/quota
>  
>  # real QA test starts here
>  
> -# Modify as appropriate.
> -_supported_fs generic
> +_supported_fs xfs
>  _require_xfs_db_command iunlink
>  _require_scratch_nocheck	# we'll run repair ourselves
>  
> diff --git a/tests/xfs/1873 b/tests/xfs/1873
> index 46af16f5d1..5d9fc620dc 100755
> --- a/tests/xfs/1873
> +++ b/tests/xfs/1873
> @@ -10,15 +10,13 @@
>  . ./common/preamble
>  _begin_fstest auto online_repair
>  
> -# Import common functions.
> -source ./common/filter
> -source ./common/fuzzy
> -source ./common/quota
> +. ./common/filter
> +. ./common/fuzzy
> +. ./common/quota
>  
>  # real QA test starts here
>  
> -# Modify as appropriate.
> -_supported_fs generic
> +_supported_fs xfs
>  _require_xfs_db_command iunlink
>  # The iunlink bucket repair code wasn't added to the AGI repair code
>  # until after the directory repair code was merged
> 

