Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46D20C461
	for <fstests@vger.kernel.org>; Sun, 28 Sep 2025 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759068565; cv=none; b=JqLVEe5HieGGa8Ne4B2tyGQvCIW2GGwQQjg3fQMMDzMa30i5/YzdUYU+fGPNRUw6+Vm5hqXatI0kser9nwf/lR0RaYYSSMIS/DrqkOkgykzDoB6mGUq/96JGbNirZmgQXuoh+iFhQZCTsuoasY5JRShY/No+qGL/vbID7r8AV+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759068565; c=relaxed/simple;
	bh=HIv9fxeKoLpkODQ6gx+4GUvWUiSEZp3tB2+TUXxAHmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKBkIYR5k6+KsQqhZpwMeP7aNO961lWwIPxUEMaiU1zhmWar5TqTR8qfLg8Y85coQuHOl1C5rzh3PNYj1wFi3+5piAE7B4NQ7EmKHzxUaVjwG6l+/x2UJbqqnT7TIokqaHANia80PKUCgfpZuIeu781tPEw8Xr4lfRyJbBI6gw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbEmMImg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbEmMImg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759068562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7phqQjkQjET3LfaZXC37tPIuWA1DfFBJL3a2NYjcDU=;
	b=DbEmMImgXwZDzSiItq1TMeBH2hiI4mDw0ZKIg0oamBkw1kEVbojX8RURKYEKoGmKYxjb6Y
	mCPJQK0xxbwrlEzeoNVoZ82N1uWcvUX4aR8RMPTGyOeJFC2HyzYDlMoWRloWCfL0QxMvFP
	1eVX/+PORs+gH0jodK/GM9tHFCuc//I=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-Fs0LLzLVNNOu3_JivgSzRg-1; Sun, 28 Sep 2025 10:09:20 -0400
X-MC-Unique: Fs0LLzLVNNOu3_JivgSzRg-1
X-Mimecast-MFC-AGG-ID: Fs0LLzLVNNOu3_JivgSzRg_1759068559
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7821487d16bso1702389b3a.1
        for <fstests@vger.kernel.org>; Sun, 28 Sep 2025 07:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759068559; x=1759673359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7phqQjkQjET3LfaZXC37tPIuWA1DfFBJL3a2NYjcDU=;
        b=sEOWtHnMUhuUPvsKjXwNklwGPQrg5yvshxqGmZUL4Zvo7qcOzeUHA/DDKMC4TTOUB7
         lRPXtmOIRqFoxHoblv9ngSEdE3hJ3p1t8sap0TTnD5Ya4a5rMlc3U0a7dwcvmnfBN9gW
         5COBnCIEfzrbeyqMQumrQvd4V/MK+XdjnZ/kVSkpBYocO3kXoZx8wKIU7dqmhgl3X+Md
         X9F8th1J6FzduGf+e2MTemS2HqFO21I907p4SO0x95UGhVRfg101iDlEy37r9N+qPtX6
         MLb2p1HiOZgChDyNA9Vwcf0AtFIvQIReAevEtc1nDkPGjYGsRt6Hzd5zUD/umqRmiPQj
         ziNg==
X-Forwarded-Encrypted: i=1; AJvYcCX3VG2SKrXFXF2nNsmV+k5yTSbFKV6TqhWA0ZRT0ewJTrjEUp6GDUONN9TGxSTLyNAUbhJToNYf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xj37WfwIoeIOpKNQAEMxSaMB1Rfi6jBqJl3C/g/Xic3gEeST
	lO0bXIhtUAI7KE3jT/MEsF+hsC20VWgCQDC+OohUXGaNx9YpdytgZcGKYSKgCQSXuS2isnNSNNc
	FjMgIacI7+hzG3o7H4VG/3EnovjmIMJtFhXtw+v7cZ3Sv3XVjVknLymRbSOk=
X-Gm-Gg: ASbGnct1NPlTIoOvvLTy0nIRzMqErQshB09JQRILirJx8QxWVKjCxMu+4XjEcjXivGY
	0PmI/pFxWgIZOmvl7TFq1/hLtnotJGGJMK1ft5RrZa0AMjX4q2UoWgOYOqyXKRI1FQoc63NpmAU
	2/kyrluJIDPSauvrkenY6qnyadCwabKzvf5BvecRxydFbWFNKOYU/OyejhjNI/Jx/oOnYeQ5s/+
	sPJ+afly0LK4xO3LzMMP4cv4uQrrr3tdSZN55w7vQa+XN1R0o9kz8p3hIEkWoJCEQF0k9Ozhxhw
	8Aso7Jwa+OW2mjC9C3j8vdsdVjLHdf5PC4ydLaK9sJO+YldvfIi6RMESvjaqNpzHlYRuQH7HptR
	wlPv9
X-Received: by 2002:a05:6a00:3e27:b0:781:2538:bf95 with SMTP id d2e1a72fcca58-7812538c1afmr5863338b3a.10.1759068559233;
        Sun, 28 Sep 2025 07:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9KwuyyUxEYxrcXGvbZ56lhVKm2MUGHT1tYoWpwyucJ5NEUp+nTy3kb4K12c/ZZMKGd/lvTg==
X-Received: by 2002:a05:6a00:3e27:b0:781:2538:bf95 with SMTP id d2e1a72fcca58-7812538c1afmr5863322b3a.10.1759068558888;
        Sun, 28 Sep 2025 07:09:18 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-783ad5e99acsm1496423b3a.22.2025.09.28.07.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 07:09:18 -0700 (PDT)
Date: Sun, 28 Sep 2025 22:09:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs/26[67]: update the stale comments
Message-ID: <20250928140914.xufifxpgz6dpnqmd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250918224327.12979-1-wqu@suse.com>
 <20250918224327.12979-4-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918224327.12979-4-wqu@suse.com>

On Fri, Sep 19, 2025 at 08:13:27AM +0930, Qu Wenruo wrote:
> Test case btrfs/266 is verifying the buffered read repair on RAID1C3,
> and btrfs/267 is verifying the direct IO read repair on RAID1C3.
> 
> However btrfs/267 is using incorrect comments, it says the test case is
> verify buffered read repair, but it's not the case.
> 
> Fix those stale comments by explicitly mention buffered/direct IO for
> each test case. (btrfs/266 for buffered, btrfs/267 for direct)
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Makes sense to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/266 | 4 ++--
>  tests/btrfs/267 | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/266 b/tests/btrfs/266
> index 3490ecce..f8407c98 100755
> --- a/tests/btrfs/266
> +++ b/tests/btrfs/266
> @@ -5,8 +5,8 @@
>  #
>  # FS QA Test 266
>  #
> -# Test that btrfs raid repair on a raid1c3 profile can repair interleaving
> -# errors on all mirrors.
> +# Test that btrfs buffered read repair on a raid1c3 profile can repair
> +# interleaving errors on all mirrors.
>  #
>  
>  . ./common/preamble
> diff --git a/tests/btrfs/267 b/tests/btrfs/267
> index 66e08d18..22c4aeaa 100755
> --- a/tests/btrfs/267
> +++ b/tests/btrfs/267
> @@ -5,7 +5,7 @@
>  #
>  # FS QA Test 267
>  #
> -# Test that btrfs buffered read repair on a raid1c3 profile can repair
> +# Test that btrfs direct IO read repair on a raid1c3 profile can repair
>  # interleaving errors on all mirrors.
>  #
>  
> -- 
> 2.51.0
> 
> 

