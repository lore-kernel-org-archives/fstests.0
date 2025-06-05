Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E81E500C
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131543; cv=none; b=f6eImNKSclayJ/ewdntCCoBfJ1A7pX788Ze7uRagN9ou4VXSe9OsVdhEYgXMWJe519r5S9aobbokXDbuAaBAA568DO760+E2xiPbhIc8p86OSh/f6et0t7i+LIEDC1DrAZxG65P/4zRSJOAVUeek0I2VC95kC8QMI95Op4q9Kak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131543; c=relaxed/simple;
	bh=gZRg6kzjFZMvhrvX33Zd+8gK9fmYwo6H8zdSRVZFC4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oedEDdc0UzLveW95W55HerXFXHJfSy2vapofyalnXyKvtk4zCsb365e3/p0TerA2fT0tUb+yjBCXy8GnKY0Pxc+Rhhg7L/ZcRpB4f5/oYucZB9/3HtEpUZhqVQCPxW9PAKylP8AXA1qgAyc7dsJKBetVcY1a58kUT2u9K5C7BUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOLdPW3L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOLdPW3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749131537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bMDGXsiJeDeXpV1GnUscnX3LBbDZTVa7SCUoXvn1oVQ=;
	b=MOLdPW3L2R5e7y12KlkOK7RBvqJ/vTV30yBamE0TgC4JZCBV0sNovMYtxWoAFx9p4bI5Vf
	CpoYUi+uUXIgmh7HCujZAJndW5KP7j3w6Krjbisl/TTuiVu2zICFJdYCtjKsDqSoNekdzJ
	MnvaLygdC4Zj+ZXQCFmoDp0g3cTK1vs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-50C5dGmdNiGfgkftyBzUlA-1; Thu, 05 Jun 2025 09:52:15 -0400
X-MC-Unique: 50C5dGmdNiGfgkftyBzUlA-1
X-Mimecast-MFC-AGG-ID: 50C5dGmdNiGfgkftyBzUlA_1749131535
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23494a515e3so8448505ad.2
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 06:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749131535; x=1749736335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMDGXsiJeDeXpV1GnUscnX3LBbDZTVa7SCUoXvn1oVQ=;
        b=cqLfEd1POMckjcmGHMhusoLxnlduMHIHm/qU/KHCPZ9jDhF1wYo01oLXifxPSUmqwD
         udbFpdpaFXB4YSpI/a6kjL0yCsOIo3pvrWbMyJutr0Vf9jETn40LyWsbIUShblyqMs2s
         idrsEkN1HMafOypB8gdt86H2Uz3FvxHsvmRjMkZ5NdZMbPG1XzKD/O/igU8ZR57qoPPB
         jfRItKMlVHsXKFPbB2rGivIsBeC85do0OpSSGysbrEqYM0AuYeBuK/rPR1apQWK3q8+a
         vPm21/H5OXcYWDx5FvQmomjf23BKmF8VPeGxQoKMsPTJJllA9tzjPif1UfqsLccADQ5t
         P/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL6q46pCvn0jixypTwZIxHfbW+KKhV0q8LAJIuR8sAKhdNG4tRq4qHnueR98VyDko071X9mnid@vger.kernel.org
X-Gm-Message-State: AOJu0YwVykRCdKiVP6t5ZwcfnwbJ6r+ZSg8Djgq8RyDtEEyPTaHmCsRT
	O1ca/lR8kh+BoT9ZN6DT2qzxH9H7N3STlUeMKqV4IpaWjRrHE9WVCNXrym9ArIr3aiIZ2CqT0Fl
	rAab7pUtOaCebGzZzPbtA9gqBUeSsG017S6jLDervPf3+VphmR1tym1fUmd4=
X-Gm-Gg: ASbGncuidsYUKdQII88kB8/Ch54XPXQgiJXCMlGFVh9nmnwZAWX57Hd4tIUu3FPMqlL
	zVGHe7pK/yZla+luRSL4r7pInRYFIyymzWbFR8AOao3MrUzqpUEYrXefL/AoAwOFnYZ6s8RVxNQ
	k7Ukvs3gJlxBEiALgSW4vwjDHjEWjaMH/lIkoIJkuVWw85Ue9Cr9Yu/edlaOfVqrm/dUKQYpZ74
	Zcmm97UD/aF5lXS9yXGLz8Ye3j27kzc2ZCRiGFrL8J1VylxxxFPazawibruACuw/TKZJIZE4J8I
	jW56C8gCG8eQCFd5lvCGef/1E7DxUS90UwC76dpzmlCsZN3nQfCH
X-Received: by 2002:a17:903:230b:b0:233:f3df:513d with SMTP id d9443c01a7336-235e1504f1amr110111685ad.35.1749131534805;
        Thu, 05 Jun 2025 06:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6YGJ+CzWhUNVyXRTp94d12NtkHpx3L0GPhQywe4Iz+ruwJP6714xt+3r4Kr2uPpMojY8Wtw==
X-Received: by 2002:a17:903:230b:b0:233:f3df:513d with SMTP id d9443c01a7336-235e1504f1amr110111255ad.35.1749131534411;
        Thu, 05 Jun 2025 06:52:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf53b5sm119890175ad.176.2025.06.05.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 06:52:14 -0700 (PDT)
Date: Thu, 5 Jun 2025 21:52:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/740: add _require_scratch
Message-ID: <20250605135210.zrezswl6qgc62mmq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250604131922.848228-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604131922.848228-1-hch@lst.de>

On Wed, Jun 04, 2025 at 03:19:22PM +0200, Christoph Hellwig wrote:
> This test requires a scratch device.
> 
> Found while playing around with a setup that only has a TEST_DIR.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/740 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/740 b/tests/generic/740
> index c0a634f2302b..d14e873b2fac 100755
> --- a/tests/generic/740
> +++ b/tests/generic/740
> @@ -21,6 +21,7 @@ _exclude_fs jfs
>  _exclude_fs ocfs2
>  _exclude_fs udf
>  
> +_require_scratch

There's a "_require_scratch_nocheck" in this test case, but it's called
after the "_require_block_device". Maybe you can check below commit [1],
to figure out what change do you really need :)

[1]
commit 3ae8a19f97d09852f59a8067d770930aa5f389ce
Author: Christoph Hellwig <hch@lst.de>
Date:   Sun Jun 23 14:10:34 2024 +0200

    generic/740: enable by default

>  _require_block_device "${SCRATCH_DEV}"
>  # not all the FS support zoned block device
>  _require_non_zoned_device "${SCRATCH_DEV}"
> -- 
> 2.47.2
> 
> 

