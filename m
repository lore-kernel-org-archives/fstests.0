Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996428A418
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429716; cv=none; b=DDueAvlTlbF1kwg8xDqoXAPM9g/Vih1F2j7FuLuGE9FJp7UC5eR9Kodk1/5qZGkJRPNZOiquKOcRzfSnlSdOsMB3MaMx3CF1LUebpEOd7LQ9lMixP+gtAFiSpcG8EwufQ/O5S4j1igPxyV7gi/tPt8CbAmw9pc9EnWpjuKvtrsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429716; c=relaxed/simple;
	bh=IXeLyZw+ZIMrITdJz6u5WVkz8JV6iuBYXdeTayeLzXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5RjJX5Lu4AoimT5vf9L+AGwKcmZBWFHIekHB9rjmoLOwAvcjr900eMIOb/GZZJ4TSLCPeJoAgwwImQss0EusklyBl4q1n2FmmPk7vqTpavm0m0W40LYhdjOlVntdDBGttr0Ogo/N3QlBL2n2piIfxsMtz1PZMHtbVCAus1GgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfnmX+9D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfnmX+9D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750429714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ucWMOo5W4QYO6Mg122vHo8guICWeoYajSNvWPSEp3M=;
	b=KfnmX+9DYVfHriDdJBXRR+uqtCIu1agRcZaG3rzzHotkUUJuHbrO6cF4iqBINAf7HFkrV/
	/JGc/craQQcAAQQfkhabST4o9q8FDdusLHbZduD8r5rXJBuTuFbSFgspLcrI9Fq3KZS2J0
	kJK1ZFAF9XOZTdraaQcphp6TwHAiT9A=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-Ndmrw0kDPrCancjYExQYeA-1; Fri, 20 Jun 2025 10:28:32 -0400
X-MC-Unique: Ndmrw0kDPrCancjYExQYeA-1
X-Mimecast-MFC-AGG-ID: Ndmrw0kDPrCancjYExQYeA_1750429711
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74890390d17so1746806b3a.2
        for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 07:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750429711; x=1751034511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ucWMOo5W4QYO6Mg122vHo8guICWeoYajSNvWPSEp3M=;
        b=mjVMTUG0cQdbEQ3lE2qL766h8xaGj91BvOlLe0MEN/A7QSh0BLjIZYXQ9Tt2xS0YXU
         skK4c9MedSqy8wVNBQ+UwXkehwrRBuoKzNBXoFLFkRekIi0rDPwcrY7izwGzSBmdwSgt
         6T+6FPZNqsjd+AOsUNCEb6kLOnY1+Me5AmtX9HQbZQEsYXNCnjaCviEp1k+IpoUw3Haz
         5eyOuz4G2HbmeEDP+x4x+7QyYmb/PNHKXKjFoOcFV2U/JrNOdvF5qIPZOTYh0FlsV2C9
         HxSCxjA55+O504b0CU17DrZbsZ6VSkV2hrKHvAlmbiKBw1rtmQ4IAlV2isIrCF7zUtOB
         6qcA==
X-Forwarded-Encrypted: i=1; AJvYcCV4YJkpbYByUZjsZ2VzDQeU6EfJHuJOciQ8aWkRuvpPyqloglbmvBNFTh1AAgHTdi0dlMQqswqi@vger.kernel.org
X-Gm-Message-State: AOJu0YwxgihaxmR/p3YVUWOGaUnTUVHwkJjiaP6sWM0QPwF3rW/+ZZBi
	PQg4jPab1EyOG95ANqpyO818reStkDr9SjDfWpWAddSD5NzcYCPr15BNO+rKNn2NqpKSHVakdwA
	ysSihEld8x4OM6eYxHfEoxbOzGD9jvktaz94jk1rQ1PEFmy8Bbtx+5DY5f3UQ16YodP8=
X-Gm-Gg: ASbGncvyFmcsMx7GPUxEoBuN2XPyIsSM4rF0uQm79VT8SQ+Nn2XNlh5hxDVT43X3HkN
	LmO6iG2IXWRgYXWTBNohoodomWRDd0wHs7KQXB1fBXiRcnv320oEJbKI+x381qU2VpiGbIq0PVg
	xfuDpyWlvYZYHGV8SAIfbMc8WEk3R3xKjG878FWKqF8/QOiGNU4j5HFTWJ/pJm/m3BZraLhNwYC
	i1yMDTGlyAiTJgEjSeKI+KxKHwhJI4CAGo8r6uTaypVipljXx0JLH4WjUaJc2+FPjuT5dIFZ9Nk
	H1EeXIMgfUCPXC4hkZsc9ejWept9MOvvVydhMWOHd45lBF67EGJXY+AhmhLYfZs=
X-Received: by 2002:aa7:88c3:0:b0:747:ab61:e4fa with SMTP id d2e1a72fcca58-7490da4a743mr4521610b3a.14.1750429711238;
        Fri, 20 Jun 2025 07:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8AqXLFkwz0QSfwU9gX6l+H/B9X20dgZVbMCYNNJ+6/zgR9Um4zjBr3hKxT+ilWXhOO5Gfqg==
X-Received: by 2002:aa7:88c3:0:b0:747:ab61:e4fa with SMTP id d2e1a72fcca58-7490da4a743mr4521582b3a.14.1750429710906;
        Fri, 20 Jun 2025 07:28:30 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a621ceasm2262963b3a.97.2025.06.20.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 07:28:30 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:28:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jan Prusakowski <jprusakowski@google.com>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
	fstests@vger.kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v1 0/1] generic/018: do not run the test if a compressed
 filesystem is used
Message-ID: <20250620142825.hczg4ldsk46delze@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250620082906.2122560-1-jprusakowski@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620082906.2122560-1-jprusakowski@google.com>

On Fri, Jun 20, 2025 at 08:29:05AM +0000, Jan Prusakowski wrote:
> Hi,
> 
> We're testing F2FS internally and when we use a compressed file system we

I saw you used _require_no_compress in your patch, but this function only supports
btrfs checking currently. How do you avoid your test failure on F2FS?

And there're many fiemap related test cases, will they all fail on compressed fs?

Thanks,
Zorro

> see the test generic/018 fail consistently. It looks like this is due to
> fiemap not supporting compressed extents correctly:
> 
>     [...]
>     defrag /vdc/fragfile.9981 in region[0, 40960]
>     /vdc/fragfile.9981:
>         0: [0..31]: 2682968..2682999
>         1: [32..63]: 2682976..2683007
>         2: [64..79]: 2682984..2682999
>     Failed to adequately defragment file
> 
> We'd like to disable the test when the file system uses compression. Please
> check the following patch.
> 
> Please let me know your thoughts on this.
> 
> Kind regards,
> Jan
> 
> 
> Jan Prusakowski (1):
>   generic/018: do not run the test if a compressed filesystem is used
> 
>  tests/generic/018 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> -- 
> 2.50.0.rc2.701.gf1e915cc24-goog
> 
> 

