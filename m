Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23672EE98B
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258599; cv=none; b=ZLKzFuu+sLu9RHdbeLOA9ILqxo8gfX1T0lTo4o9nl7Wh5ny+70geQBzJ4J9SnxJVyLDiSuRtB7hFvbRapDKsX9gIeXvlu7JC6iF+ZoqLTiriYyMYjcrZd85fw9EFirEf/azabr2qa9NyZLPoGljw/ip1MmmcL43wxCCxwopMros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258599; c=relaxed/simple;
	bh=uQKxwv+tZNxK3FWjArDBVpE4yn39W5vpTVad4Dy15iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=my0Pv6/kLrJEK7HizbbMFAe1vcMD4jbV8Gskt0L2eKY4sKXAevlSwkYADTOKOtsK4NyVcdckjo8N0EaLH56YwoEcXEzfjGX7Ciu5j+PHBsIlrDTeLiSdyvs4Lygpw9VyzKaUEXbt1/tef8TJT1mtOUg74AX18a2CK13yBkMbbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVzppK40; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVzppK40"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750258594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RKFQQTnsHw62TEsOwEWNsE2ygb/sfOvWxBgOUYxwwU=;
	b=QVzppK40AXkn7jLFYT4uZ8ON54id6V6AmUwADm53oXhldVBC/g8DB2ljo+3QSTp/zNaFey
	JuKjW9IKwxYw5APge9TrUeMPKViM9ufb8n6eqB/WIBYtOWsoq0t3bUWMQr6M889+Ps2OW1
	Oixcb57Hm5OoyQ6gVuKxLXJVgFP7RhM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-vpiksdZQPz-TTq9I7DcTOA-1; Wed, 18 Jun 2025 10:56:33 -0400
X-MC-Unique: vpiksdZQPz-TTq9I7DcTOA-1
X-Mimecast-MFC-AGG-ID: vpiksdZQPz-TTq9I7DcTOA_1750258592
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-234a102faa3so48191955ad.0
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 07:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750258592; x=1750863392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RKFQQTnsHw62TEsOwEWNsE2ygb/sfOvWxBgOUYxwwU=;
        b=tE/z1O+7XFNKmNaV7tsOadpr4+vHdea/6Qy2mYXb7XcSD675SqO1sQurogyPDV7VLI
         rTcU7yot89rgSdS3yQlNHuokAXozRThcazZZZ3m+PWii5CA57UYNvNJQS98qMAMwQDBD
         oY04e3/JDtyZr8GgvOeONb67G8JeEFthwKX8DIByQf7UKfOYE8Qcedyl7KKlH/FgMDHM
         a3qvGEjaViIJabFZJ2b6S4/g410NUwMTCGQVVi7rRfJ7rIX/fzrmJHfG93jfr+FBNbIn
         YJPSUCxs8XLVLpDom5fCj9wZ85w66iGBL1+cyvn6ml/0jHqqEDQkBa3jzrtus6krcP5V
         1vdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqAk0goJkU9AKovrtEa/gxzHzOQniUyDeZvU3udpbOVztCWI3BVkZCEbwEgbhNZEyDV094gOeT@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7wYcUitmTTNF6VZFoX4QPFuY634TSG3+8NpT/1g60H1E00CI
	1tK7KvG6ScEHKwCqjq7RWRCGd7qkvsP1WpwtwmHjrZSKD5yaYXQnj/nWNnbux+AP7Ml0tjDFxSh
	luy1PgAhMDp4H5NHuierxwkwbG9no2DCYuTF4tvW7LKufu3f/xaZztUWmifh3QkONwd4=
X-Gm-Gg: ASbGncvSUW96XmThXxZ/BUx+agZWv8YZ77jvgNKWQ0wFiCD8G3Z+7OcKHbEzLNBZFA2
	z8E8xWlzvm//HagKNOUCHAp28IQX51s+YPRcPC7ij/Hw0hIW5Bn9VF0CM+jGpNv+pk4dXzkaYOF
	+bv+l5V49RLnlEVSClnfLbSA9ow3Z2Fjy5xdUBCX5aOxjNPxNwvAqPGKyYrbvGH3eTpEZiEVTSZ
	cSBB7+Krz+9TtLYuC0NnN8X9hSUDUc6w8R+0Urr4evO1sJci2rGSkLPGzIOl4FQkHOlRk8wN597
	OGfYU/53EE0jqUQeOqgHEM5NmHUK9jhneuhEtxHwZzm505/8Hc7NCQukIqqFXts=
X-Received: by 2002:a17:903:320b:b0:235:f4f7:a62b with SMTP id d9443c01a7336-2366b13af7bmr288523515ad.41.1750258591973;
        Wed, 18 Jun 2025 07:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFabFJFiL22n7lCCg4cOVxm7aNPOa8bMeeVTFijQmg0cfrqeYRHfv9rNIgz3k4LiSdEpz90Jg==
X-Received: by 2002:a17:903:320b:b0:235:f4f7:a62b with SMTP id d9443c01a7336-2366b13af7bmr288523215ad.41.1750258591694;
        Wed, 18 Jun 2025 07:56:31 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a4d6csm101459915ad.88.2025.06.18.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:56:31 -0700 (PDT)
Date: Wed, 18 Jun 2025 22:56:26 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 0/3] fstests overlay updates for 6.16-rc1
Message-ID: <20250618145626.xm5x56zwl724jonj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250609151915.2638057-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609151915.2638057-1-amir73il@gmail.com>

On Mon, Jun 09, 2025 at 05:19:12PM +0200, Amir Goldstein wrote:
> Zorro,
> 
> Please find two new tests by Miklos to cover ian overlayfs feature
> merged to 6.16-rc1. Those tests do notrun on older kernels.

Thanks for the testing and feedback for older kernels :)

> 
> Adding two new helpers to sort out the shutdown test requiremetns w.r.t
> overlayfs following our discussion on generic/623 patch review [1].

Sure, I'll merge this version (after testing) as we talked.

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/fstests/20250603100745.2022891-5-amir73il@gmail.com/
> 
> Amir Goldstein (2):
>   fstests: add helper _scratch_shutdown_and_syncfs
>   fstests: add helper _require_xfs_io_shutdown
> 
> Miklos Szeredi (1):
>   overlay/08[89]: add tests for data-only redirect with userxattr
> 
>  common/overlay        |  29 +++++
>  common/rc             |  48 +++++++
>  tests/generic/623     |   2 +-
>  tests/overlay/087     |  13 +-
>  tests/overlay/088     | 296 ++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/088.out |  39 ++++++
>  tests/overlay/089     | 272 ++++++++++++++++++++++++++++++++++++++
>  tests/overlay/089.out |   5 +
>  tests/xfs/546         |   5 +-
>  9 files changed, 695 insertions(+), 14 deletions(-)
>  create mode 100755 tests/overlay/088
>  create mode 100644 tests/overlay/088.out
>  create mode 100755 tests/overlay/089
>  create mode 100644 tests/overlay/089.out
> 
> -- 
> 2.34.1
> 

