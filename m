Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316129BDA6
	for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935963; cv=none; b=lqh5OGwqVzc7WZGNv5k3mMmiiM8Vf+43R36ZFVvg0/ZtTKEFdHjriRi11F92hc7SEyUVtZKI2VPNoTU6vGUOoZSs34uo3D748zYb2rLf9kTxR0gSuHcecI30abJIWJ83XNMlzrCN3X4DzQwl3DGUZcihRo7t1zF8tP9BbkTvYdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935963; c=relaxed/simple;
	bh=T1TbY2V3duINVsRmkHpfxRcOte3eOWw8A/E06eTbPow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7dflyk/p8PdDrna6kEJ4OaNbiLUnN7iF/jXRMFAA29j9ypfC3kypqkwsC0pXb5jVFq/QXv3E4sxCHddXqG3IPOc6lhQdZxfh1p4VY9UxC4m5/VCpXxNG8lAyUWrb4pybTVZFPWtsnZ+YCc1J4ZLsDbI7BLfiXYgGg8v9zaNGOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3pI69+Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3pI69+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754935960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81uqlJiu3KKJ+tPXBfJ9HETxELLjgevjOQyrFQtsQWA=;
	b=G3pI69+Ywth1ydHVYEzFu3ozDXpFI4Vh6+0bvfnMG9NCKaQhb6dCnerGkNC+/2wGgOg0kf
	X+oCU69KGceM4Bm7kTd9oxm2vRQe9h9aDjnn7sjxcF3XacRXxnthyD6iXcYmgouzTtRHbu
	7rHBFZ3q2+2lAIh0Qyp3NH9HVCWsogQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-KnmnjEaAN1ChrUgvtJHHTg-1; Mon, 11 Aug 2025 14:12:39 -0400
X-MC-Unique: KnmnjEaAN1ChrUgvtJHHTg-1
X-Mimecast-MFC-AGG-ID: KnmnjEaAN1ChrUgvtJHHTg_1754935958
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b78329f007so2790081f8f.1
        for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 11:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754935958; x=1755540758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81uqlJiu3KKJ+tPXBfJ9HETxELLjgevjOQyrFQtsQWA=;
        b=EzHYOc2Gvo7od6fO35BSnNRDAZwm9dvg1mXkFN1qbe/9PSuP8dMCCVBQMXLjW9lgaT
         GlwioH4EwN1RDhkVBwTLCxTXae4GmckL0r85VGjWxcw+xYapl7tpOcRMQemwwv72nolW
         ItxHlMX9wy/qs6+Es7GOLqYtT5oxM4CpVgbnjlHf3HLCWOXxonomd13czvUJcwoGN5sV
         CYPTA3vswtofh3orF0kCoqUovS/Vw9ivUqoRGSTMv0a65LtN3KUVtox8kTWVzLtVni0r
         V1mPVKhA3w+01BdnZS4TN5uMS9nl7pdgAMlP7zBHDr2WTAD7FeLTR8KHatvSSPVnhg4D
         LbiA==
X-Gm-Message-State: AOJu0Ywott+j3zlo4zjujRPq/Tar6zm52Iu/UeOrB2GoPFF6RHTJMRjS
	J/10auNgx0yGBIsP6+rIisUqfJZ5VKawqCWsGZJ4x9spZWc34wKk0ulTFxlN1/JUoWe/Js7T3YI
	zyCpPh3QG3GNntyZTnQ+WyMKD1ZdU1gxxnIwBQthROZADccUFxuk6tg7+IA==
X-Gm-Gg: ASbGncuqm0a+uuSXjDnBUDiQl6lnuQRfkQaVLUsSnC3iEnJr4idPB4TrtJNVEFMRYJX
	Xdd5510NxO6ezYfJwcK+XliA8TZ7n6wDSd1oJcwsk3Z0b+hUxA+ewUluCDGuvMAs03x5Fnl2YKY
	l3HBvA8IpKstVaRot/9reekxELWNtuYLhnwu1W8z6JffRrbxdz8kMlyOUNKqjIwO5JJ/58D8s6O
	Lyn0kf7+BeaQYtPjTEMhwjap2O7zAxYZaTIywoUQDCNuwDrvMkuNsozaCdLAoP+GKZx2hi5Hquo
	wk8PBGYXVwMjLyrSfEKQrKeYdntDIC2Ak/rdP1sCK8C8rYsdNuTgyBEWP+I=
X-Received: by 2002:a05:6000:4387:b0:3a4:f72a:b18a with SMTP id ffacd0b85a97d-3b900b52958mr12107086f8f.26.1754935957775;
        Mon, 11 Aug 2025 11:12:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMlgmyhItfKunlp7MS1hsmVXPdcoGXFCSQWd0jOrnBuISzKtEDYAL3EkLU5AqA2dr0zaPDQg==
X-Received: by 2002:a05:6000:4387:b0:3a4:f72a:b18a with SMTP id ffacd0b85a97d-3b900b52958mr12107060f8f.26.1754935957372;
        Mon, 11 Aug 2025 11:12:37 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed0ecsm183736025e9.4.2025.08.11.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:12:37 -0700 (PDT)
Date: Mon, 11 Aug 2025 20:12:36 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 1/3] file_attr: introduce program to set/get fsxattr
Message-ID: <4lvrb3s5nrch3bas53ig72d5aqlc3tnvtfbnrvgvattxsftdrk@utdtay3kavej>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
 <20250808-xattrat-syscall-v1-1-6a09c4f37f10@kernel.org>
 <20250811175107.gxarqqcsftz5b6m4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811175107.gxarqqcsftz5b6m4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On 2025-08-12 01:51:07, Zorro Lang wrote:
> On Fri, Aug 08, 2025 at 09:31:56PM +0200, Andrey Albershteyn wrote:
> > This programs uses newly introduced file_getattr and file_setattr
> > syscalls. This program is partially a test of invalid options. This will
> > be used further in the test.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  .gitignore            |   1 +
> >  configure.ac          |   1 +
> >  include/builddefs.in  |   1 +
> >  m4/package_libcdev.m4 |  16 +++
> >  src/Makefile          |   5 +
> >  src/file_attr.c       | 277 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 301 insertions(+)
> > 
> > diff --git a/.gitignore b/.gitignore
> > index 4fd817243dca..1a578eab1ea0 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -210,6 +210,7 @@ tags
> >  /src/fiemap-fault
> >  /src/min_dio_alignment
> >  /src/dio-writeback-race
> > +/src/file_attr
> 
> I'm wondering if xfsprogs/xfs_io would like to have this command :)

it has chattr/lsattr, but this one also generates quite a few
invalid arguments for these syscalls, I don't think it would be
useful in xfs_io

-- 
- Andrey

