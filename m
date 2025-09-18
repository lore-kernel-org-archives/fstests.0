Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58721B905
	for <fstests@vger.kernel.org>; Thu, 18 Sep 2025 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212152; cv=none; b=ZvEtRW8qFf91xpERucUASX6KI7235PD/k1cuVtXmfz+6o+xhoH7iOgX0ai0Jl7i1b8WBRU0JfrXD2g0PTPjDYw5ak68tz2x0Bp/CdZeK/MMSd/AGDn4v1TNYsUi3ZItwqc0XPhhOlmagqQdU/3J0OmicuIkRoDq+lu1aAAwbmKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212152; c=relaxed/simple;
	bh=BBcXkF218h/n+sjdRsmTt/qgF2tdpx7WgyO2AZNvKaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWmj+vxHBOcN8Fu8JpNqUAdDLx8I4J7AQ+gSyt6L0Eot8juHB6i1FhLF4SJQucCHsxFQO6ZRfYkfFS/2LXk7dAjYxajc5gPGDsIUtWRaScyX01ypMl/SqAAn8IdEarcD3c4RELMbc7IuBgAtp2IbmaGJHrRY/mJ8GJCGzG2M0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCb5V1Xq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCb5V1Xq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758212149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHi0Djn9pjoeuw2kAszNHnpCYY5ix2jYe9lxD0wWsrY=;
	b=NCb5V1XqRNLJHbm9lpAU+wjkRQkFY6Fx67uXe09ZQW350nnBjG48G5C/Wh6ZJV1+GfulVn
	HxnBi9BwNe6i85rqNUQ2hCFuSPUYniYryl7cDSq8aZWQ8BjG7n8QcS4Lsm0TdZbx4BRnuT
	GN8xQA19o/rH4u/m2WJ3J1Pgednivw0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-hOvvFo9VOFiWdMKtws4u0w-1; Thu, 18 Sep 2025 12:15:48 -0400
X-MC-Unique: hOvvFo9VOFiWdMKtws4u0w-1
X-Mimecast-MFC-AGG-ID: hOvvFo9VOFiWdMKtws4u0w_1758212147
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55118e2d01so291021a12.1
        for <fstests@vger.kernel.org>; Thu, 18 Sep 2025 09:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212147; x=1758816947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHi0Djn9pjoeuw2kAszNHnpCYY5ix2jYe9lxD0wWsrY=;
        b=CTYAzU7A3Bn4NxK2M1zN/wu3riKcR2Tr3ovmV49AsOl/Ef8Qgdbqn52KeZiQ3G874p
         PgfBlUm6zKh4NTIOlxbWzd0GrnwrJHM5MklbXAkM56Gd15+UV9w6O/Q/qj9QgHbWeWwD
         vGDaUJXTsZEPMfqJ2/0a6d3iQZKLWF4RMfmkB4remk8wIMp2boZ1WWut9p+iN8+/HKrs
         Ozd7YzKIHydWbWMIo45HiQSVCwH7wBcGV6x3ejtN08WqqjhbtcHos5k0z00+gHsyc3OT
         b2xIA8YQ2RUQiLcYFAbtxk+ArccLziHm6gmF43wwA5aQkhTFbRMJiM9xblbAnHBmDLW6
         jSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+zKD0xkYTzQqzH0aC1nirP7y0lNL6JR+mhAST9Z+YQeS+NXTelrXDySJ6UyyXE0Ye2Huy2nz@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXLthlOUdUPEIolO2lI45L/1eor9PZRKvomFebPME3BbmZFM/
	W27D8a0tjtx3zMW20Yo02pgUf9F912N0uUO+SPb4VqjeIfDExZrGQLxw+hxg0/R5HD3kNAv5fAd
	GOc3lb2UVM4my0cPrRLQPSgNVgpOOuPBc42EeAOzroGTl8Wqck17nO8FKtS8=
X-Gm-Gg: ASbGnct5P9gbJRaR1+w2+RhArk4gvI2IdOB8j7udpUS2I680muP+qUvWzSKi65HNMxo
	4CSFFuGnfJb3MJoU3F7bE1j1gK9NS0KAaqzEBzh8YLLw4Z5LabP3RpfklaAqdE0W/fyCtjR6ccc
	11dNQpXWo24jN6iWkiPYCIBBJUEUhVRRcPmak026ZZn2ghX6Gi08hDG904b8tfXItZySX5+GYun
	4BfMfEs8gxuIhyQkM1n40OrPpesgwF80CTplnMW1G5AAwYGq9xkWXakmsOJCqBYvCSAQNGH2Mpx
	/E2e4NJkRs6Xshv1KqOne9nUJFT9etr+mvsumJ2b/AeS4TBa72VmsSjIooStJkS1zv54acwL03D
	Zbna9
X-Received: by 2002:a17:902:ef48:b0:248:6d1a:4304 with SMTP id d9443c01a7336-269ba50119amr1725405ad.38.1758212147232;
        Thu, 18 Sep 2025 09:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLU7pgjoAnL3Ri3kP/kIOmI3SEhjxxYClOXShBU7Aiqq9kw1kyHDtTZrQxJqAji3pow1cQGQ==
X-Received: by 2002:a17:902:ef48:b0:248:6d1a:4304 with SMTP id d9443c01a7336-269ba50119amr1724915ad.38.1758212146704;
        Thu, 18 Sep 2025 09:15:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980331eccsm29776065ad.123.2025.09.18.09.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:15:46 -0700 (PDT)
Date: Fri, 19 Sep 2025 00:15:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: reject fs block size larger than 4K
Message-ID: <20250918161542.a432gwgfzzbxz4rc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250918103226.99091-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918103226.99091-1-wqu@suse.com>

On Thu, Sep 18, 2025 at 08:02:26PM +0930, Qu Wenruo wrote:
> [BUG]
> When running the experimental block size > page support, the test case
> btrfs/192 fails with the following error:
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #287 SMP PREEMPT_DYNAMIC Thu Sep 18 16:42:54 ACST 2025
> MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
> btrfs/192 436s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//btrfs/192.out.bad)
>     --- tests/btrfs/192.out	2022-05-11 11:25:30.746666664 +0930
>     +++ /home/adam/xfstests/results//btrfs/192.out.bad	2025-09-18 18:34:10.511152624 +0930
>     @@ -1,2 +1,2 @@
>      QA output created by 192
>     -Silence is golden
>     +ERROR: illegal nodesize 4096 (smaller than 8192)
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/192.out /home/adam/xfstests/results//btrfs/192.out.bad'  to see the entire diff)
> 
> Please note that, btrfs bs > ps is still under development.
> This is only an early run to expose false alerts.
> 
> [CAUSE]
> The test case explicitly requires 4K nodesize to bump up tree size.
> 
> However if we use fs block size larger than 4K, the node size 4K will be
> smaller than a block, causing mkfs failure, as block size is the minimal
> unit for both data and metadata, thus node size smaller than block size
> is illege.
> 
> [FIX]
> Before calling mkfs on the log-writes dm device, do a simple mkfs and
> mount of the scratch device, to verify the block size.
> 
> If the block size is larger than 4k, skip the test case.
> 
> And since we're here, remove the out-of-date page size check, as btrfs
> has subpage block size support for a while.
> Instead use a more accurate supported sector size check.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add the commit message on why we can remove the page size check
> 
> - Use _scratch_btrfs_sectorsize() so we do not need to mount/unmount
>   scratch device
> 
> - Add the missing _require_btrfs_support_sectorsize call
> ---

Hi Qu,

As this patch only changes btrfs/192, so the subject is better to be
"btrfs/192: ....", due to "btrfs: ..." makes me think it changes lots
of btrfs cases, or it's a new btrfs case :)

Thanks for you fix many issues about "btrfs 4k sector and block size",
I saw you keep sending more patches about that, I think you're working
on this thing recently. Could you please put this patch and others
"btrfs/304~306" patches or more if you have in one patcheset. Then I'll
know you've done all you want, and I can merge them together :)

Thanks,
Zorro



>  tests/btrfs/192 | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/192 b/tests/btrfs/192
> index 0a8ab2c1..a9a43cfe 100755
> --- a/tests/btrfs/192
> +++ b/tests/btrfs/192
> @@ -33,10 +33,15 @@ _require_btrfs_mkfs_feature "no-holes"
>  _require_log_writes
>  _require_scratch
>  _require_attrs
> +_require_btrfs_support_sectorsize 4096
>  
> -# We require a 4K nodesize to ensure the test isn't too slow
> -if [ $(_get_page_size) -ne 4096 ]; then
> -	_notrun "This test doesn't support non-4K page size yet"
> +_scratch_mkfs > /dev/null
> +blksz=$(_scratch_btrfs_sectorsize $SCRATCH_MNT)
> +
> +# We need 4K nodesize, and if block size is larger than that mkfs will
> +# fail. So reject any block size larger than 4K.
> +if [ $blksz -gt 4096 ]; then
> +	_notrun "This test requires block size 4096, has $blksz"
>  fi
>  
>  runtime=30
> -- 
> 2.51.0
> 
> 

