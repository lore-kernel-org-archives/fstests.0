Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A18F4A
	for <fstests@vger.kernel.org>; Wed, 17 Apr 2024 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323805; cv=none; b=T2Zz+B3tpLwMSsJ+R4c2zJG15a9bL2/MkPDW23ohL1GLtn9ycQqYz6s+UctwC0khRjrQCB6OQfItPzshQT+5TNfSsFAOOgI8OtQNI4mIxEwrSmWc7MnyKeDaoHx75A9L+HrWLKLHWg+9Y70vTFNoCm06UTUePGtcCfX4PfXej/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323805; c=relaxed/simple;
	bh=goNnZszRXBLLlVgpzHK7Vjmqe+cgMPZY7MyIUwk0ANI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFp1ktwZI90mDi8SLaGKxgZJeDZb/evmwQa3OCaRn5XjSVIR34j+HLt1ipXdnGb+1UKrR8QTkn4eZp4LkuypXHFpxABdSUBCMBIFmMK4lPBB1/mcBQt0o60d4s9EWuHY+mO8XKzM+uOvo8lmTJqZRyZVst5jM7tUZN7m2bfjimQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFE5axbn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFE5axbn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713323802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nid1SGsDjBVi4vfnINteaorQ2WAwGabIOLIsBWDkZGk=;
	b=WFE5axbnzrn+nRqiKH4mn1EzPV4e9L2XqHiPRhuCEVCMBKjWf6z9eKAXc/tl0oKI3Haode
	BdfJPkDDF8ttuUeRBLIupTcrcWdKovMnGzwyKBZqNULJ4LS1p6OM70xXopnIhTBF/9x0EK
	aDhx7TOZ5f5aydE4h9kS6JcXAsJJJrY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-aWVdOlMKOEKNa7vMHeGR6A-1; Tue, 16 Apr 2024 23:16:39 -0400
X-MC-Unique: aWVdOlMKOEKNa7vMHeGR6A-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e3c8d7d87cso3460195ad.1
        for <fstests@vger.kernel.org>; Tue, 16 Apr 2024 20:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713323798; x=1713928598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nid1SGsDjBVi4vfnINteaorQ2WAwGabIOLIsBWDkZGk=;
        b=UMl+TXBwnqwe54oMEur9S2PXqeedokZEEHrcvURf87WhbQklvtH9CuOQ4fh8OP8MNs
         QIFLi2LEWgcnj+6dRyLr69wbfPrpB3ilaiEUUl7z91NjxyM14RrElg9kpj59UttoS+Z8
         1l1naBbbd0rxvWqKiD1s9x6jV4NYlbLcEOoY/ON+OHvCgF5LaFLgDnrNq0wINvW7p7Tw
         6Y8ZLFfF9vpnni3DjTyl470HJNDetCmnpOp1l0/VQKFGKZ/F8+BHIeN1gDjaf2vH5bZa
         m4cfI2bfP/9q5g8UU6Ggpvf3ogyd/dGdEMIYIg9aUrR7mbG8sXqfPryue0KfyUNARioh
         rtYA==
X-Gm-Message-State: AOJu0Ywv3tzy7zP1+amBzSNdHY5xCjrA7oF49i1Lwo5DG/xpWDOaGCw6
	4U2rhmKrUl1ybxc+1ML7wOmDkVJeUuqAcTra5jqUzjltiK8HCpyQ4wgkrKn6JVkOvlHtoeCLaaE
	VEU6F1liTVkNb98iIfMaJEb6QqFhRUm3B8v9MW9Ej+P8pP3Cwsnvatvw=
X-Received: by 2002:a17:902:a987:b0:1e5:a3b2:3da9 with SMTP id bh7-20020a170902a98700b001e5a3b23da9mr4104682plb.17.1713323797996;
        Tue, 16 Apr 2024 20:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRK6+pU2sdfdG+AF8eD73PL3wQrawl+MN5871gFXL371xA1tmtVwzZlYl3vCik72K7QtIFwA==
X-Received: by 2002:a17:902:a987:b0:1e5:a3b2:3da9 with SMTP id bh7-20020a170902a98700b001e5a3b23da9mr4104657plb.17.1713323797495;
        Tue, 16 Apr 2024 20:16:37 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001e3e0a8b32asm10486438plg.45.2024.04.16.20.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 20:16:37 -0700 (PDT)
Date: Wed, 17 Apr 2024 11:16:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] common/quota: update keywords of quota feature in
 _require_prjquota() for f2fs
Message-ID: <20240417031633.chckvd5ebnakmp7g@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240416101650.53078-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416101650.53078-1-chao@kernel.org>

On Tue, Apr 16, 2024 at 06:16:50PM +0800, Chao Yu wrote:
> Previously, in f2fs, sysfile quota feature has different name:
> - "quota" in mkfs.f2fs
> - and "quota_ino" in dump.f2fs
> 
> Now, it has unified the name to "quota" since commit 92cc5edeb7
> ("f2fs-tools: reuse feature_table to clean up print_sb_state()").
> 
> It needs to update keywords "quota" in _require_prjquota() for f2fs,
> Otherwise, quota testcase will fail as below.
> 
> generic/383 1s ... [not run] quota sysfile not enabled in this device /dev/vdc
> 
> This patch keeps keywords "quota_ino" in _require_prjquota() to
> keep compatibility for old f2fs-tools.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - keep keywords "quota_ino" for compatibility of old f2fs-tools
> suggested by Zorro Lang.

This version looks good to me, thanks

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/quota | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/quota b/common/quota
> index 6b529bf4..4c1d3dcd 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -145,7 +145,7 @@ _require_prjquota()
>      if [ "$FSTYP" == "f2fs" ]; then
>  	dump.f2fs $_dev 2>&1 | grep -qw project_quota
>  	[ $? -ne 0 ] && _notrun "Project quota not enabled in this device $_dev"
> -	dump.f2fs $_dev 2>&1 | grep -qw quota_ino
> +	dump.f2fs $_dev 2>&1 | grep -Eqw "quota|quota_ino"
>  	[ $? -ne 0 ] && _notrun "quota sysfile not enabled in this device $_dev"
>  	cat /sys/fs/f2fs/features/project_quota | grep -qw supported
>  	[ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
> -- 
> 2.40.1
> 

