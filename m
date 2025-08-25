Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C02FB60D
	for <fstests@vger.kernel.org>; Mon, 25 Aug 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135777; cv=none; b=qeTzb74ayhGe5pyGRytS55bdT1W1tML6duFcK3Ch4CXtfq6OyuasS3cFbkULGykE8y5LOaM/+Mwd+eTTqe2lZBuGo5m9ciD13/PmxTA4LNhcsqnswPA0qQKE6cw1iPFBP4OCMMewRihxNHwq8bEcy5pmBwURA0Yitpzp6H0qypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135777; c=relaxed/simple;
	bh=J3OexhTznRccGZs6rVKORbGFuV/gnAKP1RScDPG8lrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOTg28xaiA7weWZ46AB7tsZ3ydbEtJMQbehg4kwBKCBUNeoOJqlpPy3NeV4bNXWNC5BYOKSCyFSxcpS+fQOgopHmvG1UjC8RfX0wNGKYl7GPKx42w94oz5XXbBM0zQS1qH/MBE6YdzQLvLLB+ffEc47iZQx9G9EZW+gBeek440M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehts61jh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehts61jh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756135774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1i2+2A3UxG6szUKYKSkulwqqvxOOp1ZI6uI4Bar8uaU=;
	b=ehts61jhmzr6ZNeap394AF7LuHKL98Fc6+BL4YzkDqr0NKO+O5tm/MvFesC6C5dmZ/7WYs
	YlOEPp4tPxlI0TsGY+gnPd7bBcgv2M9ksQAC+XZ+dj3ABFUGPFvPVJcQ06dHJdcy5Wo7FF
	MbpyxIbWoIf9hlKefuAg4NZahXkybbQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-cfhdfZq6Nv6jqCbEE2E0MA-1; Mon, 25 Aug 2025 11:29:31 -0400
X-MC-Unique: cfhdfZq6Nv6jqCbEE2E0MA-1
X-Mimecast-MFC-AGG-ID: cfhdfZq6Nv6jqCbEE2E0MA_1756135770
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2465bc6da05so35051115ad.0
        for <fstests@vger.kernel.org>; Mon, 25 Aug 2025 08:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756135770; x=1756740570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i2+2A3UxG6szUKYKSkulwqqvxOOp1ZI6uI4Bar8uaU=;
        b=t3mP5y+XHGdT+CfVioUb8iZwdnYVW1nbmCG8FNVZCNgWjzYZZ0BmH4vh5ae0GB6e+6
         3FebMPfZ/xJkLeYp+ZSV2fGsvUnFG/48XrkVlcDIfhomsxXXAt/xXID11sZvAPp4hIf0
         LCtKCAF5xzFiPpOCFphQDhkdYk1dA0yRsvwEvfrnyXV55R4W8E1mONDtZjhCQGIErioi
         OTpN/R5hqu+dbqGEXdc4lXacKw99zRR5aAk+qFlKDsxJZMmO5CP26S6uOhrMLR1X/P/+
         7Ddb5rWPIshUEMAi4cmVaILuVJBsjXQjHwUuhtGGqMygacI68lz3V3haNviId5JXKm/m
         EU3w==
X-Gm-Message-State: AOJu0Yxvt9bE0NnuK4rMRJLPDrwBhZmHk7Mie4DZk2SgVy9R+D94iGio
	rWJi7AAjgs8xge2a8Is4Kf0NTKAa3+Kzjyd2ox40l4OLfYN2af/8lfZgukVCcj3d/EtA95p4Y1V
	11YxpiRK0FBfl1Qt/mataTPlVTIiXdUyAZ/c0+hPFBJirTqx+JVwqTD72CgU=
X-Gm-Gg: ASbGnctoXkd/7ODT9rN/q5Q4eFEXqNNM8ifEfHMbkqPE94v2D9poff5ffZ359cwTrTe
	fJUJQVsXqZ42QQNBEQXnRdlIicfVRGsO9BX6RnDa9fogif3R1BzmxOz/Wcoj/XGupcPneI6SGNH
	FJbU2ErNrfY0kEpG/NU9BAENc4IZIoL9s4KGUo4a/WspxtXozLmIqX6lYO6mccEj5mtGVHcxaI/
	K2deV6mKkpKs/7eDvayG/GlkBBpsyikCBXYfXZKbZvPbbbxgzT3khE+8FNmb/7gnvMeSmbvWrB1
	ItJC2dPAT3FSAMuR5As5u8iQiaL9xkbrZT3a0xtNq5hv5n9NWN5aqZF0zc8aqKUS1G3v/AiNh3s
	B5Zth
X-Received: by 2002:a17:902:ec89:b0:246:6fb:5016 with SMTP id d9443c01a7336-2462ee8df3bmr168166815ad.20.1756135770227;
        Mon, 25 Aug 2025 08:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkjrdn8sUCl9oN5WP7fv8c57Lb6oiCyKRUuIJz4eEVVQ+NkS3wVSOVsUIBXnoXNW1yzDXQtw==
X-Received: by 2002:a17:902:ec89:b0:246:6fb:5016 with SMTP id d9443c01a7336-2462ee8df3bmr168166495ad.20.1756135769854;
        Mon, 25 Aug 2025 08:29:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254c47f2dcsm7174352a91.31.2025.08.25.08.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 08:29:29 -0700 (PDT)
Date: Mon, 25 Aug 2025 23:29:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic/365: Fix false failure when mapping ends with
 free space
Message-ID: <20250825152925.tcbbn5rxbjpk4ts7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cc80fdb62151d677809f2eb36eadebd3720c8701.1754385487.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc80fdb62151d677809f2eb36eadebd3720c8701.1754385487.git.ojaswin@linux.ibm.com>

On Tue, Aug 05, 2025 at 02:55:56PM +0530, Ojaswin Mujoo wrote:
> If we have a small FS where the first free space mapping is also the
> last mapping of the FS, then the following sub-test fails:
> 
>   echo "test whatever came after freesp"
>   $XFS_IO_PROG -c "fsmap -d $((freesp_end + 2)) $((freesp_end + 3))" $SCRATCH_MNT
> 
> since there is nothing after the freespace. Fix this by punching a 1M
> hole in a 3M file to ensure that the first free space is always
> surrounded by allocated blocks.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/365 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/365 b/tests/generic/365
> index 36cb2530..bbadae71 100755
> --- a/tests/generic/365
> +++ b/tests/generic/365
> @@ -32,6 +32,10 @@ if ((blksz < 2048)); then
>  	_notrun "test requires at least 4 bblocks per fsblock"
>  fi
>  
> +# This makes sure there is free space surrounded by allocated blocks, which
> +# is needed for some sub tests.
> +$XFS_IO_PROG -fc 'falloc 0 3M' -c 'fpunch 1M 1M' -c 'fsync' $SCRATCH_MNT/f

If you add "falloc" and "fpunch" operations, you need to:

_require_xfs_io_command "falloc"
_require_xfs_io_command "fpunch"

Due to not all fileystems support these two fs operations.

BTW, I'm wondering how small (and what kind of) the fs you use, cause there's only
one unused region, even this's a clean fs, there're some still many different
metadatas. I even tried a 100M ext2 fs (which doesn't has log space), there're
many free space regions. So I'm curious, how can you hit this issue? And if the
SCRATCH_DEV is too small (e.g. 10M), do we really need to test with that fs size:)

Thanks,
Zorro

> +
>  $XFS_IO_PROG -c 'fsmap' $SCRATCH_MNT >> $seqres.full
>  
>  find_freesp() {
> -- 
> 2.49.0
> 

