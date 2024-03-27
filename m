Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE3D12D1FC
	for <fstests@vger.kernel.org>; Wed, 27 Mar 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546050; cv=none; b=oRWNrQ+Us/KlVM9OxNaUc5HJUGZ9VjV68m0YsbyEZKHottdcB/7O1IyPhEnCMEs3GCleR4kKOceSxs1z/HJNCbw5N9VRMhLR5xB2ohFigZPI74U7lmUL+eWWeVJUGKHNHWp1hPSrVFdSZOHhVzwebldKpTaJEiF+BGiApV8u1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546050; c=relaxed/simple;
	bh=HfgahgvGXb6kKpxemVxbpCsaZ1puwpYCPY0nfMLocYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ggo7fwFH8nMXCaYmYPW0cN4YRET2GSt7tPaxBzH8WsGJB7dVbyyLzjI8pyWypon1UIHhA7PEXJ4UxDUwGMhrXGGXbin6PSq3rXruV5CEUl01ET5C3TB+nrVzcrxsOw3IAY6DEuI2eJN5HqRurWlJULVK66vUx0epIUdYn5tddfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0JyY/a5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0JyY/a5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711546048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDzzAnUCMFqSXEwOWiY3MyGlH4eFtWfseKC3HFIpeSQ=;
	b=g0JyY/a5dQKOS/foiJtgfdUip1sTNurenK+ZSjMimE3oJTXhDoIbiY38o1dr9HwbRfaexp
	eda+plIJP8ECcZ8tRVdN2wrMxv4MV7Z4B1fu8XvAV1IufgKoOaPgNolYeBWM+3+4/AREx8
	ik3TO0gSZy9DraG8RojEmS4qzv8owpg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-ILbvWCBzMvei0V1MkoxZtw-1; Wed, 27 Mar 2024 09:27:26 -0400
X-MC-Unique: ILbvWCBzMvei0V1MkoxZtw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5ce67a3f275so4112979a12.0
        for <fstests@vger.kernel.org>; Wed, 27 Mar 2024 06:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711546045; x=1712150845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDzzAnUCMFqSXEwOWiY3MyGlH4eFtWfseKC3HFIpeSQ=;
        b=rH6Zokh3J2DP2rt83XGU7V3I3Wn4VWwzYS93GTW7T763UqAXifgtxT3Ss7JZePzw91
         kk7TT3zn4YH1aQIeakrCf23+0G381YCxcIB7wlHrnD9cto94RqBY2O6ekSsP/KdC0mHe
         hgoNvqElGa8lVrY3/7nCPzB6/qT0siqv8JBz/jpo6f9/IjP89XMttZ0iKyAw3obr6Y0L
         T5SBQzxa7NuhV4YDIkgT2kLAFGiCub43Zpkoig+mFavtXCLM1z09z5LINkyNRB/nEsP/
         ew+hdi9nGK1688qxis6RIVA0aGvBf4UbpUjpdz5Fv89knwXZbnm3NCguj62+xah+d3y1
         uByg==
X-Gm-Message-State: AOJu0YzNpkgkCiglmXZbd1o6xcBtlACWbT5VhlLCEHP35diLbY+Bm20L
	MSj7l6+esU4V+0SZkbYEsA7xrZMLD4TqM4pEjtx/o9LoqGewG9t4LYUIpU8pi+NPHoFLPYS5DGC
	bs+jj7pNFa0v0DyzM/dXMZFoSGmFA10Y+vWlTAzw+IWtn2FPGxF4l6mVvtH0UqK4XtA==
X-Received: by 2002:a17:903:943:b0:1e0:a2cf:62f2 with SMTP id ma3-20020a170903094300b001e0a2cf62f2mr2977421plb.23.1711546044947;
        Wed, 27 Mar 2024 06:27:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1GnhIPwUk+ljoL4ENuBLebluvjmFcB2I/tVOTgcAHBzTqXwQea22dNT4Zbs+/gKtzB5oy1Q==
X-Received: by 2002:a17:903:943:b0:1e0:a2cf:62f2 with SMTP id ma3-20020a170903094300b001e0a2cf62f2mr2977395plb.23.1711546044454;
        Wed, 27 Mar 2024 06:27:24 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001e20587b554sm541275plg.178.2024.03.27.06.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 06:27:23 -0700 (PDT)
Date: Wed, 27 Mar 2024 21:27:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: tjackson9431@gmail.com
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] vfs/idmapped_mounts.c: Change mount_setattr expected
 output
Message-ID: <20240327132720.afmraqz6jrfcefcm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240326-mount-setattr-test-v1-0-c061b040d0f7@gmail.com>
 <20240326-mount-setattr-test-v1-2-c061b040d0f7@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326-mount-setattr-test-v1-2-c061b040d0f7@gmail.com>

On Tue, Mar 26, 2024 at 08:33:52PM +0000, Taylor Jackson via B4 Relay wrote:
> From: Taylor Jackson <tjackson9431@gmail.com>
> 
> In kernel commit dacfd001eaf2 (“fs/mnt_idmapping.c: Return -EINVAL
> when no map is written”), the behavior of mount_setattr changed to
> return EINVAL when attempting to create an idmapped mount when using
> a user namespace with no mappings. The following commit updates the test
> to expect no mount to be created in that case. And since no mount is created,
> this commit also removes the check for overflow IDs because it does not make
> sense to check for overflow IDs for a mount that was not created.
> 
> Signed-off-by: Taylor Jackson <tjackson9431@gmail.com>
> ---

Thanks for fixing it!

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/vfs/idmapped-mounts.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index 34052ca3..f4dfc3f3 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -6667,7 +6667,7 @@ static int nested_userns(const struct vfstest_info *info)
>  	}
>  
>  	if (sys_mount_setattr(fd_open_tree_level4, "", AT_EMPTY_PATH,
> -			      &attr_level4, sizeof(attr_level4))) {
> +			      &attr_level4, sizeof(attr_level4)) != -1 || errno != EINVAL) {
>  		log_stderr("failure: sys_mount_setattr");
>  		goto out;
>  	}
> @@ -6706,11 +6706,6 @@ static int nested_userns(const struct vfstest_info *info)
>  			log_stderr("failure: check ownership %s", file);
>  			goto out;
>  		}
> -
> -		if (!expected_uid_gid(fd_open_tree_level4, file, 0, info->t_overflowuid, info->t_overflowgid)) {
> -			log_stderr("failure: check ownership %s", file);
> -			goto out;
> -		}
>  	}
>  
>  	/* Verify that ownership looks correct for callers in the first userns. */
> 
> -- 
> 2.34.1
> 
> 
> 

