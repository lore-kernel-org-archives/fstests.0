Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753816B73F
	for <fstests@vger.kernel.org>; Wed, 12 Jun 2024 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178682; cv=none; b=SZNR1lEcSf+Zp6+rVMeJx1MF+RWCV8zIJuVLcvTf48w8me7zmu4MK3TP3WNbCr75CPjrxPIi40El7SCdgoQIcUJ+s2EtUaORhuzES6e3ynD7689hPhHI8rYl9coLSZcyeUNbKeChCL0kMk79QL6n4XegRAJ68UV+gRDGhM+74hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178682; c=relaxed/simple;
	bh=sZYtzv4VmPJ9VIAC4vjHYxiewwXiUUTn7ioIQRg72b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3gTT1JyD0HHfL/GWIUb/QOX6NJK6mmCg3nW0A8tWzRWYtvyPe+wgJX3tvvJHKUAdQrsc5iCG2oykwu7b9XZmFc6lRZ9Qz3RRNKr3asA9xMnG6uHHoYhXwqpbTI6QbbXbc4sxW0hfgT3NrIl7NGXSTA8O8gn0gEecIgMfGOF9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cltXt5z7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cltXt5z7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718178680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIaaK6W8uT5BSnueoPNeLW1MUPaP1VwOj2mmYxfHPko=;
	b=cltXt5z7iw7fxM1e+5Kp9DPYFAyKPABCcDzRGx7bTjwLn0FIvagFbAqo8X/rHV9LMTyNou
	fC9iDWIkhiGeh3oE5ttdLu/Afih/cF1gTpLSFmw/13E9fJ1Q8nFvWHKu/V0XjbtUUUeB2Q
	gAq8Q+ODAjwnD1TTx3l8aVVbnTWLqqY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-V7bDJ15OPHapHxjJEb5cqw-1; Wed, 12 Jun 2024 03:51:18 -0400
X-MC-Unique: V7bDJ15OPHapHxjJEb5cqw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f71d5a85f9so17043495ad.0
        for <fstests@vger.kernel.org>; Wed, 12 Jun 2024 00:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718178677; x=1718783477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIaaK6W8uT5BSnueoPNeLW1MUPaP1VwOj2mmYxfHPko=;
        b=kY3Bu0NZxgBhvCQGszZKPyTWBHOGe4xYDvq4RE7vaKeUIYnS4psMrvM9b748iPwcEq
         /VRTT4y1DOs5gXn7j5bujssmF7Q4Vz5mSCuloG8ObSgG+pajW7735LdSZ307ot/kaQnG
         aoFN/5UPfTwrDeE+nlTRV2Xeygac4JkQ4kb572mGDj69kddLV7BbdZuxIwaP0yxRzeO0
         9HLP7CtgTg7naOSJQhLHFEVf5UBqsOPwuZaKv1UyhZq9VhVKL2GdF9rcPpsi7GgJlByb
         JVoc/5Zw/3d1DwMfitmW67G2V42kg8+adlQRrnt7mj2HNJagkLW411cNsnRaH9eDhSUe
         8U1A==
X-Forwarded-Encrypted: i=1; AJvYcCXwn1vLs6DAkyJ/kGL3fMVDzc2bYhbjU1JYCOeQl8CgoSMCqJu4VNx4SUr+ulHajFigjN7Z5OfDaetoVk/x2R94ee45cVOQUQ==
X-Gm-Message-State: AOJu0YyKTl4LMrLXQdBKfSmC6OWFRiaP3c0bvghQ2jlzuFi2gCOzbQ4G
	JCHy0paQ7lBPH1Run8rfY7aQnNuExKAsZBtfjYzcsLvqMx7v6lHAYJG2eVmWzIBfhd8rap/GY/l
	sg5tYKVIN1d5rCZehrbfmZlrdl5BOMBnSEt/oJQYzE/XFPL6z0DIi2Qk=
X-Received: by 2002:a17:902:d4c7:b0:1f7:1525:ddfc with SMTP id d9443c01a7336-1f83b56bcf9mr11315685ad.20.1718178677070;
        Wed, 12 Jun 2024 00:51:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMX7aSBeEp6lKbXd+g1sAM5yfWtpI+0C98OJ7FfMPgAute/8BdN1T/JNbfc807HHvAghLdtQ==
X-Received: by 2002:a17:902:d4c7:b0:1f7:1525:ddfc with SMTP id d9443c01a7336-1f83b56bcf9mr11315425ad.20.1718178676391;
        Wed, 12 Jun 2024 00:51:16 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f72561cfb4sm35303155ad.268.2024.06.12.00.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:51:16 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:51:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 4/5] _require_debugfs(): simplify and fix for debian
Message-ID: <20240612075109.b7omu4pipo2p4sjx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-5-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611030203.1719072-5-mcgrof@kernel.org>

On Mon, Jun 10, 2024 at 08:02:01PM -0700, Luis Chamberlain wrote:
> Using findmnt -S debugfs arguments does not really output anything on
> debian, and is not needed, fix that.
> 
> Fixes: 8e8fb3da709e ("fstests: fix _require_debugfs and call it properly")
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

Thanks for fixing it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 18ad25662d5c..30beef4e5c02 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3025,7 +3025,7 @@ _require_debugfs()
>  	local type
>  
>  	if [ -d "$DEBUGFS_MNT" ];then
> -		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
> +		type=$(findmnt -rncv -T $DEBUGFS_MNT -o FSTYPE)
>  		[ "$type" = "debugfs" ] && return 0
>  	fi
>  
> -- 
> 2.43.0
> 
> 

