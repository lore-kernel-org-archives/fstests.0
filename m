Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6A24B258
	for <fstests@vger.kernel.org>; Fri, 10 Jan 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536224; cv=none; b=gFkW03e09ZArNc10L7s4ihQ0IkfDtKE+PZyApul5JGjkZTTu1msT5G2nTu6bn47RM/39iCtqPtvM1DsJhmeVjpcYuaA3Ln3k+Tny8jzO3kPSOS1HXqO9SQUNUlsVcvia4hM04rOVii1VHvYT1Juzuykf92f48jecvPkbMsW+1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536224; c=relaxed/simple;
	bh=jXxiXru38suC2Xu5hw4JU52533qfEhAWaeiZ8fVLtoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvQ6TaTVAMMCJGqIZHnht5/+g9K7Lscd3wGNCM/3hWwkXZuNotEqu4SB6o4pyC+6oQvnC5UfvOtmu7tK+34Iy4Q31ALvgrgae28FmS9nV0Afe388S8MhttuIBhs1SynQdGomO08nid4URlIONeJe7U9xWYNzxX9LWFN6Dm5Q2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4LYV7pR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4LYV7pR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736536221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BJGJZBSAqSvlN1DAry3+tYU71nLGvuo3THiydV/lU4s=;
	b=P4LYV7pRDkzrn8XdjzkV1xM8uKUARii83GQ8l8KeFLn0hNF1UYV5aqHnehQZ5gv0vLgED4
	4pjZwMTuNfKBVLlEwlMpy2oBDvHCV3WxUXZNZfEp/NMUmRlyJ0rGwT5ymMFOc6MXt2mP2i
	Ug02ReAH08pdUBsa0O4PA4lzgGd6xKA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-2VgYLPt9MdW3WlN97Tu3WQ-1; Fri, 10 Jan 2025 14:10:20 -0500
X-MC-Unique: 2VgYLPt9MdW3WlN97Tu3WQ-1
X-Mimecast-MFC-AGG-ID: 2VgYLPt9MdW3WlN97Tu3WQ
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21631cbf87dso45042885ad.3
        for <fstests@vger.kernel.org>; Fri, 10 Jan 2025 11:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736536219; x=1737141019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJGJZBSAqSvlN1DAry3+tYU71nLGvuo3THiydV/lU4s=;
        b=H6ku+g1y10fz1HMZWy1mLjAXc5Elx3e/YGq4xojomJxm5lEgTsBgSCZyzgsvb7s8WQ
         k3b1iB4QkuxNZN3nc9g9IZDDyyiKEMkQtdwJSdnaLxiUAk2UQ8v9ptEkwnXtH3cFW/BZ
         rPA4yzmZHJkHQzFE8JnKPBNzbMxSxFC2Z75vV7AYL4OvkNvOyXgMwD93upPB7iojaiVK
         HxIb1ZLUgmTyboi4BhUup6I7Kcjn/4tWa1wuWs1yMVbiCIOKzYckmQWfhARP7fLDymIJ
         Vw2S/+4nIp9dXpykzXUCVfKwFd6zQUhFgW1mxBLSuHAsBeShGDs4UaWT7/TdjbyxYCO1
         PbUg==
X-Forwarded-Encrypted: i=1; AJvYcCVj+i8Q1Lhz+J04EBYLIbbJPIJsqRO6ddnxcYfudnmn9/wk44yOAAWi2bkou2xp3xmI24LOW8wy@vger.kernel.org
X-Gm-Message-State: AOJu0YykgQ3EqZjmTzlOxIYBtlFf1I8HtNPW4vvXiNzIAujRoV0y4Map
	z8pSeFIL2CzLH3lVnL1xfJB29G/hM00tgLp4tBrySyKoYcGrtUXoMgYTpmzts5MhmCbBSkXMoRD
	gFn8JQyEpjvcAUFWeE7o3+CWSNTNQZ3vDC1R5XRcKnLq8FbwQya9sRtI=
X-Gm-Gg: ASbGncsGwILHGlh/QkZefsfLO43YNJUylEyYWyx7NbNPQwateE1LYtMItiSSEfmxcYA
	RViIxDVR79p21rfLJZyVSRoWD2qiwkWhwK+Pr5Nl6+mP4oEHKHYL6X/+M3/dF1nRkvvBNqSYblg
	AXWrdkhaR0IkcGDHrrWC6WNA6y5wTfKWnGNWkxRsO08zbW0UgxIgLVze+ga6NCjg6CY47byj8Hd
	Be3isma6Wu/SWSPz772JvTg2LPcllEOwaxCIIPYr1v8f9QmKg9EaV3SsFyz1CbZH30Nz3N1eNLS
	qZd1ShZnLB6sGSKovvAAfg==
X-Received: by 2002:a05:6a20:9150:b0:1e1:6ec8:fc63 with SMTP id adf61e73a8af0-1e88d0e1718mr18549019637.11.1736536218995;
        Fri, 10 Jan 2025 11:10:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiX8W3b+TafT191JHTpyViWF9Yc0NMljdIJ5iTudUfN0kVN0RYpTdveM4ujtc6w7gKQZZxVg==
X-Received: by 2002:a05:6a20:9150:b0:1e1:6ec8:fc63 with SMTP id adf61e73a8af0-1e88d0e1718mr18548992637.11.1736536218702;
        Fri, 10 Jan 2025 11:10:18 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a935csm1896956b3a.179.2025.01.10.11.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 11:10:18 -0800 (PST)
Date: Sat, 11 Jan 2025 03:10:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: Mark Harmstone <maharmstone@meta.com>
Cc: Anand Jain <anand.jain@oracle.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"zlang@kernel.org" <zlang@kernel.org>,
	"neelx@suse.com" <neelx@suse.com>,
	"Johannes.Thumschirn@wdc.com" <Johannes.Thumschirn@wdc.com>
Subject: Re: [PATCH v4 2/2] btrfs: add test for encoded reads
Message-ID: <20250110191013.o2jieeflghev2bej@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250106140142.3140103-1-maharmstone@fb.com>
 <20250106140142.3140103-2-maharmstone@fb.com>
 <b085669a-3684-4031-9e0d-3275289e86b6@oracle.com>
 <92429a09-4ee9-4561-8c0b-4e8abdc78f57@meta.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92429a09-4ee9-4561-8c0b-4e8abdc78f57@meta.com>

On Fri, Jan 10, 2025 at 04:39:29PM +0000, Mark Harmstone wrote:
> On 8/1/25 06:33, Anand Jain wrote:
> > > 
> > On 6/1/25 19:31, Mark Harmstone wrote:
> >> Add btrfs/333 and its helper programs btrfs_encoded_read and
> >> btrfs_encoded_write, in order to test encoded reads.
> >>
> >> We use the BTRFS_IOC_ENCODED_WRITE ioctl to write random data into a
> >> compressed extent, then use the BTRFS_IOC_ENCODED_READ ioctl to check
> >> that it matches what we've written. If the new io_uring interface for
> >> encoded reads is supported, we also check that that matches the ioctl.
> >>
> >> Note that what we write isn't valid compressed data, so any non-encoded
> >> reads on these files will fail.
> >>
> >> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> >> ---
> > 
> > 
> > Looks good. Add to the group io_uring and ioctl.
> > 
> > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> > 
> > Thx.
> 
> Thanks Anand.
> 
> Zorro, can you please add io_uring and ioctl to the _begin_fstest line? 
> Or do you want me to resubmit?

It's been added by Anand, I've merged it. Also I'd like to remove below lines:

  . ./common/filter
  . ./common/btrfs

  _supported_fs btrfs

Thanks,
Zorro

> 
> Thanks
> 
> Mark
> 

