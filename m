Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339C2DAFC0
	for <fstests@vger.kernel.org>; Tue, 21 Oct 2025 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039751; cv=none; b=kuhabFuw341mAIj+BiUwT0XWmoJI4ezij2oMXLQbJVY3EXbqltTO29ZOkLEvuyE/qTyGlIpLmfDY0M+ITuy1ddSsdMZj5dvPkEadW/xqsN0LOl3c2uPbusy6EDis2el/igRQ0GwGKJvOQzBNNCyolHTWObEGw18Xq0THTifrWGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039751; c=relaxed/simple;
	bh=D3BP5uIwpg3xO+TccJrXiMXlQvsPbJofIF9rLyHAHug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfTeqFANe6DFBHAWqk3DoxTET4EtgdsrghR3N6no3W/BWn3FNL0a8480NnPOvowh1op0NjOZS7pvXv7RXJbB4FjJ4aNurAQIGDqcqGHTI1YcqU8jpF0sv392xubsSThMkPp4l2XODLWQT7pmKunmOcFglG4puRHuEsM/LyceXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1fcUccX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1fcUccX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761039749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4yj562WwoiR5XY5KcNNse2uDUnbcLO323U1/FNFk9Vs=;
	b=N1fcUccXDjjjdXWyQXreSzURpKYB403K7JTHu7S8QjXoN5ReUP5gAROhVbf+byPpK0BAtB
	+4zbhts4doIo4Ra/lBKFeHVvTTPK5omBEW2OrPZTnQYTarrn7hbGOPqgpMF/Ky87QkZ6rP
	6Jg4nIYTNMAWV1NonyPA3hHXGXB193k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-68erKDtRN7Sia_Fd0wEzLw-1; Tue, 21 Oct 2025 05:42:27 -0400
X-MC-Unique: 68erKDtRN7Sia_Fd0wEzLw-1
X-Mimecast-MFC-AGG-ID: 68erKDtRN7Sia_Fd0wEzLw_1761039746
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426feed0016so2096094f8f.3
        for <fstests@vger.kernel.org>; Tue, 21 Oct 2025 02:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039746; x=1761644546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yj562WwoiR5XY5KcNNse2uDUnbcLO323U1/FNFk9Vs=;
        b=UCgqVIUdFtV458edLjIXGDdacHhK5hjYAX7WNeCebsUU2ckk8J/tWTpsqBa3xrdr6B
         hpJHJounxKRRNpSWb/1byNl6hT3ix2A9Bfcxy87MYiiPMr+zj+E4TqyH5PPgGiZKuvnZ
         8EilQFhwYF998aD08tvoC3tY7nGqfv6YKV7qT2MHo08McF7B8EJmEauxtZVAhZjP01CC
         OmI7wdPoqTUSY5oFZCDaKDRZFJJ1RPWf3R+T4st6MVPAZiq0niY2yCmCM5SyLm8gnk0c
         78OzsYQDCLc6P+N8kO0pT4+hYhDk3J/c1guQV03VvHWyxMi4s2hEvbpvX7IxCaq9MhXV
         KXpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLFLGesUDoHD7YFwT2/efHLTjy9BTROb0VeB9doTcKqfyMFeIU/kdlRY9Qd/5lkkTGDAx+8o+d@vger.kernel.org
X-Gm-Message-State: AOJu0YyD4xvJmDzTRaTqICMH8ATEKJc/Y0IAWIooKzoBR+u7mNykNyJx
	5KLIeyDfcgKzYivJ9B93aFqaTaqCofmRgu4JnSzQker4OMfA3oc5uBLJnFDrDTNWP9FBwG84Ho6
	+3eTLrv7zAi4pxSYWww18Lw9sYrYnx5vy7gFj1p4xxpS5jbIPyMavreh0kw==
X-Gm-Gg: ASbGnct+pqiJnGd54/8JI27p6DnlvtZiubY4XZjUeNYQ06HLKGt9xaJZ/+v+pnPmTwj
	yFH3Du41Pmdk+oW1wXLqUwFWbBYqUbaaBQyRQ8h/ksrDuadaYkmu50Mh+B2XxPf0RP1qsZzkllK
	aXDiM/3Aikartkk0s2pN7r5wBDoZAX4Ui5KjqkEpMFrW+NzVVhoyH8JqK5yqZcunoJRbye0bSN3
	1mwio0p5kid797SSiWkgrCgOfV2csc50iQpiwQpuMMHPgpKf2GbH5drQE2lYaQize86JzN4Wszl
	ssY4Mm39lMUUaCgO+rTUcgYPTPDwRZUEl2abKO/X3X9Y4D/2r8fDxtLCj6vfGYCrlJplKdDigSJ
	Whoz6YPjHMshfQkASUc0=
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-471179041b6mr121036445e9.25.1761039746114;
        Tue, 21 Oct 2025 02:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBHJPz5HBTwifjrXaKnSeeRQppAfGpsux0e+OVdcJS/6IrolUrnIWfgQ20MfbQvb09UnueJA==
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-471179041b6mr121036145e9.25.1761039745571;
        Tue, 21 Oct 2025 02:42:25 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114423862sm276085265e9.1.2025.10.21.02.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:42:25 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:42:23 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, zlang@redhat.com, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 1/3] common/filter: add missing file attribute
Message-ID: <xut2jk6z5ykoakmnnpeereg5fjxxlwinoxknraaktiimrgoyya@xjbahoc7nfll>
References: <20251020135530.1391193-1-aalbersh@kernel.org>
 <20251020135530.1391193-2-aalbersh@kernel.org>
 <20251020164624.GP6178@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020164624.GP6178@frogsfrogsfrogs>

On 2025-10-20 09:46:24, Darrick J. Wong wrote:
> On Mon, Oct 20, 2025 at 03:55:28PM +0200, Andrey Albershteyn wrote:
> > Add n (nosymlinks) char according to xfsprogs io/attr.c
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> 
> The updated version of "common/filter: fix _filter_file_attributes to
> handle xfs file flags" that I'm about to send will fix this up by
> documenting that _filter_file_attributes only handles xfs attrs and then
> making it handle all the known flags.

I see, thanks, I will drop this one then

> 
> --D
> 
> > ---
> >  common/filter | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/filter b/common/filter
> > index c3a751dd0c39..28048b4b601b 100644
> > --- a/common/filter
> > +++ b/common/filter
> > @@ -692,7 +692,7 @@ _filter_sysfs_error()
> >  _filter_file_attributes()
> >  {
> >  	if [[ $1 == ~* ]]; then
> > -		regex=$(echo "[aAcCdDeEfFijmNpPsrStTuxVX]" | tr -d "$1")
> > +		regex=$(echo "[aAcCdDeEfFijmnNpPrsStTuVxX]" | tr -d "$1")
> >  	else
> >  		regex="$1"
> >  	fi
> > -- 
> > 2.50.1
> > 
> > 
> 

-- 
- Andrey

