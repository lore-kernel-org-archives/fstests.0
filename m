Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6602192F4
	for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768758818; cv=none; b=Huonl3zDvarVNWgBI7JvKR2XMlPAsq3f2/c6zTyn/MAgpZTW0m6lkfxUPxsheVjpkxR+Q0TskVO4bYDA6o1yW6+OvPCD+GtDaaAFQ2Do83DQjBcQfPadbo/V/SBQr+yWSno1mknGhBGF5tL43lwU05tbwnCL2dtwiDCeu96wCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768758818; c=relaxed/simple;
	bh=OBY1fwyKD+/rPwGzjvs0OjCfeLmAtP2pCzQUeiPLIQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA4wdt2ZjVq69xDZLDdOrYPF5wBxo4HHMjbKXfoaHNTrXllpDla+KCN1LP4uewGLqk8NPluJeaUgkhZVFjffs2o3LZ9C5H3SVR0wxLMHAJTOHSv4HYn8XO+fi0VVwOJFXpYYwXN3ov+BFsiERY1J/MeOx3jCc17XeQ59CRuf4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PS7ogtB8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpqEbG+A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PS7ogtB8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpqEbG+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768758816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCduauureZNvluvTgXiZCfmGyf5eIIhlYcj7VXYOhQ4=;
	b=PS7ogtB8ks3TsR2GLeGsZT7S3Ko4LHnPuY3XeV8UTZgbkLecrmjQRPIeGgODpmdMJKMipf
	PVs/WYDk7g/bsz6fOCuwzr+tMbaYuqiyA2m+wjc9N6EtTiH7rau4obrz2wZ9LYC/wpKX1P
	rInyZgHtQzX/KVliQe4Nb7mav6W0Acw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-eaLVz0pFMGurtxhw6QLWkA-1; Sun, 18 Jan 2026 12:53:34 -0500
X-MC-Unique: eaLVz0pFMGurtxhw6QLWkA-1
X-Mimecast-MFC-AGG-ID: eaLVz0pFMGurtxhw6QLWkA_1768758814
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a089575ab3so30547235ad.0
        for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 09:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768758814; x=1769363614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cCduauureZNvluvTgXiZCfmGyf5eIIhlYcj7VXYOhQ4=;
        b=HpqEbG+AaNs6JZZd9OG/yUKtfDjNsqBeXvt+vtOO+UnZs8X7oKBwY+RcVfkGuB6KMP
         bqlZ/9A7x2nMehX6zeviUfNMYxH78aFOqMXvkWZp9iVH583W1SKSVavrblXsXdIYW7XM
         5/8YR/Ehy7bPap8o0npCM4csMaofdOnDqoKPdiNeK3fYJh/WQ2hl/lybGBvUEmAUfY3G
         emlQXuiIdxF5BWfPzHaYfdJe1ZEhDF3+PBqwGJDDkklxUlJpUU4ALmTjc2jRYw74xSs8
         U3pcOyQykCnjCZf8VK7ZjFrvPuUGmso9zpRnGM95XOqVYPd1A+c8ZR8gm8ufb8dQUnVy
         7cLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768758814; x=1769363614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCduauureZNvluvTgXiZCfmGyf5eIIhlYcj7VXYOhQ4=;
        b=DLMeKuDxrCRSYNs+IEoEGFzseaTUPmYa4OkBgHH95eq2U5QQVCddFKpbDwZed6nLxE
         rWAt1TR55fs65BC4l35iBByaFFcwicOyaKTMgBBQlbY1RimmQpURmO+Mf5WWDmdUGtr7
         eXwpiLxkP/oeLVUZcSFQncrqPvcojiE9MB9Edfny+OFZj6dBpFmGGYVsWPXy4SUsusG3
         KqU7aG+dznwXxPqjCPvW4feYrH71FB1C3rbfuhApz+P0CmHNyP5qaKICPiEfzALjygsb
         a3LE9cM07x/Z5w6I0Znciry/Id34sOixmbGJokSLlKoMRAlvTl1kqnN9VuPeoE423gtp
         EF+A==
X-Forwarded-Encrypted: i=1; AJvYcCWbfqYyOKAYLtX5VNrTHu0kgFBkUOrVdx1cEHWbwim5ZZCSEykeEEOGI1DQFn5nKgoewv/xNGrn@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcEGzQ5V8JhOgJZlntytuGoDU5NMqONlQpuCQqi259UWUJ8RB
	VV/+JOts9Vtx0MNGXRF7xF4+L9em0W0WZi6U1wH2cHrTwwdfcgYhCyRfM1kTf+GQ4En7TLKbAr7
	oFkIij8S3cC9BYQp1HUl2gg2jcHf74kaOR1blmwHxBSDyG7uHJr2RFaN/1FM=
X-Gm-Gg: AY/fxX4tQU7dWrtxtqu1RDLOS39Tz9f+RO28aDxntC+Wtn2LxPvSgWwAHt6jSJ7gSrh
	U8E9RHieLwmDCiwftWyMoPRDDFFcPMoKrluDX3+WLrWXqThujWuzrtMki2ruEc7Z8ars5/ujVFp
	hDu08Vp1Ldas3obJ6HmRHIYnEfhA/f+veiUsaKN6o4mu5HpTvwEIRAoQ31xi6pliDuonPfy8KXS
	+8mb9dJ5v/wi0RoST3fCtRRSBgxecH/kXZQ7GTk42HquDmiwLTJ4S29vq5F9d9Q/eoaSRj1OnSY
	rG5HT84enobpNAPvWa8I53x8AECWcfi76elF2h0Fc9e+2NBDsO7P3QzEweQIIVhwBvhoA78y8lq
	SqavLesfnRaK8myUfCux95P9Y6s459TbZlPSKftJhBobqBJ/eSw==
X-Received: by 2002:a17:903:22c3:b0:2a3:bf5f:926b with SMTP id d9443c01a7336-2a7176c7cf7mr97097105ad.47.1768758813692;
        Sun, 18 Jan 2026 09:53:33 -0800 (PST)
X-Received: by 2002:a17:903:22c3:b0:2a3:bf5f:926b with SMTP id d9443c01a7336-2a7176c7cf7mr97096955ad.47.1768758813242;
        Sun, 18 Jan 2026 09:53:33 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7194164dfsm70048055ad.88.2026.01.18.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 09:53:32 -0800 (PST)
Date: Mon, 19 Jan 2026 01:53:27 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luca Di Maio <luca.dimaio1@gmail.com>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, djwong@kernel.org,
	hch@infradead.org, david@fromorbit.com
Subject: Re: [PATCH v6] xfs: test reproducible builds
Message-ID: <20260118175327.hdevfpau7uifdsb7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260108142222.37304-1-luca.dimaio1@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108142222.37304-1-luca.dimaio1@gmail.com>

On Thu, Jan 08, 2026 at 03:22:22PM +0100, Luca Di Maio wrote:
> With the addition of the `-p` populate option, SOURCE_DATE_EPOCH and
> DETERMINISTIC_SEED support, it is possible to create fully reproducible
> pre-populated filesystems. We should test them here.
> 

> v1 -> v2:
> - Changed test group from parent to mkfs
> - Fixed PROTO_DIR to point to a new dir
> - Populate PROTO_DIR with relevant file types
> - Move from md5sum to sha256sum
> v2 -> v3
> - Properly check if mkfs.xfs supports SOURCE_DATE_EPOCH and
>   DETERMINISTIC_SEED
> - use fsstress program to generate the PROTO_DIR content
> - simplify test output
> v3 -> v4
> - Add _cleanup function
> v4 -> v5
> - copy _cleanup from common/preamble
> v5 -> v6
> - remove debug typo/leftover

I think it's not good to be commit log, better to move this part ->

> 
> Signed-off-by: Luca Di Maio <luca.dimaio1@gmail.com>
> ---

  -> here

>  tests/xfs/841     | 173 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/841.out |   3 +
>  2 files changed, 176 insertions(+)
>  create mode 100755 tests/xfs/841
>  create mode 100644 tests/xfs/841.out
> 
> diff --git a/tests/xfs/841 b/tests/xfs/841
> new file mode 100755
> index 00000000..5f981d0a
> --- /dev/null
> +++ b/tests/xfs/841
> @@ -0,0 +1,173 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chainguard, Inc. All Rights Reserved.
> +#
> +# FS QA Test No. 841
> +#
> +# Test that XFS filesystems created with reproducibility options produce
> +# identical images across multiple runs. This verifies that the combination
> +# of SOURCE_DATE_EPOCH, DETERMINISTIC_SEED, and -m uuid= options result in
> +# bit-for-bit reproducible filesystem images.
> +
> +. ./common/preamble
> +_begin_fstest auto quick mkfs
> +
> +# Image file settings
> +IMG_SIZE="512M"
> +IMG_FILE="$TEST_DIR/xfs_reproducible_test.img"
> +PROTO_DIR="$TEST_DIR/proto"
> +
> +# Fixed values for reproducibility
> +FIXED_UUID="12345678-1234-1234-1234-123456789abc"
> +FIXED_EPOCH="1234567890"
> +
> +_cleanup() {
> +	cd /
> +	command -v _kill_fsstress &>/dev/null && _kill_fsstress
> +	rm -r -f $tmp.* "$PROTO_DIR" "$IMG_FILE"
> +}
> +
> +# Check if mkfs.xfs supports required options
> +_check_mkfs_xfs_options()
> +{
> +	local check_img="$TEST_DIR/mkfs_check.img"
> +	truncate -s 64M "$check_img" || return 1
> +
> +	# Check -m uuid support
> +	$MKFS_XFS_PROG -m uuid=00000000-0000-0000-0000-000000000000 \
> +		-N "$check_img" &> /dev/null
> +	local uuid_support=$?
> +
> +	# Check -p support (protofile/directory population)
> +	$MKFS_XFS_PROG 2>&1 | grep populate &> /dev/null
> +	local proto_support=$?
> +
> +	grep -q SOURCE_DATE_EPOCH "$MKFS_XFS_PROG"
> +	local reproducible_support=$?
> +
> +	rm -f "$check_img"
> +
> +	if [ $uuid_support -ne 0 ]; then
> +		_notrun "mkfs.xfs does not support -m uuid= option"
> +	fi
> +	if [ $proto_support -ne 0 ]; then
> +		_notrun "mkfs.xfs does not support -p option for directory population"
> +	fi
> +	if [ $reproducible_support -ne 0 ]; then
> +		_notrun "mkfs.xfs does not support env options for reproducibility"
> +	fi
> +}
> +
> +# Create a prototype directory with all file types supported by mkfs.xfs -p
> +_create_proto_dir()
> +{
> +	rm -rf "$PROTO_DIR"
> +	mkdir -p "$PROTO_DIR"
> +
> +	$FSSTRESS_PROG -d $PROTO_DIR -s 1 -n 2000 -p 2 -z \
> +		-f creat=15 \
> +		-f mkdir=8 \
> +		-f write=15 \
> +		-f truncate=5 \
> +		-f symlink=8 \
> +		-f link=8 \
> +		-f setfattr=12 \
> +		-f chown=3 \
> +		-f rename=5 \
> +		-f unlink=2 \
> +		-f rmdir=1

To match the _kill_fsstress, when I merge this patch I'll change this part to:

        FSSTRESS_ARGS=`_scale_fsstress_args -d $PROTO_DIR -s 1 -n 2000 -p 2 -z
                -f creat=15 \
                -f mkdir=8 \
                -f write=15 \
                -f truncate=5 \
                -f symlink=8 \
                -f link=8 \
                -f setfattr=12 \
                -f chown=3 \
                -f rename=5 \
                -f unlink=2 \
                -f rmdir=1`
        _run_fsstress $FSSTRESS_ARGS

Thanks,
Zorro

> +
> +
> +	# FIFO (named pipe)
> +	mkfifo "$PROTO_DIR/fifo"
> +
> +	# Unix socket
> +	$here/src/af_unix "$PROTO_DIR/socket" 2> /dev/null || true
> +
> +	# Block device (requires root)
> +	mknod "$PROTO_DIR/blockdev" b 1 0 2> /dev/null || true
> +
> +	# Character device (requires root)
> +	mknod "$PROTO_DIR/chardev" c 1 3 2> /dev/null || true
> +}
> +
> +_require_test
> +_check_mkfs_xfs_options
> +
> +# Create XFS filesystem with full reproducibility options
> +# Uses -p to populate from directory during mkfs (no mount needed)
> +_mkfs_xfs_reproducible()
> +{
> +	local img=$1
> +
> +	# Create fresh image file
> +	rm -f "$img"
> +	truncate -s $IMG_SIZE "$img" || return 1
> +
> +	# Set environment variables for reproducibility:
> +	# - SOURCE_DATE_EPOCH: fixes all inode timestamps to this value
> +	# - DETERMINISTIC_SEED: uses fixed seed (0x53454544) instead of
> +	#   getrandom()
> +	#
> +	# mkfs.xfs options:
> +	# - -m uuid=: fixed filesystem UUID
> +	# - -p dir: populate filesystem from directory during creation
> +	SOURCE_DATE_EPOCH=$FIXED_EPOCH \
> +	DETERMINISTIC_SEED=1 \
> +	$MKFS_XFS_PROG \
> +		-f \
> +		-m uuid=$FIXED_UUID \
> +		-p "$PROTO_DIR" \
> +		"$img" >> $seqres.full 2>&1
> +
> +	return $?
> +}
> +
> +# Compute hash of the image file
> +_hash_image()
> +{
> +	sha256sum "$1" | awk '{print $1}'
> +}
> +
> +# Run a single reproducibility test iteration
> +_run_iteration()
> +{
> +	local iteration=$1
> +
> +	echo "Iteration $iteration: Creating filesystem with -p $PROTO_DIR" >> $seqres.full
> +	if ! _mkfs_xfs_reproducible "$IMG_FILE"; then
> +		echo "mkfs.xfs failed" >> $seqres.full
> +		return 1
> +	fi
> +
> +	local hash=$(_hash_image "$IMG_FILE")
> +	echo "Iteration $iteration: Hash = $hash" >> $seqres.full
> +
> +	echo $hash
> +}
> +
> +# Create the prototype directory with various file types
> +_create_proto_dir
> +
> +echo "Test: XFS reproducible filesystem image creation"
> +
> +# Run three iterations
> +hash1=$(_run_iteration 1)
> +[ -z "$hash1" ] && _fail "Iteration 1 failed"
> +
> +hash2=$(_run_iteration 2)
> +[ -z "$hash2" ] && _fail "Iteration 2 failed"
> +
> +hash3=$(_run_iteration 3)
> +[ -z "$hash3" ] && _fail "Iteration 3 failed"
> +
> +# Verify all hashes match
> +if [ "$hash1" = "$hash2" ] && [ "$hash2" = "$hash3" ]; then
> +	echo "All filesystem images are identical."
> +else
> +	echo "ERROR: Filesystem images differ!"
> +fi
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/841.out b/tests/xfs/841.out
> new file mode 100644
> index 00000000..3bdfbfda
> --- /dev/null
> +++ b/tests/xfs/841.out
> @@ -0,0 +1,3 @@
> +QA output created by 841
> +Test: XFS reproducible filesystem image creation
> +All filesystem images are identical.
> -- 
> 2.51.0
> 

