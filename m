Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD516BE1A
	for <fstests@vger.kernel.org>; Mon, 19 Aug 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072010; cv=none; b=mJ08MPGeIbWIUhkHiFhj9zIjuNYEub76RqZNz8f4/uDWYJi4z1PbsLnC8ZVmYYfb/u7evyggzMwOcnLf0VBVlSeNPVXbsLQ8jLjvUiFgH0sdpOWgQadzeoe9N0Zbl3E2q/n55x4WxTfArjiCxf3TA1/XaoBO5iG5A0DWFKgrWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072010; c=relaxed/simple;
	bh=1gyubLnk96C0YJqXeJCWtN09vLm1C1JWA0/AEhPvSLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd6rfwj3cDelub2BoxounI3hBGejdfFsMfJO7ShO+OF5n11QeQgwMT5WQZpUpXuMlbo4jTEZSPwUkDZlGmAbu9up62PtS6lp/i6Wagkh2QvEQ42RwAczzuB66d0gC3nK3ErNi5hwA5Re0jpzYS3m15Jgga359/ld4D2tNVRvP8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEKddtYg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEKddtYg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724072007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LYLNxoQu7t9MnK4zDc9B2PoFDwwp/niE2iRLBRkTWYM=;
	b=DEKddtYgPLBCFGINRP8fgUJLs6BO+LFj4XCxCItHT/y+kEwCBL5ob10wG7y5rjMYhehdvy
	FYu7tReuR1aGb2sgnrt0jdVc5e8/MoD1fHFmVaZ3sCu4cljYU9ItdsagaMbi3CuSs1uXSu
	/qizvfHzUP1MUGMFx4QIy7stKJ7rrac=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-fAWfYCqUMHC_rKAFeK1sSw-1; Mon, 19 Aug 2024 08:53:26 -0400
X-MC-Unique: fAWfYCqUMHC_rKAFeK1sSw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70d1831ae05so3913178b3a.1
        for <fstests@vger.kernel.org>; Mon, 19 Aug 2024 05:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724072005; x=1724676805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYLNxoQu7t9MnK4zDc9B2PoFDwwp/niE2iRLBRkTWYM=;
        b=K8FmBTEzRZBMnn1pgGy4xzRH/8FCR+u1yNnjfYNCcOqgG72+tQVcoul/LER1G2IDBQ
         AV4/DUsKx2IyIUTCDDHQnQFhMx6Y+3lItu//OaDLRgJl89apIIhXqMtwCGH0X/uHMiG+
         rOlLUaVo+YI2UHZ9j8F7gcfkF6eY7QgIyVIGFg94+B/o2gP5GutfVOfAZ0nifnuNvoq3
         zO2Rmx4xiXIaswVFmCRPLpuw7mrOvzPZzrLBRueMEJL758Zer0CSMq96gPTHMKJ2K8WJ
         UK2XrohaUHzuu/uUfqTj95nfPcs+sKlLFFB8Ye5qmcTncTklWW6ZbDhAQ3pkewN2EexE
         Rtxg==
X-Gm-Message-State: AOJu0YxGw5FerKyls8WuZrpvXC4m8igd/cV/lP9srrjaSt3Ixzp2IdjJ
	EFLM+m/xN4Cf8C1WTq57WwihewdSJtu7cGlIm89+RKrdq/OniF1Ij8PH0eTmJTdHwaBelQYABBB
	ZIgLJiRn4W10esvY6qCd4aMx0ueawzATvJf1TLNQDMQdY2+sdNplIabM=
X-Received: by 2002:a05:6a00:1988:b0:706:74be:686e with SMTP id d2e1a72fcca58-713c5240f22mr13512484b3a.26.1724072004953;
        Mon, 19 Aug 2024 05:53:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHudnfX5f2mvWGbggwpOFKPC7SGdoLq2XZO5rJKn+ajHf89zQ4OkpZXmXjwrLY5Luuu+VIV+Q==
X-Received: by 2002:a05:6a00:1988:b0:706:74be:686e with SMTP id d2e1a72fcca58-713c5240f22mr13512459b3a.26.1724072004443;
        Mon, 19 Aug 2024 05:53:24 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0e9acsm6526293b3a.82.2024.08.19.05.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:53:24 -0700 (PDT)
Date: Mon, 19 Aug 2024 20:53:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] generic/732: remove unused code
Message-ID: <20240819125320.zsooroffeg4b3iug@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240729084715.1736839-1-yangerkun@huawei.com>
 <ZqekL92fZP9cxe2h@infradead.org>
 <ed1a16d0-cc1e-005a-e0a2-9c08cb71caee@huaweicloud.com>
 <20240817191611.ohxdvqtwx5nskqct@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ac950efd-57af-02ff-ccaa-b50baff30de7@huaweicloud.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac950efd-57af-02ff-ccaa-b50baff30de7@huaweicloud.com>

On Mon, Aug 19, 2024 at 09:06:06AM +0800, yangerkun wrote:
> 
> 
> 在 2024/8/18 3:16, Zorro Lang 写道:
> > On Sat, Aug 17, 2024 at 02:24:26PM +0800, yangerkun wrote:
> > > Hi,
> > > 
> > > Ping for this patchset.
> > 
> > Is there anything wrong? This patchset has been merged as:
> > 
> > 50da3fd9 generic/732: don't run it on tmpfs
> > 52a36bfb generic/732: remove unused code
> 
> Sorry! I have not notice that this patchset has been merged to
> patches-in-queue.

It's not only in patches-in-queue, it's been in for-next branch
with "v2024.08.11" tag.

Thanks,
Zorro

> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > 在 2024/7/29 22:16, Christoph Hellwig 写道:
> > > > Looks good:
> > > > 
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > 
> 

