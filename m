Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B851DFF8
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145904; cv=none; b=lJnQWJMhtWdLhuxpZV5wQmlNZhOYbw4m/1teM8eGG6O32SiAGr2/dOIrgpg0sXa9HFz6bCCI0C6Ud9HjdS4DTbPQjdf7KFpQjSr5NbyIDYp8jW+qLfQvAPW3O/k239R5zo8tRptopQ5yOmtvZ85nXzHG1H/lhepH4GrWFpFSkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145904; c=relaxed/simple;
	bh=0J9chlP5tDg8YEyWbh7M3smk/tq+nOwbobfR8qPBNqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZWOFwi/tHcdCNeow2P+oBSEw5yNnY16hptQCHrqpwOkjX69cWrKooU+8oGjB+8xh4y9xAxqSzjJTwyYgW8+34EyewxAHu2x9HIwESZ9eyHFx7XV2gu1rgPEMGEqlmw/PdfwcMN9Nqz+r9oHX2tBCHZEde7hf/WBPpVfw5RbQQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JE/QcFGZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE/QcFGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749145899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IpwJtqPomB8YxZ1KT/uYnIZYN4FYMqOD3S9Ak+nbpA=;
	b=JE/QcFGZilJ0cLa5ddGv/NqRpkD11NYONYjNyKf80TyVeZeDb91J7jPCSF2opi7EAK2GJ1
	zCTXxIVgcPB2FqcBeyeYGsVt3OD2ndkBor3siMr5wDxapsLH6vE+Q70FAfVNIZH8JZE2CG
	IDjpRfYABV6G8GTiAKHpROc/7PrV6RU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-f2Pwvx-CP-ag_m4mTXDwpw-1; Thu, 05 Jun 2025 13:51:37 -0400
X-MC-Unique: f2Pwvx-CP-ag_m4mTXDwpw-1
X-Mimecast-MFC-AGG-ID: f2Pwvx-CP-ag_m4mTXDwpw_1749145895
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235e3f93687so18402285ad.2
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 10:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749145895; x=1749750695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IpwJtqPomB8YxZ1KT/uYnIZYN4FYMqOD3S9Ak+nbpA=;
        b=EqhGKa+VWBfKIepsicGSBL+YFXClVVWBw2OJVf3caTLQ8no+8mNZwZjziLuXVcx7u2
         6yaYWhbzJXxq0ETm/P3Og9bfapIGGeL1hw5VfKWXaEXtsm+VdStYurB78lvE7NSgQ6QQ
         h2q9W/YRNQml2iIR1gbVqLW3U6e59Yu53gioIqqyhbT6Bpnw9P0oa3VpvEtnYdGFuPGj
         BqDCWOMlKJH3M/7/13/u9jwEJwDVP6BvnBCUUmtqXBENmcae8r6XwxB/yjHl3qgSOCcE
         RmKCg3yEv9TOjQ8Bp4xhyQl/ImxBg3SaQzaSQB66cqlG1HrrO2TWKIBoDzPmJv5JB60H
         9gvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq8FyAYI8KBrdC3t7ITUtegurQmxThThMd3Yh25IlaRFSUmDQAxwIBru9Wf7C3YowMPwUUWzqp@vger.kernel.org
X-Gm-Message-State: AOJu0YyiuxBBxhM1yhvTFO2bMe5xCeg9Lp0DAhBLUQJv2eBQfhUOWrQb
	zs7NH9CqhpkE5mdOCgNILI6w3k1IGbqA/uMb7fteLREITvPLEVjZ+khbj9dH1EzelhdSTPpUZ0X
	QpzwC1bhPyrL0xOucRqkxydG4ST4iFBnsWOFJ9GFJ8c69dNkhN0Hpr+EKsvQ=
X-Gm-Gg: ASbGncsanZiOojjzqvIS97d8vqrDkSdkK+wBlyzCDrNM0PT/HqxfjEb+jls77oLzr9T
	D/Fq1LhUyi/KqpbK9ttme5VsyHrSLMTAdSbzX0sKPBv4m+UZAmN/WhTgiPYYYt7UkwNZrNnzfIB
	+m9d9JoVzvGmhDEfx2N0T/XokOVfU+fqPNobWTHM+f8d51brNp0m0t2nJSYXtUiO0gztFq84RWv
	jpUpxOdQ56XvrjE8yBKFfnCoI3pBdrYD7CL4oRh/QLrgTxaBP+l6cYQl1IJUdnlO3mILkESClra
	1qSTOwHddc/LFAb7VxEenbeYRQuFG/roZJE3FmtXVX7eLiZ3aw7ZdM+hTvjSNvA=
X-Received: by 2002:a17:903:2450:b0:235:cbcb:48b7 with SMTP id d9443c01a7336-23601d71149mr3693585ad.34.1749145895242;
        Thu, 05 Jun 2025 10:51:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz1HOmtlmXTiVqSyNhQCCc3bRAxq/KZSlTjgwMDukMGwOL1j4gDyin5NheDuIMZk9fKjzD2Q==
X-Received: by 2002:a17:903:2450:b0:235:cbcb:48b7 with SMTP id d9443c01a7336-23601d71149mr3693105ad.34.1749145894652;
        Thu, 05 Jun 2025 10:51:34 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14cbdsm122350395ad.221.2025.06.05.10.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:51:34 -0700 (PDT)
Date: Fri, 6 Jun 2025 01:51:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org,
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2 1/6] overlay: workaround libmount failure to remount,ro
Message-ID: <20250605175129.oqqzr5qluxv52m6b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603100745.2022891-1-amir73il@gmail.com>
 <20250603100745.2022891-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603100745.2022891-2-amir73il@gmail.com>

On Tue, Jun 03, 2025 at 12:07:40PM +0200, Amir Goldstein wrote:
> libmount >= v1.39 calls several unneeded fsconfig() calls to reconfigure
> lowerdir/upperdir when user requests only -o remount,ro.
> 
> Those calls fail because overlayfs does not allow making any config
> changes with new mount api, besides MS_RDONLY.
> 
> We workaround this problem with --options-mode ignore.
> 
> Reported-by: André Almeida <andrealmeid@igalia.com>
> Suggested-by: Karel Zak <kzak@redhat.com>
> Link: https://lore.kernel.org/linux-fsdevel/20250521-ovl_ro-v1-1-2350b1493d94@igalia.com/
> Link: https://lore.kernel.org/fstests/CAJfpegtJ3SDKmC80B4AfWiC3JmtWdW2+78fRZVtsuhe-wSRPvg@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Changes since v1 [1]:
> - Change workaround from LIBMOUNT_FORCE_MOUNT2 to --options-mode=ignore
> 
> [1] https://lore.kernel.org/fstests/20250526143500.1520660-1-amir73il@gmail.com/

I'm not sure if I understand clearly. Does overlay list are fixing this issue
on kernel side, then providing a workaround to fstests to avoid the issue be
triggered too?

Thanks,
Zorro

> 
>  common/overlay    | 5 ++++-
>  tests/overlay/035 | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/common/overlay b/common/overlay
> index 01b6622f..0fad6e70 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -127,7 +127,10 @@ _overlay_base_scratch_mount()
>  _overlay_scratch_mount()
>  {
>  	if echo "$*" | grep -q remount; then
> -		$MOUNT_PROG $SCRATCH_MNT $*
> +		# By default, libmount merges remount options with old mount options.
> +		# overlayfs does not support re-configuring the same mount options.
> +		# We workaround this problem with --options-mode ignore.
> +		$MOUNT_PROG $SCRATCH_MNT --options-mode ignore $*
>  		return
>  	fi
>  
> diff --git a/tests/overlay/035 b/tests/overlay/035
> index 0b3257c4..2a4df99a 100755
> --- a/tests/overlay/035
> +++ b/tests/overlay/035
> @@ -42,7 +42,7 @@ mkdir -p $lowerdir1 $lowerdir2 $upperdir $workdir
>  # Verify that overlay is mounted read-only and that it cannot be remounted rw.
>  _overlay_scratch_mount_opts -o"lowerdir=$lowerdir2:$lowerdir1"
>  touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
> -$MOUNT_PROG -o remount,rw $SCRATCH_MNT 2>&1 | _filter_ro_mount
> +_scratch_remount rw 2>&1 | _filter_ro_mount
>  $UMOUNT_PROG $SCRATCH_MNT
>  
>  # Make workdir immutable to prevent workdir re-create on mount
> -- 
> 2.34.1
> 

