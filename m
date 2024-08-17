Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759AD7F7CA
	for <fstests@vger.kernel.org>; Sat, 17 Aug 2024 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723922181; cv=none; b=G4J1E+q/Qll7DklvSKBxV1Y+EhW28INDHgi8kTlZTehBKyGMLZ1BJ/KTnX0yNQFWnKykp0zQ1JDeXs7svaMgmRk0QSGD/Z2OuxzQJ2bsbmE+ZSjD4yFrPUl1f0TxHzJjCH4DZsop5/Hi+N3DUby0/a+agCpb7giX/Y46Wal767M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723922181; c=relaxed/simple;
	bh=cKQMWZ6YrNB8gd/Pe8tlBGKP817l0mjPy59iQ4C9C50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqZLaiILlC6iuXPZU1wTnBtHfzEAj678niagW11S6AEZOAnBKDVlzfxyBNhULMWUMjFuGHYlMYFg2KuCkscmJAxNWAEKvbxxpdZ5GEHB1RFhFUd4+P3Ia8CRIxgcIztaFEAPDulr6URI8VglzKWoeH78tVNMn5W84JQvkEsQPmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFHawcOd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFHawcOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723922178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/6AjSjCOQszLn+4WdPIVHohj4aqJLXZjfUWZZdyqSE=;
	b=OFHawcOdFbH/P9RPVqjPol3mI8Vl1lvJYJ13LZnuXOVS8gFAnWWitqn46wzG8o/yEge1NX
	AcJ23W+gHxeTx09Uv32CvSmb1lSdvYz4NKKu9h8Htij7mBeOYoBcA8JRdS3VpttTaCmQcT
	XzYVQEflmZjUAAzKXlawZ/I071Gnttc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-8KDF0a7jMPyOa9x-yG-N1g-1; Sat, 17 Aug 2024 15:16:16 -0400
X-MC-Unique: 8KDF0a7jMPyOa9x-yG-N1g-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-201f022c516so25511265ad.1
        for <fstests@vger.kernel.org>; Sat, 17 Aug 2024 12:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723922175; x=1724526975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/6AjSjCOQszLn+4WdPIVHohj4aqJLXZjfUWZZdyqSE=;
        b=X0daw1PZneRehqv7n77Nbz1ttJ5uf1mP66Nvk9UGtHUfMgdDLwevqTRTCqYoSSQZUK
         UQAxVQE8HSCfXBZekT4vRVVbP0TimK6rSNnsUGsh0YkTIaFt6tNrXCB7i8tsElMO6CDy
         /1yZU2yG4AFr1F3seV548quYz4M9JLdyonDhFSK3Kv6mhZLxJeMEDgBCvCHwPxQAn7q2
         ElD7nigNpZO1zlrb2OdXd8RTEgDud1IwidwrUVAkrVY4+ly0an3RXvNdVEbPzvZdI7l/
         HB5Uuv3ZlSLfLsNIAHZ9HKFtXwufcW4LsoFhGVCLLQxfmmJNPCSZuupAWIMvjTjF+cwz
         V4vg==
X-Forwarded-Encrypted: i=1; AJvYcCXRC+7z6KeyFej6shjkjPofQ4rxdtsv7/XaEWzA03utvwNyfjx0+I/x0jGLLiXjERkymdf+ZryT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlas6OfcTopQKyHNFpfDYYiHoo0DDeKqaUoJwPtC6SC0q1Da5l
	QKrHJSOV0DEDaFEpjOQajvYFUr4qTsxfvR603aMsFj410qohSGXFn3U9ydjW70iPkClZGFfRqQW
	fFeDmYg0inYegSnR8B5F5dG0d4OiHfd4tDXZOFShonIvLn87Qe42pUETn5/sM/DiXWA==
X-Received: by 2002:a17:903:2307:b0:1fd:a5a2:5838 with SMTP id d9443c01a7336-20203e5518fmr98102585ad.6.1723922175559;
        Sat, 17 Aug 2024 12:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC1NN54jbA3N/tiyUwQd9PzwVXOW6Hr3hF93We9DyGkYQAF0h70magP0bvBP0mILOKkEkUnQ==
X-Received: by 2002:a17:903:2307:b0:1fd:a5a2:5838 with SMTP id d9443c01a7336-20203e5518fmr98102135ad.6.1723922174935;
        Sat, 17 Aug 2024 12:16:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0319755sm42058915ad.65.2024.08.17.12.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 12:16:14 -0700 (PDT)
Date: Sun, 18 Aug 2024 03:16:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/2] generic/732: remove unused code
Message-ID: <20240817191611.ohxdvqtwx5nskqct@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240729084715.1736839-1-yangerkun@huawei.com>
 <ZqekL92fZP9cxe2h@infradead.org>
 <ed1a16d0-cc1e-005a-e0a2-9c08cb71caee@huaweicloud.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed1a16d0-cc1e-005a-e0a2-9c08cb71caee@huaweicloud.com>

On Sat, Aug 17, 2024 at 02:24:26PM +0800, yangerkun wrote:
> Hi,
> 
> Ping for this patchset.

Is there anything wrong? This patchset has been merged as:

50da3fd9 generic/732: don't run it on tmpfs
52a36bfb generic/732: remove unused code

Thanks,
Zorro

> 
> 在 2024/7/29 22:16, Christoph Hellwig 写道:
> > Looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> 

