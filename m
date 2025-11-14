Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4E280330
	for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137079; cv=none; b=maD+gE3h32zJ18/dCxqzn1KNPHNVRvL+KW79kUHZrh6+gt0puvGoPO8KiSvBnI6jR3ibc0ePlClNtbfi1C7x5O9l/VgFcirDXIw6OqSbe6XiQagU7BpEJhCyxOI44GIf1HaE1z2KcmKhbCuP7DxrRoGlT4yYnd/S6LkcjfhYwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137079; c=relaxed/simple;
	bh=hsLzaCoCl2lTFsnDTRe+aZoOm/cGSPDM8ESyOdiUb30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiZvEmwkekvzCQTwgdsnntn4zyTdBFfDkHWoUq+GGguqH+YJXi4SKzW6JWJGq5V248RKNM8DjhnMP8OOGTUxJxfXFYM1DCH6W1TsX3Fw2b1eZC26FOXad3UIDPDwVKbaScqvBlTfhlorPHg/fHxIqGOgmZtSQmUcs1WlcAuVKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOY5NCas; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULtpUvjj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOY5NCas";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULtpUvjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763137076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9T5qQ8wp+xkTyz6Ll5zoby6bk6s5RhCLa0mefFxCTyA=;
	b=cOY5NCasOl1YokogMbfCW8YqCLYnN+Aybu/GFiy+r6vZciRg1tx8h56jJlFNqZgQQbXzfl
	DF7h/c1OUHYIX63FmNdnLFmp1quZPySOWo7SIoXBF9t+vb48XcQw4NYsz/2k7X8SzcNTGc
	c8/T2Ld+2Rk2ttHSaiwnZej42N/I6z0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-hHKrCGfSPlSXxsCBsUzJQw-1; Fri, 14 Nov 2025 11:17:54 -0500
X-MC-Unique: hHKrCGfSPlSXxsCBsUzJQw-1
X-Mimecast-MFC-AGG-ID: hHKrCGfSPlSXxsCBsUzJQw_1763137072
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b895b520a2so2344803b3a.0
        for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 08:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763137072; x=1763741872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9T5qQ8wp+xkTyz6Ll5zoby6bk6s5RhCLa0mefFxCTyA=;
        b=ULtpUvjjCB08S2/hUZH4Oc3u7sAJEqZ3EI4XR6QS0dXPhqrjamyDNuccmff+q1xduy
         epmaOKa9aQHbQkS5TUxHgyODsK/cqgNa2c701yhwaGpZ6Gcur89rR6onWthykGJ80XzP
         wORzb63MEmCfMDCIShHyYYh7EYYCuYTJEHgBy2SSdQCJJPJ7BrE9X2KJ1NF332PZsz8C
         eZLv0d9/ytM0xy+gE8zBlTPIgFIeOzxsQDMA9/8trr482yTQbl5kxEqCwtipLqjKybiI
         t5HXgYWoL6ZmHWtyNm4CgfsNOqcQvR+kWbLLRDvbA3pzHpbofYTbTEnDdfffVnw8Ltn+
         sLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763137072; x=1763741872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9T5qQ8wp+xkTyz6Ll5zoby6bk6s5RhCLa0mefFxCTyA=;
        b=UsyWLO7SvFaH7ysOmGXk5Ygk4PTqPm067wIlq+7AW+OACax8SuWEfeNjrh+m0xZRMV
         EGMDNH79XQ/nZk59q9EU+ckvzPfjmcU9wnbRvRSmu2qCvdauWTZqRCZg3iRKL+pp5usd
         27nH4nwFlrt05acl/Wj9V8uqwiXvt751rQRMa99SWNRb95Dc/QiWQBy52uaYL8wvr0Io
         7UUevGPu/fcNZw7jYQlk9Ilf4LpWjTIxRV7sedjl+Mzzcx43pNotOL4kuE9mpejAuDU5
         gIKiN6DnzjYhWCetVqqaX69NV72YTgZdBe065sOIzzo2exU+ADM2VzFW8iy4cIgFeTGE
         Y+2A==
X-Forwarded-Encrypted: i=1; AJvYcCUNVrx/L8o0PrThXIVwyxhwzElJpREKMNHR+2cQ4afoUsnasZNRvjmHq29rQPmzHCIxC9v87Oml@vger.kernel.org
X-Gm-Message-State: AOJu0YyCK51qbLYmjtpE2x/dMcxmCUw5AclIcR/94jNX5cOD46BcH2z+
	wz9mymda7NMoJsAyW1Ms8UUQOQib2BCxKTYM8VRNjoC54sjCQjvefpP2j8LegkYHzrgg4k2UpW3
	kRnK0gxtWA5ixZ2y/Z83ImFbnxFB+EId0Fzh6gw3vuZ5qKHZe+ztg4yRJPIM=
X-Gm-Gg: ASbGncs2S4M/vWnNtd+P/rx9nLUqI+hZnPh8XMWK5E/+O2u5gdqwih3nrlEWy5ogpYW
	TQ50qg/6verVLVakS5XCj5dJKn71SV125Dgrl8zuTGuw6JZNgrAL6qZNTM/OOOvzkXGGGc5n3Wo
	6j3pm0c4FqjQpM38PYC1tpHSb++Y+X3yVnfHDP5hwLAvmvV2EiEaYUaLPelTLhFhsY2VhMKM7wg
	ovdGjS2tSCFXbl69F5rDi3ccyqI5KMP3tuMc8HHp24ASiodjk1Ahiu7yEFtxQmJRWuZjF53YX4G
	pB+6YnJG5jw5WYpLZsY/PERMqIWScXgxmRaLz63DnEhLffIu4sHE62YZXpQbZ7HJBi2gWxWzzq/
	Vo0QkL2ROjN7gUuOQusCfKIM6amXDRON+EjmkxF7T0Ud4j82R4A==
X-Received: by 2002:a05:6a00:18a9:b0:7a2:7c48:e394 with SMTP id d2e1a72fcca58-7ba379a7b0cmr3956825b3a.0.1763137071931;
        Fri, 14 Nov 2025 08:17:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdnNJZYuCUsCAT9lJvgWDFizZ9BmIUoYCFtBVbyBxkzrLxhnYu5zFQo3+Sz8x8gmmzfC5QjQ==
X-Received: by 2002:a05:6a00:18a9:b0:7a2:7c48:e394 with SMTP id d2e1a72fcca58-7ba379a7b0cmr3956797b3a.0.1763137071478;
        Fri, 14 Nov 2025 08:17:51 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d2d16sm5658339b3a.22.2025.11.14.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:17:50 -0800 (PST)
Date: Sat, 15 Nov 2025 00:17:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH] common/atomicwrites: fix _require_scratch_write_atomic
 when awu_max_fs is empty
Message-ID: <20251114161746.32vqxpj33tliuxit@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250906131722.1333025-1-zlang@kernel.org>
 <aRcDQDDhbBX6oHz6@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRcDQDDhbBX6oHz6@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Fri, Nov 14, 2025 at 03:54:00PM +0530, Ojaswin Mujoo wrote:
> On Sat, Sep 06, 2025 at 09:17:22PM +0800, Zorro Lang wrote:
> > If a kernel doesn't support atomic write, _get_atomic_write_unit_min
> > and _get_atomic_write_unit_max will get nothing.
> > 
> >   local awu_min_bdev=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> >   local awu_max_bdev=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> > 
> > If $awu_min_bdev and $awu_max_bdev are empty, then the logic likes
> > "[ $awu_min_bdev -eq 0 ] && [ $awu_max_bdev -eq 0 ]" is meaningless,
> > and it causes g/767 hang on system which doesn't support atomic
> > write.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> 
> I can confirm that this fixes the hang seen when xfs_io doesn't report
> atomic write limits.
> 
> Feel free to add:
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks Ojaswin, this patch has been merged, feel free to use the lastest
xfstests to avoid this issue :)

> 
> Regards,
> ojaswin
> 

