Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B067B70CCB
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397841; cv=none; b=OLZDopDCsqwbThY4FHFfIUr0/gT6zTlXvu1EyfyHrDrg63Qciq51EpxA6OCriOr+ZPMhs10u+C776zFhtwrUyw60WtZ+wlB+nAIaLoQ0oePhq46HIEz20QnEMiGepS4ZKH47l+0qGwrLBMXbK4qZMwny++8tcGp5RTEDRuK9fI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397841; c=relaxed/simple;
	bh=FoCluCzzA8bowR3wN2pSGL5j2gp9YZGoVsok9AaVgiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSZCYp/JbfgoBdf7wzZ5MyapGHkclBbx2SKgBIYnmfyil6Vwg57fbVMbcH6OKvhdzatpZfMIyFjSrWaz8OJUeK5AXPCex+mJU1+qWOYbORsbOhR3JZANrGfg9on2gX9J3sUbbUhSlc1HqTubY97P+3Prp0JoVV/VqX/8hcepMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5/gMOIo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5/gMOIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714397838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0Z/dsQqvJT8foumUpAZ+QcL+Tm5uw3kdNIQXSlVA+E=;
	b=T5/gMOIof/TRunsZAptgNUcxmzQw8jjUx9VLwJ1l6I7Oz8h2puqJmc6a0hu9PZBBnUeK+o
	zu/gSvJXVc9gcdjKNWVIE8UO0Vj6Cv0RD8rqB227b9UBXfdlZQ1AbOpZH9ywQ4KbOwmIxX
	zxLJGa4Cf06T9e/zMVYI2654ZJUnQA0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-_mUgBAjIMJ2JsdlIoVULMg-1; Mon, 29 Apr 2024 09:37:16 -0400
X-MC-Unique: _mUgBAjIMJ2JsdlIoVULMg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e45e04bb40so55847825ad.2
        for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 06:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397836; x=1715002636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0Z/dsQqvJT8foumUpAZ+QcL+Tm5uw3kdNIQXSlVA+E=;
        b=K1wakA1MYY/EjhrL/DXiSZvN1kOInr5DkwawYSus+v97362XoVEDgenZCwAvTnxPfU
         Z2mJJ1h4W9C/tFMzRA4TM+A5i5sS0KIlSBwslb5rQ8kxslrQ4lYgtYvV15KNOoZTbIky
         CeItj62Qr8NworsVNJDn8BU5CgX2MlK4eqZMecbgPu0n00VmUfuvaZwpLyunXgDraSRW
         0jybGOcRotojztONPUO0bMUaX50JQs9c/kuv7v0D7gFm850xhGEb9FtuMnWZxnn0oom1
         R6mSnO+XxQqvLL6lkB3DwPa3zlNDKdTL1iH/Ldbd/l4GOA+srf9A05zMUdIvZPUpws+c
         a+Ow==
X-Gm-Message-State: AOJu0YxW7hfZvXwofCs4//a4mKPdBUrPse6q7xARsEfYRpuX5K8iUlWZ
	187iZbzS+YAA1iaioFINqey+isMeBM3HmCOqYy56RHWCb5AX59qYXWxErkp3ve8wNI3jPWIlfDg
	2Q8HTYl64rREQyoYaMtLVvgZsP2/j5y30HC2PmovPKU5LM5bXvL0T5Nk=
X-Received: by 2002:a17:902:e887:b0:1eb:7d1d:67d7 with SMTP id w7-20020a170902e88700b001eb7d1d67d7mr6249879plg.3.1714397835759;
        Mon, 29 Apr 2024 06:37:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSdnAhqjT50QmZdJ5IAW/kyuXn977/WGgTJX7S3tIkTkAP0iiby4DENgXqrNcn4gH1BbpJKQ==
X-Received: by 2002:a17:902:e887:b0:1eb:7d1d:67d7 with SMTP id w7-20020a170902e88700b001eb7d1d67d7mr6249851plg.3.1714397835203;
        Mon, 29 Apr 2024 06:37:15 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ja17-20020a170902efd100b001e3e0a6e76csm20353906plb.99.2024.04.29.06.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:37:14 -0700 (PDT)
Date: Mon, 29 Apr 2024 21:37:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/config: export TEST_DEV for mkfs.xfs
Message-ID: <20240429133711.rny3rzweegx66nj3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240411063234.30110-1-ddiss@suse.de>
 <20240428053717.qsvzt6jo7w32tfsh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240429212845.0094c51c@echidna>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429212845.0094c51c@echidna>

On Mon, Apr 29, 2024 at 09:28:45PM +1000, David Disseldorp wrote:
> On Sun, 28 Apr 2024 13:37:17 +0800, Zorro Lang wrote:
> 
> > On Thu, Apr 11, 2024 at 04:32:33PM +1000, David Disseldorp wrote:
> > > As of xfsprogs commit 6e0ed3d1 ("mkfs: stop allowing tiny filesystems")
> > > attempts to create XFS filesystems sized under 300M fail, unless
> > > TEST_DIR, TEST_DEV and QA_CHECK_FS environment variables are exported
> > > (or a --unsupported mkfs parameter is provided).
> > > 
> > > TEST_DIR and QA_CHECK_FS are already exported, while TEST_DEV may only
> > > be locally set if provided via e.g. configs/$HOSTNAME.config. Explicitly
> > > export TEST_DEV to ensure that tests which call _scratch_mkfs_sized()
> > > with an fssize under 300M run normally.
> > > 
> > > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > > ---  
> > 
> > Actually, using "export" in xfstests/local.config for each parameter could
> > help too.
> > 
> > The 2nd patch still has some disagreement, I'll merge this patch at first,
> > as it's simple enough and got two RVBs.
> 
> Thanks. I'll send an updated 2/2 today following Darrick's suggestion of
> _try_scratch_mkfs_sized $* || _fail

Thanks for doing it :)

I'm wondering if we could change all _scratch_mkfs and _scratch_mkfs_xxx helpers
like that. But we can change _scratch_mkfs_sized at first, then other _scratch_mkfs_xxx
helpers, then _scratch_mkfs itself.

At the same time, please don't forgot those cases do "_scratch_mkfs_xxx ... | _fail ...".

Thanks,
Zorro

> 

