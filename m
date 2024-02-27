Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF82213AA2B
	for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039709; cv=none; b=DQ8ZfMfllweN39i0y5ggsC6VRug+mrSw+Am23pmWa/IA3J1JIyqDG9bPna2Xj0VAjkRX7VbcmzbIU6HEHthvbzMdLCP/mTvm0mMAQKVS0W3rrWz9d1MNcI28hknWt/PqAB6h8C2mzvDEhtv3B9lA/MvFDSDgMYhT2azTpOQ2YIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039709; c=relaxed/simple;
	bh=RdoEZdnKeMwHhIufQgp4wD6pluHZy4XXTgVN0yUnGUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGVslbn7mLHAUaZfrsGlf8NTl1aIxuomQZPnZohTBvJNczGIavD4hhkuaATCEtNMMeBixMZsLma1sU+ybWTq8SFw9epE4Zasb64Ms+Qx9HSo5iq+NyiHNNPZOXRVVCMbUE4hy5PsMdauyyC/qRNtmiJBk5q73WEM9t9XILZ7jZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIrOLQsx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIrOLQsx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709039705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9T4qxEfQQkvSyKLRfkGUn8zmmW0fCrKdZvbzLLoJxY=;
	b=TIrOLQsxFGHlYuQkQ/BRjOWcOXWVDOR/WMFC9B6FUtbME5C7KoBm+zQdEGbXyLn/jHPM6+
	ViHkMUvwk9xaTDKzqt2Wcg/dUr3Fg7VyhIROohIRDLnHAPTmLbPwdT1jfrBWYmfgUAmwbc
	vcX67mpkeMO/mgjJHQnsDPdTzEiD5jM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-aCBDkgvTODOiGIDGvme7WQ-1; Tue, 27 Feb 2024 08:15:04 -0500
X-MC-Unique: aCBDkgvTODOiGIDGvme7WQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5dc4ffda13fso3047961a12.0
        for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 05:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039703; x=1709644503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9T4qxEfQQkvSyKLRfkGUn8zmmW0fCrKdZvbzLLoJxY=;
        b=B/ax3knFyVPwqLZ1bBUm8V3LPF0yC8yZF8yLwfgJijhATIOefTFeZiN0Iwrw+WdnQK
         pK8HJaUZuZH9NZZ+o2+P1BRlaBbTYUM8bMcmwpOS9n5DKMd/wqYlnZK+q6n8dndOb3a5
         DsxhRJxB1npjEmZCxyn/R3Mus3DC6mXcUveZ+Cl3eiEDd4XCWC/DldM6/QvFGvFRwT2Y
         TP9SAf2wGPCznhdoMTciDt9L9flLHbpaItG/2haCweN0InEa1eQrv4PPQ4pnUxltWEUX
         lJUuDUk2O0VMcDM1zN7fbvWF5BHU+spGHFp+WjYeaJ/CjogH08JTQbSK9/zlLkdJSPYg
         dJwg==
X-Forwarded-Encrypted: i=1; AJvYcCVyWTk6pLOfXTyjzHZcLdikdEAuVSqS4p7dilxkjRr0MEdSJQP0ONmH4K5jLFq/OgBTtUT1F775f5nvM/ixSPx7AxjNj82ORA==
X-Gm-Message-State: AOJu0Yw9LNcUC6re0SCVYL64nQXbf/Q08wt2o8sUzcT6V34mlsTMpvQ7
	m85wDmLc67X5pwmamwYhIyMTq4GyurSpClFrXV/9a4BGonXcTOC79IL7sylj6xlS1GsKPx9D9KQ
	owuQokanqKlyyZFmQ1tJhv+FbZWfa6mkpHAsLYmUgqHHBbLkA2tib3cw=
X-Received: by 2002:a17:90a:6581:b0:299:a5a7:7579 with SMTP id k1-20020a17090a658100b00299a5a77579mr13130339pjj.10.1709039703685;
        Tue, 27 Feb 2024 05:15:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO3ubgAsXdpCQuwb7JVy+YhkjlQr/tcNGQCR2qWazznV/vQpwgX9UJwdvsoV1Iduq4JLjqhA==
X-Received: by 2002:a17:90a:6581:b0:299:a5a7:7579 with SMTP id k1-20020a17090a658100b00299a5a77579mr13130313pjj.10.1709039703363;
        Tue, 27 Feb 2024 05:15:03 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g16-20020aa78750000000b006e45daf9e8bsm5874881pfo.153.2024.02.27.05.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:15:03 -0800 (PST)
Date: Tue, 27 Feb 2024 21:14:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org, fdmanana@suse.com
Subject: Re: [PATCH v3 0/3] fstests: btrfs: add test for zoned balance
 profile conversion bug
Message-ID: <20240227131459.soq3af64vffgj3n2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>

On Thu, Feb 15, 2024 at 03:47:03AM -0800, Johannes Thumshirn wrote:
> Recently we had a report, that a zoned filesystem can be converted to a
> RAID although the RAID stripe tree feature was not enabled.
> 
> Add a regression test for the fix commit.
> 
> ---
> Johannes Thumshirn (3):
>       filter.brtfs: add filter for conversion
>       filter.btrfs: add filter for btrfs device add

Actually these two filters are added for the 3rd patch, so these 3 patches
can be in one patch, don't need one patch one helper. Anyway 3 patches are
good to me too, if you prefer that.

Thanks,
Zorro

>       fstests: btrfs: check conversion of zoned fileystems
> 
>  common/filter.btrfs | 15 ++++++++++++
>  tests/btrfs/310     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out | 12 ++++++++++
>  3 files changed, 94 insertions(+)
> ---
> base-commit: 5d761594fc5832d6d940f113b811157e332e14af
> change-id: 20240215-balance-fix-6bd7998efad0
> 
> Best regards,
> -- 
> Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 

