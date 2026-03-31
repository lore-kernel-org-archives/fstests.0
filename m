Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593019992C
	for <fstests@vger.kernel.org>; Tue, 31 Mar 2026 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990172; cv=none; b=q2PLCioB8PE4kWsFOW6R9B5/XlT02kikjCdvNgt9aG+ip2GN8oVDB7K4ICuuhJinUySsUwVIakepsR8eU038mBp7O2CJ3ktGpvCd9HBM+le4QDeSn6aAH1ka+EGKR6VzgR8DSD8bMfB3AcGXlQBHPl1bBqvODD7/msNILezOIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990172; c=relaxed/simple;
	bh=bgXsPX9PS9PUkPSkrCQXidjXeHIZThaaQma6mPtdsp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgffu7PbNu/zoX164cgAkSWrq9PCKXaVrDpOLlkITATVtwhN/leQBsjT5fYrM5c7S8VQXGAVTjl1NFe5lrunfh1d6lkpVrvmZ/a1coV5Wl0iAeXFvVG+32qfXfTFw4YifdFn1QElOBDCDggmC7eVgNVbBpSmyfW8IkPZRpE7WS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKLCn6RS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=poHHCpPc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKLCn6RS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="poHHCpPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774990170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0mnAwTu+mdk6SjwzOQooJKc6qr/lCoIEhYMItpm9cG4=;
	b=jKLCn6RSr76nybUQaPcvbw7UD9+KdO8i8mx+Sn1wQ1FIgiyuzRqNUn53QWvTTlE4T5lZKF
	CMjiGhBDs+EPXN1YCe12+O6zWdgL3id2kTQCIsYjmbeoKLbAoAf34tHd/82DqKEXnt9sSJ
	mfkPcPoNHlr3RBlfUy20oUq/w/3t7z8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-pCoI-9EkNIe6WZHpCCbfWw-1; Tue, 31 Mar 2026 16:49:27 -0400
X-MC-Unique: pCoI-9EkNIe6WZHpCCbfWw-1
X-Mimecast-MFC-AGG-ID: pCoI-9EkNIe6WZHpCCbfWw_1774990167
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35daf3d3030so2317635a91.1
        for <fstests@vger.kernel.org>; Tue, 31 Mar 2026 13:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774990166; x=1775594966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mnAwTu+mdk6SjwzOQooJKc6qr/lCoIEhYMItpm9cG4=;
        b=poHHCpPcDvN0PI4o/tz+XL0ss2ZN6l8QPH7h3iLuSz/h+mmy9ANk32dGoG3vl6RrhT
         hBVOKhR6UerF3gvITtKPzcJjKxJdYx5ooAb0Q3J0wFDN4poYpW1DY+3VoXZD04VhzBCw
         ehcEt7WLC0auyqOhxKBjGyz0Zxf+iSWIt4SMIurlbu1u/knTaGbyri7v/8Ir/UkD+moy
         6dW8R7kPNgaRQLbjwuuHLaz1cRKafjPJuD53+mC25XuCBBoDnHq+V48HJnH6U8uJZxhl
         cLvha+9TeN8oJwDDDGPTv0dFBi1mcp43l0dhhKvj4bqjoIzUjhbvUtX2Uq3pNwCPkIOM
         it+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774990166; x=1775594966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mnAwTu+mdk6SjwzOQooJKc6qr/lCoIEhYMItpm9cG4=;
        b=kjQjKb3B3yHCM3VF8dTtwGMmyA+fL+vdIrFKBq7wsx6oAvmbNV2wpZ0zVm2e5uefss
         ZXqI1y+aPlCXiObnHUhhr+du9EXf9DC8CHmthBtzj8T7Z5hb/mtKSoAXbAT1Usor/z6G
         AeiQKFJ7RgCxdKN2UDsZU4TtCJVDEEIcqe2AEDYNhsowKNgw2FCfjW4gGbugRTVZ/DRN
         ifhDGJgrfrxNqbp6jXu9tzbfsp5anN6s1GqT+9CmZhhEGz6Hj7Jb1eBKXhusvshYU8lx
         PpaWSDq0U2koMRtE1KFZ0kLdLzCXIXzh+0lZ9+1zLEJYOFTE2ZQ1y+vcvwJPIKb0jdWP
         YgVw==
X-Gm-Message-State: AOJu0Yws5TsiOkJTOLZXU1W5GOZDGoxATnKEQUyIW7wVpYnTHaZsHfhK
	t7ETqV1qAEpY6zc7xWrOwZ0c7uUjJzOsn7gzvPfrAj+HZpmIP1cClnxyehKGah6FeuokcrRYIne
	I20WacklMyRnxH5vpcQpLIFKZXTlcW8VophdWEkVu4cExd3cWJ0HFph63AoAASwZp3LYvOQ==
X-Gm-Gg: ATEYQzxj5dvjMrYMLby2ApY41rM6p9DpPlZdMlMpbr7ym1CwkcnMXr7t7S6Wz2Xg1Hz
	o3q9p9vAuGWQE3wqhnYAuq0xq2+l+D886kdACP/MZRsFBkPoFnFG/ydYIge7joQWF8qPfg2u0ZY
	xozBZg8v/QHYWu569UeDENOeorgnZIsOM8uL/SI0RfV/ZoxZLqkhA4FSE2U6GuxZAU9kDO4sRj2
	Byz+UYWzYa/ClFTGsZ+x6NtS8/kVAKwjXTPyIp/dFHp2OwgMtrNs4YwASdYYFSRVGcga7bA8qaP
	6uyzUDfhtH78xCRzqBkhx0O+lcBmQ/PyUJkEwSRJITSlo3XDsnb1m524+vt6cPwrXeCOnvrIegg
	NHaMJVlpXsuqPMgtAMw==
X-Received: by 2002:a17:90b:528c:b0:35d:a0b7:9608 with SMTP id 98e67ed59e1d1-35dc6e7b1d8mr681938a91.7.1774990166061;
        Tue, 31 Mar 2026 13:49:26 -0700 (PDT)
X-Received: by 2002:a17:90b:528c:b0:35d:a0b7:9608 with SMTP id 98e67ed59e1d1-35dc6e7b1d8mr681917a91.7.1774990165529;
        Tue, 31 Mar 2026 13:49:25 -0700 (PDT)
Received: from doltdoltdolt ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe5e5127sm3440619a91.1.2026.03.31.13.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 13:49:25 -0700 (PDT)
Date: Wed, 1 Apr 2026 04:49:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: add kernel commit IDs for patches already
 merged upstream
Message-ID: <20260331204920.o3cbcjt2ezx7uhim@doltdoltdolt>
References: <63eb507011e1ab2681a8aaa68ec1214896c05b55.1774966392.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63eb507011e1ab2681a8aaa68ec1214896c05b55.1774966392.git.fdmanana@suse.com>

On Tue, Mar 31, 2026 at 03:15:10PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Several tests mention patches that are already in Linus' git tree, so add
> their commit IDs. For generic/762, also use "fixed_by_fs_commit xfs"
> instead of "_fixed_by_git_commit kernel" since it's a XFS specific commit
> and it does not make sense for the test to report that commit in case it
> fails when running against a filesystem other than XFS.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Thanks for this updating, Filipe :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/340   | 2 +-
>  tests/btrfs/345   | 2 +-
>  tests/btrfs/346   | 2 +-
>  tests/btrfs/347   | 2 +-
>  tests/generic/762 | 2 +-
>  tests/generic/789 | 2 +-
>  tests/generic/790 | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/btrfs/340 b/tests/btrfs/340
> index fc3b8d62..872f790c 100755
> --- a/tests/btrfs/340
> +++ b/tests/btrfs/340
> @@ -10,7 +10,7 @@
>  . ./common/preamble
>  _begin_fstest auto quick qgroup
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 68d4b3fa18d7 \
>  	"btrfs: qgroup: update all parent qgroups when doing quick inherit"
>  
>  # For the automatic fsck at unmount.
> diff --git a/tests/btrfs/345 b/tests/btrfs/345
> index 75cc3067..58727049 100755
> --- a/tests/btrfs/345
> +++ b/tests/btrfs/345
> @@ -17,7 +17,7 @@ _require_scratch
>  _require_btrfs_support_sectorsize 4096
>  _require_btrfs_command "property"
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit e1b18b959025 \
>  	"btrfs: fix transaction abort when snapshotting received subvolumes"
>  
>  # Use a 4K node/leaf size to make the test faster.
> diff --git a/tests/btrfs/346 b/tests/btrfs/346
> index ef301ef7..28c1e536 100755
> --- a/tests/btrfs/346
> +++ b/tests/btrfs/346
> @@ -14,7 +14,7 @@ _begin_fstest auto quick subvol
>  _require_scratch
>  _require_btrfs_support_sectorsize 4096
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 2d1ababdedd4 \
>  	"btrfs: fix transaction abort on file creation due to name hash collision"
>  
>  # Use a 4K node/leaf size to make the test faster and require less file names
> diff --git a/tests/btrfs/347 b/tests/btrfs/347
> index ebd53d97..9239e99a 100755
> --- a/tests/btrfs/347
> +++ b/tests/btrfs/347
> @@ -16,7 +16,7 @@ _require_test_program t_btrfs_received_uuid_ioctl
>  _require_scratch
>  _require_btrfs_support_sectorsize 4096
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 87f2c46003fc \
>  	"btrfs: fix transaction abort on set received ioctl due to item overflow"
>  
>  # Use a 4K node/leaf size to make the test faster.
> diff --git a/tests/generic/762 b/tests/generic/762
> index e3a01de8..bbaf5051 100755
> --- a/tests/generic/762
> +++ b/tests/generic/762
> @@ -10,7 +10,7 @@
>  . ./common/preamble
>  _begin_fstest auto quota prealloc
>  
> -_fixed_by_git_commit kernel XXXXXXXXXXXXXX \
> +_fixed_by_fs_commit xfs 4b8d867ca6e2 \
>  	"xfs: don't over-report free space or inodes in statvfs"
>  
>  . ./common/filter
> diff --git a/tests/generic/789 b/tests/generic/789
> index 1ed7a885..0e72966e 100755
> --- a/tests/generic/789
> +++ b/tests/generic/789
> @@ -24,7 +24,7 @@ _cleanup()
>  _require_scratch
>  _require_dm_target flakey
>  
> -_fixed_by_fs_commit btrfs xxxxxxxxxxxx \
> +_fixed_by_fs_commit btrfs 5254d4181add \
>  	"btrfs: fix zero size inode with non-zero size after log replay"
>  
>  _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> diff --git a/tests/generic/790 b/tests/generic/790
> index 9aa577f5..28f7faa2 100755
> --- a/tests/generic/790
> +++ b/tests/generic/790
> @@ -27,7 +27,7 @@ _cleanup()
>  _require_scratch
>  _require_dm_target flakey
>  
> -_fixed_by_fs_commit btrfs xxxxxxxxxxxx \
> +_fixed_by_fs_commit btrfs 9573a365ff9f \
>  	"btrfs: log new dentries when logging parent dir of a conflicting inode"
>  
>  _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> -- 
> 2.47.2
> 
> 

