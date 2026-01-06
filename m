Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A83324B1E
	for <fstests@vger.kernel.org>; Tue,  6 Jan 2026 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767705632; cv=none; b=k6kZgVaPOA+1YSWjE8lexIssUTSOIzYHtdAe408UvWhs0qc/zaFktOlMFT08oIicEzzH0p2YZ/0/1UuPcgnqrNhNYgP1FbXBNvfik3nOFoK7K6bwh20EhyYQmVVO9Wf4oH1sq8w+bZjYOUWfITZarhezdcWTb5/EdWFya1/NoVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767705632; c=relaxed/simple;
	bh=WI618H8wn1zhjKn/psXIA1znwkKkIcYj59tA/hQZDh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9ATLnUQaqQiS8Kllv5765oD5LvxlzHlkF7oDpgw/030q8e5Vq4DJNnkHkMzEps7RsvytmyC37BWEsRn7NwUAAg4k4x3TLitH44eX17SYA4JfAcPY6AG5SW48KhB49sdNOVyk6qjvc4V2D7CeRgkpdn/2SN5B+jd8Rme46ifmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDDm7emj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkVN/Pqf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDDm7emj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkVN/Pqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767705629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUSAkx4nZxzA6fIZMuCxA1apGhSnNpqKiW22Me2zgi8=;
	b=fDDm7emjd1KL5SidQPIHF4ckZ+ckshfCk3XODpTHsBPh4ccsjXBqUTfukRdydyUL73WELV
	+u5145OoeD9OvY3dfM60uNLln4vdPzWDJUz3kAP/A4gNclyG1JFrL+IpPp/9fIj/8T+5UG
	+WiwMIUgfFZP75x+7EiKLUyn9cEGYkM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-TP0MRSJEMg69efs51PKD9Q-1; Tue, 06 Jan 2026 08:20:28 -0500
X-MC-Unique: TP0MRSJEMg69efs51PKD9Q-1
X-Mimecast-MFC-AGG-ID: TP0MRSJEMg69efs51PKD9Q_1767705627
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b9b9e8b0812so1632012a12.0
        for <fstests@vger.kernel.org>; Tue, 06 Jan 2026 05:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767705627; x=1768310427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUSAkx4nZxzA6fIZMuCxA1apGhSnNpqKiW22Me2zgi8=;
        b=KkVN/Pqf0yl2eclDojiyWjY8NceQfQq7ju/KLi9xSKFrhAeBrwRh48q0QhwuKVgnU9
         EtrBXAjh7EhWAgc49NsT72EPjaf9Vouda12Uu83TfQfP4RgIVY4VBQqEq85sCSng9+LW
         vb3O0fnpr8O+ILgYGbOoK58+cIonGOcswVqkyYWj4nsPaSwUdekusyFmfEZe1jWvYzEz
         hRmWNGzDV7PIhk4ijdE9noHWRuo7bnMW9Am3MBGqlJ+ZCb8qHFJ4u+iIBwrHe+St4nUP
         ky05t0Wdm8rVu1p2RUnDLJfCxFe2pV4D0rnCI4U02W0AQilKDfthKSPfGPILUO+SiUuv
         zQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767705627; x=1768310427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUSAkx4nZxzA6fIZMuCxA1apGhSnNpqKiW22Me2zgi8=;
        b=h2Z9vogz+gqPnPrZIlquKdp3i7JCMD7GdNPw15j+HEXxfTGOpGITHleSwlnPoWsxH9
         hGG/T3SC2HsLgj635/sBsnI5cFiIOng+zr6nTCY6jWA+GcWODpY2tWfanU6FhPb/qviV
         ANb9xJNCrr6c25b/Qv/h6IN+oVF8d+mntEzwMHHQxvR17bzZYk63YzExg3fPbQFpuil/
         rLDVUoU56Y88ZxIVxD2ep3HMZ4FVhHR+MtZZYVrAnKZb//X7mWHZQ5IhVaIGPGspt3En
         3h4FXhl8dINfqaQEgsHDHySu7+Cz1D8TfDeFrCuYrr17kzY8vntVwyJwrnsJbJko5WVL
         MiOQ==
X-Gm-Message-State: AOJu0YztTgmpiUmmq89N3STRd2tJ7RyC+5E39BG2i/Y5tds7Au8/317j
	VthEDzUBHwut0E0uhQaYZ0CCsrLI+BSZpJ9JSx2QamrLghUdkZ0VwSJrGHY0nKFq6mRLmlf13wh
	qviD376nHIejwwxCQeBg/NVZN9ebVOdcgeD8OyZMhB9oCYlndcsp20sD5XloOG2S2b+s=
X-Gm-Gg: AY/fxX7gPsISYWfepltAR0StgwC6F7pOplZSDb68LkuBgOKxekRxcjS6dYHBrgpWShR
	dUCHoYfmUG52BUsDHofAs1YXGMfm6g9VF/kHpLoctCj8+d2VgyY2ZpvPbQYc8ep+ZftRGAed0c0
	+cMuimqYnYLjw2niE6XndtpwklLT1s6ZRqsuaVsZj+mS5Cg9cmlzNCTpOGluKZQzLXbvSFOSh1K
	4/RSNL71vj2gXy3uxbeIJyx2LGwqBebUKwcc6bS2qGzcXwXEci4a0pui4/jPIvehBxW0RCxDJvs
	K/xC50AUFH4zDOymX/GSj4x1pIZjPLb8RUF5BUpGNdppfmYr79a0mBy/oCa0vRrsKr3anKjRZM8
	VFzqpAOt22FU2cEKzg08JteZRLtcoa+HO2MZiYlhFH4FxBUUH/w==
X-Received: by 2002:a05:6a20:6a21:b0:366:19e9:f43 with SMTP id adf61e73a8af0-38982293ec8mr2577752637.6.1767705626807;
        Tue, 06 Jan 2026 05:20:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpGgREh90FmWU4e0xVE82EdBmczYY8AYh3RcFxs70uHEKlq+DpUqKK13CTnV7hzEwxzFa3EA==
X-Received: by 2002:a05:6a20:6a21:b0:366:19e9:f43 with SMTP id adf61e73a8af0-38982293ec8mr2577726637.6.1767705626248;
        Tue, 06 Jan 2026 05:20:26 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfe1ca23sm2440655a12.12.2026.01.06.05.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 05:20:25 -0800 (PST)
Date: Tue, 6 Jan 2026 21:20:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: test power failure after fsync and rename
 exchanging directories
Message-ID: <20260106132021.bgedspsakjok3ozj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <a28c38d771946a662a9596449f63e6060f3fc7a4.1767704259.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28c38d771946a662a9596449f63e6060f3fc7a4.1767704259.git.fdmanana@suse.com>

On Tue, Jan 06, 2026 at 12:59:05PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test renaming one directory over another one that has a subvolume inside
> it and fsync a file in the other directory that was previously renamed.
> We want to verify that after a power failure we are able to mount the
> filesystem and it has the correct content (all renames visible).
> 
> This exercises a bug fixed by the following kernel commit:
> 
>   7ba0b6461bc4 ("btrfs: always detect conflicting inodes when logging inode refs")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Rebase to latest for-next, include kernel fix commit ID since it
>     was merged to Linus' tree yesterday.

Thanks, this version is good to me, and it can reproduce the bug.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  tests/btrfs/341     | 73 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/341.out | 15 ++++++++++
>  2 files changed, 88 insertions(+)
>  create mode 100755 tests/btrfs/341
>  create mode 100644 tests/btrfs/341.out
> 
> diff --git a/tests/btrfs/341 b/tests/btrfs/341
> new file mode 100755
> index 00000000..d92f9614
> --- /dev/null
> +++ b/tests/btrfs/341
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 341
> +#
> +# Test renaming one directory over another one that has a subvolume inside it
> +# and fsync a file in the other directory that was previously renamed. We want
> +# to verify that after a power failure we are able to mount the filesystem and
> +# it has the correct content (all renames visible).
> +#
> +. ./common/preamble
> +_begin_fstest auto quick subvol rename log
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
> +. ./common/renameat2
> +
> +_require_scratch
> +_require_dm_target flakey
> +_require_renameat2 exchange
> +
> +_fixed_by_kernel_commit 7ba0b6461bc4 \
> +	"btrfs: always detect conflicting inodes when logging inode refs"
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_scratch_mount
> +
> +# Create our test directories, one with a file inside, another with a subvolume
> +# that is not empty (has one file).
> +mkdir $SCRATCH_MNT/dir1
> +echo -n > $SCRATCH_MNT/dir1/foo
> +
> +mkdir $SCRATCH_MNT/dir2
> +_btrfs subvolume create $SCRATCH_MNT/dir2/subvol
> +echo -n > $SCRATCH_MNT/dir2/subvol/subvol_file
> +
> +_scratch_sync
> +
> +# Rename file foo so that its inode's last_unlink_trans is updated to the
> +# current transaction.
> +mv $SCRATCH_MNT/dir1/foo $SCRATCH_MNT/dir1/bar
> +
> +# Rename exchange dir1 with dir2.
> +$here/src/renameat2 -x $SCRATCH_MNT/dir1 $SCRATCH_MNT/dir2
> +
> +# Fsync file bar, we just renamed from foo.
> +# Until the kernel fix mentioned above, it would result in logging dir2 without
> +# logging dir1, causing log replay to attempt to remove the inode for dir1 since
> +# the inode for dir2 has the same name in the same parent directory. Not only
> +# this was not correct, since we did not delete the directory, but it would also
> +# result in a log replay failure (and therefore mount failure) because we would
> +# be attempting to delete a directory with a non-empty subvolume inside it.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir2/bar
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log. We should be able to replay the log tree and mount successfully.
> +_flakey_drop_and_remount
> +
> +echo -e "Filesystem contents after power failure:\n"
> +ls -1R $SCRATCH_MNT | _filter_scratch
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/btrfs/341.out b/tests/btrfs/341.out
> new file mode 100644
> index 00000000..bd46bdea
> --- /dev/null
> +++ b/tests/btrfs/341.out
> @@ -0,0 +1,15 @@
> +QA output created by 341
> +Filesystem contents after power failure:
> +
> +SCRATCH_MNT:
> +dir1
> +dir2
> +
> +SCRATCH_MNT/dir1:
> +subvol
> +
> +SCRATCH_MNT/dir1/subvol:
> +subvol_file
> +
> +SCRATCH_MNT/dir2:
> +bar
> -- 
> 2.47.2
> 
> 

