Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E81D63D2
	for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119826; cv=none; b=Eml0cc9LC4SEQEep4ssYCUiVWXhXM48Fmbl8LpMlgfVgjPYcUBTvpa+fC4CusVQ+EWQHdT80/y2IRIxvCnmeZrD4mns8JLc2Hy/ePe4b8l6ZL8p5zuiw9CiNd0OTKp/LN46EvTV5KXc/EFnqwuBXnDFbWtiD7fy8hpOJSBtDvXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119826; c=relaxed/simple;
	bh=eVo74uH1a3S1xTDyHAwg/cqDzhhkxhUoHUiV5/lJywg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoHphrmBQhJ1igHjNdzpQSj75hFvk560PxvLQJSi/+RbH1CaP6wlcCd0NHgD/0H0/5QTy98GSpqYo6VFQUU0JtFs8X4ZgcfPRH9TCdrV5vACqlCYW8qwNcmxf2AoINI6Q08L0Wn3opxQHWOLNAm5+TB5AY1P2rQ9PUvntFWPtAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XISKbm/G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XISKbm/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730119823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=locDhZ8enW58ZhgvKUzesyAlGj6c2tT4bEjg1OEiR/E=;
	b=XISKbm/GMlyQ5OV2bsl4kHGLjlLuY5ZCJUnRz8WFcEVBQ9ZjA8uRRx3yu3lJNQOTHD3z3I
	Pz0tuYkG3msXjySe4ZMv5br+alEx0K1SsDRc5pdDyCHPoKHKIJkfqNytEaNeqKPWir31Gw
	DgV/2Z8g7HLkrZ7/4U4376xYDRUh0J4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-kOp2EaHeNc-vN2A79T4s8Q-1; Mon, 28 Oct 2024 08:50:20 -0400
X-MC-Unique: kOp2EaHeNc-vN2A79T4s8Q-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71e5a7bd897so4518496b3a.1
        for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 05:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119819; x=1730724619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=locDhZ8enW58ZhgvKUzesyAlGj6c2tT4bEjg1OEiR/E=;
        b=Wkc3DrPcW67gnvaR8wJCwGr2SEYSclFEPl9fYl6S5D/x/iOwDd7iCxHH202PPwEyPv
         bEZWiVWtDCKLtOPys8t6G+b7N2n3QOxjHHaDBSuWfuP/0ewvEv63O5eeYN7PuTao4yxJ
         3AP7tWx2b9/n7AhoqE2llS/KCw400qS3lMtEBqw4j4n8ak6Udv1vPySv1IBNQDY15MEQ
         yXitZrMZUrNmpiA3Cm1EoZPBfGjJ2YncBJZ91UYM1gBz5lcAp1ffMEPEEpylZDNu1Ku9
         y3bP/lkf9PuvV5F5dG30Eybb28J47JdlpNm8CFmQkO41n4G58/tqrlo4GI4ks37Na2Mc
         xmUw==
X-Forwarded-Encrypted: i=1; AJvYcCVcjiGAoMnHy0/vKlY0i4OuG/Y1G/84wc8enYU5gRvJgFG+VNh6ro9pWQIgqHsdO2UZkt8oMciP@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhuKt331xqE9GwURClFC1g+WGj4LqeZLVQU5B3PsuhO9zkB2M
	Vl/aERQf3LVRSMsPHDjM+W1DSQeSFxL4V84MTo/Otfzaacz2K1PPQ4PT7bpjoatszl4gm40Vo3N
	sNMDHS8ZCAMVvvzYU3RbCRlHwqEK/jMQMaw25r3o8riYQL/3rTPxfXPI=
X-Received: by 2002:a05:6a00:1398:b0:71e:59d2:9c99 with SMTP id d2e1a72fcca58-72062f8376emr13432543b3a.4.1730119818932;
        Mon, 28 Oct 2024 05:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeDRueDu/QalrBy6yjA8xJl0WqO1On2tyepjdx21DYmt0yg/dQGMT4XuWo9uJuaZFlKRKqAQ==
X-Received: by 2002:a05:6a00:1398:b0:71e:59d2:9c99 with SMTP id d2e1a72fcca58-72062f8376emr13432514b3a.4.1730119818590;
        Mon, 28 Oct 2024 05:50:18 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057935769sm5640003b3a.77.2024.10.28.05.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 05:50:18 -0700 (PDT)
Date: Mon, 28 Oct 2024 20:50:15 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: notrun if kernel xfs not supports ascii-ci feature
Message-ID: <20241028125015.nzly4g4kxmyjtefv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241026201234.77387-1-zlang@kernel.org>
 <Zx9PGD6m8ySNaXSR@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx9PGD6m8ySNaXSR@infradead.org>

On Mon, Oct 28, 2024 at 01:45:12AM -0700, Christoph Hellwig wrote:
> > +	_try_scratch_mount >/dev/null 2>&1 \
> > +		|| _notrun "XFS doesn't support ascii-ci feature"
> 
> I would have normally expected the || to be placed on the previous
> line.

Sure, I'll merge this patch as this:

_try_scratch_mount >/dev/null 2>&1 || \
	_notrun "XFS doesn't support ascii-ci feature"

Thanks for your reviewing.

> 
> Nitpicking aside:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> 

