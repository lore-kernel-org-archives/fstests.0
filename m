Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA21CCEC4
	for <fstests@vger.kernel.org>; Fri, 11 Oct 2024 05:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728625846; cv=none; b=Fg6NZz9nx41p+77HcXR/5yoCVWboTTMrle5UOYgugTYIOEl4YB2hKxyqgaNizY0xzGoFqjPCYH/3iCpfQLLZINEarqVkfDSG0jN08PlYdAQBH2M8k1YDR41QsXrFAG5MfoEFTwbuumjDLkSYes71bvmJzIzncy5HR41RPf5IBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728625846; c=relaxed/simple;
	bh=xVxGxZMNwukkZYfK5C6gY9+PsdxCXGzWSAuOIuPgRxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5aHD9tcZW0XM+t0slt8a6El9OA8+6ISRcZuLzMvAVQjig1cDGwM/VGARIE09RqcfmttPUO45cUIb4OKR60VfQY7yuY7WPyjQZkIjPIhuFljKSrPX6Bzil0+d5z1y7sz0nKeFnv0DY3G/m4BogAL1OJzHoqfkEOsix+23opjie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwBDJpwu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwBDJpwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728625843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=At274ALujhsvu+0uU+9JDSzZXqR3COc/Wp3QICL59cU=;
	b=dwBDJpwu7ZI6FJK05d8Bc7kIUWKKA1cAzCzN65MZiyt1J9Fzr9dQsnoEY+c52ooprZOZUj
	iTcmPv8A9QnZU3Bo1Iz7tIVLtSNE27Gv93FO97m2XRza+U6/Tzu6vsOuPvZ0Hngsh4eJq5
	bFmxbmCbShpBGM5KRSyDEHcnJvb+sCA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-yZBmCg4APsquY_iaoR_bXw-1; Fri, 11 Oct 2024 01:50:42 -0400
X-MC-Unique: yZBmCg4APsquY_iaoR_bXw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7e9a3e3ec4fso1325524a12.2
        for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 22:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728625841; x=1729230641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=At274ALujhsvu+0uU+9JDSzZXqR3COc/Wp3QICL59cU=;
        b=i1AzZfjXEeDzHX36JJT+68OJQlpnibD9STXJFHUBpB2vezcdrI/SDPQtvO3OmvyBiW
         Gx9mTLjDvLrOJcEr3R1tvKpvoL/AT9Hr2Ze9umyqQ3oiMcv5Egqnv/kkDjqZnCz2Pazz
         QJNVKQccUqLtyb6VFdjZaF6tjeGMlmgbS6KLxhAwp50rcbC/21JdoU9lYGyvruFft0TM
         NRzvYeA3zC1nOu+if4FdvSMA/BD3jMTdPHozPi0pVqgZwzWgQ/b5BKHPxQwHHo86svfw
         wF9QBtGtB3qnaQ+W4TqmYPUIisW3DgWF/9GwEA26EvZTsL59vIx74duG0crWISxEojRa
         MKZA==
X-Gm-Message-State: AOJu0YzdjhLzcxPLCwh9WmlFwJpXrByuW4/h+J+OMXnZz0jBMOHCK70Q
	Z0OK++VqCjJV+6wSfHV5yXf9EIHez3Qe21/G7j1+JgtHitAus4iXMzkMDv/A7A2UFBqOfucEsgi
	GJAG9lIRR/SJ/72HramojRzA63Oamcxv8nrM1B9R+jg+0SJ8SKm/Lfpr/lWfOBGUjog==
X-Received: by 2002:a17:903:24b:b0:20b:9088:6545 with SMTP id d9443c01a7336-20ca16c5aebmr17202705ad.46.1728625840968;
        Thu, 10 Oct 2024 22:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPRS6bhWYTll1hI78YlQCiApHwYnKfvaMcNmDJJ24tysRwQ7lpDL4ESjmbj8Eaj13BOPIFyA==
X-Received: by 2002:a17:903:24b:b0:20b:9088:6545 with SMTP id d9443c01a7336-20ca16c5aebmr17202525ad.46.1728625840616;
        Thu, 10 Oct 2024 22:50:40 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c215f0esm17611245ad.219.2024.10.10.22.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 22:50:40 -0700 (PDT)
Date: Fri, 11 Oct 2024 13:50:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] check stx_dio_offset_align to determine if DIO is
 supported
Message-ID: <20241011055036.hs7v2hordwwliudq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240923090607.953579-1-wubo.oduw@gmail.com>
 <CAL3q7H4dthnioL3m9ejzp8sNOeaYLZpRxd2ciEi36uuZSxGoLg@mail.gmail.com>
 <20240923134603.cs5u4ea7bnaarnme@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H4MVxFMU1LqESrnACc28sHhUaPvy4_FTP0qh4qiEsttSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4MVxFMU1LqESrnACc28sHhUaPvy4_FTP0qh4qiEsttSg@mail.gmail.com>

On Mon, Oct 07, 2024 at 01:14:09PM +0100, Filipe Manana wrote:
> On Mon, Sep 23, 2024 at 2:46 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Mon, Sep 23, 2024 at 12:01:22PM +0100, Filipe Manana wrote:
> > > On Mon, Sep 23, 2024 at 10:06 AM Wu Bo <wubo.oduw@gmail.com> wrote:
> > > >
> > > > According to the statx manual, if stx_dio_offset_align is 0, it
> > > > indicates that Direct I/O (DIO) is not supported on this file.
> > >
> > > There's already a patch for this:
> > >
> > > https://lore.kernel.org/fstests/20240911035333.364961-1-chao@kernel.org/
> > >
> > > (but not merged yet)
> >
> > Thanks Filipe. Yes, this's fixed by Chao Yu. You can check it in
> > "patches-in-queue" branch, it'll be merged to for-next soon (this
> > week I hope).
> 
> It missed the last update and it's still not in the "patches-in-queue" branch.

Yes, sorry I missed that patch, my bad. It'll be in the release of this weekend,
I'm sure about that :)

> 
> Thanks.
> 
> >
> > Thanks,
> > Zorro
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > Signed-off-by: Wu Bo <wubo.oduw@gmail.com>
> > > > ---
> > > >  src/min_dio_alignment.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
> > > > index 131f6023..c50ae8c3 100644
> > > > --- a/src/min_dio_alignment.c
> > > > +++ b/src/min_dio_alignment.c
> > > > @@ -28,7 +28,7 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
> > > >         fd = open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
> > > >         if (fd >= 0 &&
> > > >             xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
> > > > -           (stx.stx_mask & STATX_DIOALIGN))
> > > > +           (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_align)
> > > >                 return stx.stx_dio_offset_align;
> > > >
> > > >         /*
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > >
> >
> 

