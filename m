Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA220C49C
	for <fstests@vger.kernel.org>; Tue, 18 Mar 2025 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304242; cv=none; b=U69a2ShV47m/4OovQ0ed8zkKy2nyKyB7ZRb11QpIsCUoYoxWum3vzlHmRRaKKpHAs/uWWrP/KtnJnVBb4UtCY7aAHu1hKBx0IhyBYahl5XkuVQTiXxGtcSggLu/zk4dTRY2kZn4KImJ/Gu+Vf3vkO1FbNJQCmIdLgg8O06D4ewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304242; c=relaxed/simple;
	bh=wx/fVud7EVv4gpynrfw6VCmEvp90zo4OUycjHe7drcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOZ2YdWY4iQCcOhaqxrUOiz87HY0H2cRh4vsn/+LNpqm2kZ3Es1t4IH4bO8AQtFxtToooAbdVxRMmumN45TP1izMbkST1caI/x5WRXgiXASxOyJ1pz2OXCHGd9rJEFWtuEIXhvfdpgtZlncOf9jTdBJQSt+vWymikyyNeo8u3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRqVnJKj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRqVnJKj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742304236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MInt3qHY6u1/lq/9wcYWTPZxmcqRecEfDud/ND5Sj5A=;
	b=RRqVnJKj8A3P84rxxBnwLBHIW39yAwIDrYgJ0mEvwtJJYSZL+plSQUF5UGcshwpgzpureI
	UvxCV3TKslSeU6KbRfhlZGlOsjiP+bgBUjmp8k0B7jJEAanyjIkK+J0+SZFbJ0/TF9KB2t
	dZlzOKcUEA2DuPiVZKgGIZxQo18RSzY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-vBXWuaBxM4C3omWq90atwQ-1; Tue, 18 Mar 2025 09:23:54 -0400
X-MC-Unique: vBXWuaBxM4C3omWq90atwQ-1
X-Mimecast-MFC-AGG-ID: vBXWuaBxM4C3omWq90atwQ_1742304233
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-223fd6e9408so84538595ad.1
        for <fstests@vger.kernel.org>; Tue, 18 Mar 2025 06:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742304233; x=1742909033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MInt3qHY6u1/lq/9wcYWTPZxmcqRecEfDud/ND5Sj5A=;
        b=uDIgwruzJV0vWp/lbqo05JKN1+VJcbx1IgCj0OaNmQU88kolvQ9EVbeMh/KODsUu+U
         coTX4fIubZoqTCuLOkRkX6dYpTaRUWGd292ZfuBVnwT84N6CwesF61d8hZzsnjQm8HVL
         z2LZh0WvDVZpY10JhfcVQlf7PlEilAvnm8eVN/w37liOcJBrMS5/JCF6dew4/twcHy7P
         hYmK8mdMDGcySCH+UC8wywOxJO9KNfpkt1snIYXO+tf8fdLSCl4rGKpfHd9jgwLVxG1r
         zaVUeGQMLqAUbrBHVBcIEQ0xHCIiNeyuhBNB5RQPOblsNWfk8HCtDHAQ4dOfP3VdmKjj
         vOdw==
X-Gm-Message-State: AOJu0Yx05PHPQ9oOUol0TWflXReVnyo8GiY+HMq1gfiqDL+cle/L3jQb
	RFOYL1W7G6pHGbE9xJv4rdgMAfg7NzvR3MLjnr5LdgusavUMw2plgywvHuzGdoMCyNLEFhMQG5O
	WnfqokCGAN0hT3xn1IJWwKDtotYb5NxJ3WzzNoTke7ahy1Ny6LVQwyA3+rX6S9Q0lEOxSgnUjUD
	bP9I8UTTBGBSaBke3boCWcQbV3DyP3PL1O2cCfpQ==
X-Gm-Gg: ASbGncsfTyDKYoZSXsVDuKpDMPkuD4OKKFMmcT4D2/kq1xKBU6zQ72ThQWp3Z+bMKAi
	yO7ZEtwNQlmpfzDa7DrM5bw2pUZwsayYOBZjfuGoA77tAqqog1j0J2jJln2Xqdpj8moRUEqaoA/
	t51N4HGglKNTAlZlaccZ1VhfOALMFtXGQz/AVTVTn06wWGWaXp49y7yKutxUtIf7rqWnyFC+1tn
	/U+KANC0bcyWb+wGWCi4nQoYOx0CQ4mXHt3kT9RUZTKAt9NhGP10anAIpxbGvoIaUJLiAFOGfXi
	QSElo+oRe48srlcO7O5RBPtMbSjmGCiAsBBGlXGxuR51XfPdJ9vUQIqv
X-Received: by 2002:a05:6a00:3d02:b0:736:491b:5370 with SMTP id d2e1a72fcca58-737577f96dbmr4577728b3a.10.1742304233201;
        Tue, 18 Mar 2025 06:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi2PKqn+u7uwlB1HAZQO6mgRbpZH1pJXsZBUEcGQdmmf0L4NMymc9mxJrLt2j533HHWoxF/g==
X-Received: by 2002:a05:6a00:3d02:b0:736:491b:5370 with SMTP id d2e1a72fcca58-737577f96dbmr4577674b3a.10.1742304232597;
        Tue, 18 Mar 2025 06:23:52 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af594eb973dsm5827348a12.19.2025.03.18.06.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:23:52 -0700 (PDT)
Date: Tue, 18 Mar 2025 21:23:49 +0800
From: Zorro Lang <zlang@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: Re: [PATCH] common/rc: explicitly test for engine availability in
 _require_fio
Message-ID: <20250318132349.7cbdobk5cy5v7b4x@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250318100848.114915-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318100848.114915-1-zlang@kernel.org>

On Tue, Mar 18, 2025 at 06:08:48PM +0800, Zorro Lang wrote:
> From: Eric Sandeen <sandeen@sandeen.net>
> 
> The current test in _require_fio (--warnings-fatal --showcmd) does not
> fail if an invalid/unavailable io engine is specified.
> 
> Add an explicit test that every requested io engine in the job file
> is actually available.
> 
> Also, remove the "ioe_e4defrag" entries in the [global] stanza of several
> ext4 tests which use fio jobfiles. While ioengines can be set in the
> [global] section, they can also be overridden in individual, subsequent
> stanzas. In each affected test (ext4/301, ext4/302, ext4/303, and
> ext4/304) every individual stanza after [global]re-specifies an ioengine;
> either with ioengine=e4defrag or ioengine=libaio.
> 
> Because of this re-specification, the ioengine in the [global] section
> is ignored. This is a good thing, because ioe_e4defrag is not a valid
> ioengine, and would fail this new hand-rolled check, even though fio
> did not complain.
> 
> So rather than over-complicate this new check, simply remove the unused,
> invalid "ioengine=ioe_e4defrag" lines in these tests.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---

Please ignore this patch, I send wrong commit...

Thanks,
Zorro

>  common/rc      | 7 +++++++
>  tests/ext4/301 | 1 -
>  tests/ext4/302 | 1 -
>  tests/ext4/303 | 1 -
>  tests/ext4/304 | 1 -
>  5 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index dcdfa86e4..e51686389 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3985,12 +3985,19 @@ _require_scratch_dev_pool_equal_size()
>  _require_fio()
>  {
>  	local job=$1
> +	local eng
>  
>  	_require_command "$FIO_PROG" fio
>  	if [ -z "$1" ]; then
>  		return 1;
>  	fi
>  
> +	# Explicitly check for every ioengine listed in the job
> +	for eng in `sed -n "s/ioengine=\(.*\)/\1/p" $job | sort -u`; do
> +		grep -wq $eng <($FIO_PROG --enghelp 2>/dev/null) || \
> +			_notrun "fio engine $eng not available"
> +	done
> +
>  	$FIO_PROG --warnings-fatal --showcmd $job >> $seqres.full 2>&1
>  	[ $? -eq 0 ] || _notrun "$FIO_PROG too old, see $seqres.full"
>  }
> diff --git a/tests/ext4/301 b/tests/ext4/301
> index abf47d4b7..a05b8e8a8 100755
> --- a/tests/ext4/301
> +++ b/tests/ext4/301
> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
>  cat >$fio_config <<EOF
>  # Common e4defrag regression tests
>  [global]
> -ioengine=ioe_e4defrag
>  iodepth=1
>  directory=${SCRATCH_MNT}
>  filesize=${FILE_SIZE}
> diff --git a/tests/ext4/302 b/tests/ext4/302
> index 87820184e..e0f5f2f98 100755
> --- a/tests/ext4/302
> +++ b/tests/ext4/302
> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
>  cat >$fio_config <<EOF
>  # Common e4defrag regression tests
>  [global]
> -ioengine=ioe_e4defrag
>  iodepth=1
>  directory=${SCRATCH_MNT}
>  filesize=${FILE_SIZE}
> diff --git a/tests/ext4/303 b/tests/ext4/303
> index 2381f0477..0a83e86cd 100755
> --- a/tests/ext4/303
> +++ b/tests/ext4/303
> @@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (3+1))))
>  cat >$fio_config <<EOF
>  # Common e4defrag regression tests
>  [global]
> -ioengine=ioe_e4defrag
>  iodepth=1
>  directory=${SCRATCH_MNT}
>  filesize=${FILE_SIZE}
> diff --git a/tests/ext4/304 b/tests/ext4/304
> index 53b522ee8..5f2ae4bdc 100755
> --- a/tests/ext4/304
> +++ b/tests/ext4/304
> @@ -32,7 +32,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
>  cat >$fio_config <<EOF
>  # Common e4defrag regression tests
>  [global]
> -ioengine=ioe_e4defrag
>  iodepth=1
>  directory=${SCRATCH_MNT}
>  filesize=${FILE_SIZE}
> -- 
> 2.47.1
> 
> 

