Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85302140E5F
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637017; cv=none; b=j8jVlaXqw2SJkJlSWyMUwtVbNFsQV39CpLRoxsq43dE1yPm0MSozWbehdiPkb40Cih3sAmzYFZUXA99D67xIvJ+RKc2Hk2fk4HJhXYgF9CQNLMTSbioSBcFiGNpDsQcRNp+XQW55pnpOdzjm+ytz6sHorVz/P4UzB/eTSkYM1/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637017; c=relaxed/simple;
	bh=XPnrY8w26PlV2Q8RCCEDDRRLqoMCEhvCHkY8THm9Dhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQJA6mDlIaceWlvyhgW94YCbjKpNbQBTs0yyCTVcoKuWUkcLcMdtKMPHbYaXwbwQU6VWq6urOurvchpnA9SWvpXU4ZemsknP8bYybcYu5RPZfeamUBeUyBZN5HNXeBgb7gaJ6VWaeAPJUz7juribtjUnf/mnq3wbc5HAXSvgtpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYn+/jzJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYn+/jzJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741637010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uakVQJCzySOCijcVMdsByC12sKBD/ugHJsyA4B8eqjg=;
	b=XYn+/jzJCrwrXT+kyovFRGjsJJ1ryWzXhyVS/4CGh5PexF4hz63dS1x8IPGCCHSh1MDzwo
	5MhpKNHADgelNlYqiZvslq1DtrhGk5iqhAZ8CQCKDHO/dL3W3gZytJmz+ZMb7qQpvL891J
	CRhH7iFfFUHcXiLgVcDeNJ/NdFwaQXs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-EiiWKlzhMmKgS4Icqs78ug-1; Mon, 10 Mar 2025 16:03:29 -0400
X-MC-Unique: EiiWKlzhMmKgS4Icqs78ug-1
X-Mimecast-MFC-AGG-ID: EiiWKlzhMmKgS4Icqs78ug_1741637008
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-223a2770b75so83094935ad.1
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 13:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741637008; x=1742241808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uakVQJCzySOCijcVMdsByC12sKBD/ugHJsyA4B8eqjg=;
        b=iF8EYOvjGjfIpK/bGq8gYvxciC9mOyksJizVNLOo28vUXAdXw11cMhiBt6Ni+pB+W+
         t7gJoBJ7wqxbMS97q8pET+bMWANBVldMSzo0WDecjjvDhGSnXcJaR+9NeWVpmqcLF85b
         GL0z0N5mI92EioGHFG5+iQJAFAZtnVUgrsBCpXwniUoNVUnyofIGL5l50r0bjE5vnZFk
         k8GPwZ+mWhgWGT9Qchy0HvqFlphGsjxWNbV9OqSMxka1i7SuSlqOEVCfSuRaI8rVVeZ2
         pP9wBasgyI3bBwaJYBBC9UVAnaMXAJDSPEM/iGWxlcwbRn1X+Ixl9hflDLWqc1SHnQOF
         KbGA==
X-Forwarded-Encrypted: i=1; AJvYcCUggCnSrhnLWzso7dgPR7A6SX9JV5EgXhpHCrx4I2hlJ+/MmpplWZokn5wkfnygJ72xOfz2XVWr@vger.kernel.org
X-Gm-Message-State: AOJu0YwsiUGmmo5z+H5Sw2fgiJmGe59eIeN2E55xqht7q0zAYznmpO4O
	54FGysWuGOPsfjcvhrTzPuKgaBcsx8BiMU7dut4jPZZIksv/PueiSEIGAaVZ9bG9d+DkLHurkAM
	MgOCGqCK1okRe0NQKbJkW8Ef9I4nrrg/JUgPtnVBYGywxp/4RrBM0vI0=
X-Gm-Gg: ASbGncuLZf0M5SjCJzcHSRsCey4THZf7gQRIwFfkY57XafKa7WyKvbIIavKm38vhtgz
	yJr9YbQ4hj0V2D86vW0vubJKqO12e4waoN5k5JFC/sJnaQAxJPViPQuX1ekF+VOEBMVruyH4Y59
	0CcjXhHBVmDhKACRyrczEW/xvuqQ3vIsRzUcLFwR9XFjPAks3dECV2wuyXkhFdwqBtWzdbhSAVU
	H98xYr4nXqxvcvVO7/0YkSkBC/0V4WOd443rks9vSTNA6tW+oHa2xN3O0hKGGURgE8ZR7wKyfd1
	IbK0YPKsVX8/bP2qZuYcUBFWUN3MUz75gigKjwQ18aLp0lIxdR6x1rN9
X-Received: by 2002:a17:903:32c6:b0:224:13c0:58e3 with SMTP id d9443c01a7336-22428bf1976mr198870415ad.51.1741637008525;
        Mon, 10 Mar 2025 13:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHdP3lhkvO4vv1v0uqKE6VKOKrmQ5TN8oJrfPJ8ZypUYZSMUOGOmUKXlyfH5/KX2KJQg/5Cw==
X-Received: by 2002:a17:903:32c6:b0:224:13c0:58e3 with SMTP id d9443c01a7336-22428bf1976mr198870135ad.51.1741637008095;
        Mon, 10 Mar 2025 13:03:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa5eedsm82871265ad.236.2025.03.10.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:03:27 -0700 (PDT)
Date: Tue, 11 Mar 2025 04:03:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 4/4] f2fs/009: detect and repair nlink corruption
Message-ID: <20250310200323.fl647x67kxe6r7xe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250310115621.3441518-1-chao@kernel.org>
 <20250310115621.3441518-4-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310115621.3441518-4-chao@kernel.org>

On Mon, Mar 10, 2025 at 07:56:21PM +0800, Chao Yu wrote:
> This is a regression test to check whether fsck can handle corrupted
> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> and expects fsck.f2fs can detect such corruption and do the repair.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - make _scratch_mkfs() to format f2fs image forcely
> - adjust _check_scratch_fs() to allow specified parameter of f2fs
> - add _fixed_by_git_commit
> - add _require_command inject.f2fs
> - simply return value handling
>  common/rc          |   9 ++-
>  tests/f2fs/009     | 133 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/009.out |   2 +
>  3 files changed, 143 insertions(+), 1 deletion(-)
>  create mode 100755 tests/f2fs/009
>  create mode 100644 tests/f2fs/009.out
> 
> diff --git a/common/rc b/common/rc
> index bf24da4e..e156f3af 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -993,7 +993,7 @@ _scratch_mkfs()
>  		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
>  		;;
>  	f2fs)
> -		mkfs_cmd="$MKFS_F2FS_PROG"
> +		mkfs_cmd="$MKFS_F2FS_PROG -f"
>  		mkfs_filter="cat"
>  		;;
>  	ocfs2)
> @@ -3682,6 +3682,13 @@ _check_scratch_fs()
>      ubifs)
>  	# there is no fsck program for ubifs yet
>  	;;
> +    f2fs)
> +        if [ "$FSCK_OPTIONS" == "--dry-run" ]; then
> +            fsck -t $FSTYP $device -- $FSCK_OPTIONS >> $seqres.full 2>&1
> +        else
> +            _check_generic_filesystem $device
> +        fi

If the "--dry-run" of fsck.f2fs is similar with "-n -y" of fsck.ext4. Then
you might need to change the fsck_opts() function in common/config.

  _fsck_opts()
  {
        case $FSTYP in
        ext2|ext3|ext4)
                export FSCK_OPTIONS="-nf"
                ;;
        reiser*)
                export FSCK_OPTIONS="--yes"
                ;;
        f2fs)
                export FSCK_OPTIONS=""
                ;;
	...
  }

The default FSCK_OPTIONS for f2fs should be "--dry-run".
        f2fs)
                export FSCK_OPTIONS="--dry-run"

Then ...

[snip]

> +	$F2FS_INJECT_PROG --node --mb i_links --nid $ino --val $nlink $SCRATCH_DEV \
> +		>> $seqres.full || _fail "fail to inject"
> +
> +	export FSCK_OPTIONS="--dry-run"

... then you can save this export FSCK_OPTIONS="--dry-run". I've explained
more in your v1 patch review, refer to:

https://lore.kernel.org/fstests/20250310194818.wki325qreuta26nc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#u

Thanks,
Zorro

> +	_check_scratch_fs >>$seqres.full 2>&1 && _fail "can't find corruption"
> +	_repair_scratch_fs >> $seqres.full
> +	_check_scratch_fs
> +
> +	_scratch_mount
> +	_scratch_unmount
> +done
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/009.out b/tests/f2fs/009.out
> new file mode 100644
> index 00000000..7e977155
> --- /dev/null
> +++ b/tests/f2fs/009.out
> @@ -0,0 +1,2 @@
> +QA output created by 009
> +Silence is golden
> -- 
> 2.48.1
> 

