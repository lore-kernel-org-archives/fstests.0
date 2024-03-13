Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE73F9D8
	for <fstests@vger.kernel.org>; Wed, 13 Mar 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340896; cv=none; b=Zn7E+l8FIrybXBqqGfH4pL2PPZTRuD+/KoL5n1yRxWs6/Ro887d+odFZxdzD2htUMzv917b4JYjodV0KnKECs5YkVYL3KVXwtegDgmmqOdtB5L0FLZo6ihlafXTK3IXqUBw0dzGriVuFhpOollxZAxL87bJBkmGVN1C56laLzX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340896; c=relaxed/simple;
	bh=jnxLycoHz4+VE8tt+3N42QLiFq3YOj8fC9Xir+iIqwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvQCNUA8BTeZT4NW2NGj3sO7GeJFk5fteQEnFMJ8jpbkJAbz1owty+nW7s9G4t+FOTctFhx2++o3ztqlQ82wi9gpylEERqj8yg05XRyOoB51mmnpEzqtDrXCSvWKotgiThevTS7O8+ou/vFva6uBrQWGzINMG0LZjBbQZ0R2Sak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibIdFjO6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibIdFjO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710340893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QAxdYfMVZ7obWsme/6RW48NcFPVYMqabsFQXS2eu+Z0=;
	b=ibIdFjO68cTRF4R4fp6AVcyD3bXjHSQfSZ0hxChCPIjhHYMGM8p6vmqS+MbLbFn9CUl3uJ
	7PeI1PeSR1xL4JgDUgFbwFL13R+PxdoKnJXG7RJ8pR0XE2QxYc8NvVbqJXIKos7Ov7pjEC
	q38Yj57o9F/0no7opUBrDfe9FwYFyzA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-PqKzGTMnMB6ZOfBmMQrBFg-1; Wed, 13 Mar 2024 10:41:32 -0400
X-MC-Unique: PqKzGTMnMB6ZOfBmMQrBFg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-22216b64ffeso2622767fac.2
        for <fstests@vger.kernel.org>; Wed, 13 Mar 2024 07:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710340891; x=1710945691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAxdYfMVZ7obWsme/6RW48NcFPVYMqabsFQXS2eu+Z0=;
        b=pZsQfcAWqYOJEPHubGKmdbsmDH9pTgBp5Wy1WH2KE3n4ubq6c4HvrKQ8prwbYHX0KA
         ArMVtIz/sCkq6qrf8QsXHc0iuwCT5gQgFAC6tjzuY6Raf600i7cMQa5M0+7p8U55HLCx
         WiR1eZta5EyV3IekkULqb+t0/pHpjrUA3C4yk2gVoIlIFrXXgc7vtXss3HUBx8y4jMnB
         6yqvTxYM7NV7X+Uss2QxWClEkhqlxK043tfgxP2GrAuXhnj9RSIbJBHRBoXhVs+P93/i
         QctLrfQFQmpHRvpflD0aqVd7kP0rnHrap0maPl3dm2aaClojcrnpnnk40q+JVSizLcFT
         0JJQ==
X-Gm-Message-State: AOJu0Yzm6A8KEDG1NNzNIL/rcXxjZaGZRYgK3gloCnISGcPWde6DGsPN
	QsRNyPeNoyx+EuL+LZUBh5jN7Aa/o7d+Y04SkEkLJDNptJC2VBlGdEDAW/TJaneYakzE4tVAYG3
	FlnE/cQn3tOEvOkAjjWzfQJoH51Vs6JgpEfbjM6F/DrDw6VpfEzL14so=
X-Received: by 2002:a05:6870:d1c9:b0:221:14e3:7f6e with SMTP id b9-20020a056870d1c900b0022114e37f6emr13880403oac.46.1710340891200;
        Wed, 13 Mar 2024 07:41:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO2ouw3nBpbigMVivdz0bUyw6AgoHMQkuM8vrXRJ1i2sYqF8DGA7GwTOQSbBDUna+tFs3Dvw==
X-Received: by 2002:a05:6870:d1c9:b0:221:14e3:7f6e with SMTP id b9-20020a056870d1c900b0022114e37f6emr13880382oac.46.1710340890834;
        Wed, 13 Mar 2024 07:41:30 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v22-20020a634656000000b005dccf9e3b74sm7703389pgk.92.2024.03.13.07.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:41:30 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:41:27 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: add missing kernel commit IDs to
 _fixed_by_kernel_commit() calls
Message-ID: <20240313144127.5etpc7ja33orjrf6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <d0c99b30b1f0b777375fa3512ff21b35d1d3a805.1710337140.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0c99b30b1f0b777375fa3512ff21b35d1d3a805.1710337140.git.fdmanana@suse.com>

On Wed, Mar 13, 2024 at 01:39:28PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some tests are still using a 'xxx...' commit ID but the respective patches
> were already merged to Linus' tree, so update them with the correct commit
> IDs and in one case update the subject as well, because it was modified
> after the test case was added and before being sent to Linus (btrfs/317).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/303 | 2 +-
>  tests/btrfs/309 | 2 +-
>  tests/btrfs/316 | 2 +-
>  tests/btrfs/317 | 4 ++--

Thanks for this updating. As you're doing this job, would you like
to help to update below line of *btrfs/249* by the way:

_fixed_by_git_commit btrfs-progs xxxxxxxxxxxx \
	"btrfs-progs: read fsid from the sysfs in device_is_seed"

And ... if would like to go a step further, you can change one more
line in generic/707 to:

_fixed_by_kernel_commit 0813299c586b \
	"ext4: Fix possible corruption when moving a directory"

Then I think you can change the subject of this patch to:

"fstests: fix missing commit IDs of _fixed_by_*_commit calls"

due to all current missing IDs in fstests will be fixed, don't need
one more other patch :)

Of course, with this change I'm glad to:

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> index 26bcfe41..ed3abcc1 100755
> --- a/tests/btrfs/303
> +++ b/tests/btrfs/303
> @@ -25,7 +25,7 @@ _require_test
>  _require_scratch
>  _require_xfs_io_command "fiemap"
>  
> -_fixed_by_kernel_commit XXXXXXXXXXXX \
> +_fixed_by_kernel_commit 5897710b28ca \
>  	"btrfs: send: don't issue unnecessary zero writes for trailing hole"
>  
>  send_files_dir=$TEST_DIR/btrfs-test-$seq
> diff --git a/tests/btrfs/309 b/tests/btrfs/309
> index 5cbcd223..d1eb953f 100755
> --- a/tests/btrfs/309
> +++ b/tests/btrfs/309
> @@ -12,7 +12,7 @@ _begin_fstest auto quick snapshot subvol
>  _supported_fs btrfs
>  _require_scratch
>  _require_test_program t_snapshot_deleted_subvolume
> -_fixed_by_kernel_commit XXXXXXXXXXXX \
> +_fixed_by_kernel_commit 7081929ab257 \
>  	"btrfs: don't abort filesystem when attempting to snapshot deleted subvolume"
>  
>  _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> diff --git a/tests/btrfs/316 b/tests/btrfs/316
> index 07a94334..f78a0235 100755
> --- a/tests/btrfs/316
> +++ b/tests/btrfs/316
> @@ -17,7 +17,7 @@ _begin_fstest auto quick qgroup
>  _supported_fs btrfs
>  _require_scratch
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit d139ded8b9cd \
>  	"btrfs: qgroup: always free reserved space for extent records"
>  
>  _scratch_mkfs >> $seqres.full
> diff --git a/tests/btrfs/317 b/tests/btrfs/317
> index 59686b72..b17ba584 100755
> --- a/tests/btrfs/317
> +++ b/tests/btrfs/317
> @@ -10,8 +10,8 @@
>  . ./common/preamble
>  _begin_fstest auto volume raid convert
>  
> -_fixed_by_kernel_commit XXXXXXXXXX \
> -	"btrfs: zoned: don't skip block group profile checks on conv zones"
> +_fixed_by_kernel_commit 5906333cc4af \
> +	"btrfs: zoned: don't skip block group profile checks on conventional zones"
>  
>  . common/filter.btrfs
>  
> -- 
> 2.43.0
> 
> 

