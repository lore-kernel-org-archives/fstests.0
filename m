Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A5576413
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400456; cv=none; b=Og1G12hxRwLelK5/oPFfHep8cLRjqGsP+i6WOHt89bx8iiPNqOy7QGBnGKKT088drJD8dCvVr01hz6pws0G4mcItGi3bglxRo0693NoG6w1b1BEm7gjFH+IOLa510MW4qpW3cZRpjJXrzYsMA8wAcq8sVV3gy9JsXwHGnl61kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400456; c=relaxed/simple;
	bh=oxcjuCsClzGt7kG7ieOC9UZaB1ndAR03opK5HDsYqbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5fQS7z3XReYLu1O1gR9q1bjAzP1i5WU0MvqOOG7ur3qFp1TtWMixzmEN+PgHq0A6+itxI1qmiWd39AAH/eXXfaVo8gux2kgUOJrV//tIphtGn9RZ1wtfnwRRrcFQe3IwgFdP7KcPQWXQrdc6DJUiFpbUkP1EwfJTNOQ4XC9Nh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTn08i7o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTn08i7o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714400453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqmGiN5NrDbqqE/DWJqb5zJnPTX/FXC/9hqKXGHU6yU=;
	b=WTn08i7ofUZdygM3Op2uYMfudMb6SWJGyupWqlWn+KOsDoHSs5YmKafiPetbuVpeC2T+RZ
	k2kvZRM6TKfIIxDp9GybhspzFLyPY9ODtnNYJxeAc5ngtE5pJ3FiAgxGIfRDPr7qql0oi1
	O7GfRwAWowgkDhtyyxZb1DhAYCDcsbo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-ZdnAIaOgMqO19sH4OF9P8w-1; Mon, 29 Apr 2024 10:20:51 -0400
X-MC-Unique: ZdnAIaOgMqO19sH4OF9P8w-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed58ef3e3dso3790624b3a.3
        for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 07:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714400450; x=1715005250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqmGiN5NrDbqqE/DWJqb5zJnPTX/FXC/9hqKXGHU6yU=;
        b=tMTziA6kdvKdqShFaUFPksEpMOeXIQYrOoNCV2bfDgF0RhjWt6PPLqH7nVoVD0KNRp
         bV38FKPXL7+HV2dlpQrqBkKIAMCXC+oVg+PACt41YLiKvM+k1TMOk71Ree1o/zoaZVoV
         T2/ptFfRqPOv0eovQmRcOiCbBxYHZEFcrWtgNwclJvlfEQ/hLfvzZFz9mfutVnpyTarI
         QT4aDHOy1SIiopeAMPXEurm/fy9qaJXVanMgt48ZYTCT04206OZm9J7AFFM2GCr7mpGo
         2fNQU46EbT+FOmd/PCpfknXRCuwT0PASRz2XePDhEcLxEwYGngtCTh80GDuA2eVFsCzS
         ErMA==
X-Forwarded-Encrypted: i=1; AJvYcCXnLoQ0Bh02eaVeIYPKlHYcinwu6gCiEtLTMiE27l/aEyP/Qn79HpQlEVUQsqbbqmTmrbffoq+su07Qlv3OX2ko3Vw0A0OcUg==
X-Gm-Message-State: AOJu0YzJn0K0tIqT5/bD4sFJzcHkp2XCF+C6OmdMUxcT4iZD3lME1Lo9
	D+WEew222Ka+nMziiC4G4Ix6EjBm+i2N8NStYtpAGg1GJ2O01MM6ExDtXxz+t6teXRAMKQ4mXnV
	A62ahZaA3ukLJxetZimhwQ0zLA+SGqnlsNSiOQumF6rap5LxPIwqCziY=
X-Received: by 2002:aa7:88c1:0:b0:6e8:f66f:6b33 with SMTP id k1-20020aa788c1000000b006e8f66f6b33mr13592972pff.4.1714400450470;
        Mon, 29 Apr 2024 07:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCi/lLJ8ZRLjdiUU3OTGWsavGD1f6c86BhAd33cBWujTb75f9iky46wEjtW4xp2k7WS2ar+A==
X-Received: by 2002:aa7:88c1:0:b0:6e8:f66f:6b33 with SMTP id k1-20020aa788c1000000b006e8f66f6b33mr13592938pff.4.1714400449986;
        Mon, 29 Apr 2024 07:20:49 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e14-20020a62ee0e000000b006eaf43b5982sm19289700pfi.108.2024.04.29.07.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:20:49 -0700 (PDT)
Date: Mon, 29 Apr 2024 22:20:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH 1/6] xfs: remove support for tools and kernels with v5
 support
Message-ID: <20240429142043.324fmguwtqyouuwb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240408133243.694134-1-hch@lst.de>
 <20240408133243.694134-2-hch@lst.de>
 <871q6oqzik.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q6oqzik.fsf@debian-BULLSEYE-live-builder-AMD64>

On Mon, Apr 29, 2024 at 03:04:51PM +0530, Chandan Babu R wrote:
> On Mon, Apr 08, 2024 at 03:32:38 PM +0200, Christoph Hellwig wrote:
> > v5 file systems have been the default for more than 10 years.  Drop
> > support for non-v5 enabled kernels and xfsprogs.
> >
> 
> Hi,
> 
> This patch is causing xfs/077 to fail as shown below,
> 
> # ./check xfs/077
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 xfs-crc 6.9.0-rc4+ #2 SMP PREEMPT_DYNAMIC Mon Apr 29 08:08:05 GMT 2024
> MKFS_OPTIONS  -- -f -f -m crc=1,reflink=0,rmapbt=0, -i sparse=0 /dev/loop6
> MOUNT_OPTIONS -- -o usrquota,grpquota,prjquota -o context=system_u:object_r:root_t:s0 /dev/loop6 /media/scratch
> 
> xfs/077 9s ... [not run] Kernel doesn't support meta_uuid feature
> Ran: xfs/077
> Not run: xfs/077
> Passed all 1 tests
> 
> The corresponding configuration file used had the following,
> 
>   export TEST_DEV=/dev/loop5
>   export TEST_DIR=/media/test
>   export SCRATCH_DEV=/dev/loop6
>   export SCRATCH_MNT=/media/scratch
>   
>   MKFS_OPTIONS='-f -m crc=1,reflink=0,rmapbt=0, -i sparse=0'
>   MOUNT_OPTIONS='-o usrquota,grpquota,prjquota'

Thanks for finding this issue, the _require_meta_uuid helper or the calling
of _require_meta_uuid looks not correct. The xfs/077 calls _require_meta_uuid
as:

  _supported_fs xfs
  _require_xfs_copy
  _require_scratch
  _require_no_large_scratch_dev
  _require_meta_uuid            <=====
  ...

The x/077 hasn't mkfs on SCRATCH_DEV, but the _require_meta_uuid does
_scratch_xfs_db directly. That looks not right.

I think we should do "_scratch_mkfs ..." before doing _require_meta_uuid.
E.g. mkfs at the beginning of _require_meta_uuid.

Any thoughts?

Thanks,
Zorro

> 
> -- 
> Chandan
> 

