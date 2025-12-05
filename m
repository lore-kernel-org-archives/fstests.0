Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634212F39B0
	for <fstests@vger.kernel.org>; Fri,  5 Dec 2025 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764916384; cv=none; b=bug5zDn783lgBcQYtkMcOz1cQWIxUXu6jQ1x1eJu9zNBPFhndHM0kytdkPcPpe/xvN1kSXs89gqso0dPCjMkZh2WgJTbtzvTw9nNUrjxSGKkmD+AquVDKAJ7Fywu3eiW6sWEU6rqgYEMbwLmqJU+/Cx/kkt77c+GEzCTyuuC97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764916384; c=relaxed/simple;
	bh=mQF+UH7XKhH3onXdlZmd8nHr/dAP/g4rycaSgnwq9EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h28B3gdLgI16PfqEDdnFIzvh8T7ni0H331p2xx3SXjEaTwAU6yKBMiQpA1GivTUxbU1XEDtPVsz1tK+fWSBg94t2+ugFqExR2weQ6HkKm3otR0iihNvud8ASR8ceV6DncRMvniAQI9ZHpwXnHpive3/fB0r//zt+qJ8rdd74NMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fb+UvakS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnmLySqs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fb+UvakS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnmLySqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764916378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MxQYGdl9daQmzLJX+aD+FW2UyY+NMB7PfubW+CqxcGA=;
	b=fb+UvakSh400pL/uxLoVq/GZU+ddyr7QnzO20bbrlV6XgHZEor7IInlGVWGfiHalbVtO5G
	y7ZmVYJPNWZwQt7Op1X9ykn3WgVCs27vL9vqc/B+qxW+Qj/QeljSBxVHjYCA4ttKdCaG+F
	q0IYeZYyYCpIH81CF5qw1WFB9Va+BIo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2--Fs23h5TO1qlCuUqvnsQHQ-1; Fri, 05 Dec 2025 01:32:56 -0500
X-MC-Unique: -Fs23h5TO1qlCuUqvnsQHQ-1
X-Mimecast-MFC-AGG-ID: -Fs23h5TO1qlCuUqvnsQHQ_1764916376
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297e66542afso44547925ad.3
        for <fstests@vger.kernel.org>; Thu, 04 Dec 2025 22:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764916376; x=1765521176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxQYGdl9daQmzLJX+aD+FW2UyY+NMB7PfubW+CqxcGA=;
        b=AnmLySqsvk2361Bhd21CcI1C8jy8+qQnvP2LJ7Qo/5i1MKJDOPY7RjDAwGEt7nx8Fc
         5aAn25MgwXR2JCp6/wJg4RthfzO4KUgaFUINDsSD+EllTcUNUcs4Q3K9uaYThvigb96b
         ub6yOWNJsQDtG5DHrJ3njmURBmDaKV2Q0zAJEwiiHQmDrCfyDmAJEwa5/Tt8TYqLMuBU
         46BBtAeiGvto0O2ELlEGJ5EqQQELTPBf1cWQ/gEgKlPWO+2ruaSpSndwyzrvCGF3cNmz
         LoE/rJavS2qZfCkvLQrPU/k8Zl5WhlEYN5/GW+YuJwYjfdUE4H1Qoq5nvpGRGmn10Yn1
         aEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764916376; x=1765521176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxQYGdl9daQmzLJX+aD+FW2UyY+NMB7PfubW+CqxcGA=;
        b=rrjYpl6Fnwjf2/pC83ac1Pb5wqFsv1YZ0MTRPx2J9IoSJcNrwLzldsVUoylkznWqJK
         GA2UPEL34aCwNjmfw+DREqqgEYDxlpeYkPPgzdokCoCahPpoD5kXQ1c7OBo/Mbyr22Q1
         +jVoWIs11i2ktzTqgpF6orEoNXz2O3xYNsfK43qnCVV2uzcrvQmDcyOgtkxb9CoYLqEU
         WM9tCZ0kbPgJITqCiRB0hx2MpNudgzmaQRhFoxgYGePBtRzNzIdLFxJ+or9pZ/yBCK9+
         pgnOxf8+z/f1E+h3hUYczLy4Xe/OXBP0bNDXoMCDeaOm9dVqIioJbkxQo5kyq1ELTnN3
         0cMg==
X-Gm-Message-State: AOJu0YzFH1mrtQ+e6qM77VQXHwNY1LUKVuGh/DaNdItSy4YP+nsvhAqm
	8NGKJiJvTomVR0rO1/CF5uGoE8+Eh1eLp2E6Uz6mJ7AtiwXkpyWT3AuU2M/dzCIDRG+DVTequ/D
	ke8iKRkgBPV+EheUftK43RxT2xkxh3ojE6Gn4/BjEsVkxG1kUH3/NtvKkMkM=
X-Gm-Gg: ASbGncsCXn8FBEeJxTnu7ruvGR7Iu/fTXNk2vA2TBIZu1t2bxUBFHAoDX+ljG9kB6aY
	mYZc3Pf4ikEok0cTqBFoarI4GGQ++GNqmhJTZxTXroLphDxQB9BNV0xaOets1CB+QBUu2XHnjBd
	2opyOPmHVH1sKgvJ6Yac8EAkp2sfjpgMjWIGrqGkG4uQARvwhzj1dM/cxJyAYkVcIXuKGARrlfC
	/piOM0u6DU/emrUmfiGV48ulAfhUA3TBusqNjXdh2olwh0LJVL+UM9f3Qw04UKgMGqN0YU9t/rn
	GKV+zGoiNgjmXrpEqB9B9NJWm5qyWiDVW3nu/Y2qJkVo7S8MQjxI2tPWrbj16lBJnmmIaLtPkiq
	6e3lD6Cb2RcOpLu/9PpO+T7pWZBzVYdlDw8hGaD6d8QgBtUP6Mg==
X-Received: by 2002:a17:903:2303:b0:24b:270e:56c7 with SMTP id d9443c01a7336-29d9f67d57dmr65051195ad.7.1764916375593;
        Thu, 04 Dec 2025 22:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExcEHN+AWAV9cWkGJZYiC3/x7+IcD7DjmA1NemvRy6mH6eHM3wG0CuOMqu80wQf9iNTmcdRA==
X-Received: by 2002:a17:903:2303:b0:24b:270e:56c7 with SMTP id d9443c01a7336-29d9f67d57dmr65050825ad.7.1764916375078;
        Thu, 04 Dec 2025 22:32:55 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6ea0sm37752035ad.99.2025.12.04.22.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 22:32:54 -0800 (PST)
Date: Fri, 5 Dec 2025 14:32:50 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test journaling after renaming fsynced file and
 fsync parent dir
Message-ID: <20251205063250.zj746ryaullmkc4a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <a883e236548bec41bb0b043fe0105b4da4fd0749.1764783252.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a883e236548bec41bb0b043fe0105b4da4fd0749.1764783252.git.fdmanana@suse.com>

On Wed, Dec 03, 2025 at 05:38:14PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we fsync a file, create a directory in the same parent
> directory of the file, add a file to the new directory, rename the
> initial file and then fsync the parent directory of the first file, after
> a power failure the new directory exists, with its new entry and the first
> file has the new name and any data we wrote to it before its fsync.
> 
> This exercises a reported btrfs bug which is fixed by a patch with the
> following subject:
> 
>   "btrfs: do not skip logging new dentries when logging a new name"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/785     | 73 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/785.out |  4 +++
>  2 files changed, 77 insertions(+)
>  create mode 100755 tests/generic/785
>  create mode 100644 tests/generic/785.out
> 
> diff --git a/tests/generic/785 b/tests/generic/785
> new file mode 100755
> index 00000000..a6cfdd87
> --- /dev/null
> +++ b/tests/generic/785
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 785
> +#
> +# Test that if we fsync a file, create a directory in the same parent directory
> +# of the file, add a file to the new directory, rename the initial file and then
> +# fsync the parent directory of the first file, after a power failure the new
> +# directory exists, with its new entry and the first file has the new name and
> +# any data we wrote to it before its fsync.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/dmflakey
> +
> +_require_scratch
> +_require_dm_target flakey
> +_require_fssum
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: do not skip logging new dentries when logging a new name"
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# Create our first test file.
> +echo -n > $SCRATCH_MNT/file1
> +
> +# Persist the file and commit the current transaction.
> +_scratch_sync
> +
> +# Change the file (by writing some data to it for example) and fsync it.
> +$XFS_IO_PROG -c "pwrite -S 0xab 0 1000" \
> +	     -c "fsync" $SCRATCH_MNT/file1 | _filter_xfs_io
> +
> +# Create a new directory in the same parent directory as the previous file.
> +mkdir $SCRATCH_MNT/dir
> +# Add a new file to this new directory.
> +echo -n > $SCRATCH_MNT/dir/foo
> +
> +# Rename the first file, but keeping it in the same parent directory.
> +mv $SCRATCH_MNT/file1 $SCRATCH_MNT/file2
> +
> +# Fsync the parent directory of the first file.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/
> +
> +# Create a digest of the filesystem's content.
> +$FSSUM_PROG -A -f -w $tmp.fssum $SCRATCH_MNT/
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# Verify the filesystem has the same content that it had right before the power
> +# failure and after the last fsync.
> +$FSSUM_PROG -r $tmp.fssum $SCRATCH_MNT/
> +
> +_unmount_flakey
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/785.out b/tests/generic/785.out
> new file mode 100644
> index 00000000..b509508b
> --- /dev/null
> +++ b/tests/generic/785.out
> @@ -0,0 +1,4 @@
> +QA output created by 785
> +wrote 1000/1000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +OK
> -- 
> 2.47.2
> 
> 

