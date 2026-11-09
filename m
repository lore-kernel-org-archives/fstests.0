Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233434;
	b=Wu4aSTSE4Xm/CGLTWUQueAAGfECZjm+3DZIaKDwWzB3ecq2n0vbhQuE4ornZea62/zCj
	 iXB1xIqduxr8KUED/+tbXBvbEWQlKL53Rn0XdUiqjetdfSZvtqBo/eyTTymFWWLxvamsT
	 367bj6jBq/BKCT/ItRrOAtj+tq4Ttw1jJzbhH8hcymHlSv1+zrTRyB19TAyne6YfeK5jF
	 cm0IQ+nziALsO4CHdfKVrxAUfGUtHB0RDsCl16Lw5xzTDQcHf9B99ZLS/gkk1l54pnHGV
	 5f99DdZyqXW+zJX35BUeYuYAsYpljz3UYOlAQcPxh4WkVkm+LdNTywIIZQTSqQZk1CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233434;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=PzVL6PAEbl5pgELLvZXHHqt0TxkEy8XXG+9cmQK2Ji4=;
	b=zVRhRPTXPqOVJjg1pJ8sh1AMrxKHuN+ewJySCSRiD27sdrSePjvaJj7rNF1+3LilH/U6
	 aLhVQJ8rBl7dj+lx/EvfxAYMZZXGS0I6NbwWVWFj+J7qFktAi7P2aoUnlgSKkY7357nlc
	 /GCU+qQgUOmquVpat09OV75kPsW3jsvJdh+52+K+9bT/hPcVwfrCdXCU+tYAGADdwXuI2
	 Gih8EUoIaigHjnp+br4tC4DdwHbI1IC5tAWR9rrKbnI2WcFUR7SKqK0Lm6/7JqPE/YszY
	 f61OITiYh9d/rsOH3HO50JVLeexCYeZGJxiqSArlbLQWJSWY1kAwS/W2w6Ir0Qt/xZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="B/ZJNle7";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F84606EEB3
	for <fstests@vger.kernel.org>; Mon,  9 Nov 2026 14:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50F84606EEB3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B/ZJNle7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794233433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PzVL6PAEbl5pgELLvZXHHqt0TxkEy8XXG+9cmQK2Ji4=;
	b=B/ZJNle7Myyx6uRyZyVR3IDpsdpTZ0KypcyTAPo1y2V53sPo7LT3wE6oIAO5FLFjPefq7f
	VfCTnU4A7/nhSbXL0jzPBsxqB9tZ9keuuipZ8RS4BIvTzJ6dt4geAPO2t0seiKC+CdAjOs
	pyFQfJTXFE7G4aj7LbYWBE1gdHiEGu8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-tcRDbXHnNaSjEd31VVFgCA-1; Mon,
 09 Nov 2026 09:10:30 -0500
X-MC-Unique: tcRDbXHnNaSjEd31VVFgCA-1
X-Mimecast-MFC-AGG-ID: tcRDbXHnNaSjEd31VVFgCA_1794233429
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FAF61955F7D;
	Mon,  9 Nov 2026 14:10:28 +0000 (UTC)
Received: from bfoster (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3800F1961755;
	Mon,  9 Nov 2026 14:10:26 +0000 (UTC)
Date: Mon, 9 Nov 2026 09:10:23 -0500
From: Brian Foster <bfoster@redhat.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 3/3] generic/810: check that RWF_DONTCACHE I/O drops
 its folios
Message-ID: <avHUTwnSMVCkKVoW@bfoster>
References: <20261107-dontcache-test-v2-0-7655bf08d6d1@columbia.edu>
 <20261107-dontcache-test-v2-3-7655bf08d6d1@columbia.edu>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-dontcache-test-v2-3-7655bf08d6d1@columbia.edu>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Nov 07, 2026 at 09:19:41PM -0500, Tal Zussman wrote:
> A dontcache write drops its folios from the page cache once writeback
> completes, and a dontcache read drops them once the read completes.
> 
> Test this by writing and reading a 1M file with and without
> RWF_DONTCACHE and checking with mincore how much of it is cached
> afterwards: all of it for plain I/O, none of it for dontcache I/O.
> 
> The overwrite is a separate case because the drop is skipped when
> writeback completes in interrupt context, which is what happens on ext4
> without commit "ext4: complete dropbehind writeback in task context"
> [1].
> 
> Link: https://lore.kernel.org/linux-ext4/20261012-ext4-dontcache-complete-in-task-v1-1-6ac801557041@columbia.edu/ [1]
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---

I like it. Thanks for the tweaks!

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/generic/810     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/810.out | 11 ++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/tests/generic/810 b/tests/generic/810
> new file mode 100755
> index 00000000..1866848f
> --- /dev/null
> +++ b/tests/generic/810
> @@ -0,0 +1,77 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Tal Zussman.  All Rights Reserved.
> +#
> +# FS QA Test No. 810
> +#
> +# Check that RWF_DONTCACHE I/O drops its folios from the page cache: a
> +# dontcache write once its writeback completes, and a dontcache read once the
> +# read completes. Plain buffered I/O on the same file has to leave them cached.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +_require_scratch
> +_require_xfs_io_command "pwrite" "-U"
> +_require_xfs_io_command "pread" "-U"
> +_require_xfs_io_command "mincore"
> +_exclude_scratch_mount_option "dax"
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +size=$((1024 * 1024))
> +file=$SCRATCH_MNT/file
> +pagesize=$(_get_page_size)
> +
> +# Count the bytes of the file that are in the page cache.
> +cached_bytes()
> +{
> +	local pages
> +
> +	pages=$($XFS_IO_PROG -c "mmap -r 0 $size" -c "mincore" $file | \
> +		awk '{ n += $4 } END { print n + 0 }')
> +	echo $((pages * pagesize))
> +}
> +
> +# Report how many bytes are cached, after waiting up to $1 seconds for the
> +# cache to empty. Dontcache writeback can drop folios just after fsync returns.
> +report_cached()
> +{
> +	local delay=${1:-0}
> +	local i
> +
> +	for ((i = 0; i < delay * 10; i++)); do
> +		[ "$(cached_bytes)" -eq 0 ] && break
> +		sleep 0.1
> +	done
> +	echo "$(cached_bytes) of $size bytes cached"
> +}
> +
> +echo "plain write"
> +$XFS_IO_PROG -f -c "pwrite -q 0 $size" -c fsync $file
> +report_cached 1
> +
> +echo "dontcache write to a new file"
> +rm -f $file
> +$XFS_IO_PROG -f -c "pwrite -q -U -V 1 -b $size 0 $size" -c fsync $file
> +report_cached 5
> +
> +# Start each of the remaining cases from an empty page cache.
> +echo "dontcache overwrite"
> +_scratch_cycle_mount
> +$XFS_IO_PROG -c "pwrite -q -U -V 1 -b $size 0 $size" -c fsync $file
> +report_cached 5
> +
> +echo "dontcache read"
> +_scratch_cycle_mount
> +$XFS_IO_PROG -c "pread -q -U -V 1 -b $size 0 $size" $file
> +report_cached 5
> +
> +echo "plain read"
> +_scratch_cycle_mount
> +$XFS_IO_PROG -c "pread -q 0 $size" $file
> +report_cached 1
> +
> +_scratch_unmount
> +_exit 0
> diff --git a/tests/generic/810.out b/tests/generic/810.out
> new file mode 100644
> index 00000000..cb6c3f2a
> --- /dev/null
> +++ b/tests/generic/810.out
> @@ -0,0 +1,11 @@
> +QA output created by 810
> +plain write
> +1048576 of 1048576 bytes cached
> +dontcache write to a new file
> +0 of 1048576 bytes cached
> +dontcache overwrite
> +0 of 1048576 bytes cached
> +dontcache read
> +0 of 1048576 bytes cached
> +plain read
> +1048576 of 1048576 bytes cached
> 
> -- 
> 2.39.5
> 
> 

