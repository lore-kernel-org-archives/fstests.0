Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305F19CC16
	for <fstests@vger.kernel.org>; Mon, 23 Sep 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099178; cv=none; b=KLBytmpoOSBrceoH4cRAxef44IbFy+HZ6L4sMiudTkTykTN7B78rpg9R/lDPXW1C78VaA6+AHWY1JHrpTW7XwpRov02LqAx9ts6vOBSAvSf4SaLIyAuPX7b7rLXNh3QTvZ53BO0kzW0mn+GkAKryHj3lcMAFCnHn3EttvmDWAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099178; c=relaxed/simple;
	bh=H+G5ZsrZcezv+gcIMH3r5WuGwG0Yvv+RZhsczkil9n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUQYdJ4AAzy+dqlbfZdhFAS8t1Keeufe0Vd4vGtg3LuG5EIJoPGYR9b3+hatvH0umbD5+KVu2iW2BH1ilKg76hlgu+70wqQ+H749E+p9KLKDcOOvF+qKihMw252TWTsPRHwNYqgMiExp/SL6y7JEo+yU5QndtNRIPCEgPgfutaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWc6HsCm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWc6HsCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727099176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk5yXTOkEaA8RqHM0++wGrXgkiSXFuOo+RmDWWPhCiw=;
	b=LWc6HsCmPN++q1mkNS/qPxTivJWjP9PpYW8VkVhTdXIKWd8Q9U6/JZ0oRI3X5vBATT5feU
	5dIdRRti6FIeFcBoxQU//vFo32b9VLyg0Dv8k8XcLVxpIkgSUsAa/R9vJJqwPQvHwF1DpV
	YWiyWXW9LfOjbwZypgf1kzgCt/GmolI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-X1Z2Op1LME-GBqT5NDOuhQ-1; Mon, 23 Sep 2024 09:46:11 -0400
X-MC-Unique: X1Z2Op1LME-GBqT5NDOuhQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-718e129311aso5367674b3a.0
        for <fstests@vger.kernel.org>; Mon, 23 Sep 2024 06:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727099169; x=1727703969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk5yXTOkEaA8RqHM0++wGrXgkiSXFuOo+RmDWWPhCiw=;
        b=c4Fhu5bd938VGireoRbhPAgSXfzslfCU384sy6NvcNUkaCJNC05zyaT7lGyzgLm0sr
         SgrgBkFChl+X/HH7D43CenpjRDVOEsTc/i8kELl1zeBikjmjTtzdFggaUXE6IwoXlaYU
         46DeSiQQXwg7a9o5/gJ6flOlf5mMUCFe+HW+m/qaLJqqovEJtTRH1VVRDTstx16LCUC7
         CAZsxbVa8AZFeXT1fpUcg8FvugzDGsaejvXr0oI8Kd7EB9MTt7PTxBMHEqgrqHxfDhPe
         DadmO8Ml3TYH8cB9AUs6ZwCJuceOphD71MrolZTGdhBDlJeEtbUhf0KlYObLer/myFly
         H5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXdvxjBDtD4ymB1VGxc8NN8wysTXBOJWqR8Pd7k+OlTYFXk2QAzIh5I8bs151eJdN5XeVinRpjM@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0LVul7+rj/g9zTK+/j/dUibzn0PaW4H+UtmZ8jLxuQckr/6w
	DlUFf+UVByVjzHoixQYHNC8xXhzhXBjS0t/pplTTEbHr0ZyphCVD/jyPmJnmm7l+RpGdt9rxutx
	YVgPvt4Gllk6yMRHtHTbbPtIc+/6OXavYdTpB9NGWe4CJ4ceSf/3NFquV4Ms/zjQ=
X-Received: by 2002:a05:6a00:23c8:b0:706:aa39:d5c1 with SMTP id d2e1a72fcca58-7199b0cff9bmr15319401b3a.8.1727099169105;
        Mon, 23 Sep 2024 06:46:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs6r6GbMmJ8Lz30BLUMZkGYDdpwgKQH+/HFDkwXpELvQYb9ljtkXY4IcoCcavxx2YS2QOQTA==
X-Received: by 2002:a05:6a00:23c8:b0:706:aa39:d5c1 with SMTP id d2e1a72fcca58-7199b0cff9bmr15319338b3a.8.1727099168485;
        Mon, 23 Sep 2024 06:46:08 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b18csm13869223b3a.100.2024.09.23.06.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 06:46:07 -0700 (PDT)
Date: Mon, 23 Sep 2024 21:46:03 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Wu Bo <wubo.oduw@gmail.com>, fstests@vger.kernel.org,
	Zorro Lang <zlang@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Wu Bo <bo.wu@vivo.com>
Subject: Re: [PATCH] check stx_dio_offset_align to determine if DIO is
 supported
Message-ID: <20240923134603.cs5u4ea7bnaarnme@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240923090607.953579-1-wubo.oduw@gmail.com>
 <CAL3q7H4dthnioL3m9ejzp8sNOeaYLZpRxd2ciEi36uuZSxGoLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4dthnioL3m9ejzp8sNOeaYLZpRxd2ciEi36uuZSxGoLg@mail.gmail.com>

On Mon, Sep 23, 2024 at 12:01:22PM +0100, Filipe Manana wrote:
> On Mon, Sep 23, 2024 at 10:06 AM Wu Bo <wubo.oduw@gmail.com> wrote:
> >
> > According to the statx manual, if stx_dio_offset_align is 0, it
> > indicates that Direct I/O (DIO) is not supported on this file.
> 
> There's already a patch for this:
> 
> https://lore.kernel.org/fstests/20240911035333.364961-1-chao@kernel.org/
> 
> (but not merged yet)

Thanks Filipe. Yes, this's fixed by Chao Yu. You can check it in
"patches-in-queue" branch, it'll be merged to for-next soon (this
week I hope).

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > Signed-off-by: Wu Bo <wubo.oduw@gmail.com>
> > ---
> >  src/min_dio_alignment.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
> > index 131f6023..c50ae8c3 100644
> > --- a/src/min_dio_alignment.c
> > +++ b/src/min_dio_alignment.c
> > @@ -28,7 +28,7 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
> >         fd = open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
> >         if (fd >= 0 &&
> >             xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
> > -           (stx.stx_mask & STATX_DIOALIGN))
> > +           (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_align)
> >                 return stx.stx_dio_offset_align;
> >
> >         /*
> > --
> > 2.34.1
> >
> >
> 

