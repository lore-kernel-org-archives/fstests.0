Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25C129A7E
	for <fstests@vger.kernel.org>; Mon,  5 Feb 2024 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163485; cv=none; b=OAK9Di59Nw7WgJRBv+nWGEaI19ZzLF9KVNPHYfl//hvMe2W5XmXU9/y2hfJnnn5LZO2XEODzf+uvW+vTIqMutWOVWymIa6pRzjLVfadVXhXSYwmHAlzoGfVGNM1ELuxr6+ckoGWwvcZ3oD33nGmZ7/KZcp02Dz3fdfh7fflFtro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163485; c=relaxed/simple;
	bh=FHedRLWfq+EkeJutb9HV8n+j25cLRDrzQgWc2pceBjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnLBcG0OSs05lq4F3TQ7RvYXJq69JG+Ky+3TeXveC5SMtTNlPkTVXpIZUfBjRxTFbDwI6Rr9dNn/E4p5RT5bWhhMwE+0L2RSUvWL9PRpkcRBiMeb6NRx89q5VkeGOPTBeD+GvXdm6FqYCnN14LkOLj5+Y5vChmJ5P2VCKXRfOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqNl4bQn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqNl4bQn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707163482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWVg255ZVV9Nq8B7VrBXizTrOwGM+r2C5HvQoijmC5c=;
	b=bqNl4bQn9sEZhC/hCjQqzffyqJpZoaBzGCNQbw35fjlTDnG2vmyoBYSJdtWbnaI2J7esFG
	+/rAfjeM+C643LEbis5rp4dN5pGKzD03Z3f2XE7zLK2c14mLbZQJCAGw/1TxLmftKfkDCB
	5uFMo8HkgmkNFqeAJ9japwj6OrBjxRk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-bLO_oDKuO9OZ_EpuQNgAvQ-1; Mon, 05 Feb 2024 15:04:39 -0500
X-MC-Unique: bLO_oDKuO9OZ_EpuQNgAvQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e04e162d4cso847900b3a.0
        for <fstests@vger.kernel.org>; Mon, 05 Feb 2024 12:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707163476; x=1707768276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWVg255ZVV9Nq8B7VrBXizTrOwGM+r2C5HvQoijmC5c=;
        b=Cc9r3oU9E1nfS4QdBdBwVDDf50nLmvdNmTBNHCeazEjjB2oB/9cjrlqsZGlQDT+Q9l
         hWlgutwN2sLy3IhWfyDwsGgfHyrrLGvrE7PRJkUh5r7FHZ0ijJbHkrfOOZVZho9upow1
         6GuOvjk01UuHB9cc63Y3zFXRNotG0dlxFUHi/9kw3GwBYVN5iHqg/JB1L4Mg+XiX0xWd
         GbKmAUWf+Ya1xMJDkTFmhMaugUOX4FjNwgn7wrvOBJNKU5jpapxCxQwC/RWKfzJbY3yD
         UC03tPc+8KGHQtBmvxeRQMMwHH60AmkJp+zMYIg7a3BUxkD2/huqE3y6tnKqe7/7YwX+
         cvQQ==
X-Gm-Message-State: AOJu0YzuR97xyZGS2pcYF1AZ33r1I1xAz7Z+lsRaQHlh/McyFxUBrI4I
	sJr+/IPPg3DUhnvVNkljLVbGBtSJS36PZNaiDNbujtRNtyb2Q/1vxB7pswDBXQ3I6PhhVlZyTdD
	JwzNDaLgPU1NyMtee3xXA3jsfuvUovaOtV0yCyPYkWA8u7JwTENrLiCM=
X-Received: by 2002:a05:6300:8085:b0:19e:39d4:284c with SMTP id ap5-20020a056300808500b0019e39d4284cmr603893pzc.29.1707163476339;
        Mon, 05 Feb 2024 12:04:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEh+8RgRnlGlbAxQoyd9qDzlJkUsuE0cQYI8jfa4DMRgcCbsbcHnPcWH/ZkaIf9Jah9Z+SfQ==
X-Received: by 2002:a05:6300:8085:b0:19e:39d4:284c with SMTP id ap5-20020a056300808500b0019e39d4284cmr603871pzc.29.1707163475910;
        Mon, 05 Feb 2024 12:04:35 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78554000000b006e0322f072asm262220pfn.35.2024.02.05.12.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:04:35 -0800 (PST)
Date: Tue, 6 Feb 2024 04:04:32 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] common/metadump: fix _cleanup_verify_metadump system
 destructor fleet
Message-ID: <20240205200432.3zrtyo45mlzfo47d@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240205175552.GJ6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205175552.GJ6188@frogsfrogsfrogs>

On Mon, Feb 05, 2024 at 09:55:52AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Zorro reported that the cleanup function in common/xfs_metadump_tests
> zapped one of his test machines because of a well known shell variable
> expansion + globbing footgun.  This can trigger when running fstests on
> older configurations where a test adds _cleanup_verify_metadump to the
> local _cleanup function but exits before calling _setup_verify_metadump
> to set XFS_METADUMP_IMG to a non-empty value.
> 
> Redesign the cleanup function to check for non-empty values of
> XFS_METADUMP_{FILE,IMG} before proceeding with the rm.  Change the
> globbed parameter of "rm -f $XFS_METADUMP_IMG*" to a for loop so that if
> the glob does not match any files, the loop variable will be set to a
> path that does not resolve anywhere.
> 
> Longer term maybe we ought to set -u or something.  Or figure out how to
> make the root filesystem readonly when we're running a test.
> 
> Reported-by: Zorro Lang <zlang@redhat.com>
> Link: https://lore.kernel.org/fstests/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> Fixes: 85c1e0f518 ("common: refactor metadump v1 and v2 tests")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Hi Darrick,

This change looks good to me, but I've reset the for-next branch,
remove the v2024.02.04 totally, to avoid it kills others' systems.
Now there's not v2024.02.04 release anymore, so you can resend a
V2 of:
  [PATCHSET] fstests: random fixes for v2024.01.14
or resend the:
  [PATCH 05/10] common: refactor metadump v1 and v2 tests
if you don't have more changes on others.

>  common/xfs_metadump_tests |   19 +++++++++++++++----

I saw you name this patch as common/metadump, if already have a patchset which
changes the common/xfs_metadump_tests to common/metadump, feel free to send to
me directly as V2 :)

Thanks,
Zorro

>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/common/xfs_metadump_tests b/common/xfs_metadump_tests
> index 5a5579b6b9..c8652f16ea 100644
> --- a/common/xfs_metadump_tests
> +++ b/common/xfs_metadump_tests
> @@ -15,12 +15,23 @@ _setup_verify_metadump()
>  
>  _cleanup_verify_metadump()
>  {
> +	local img
> +
>  	_scratch_unmount &>> $seqres.full
>  
> -	losetup -n -a -O BACK-FILE,NAME | grep "^$XFS_METADUMP_IMG" | while read backing ldev; do
> -		losetup -d "$ldev"
> -	done
> -	rm -f "$XFS_METADUMP_FILE" "$XFS_METADUMP_IMG"*
> +	test -n "$XFS_METADUMP_FILE" && rm -f "$XFS_METADUMP_FILE"
> +
> +	if [ -n "$XFS_METADUMP_IMG" ]; then
> +		losetup -n -a -O BACK-FILE,NAME | grep "^$XFS_METADUMP_IMG" | while read backing ldev; do
> +			losetup -d "$ldev"
> +		done
> +
> +		# Don't call rm directly with a globbed argument here to avoid
> +		# issues issues with variable expansions.
> +		for img in "$XFS_METADUMP_IMG"*; do
> +			test -e "$img" && rm -f "$img"
> +		done
> +	fi
>  }
>  
>  # Can xfs_metadump snapshot the fs metadata to a v1 metadump file?
> 

