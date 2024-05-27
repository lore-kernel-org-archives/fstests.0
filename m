Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB67915E5CC
	for <fstests@vger.kernel.org>; Mon, 27 May 2024 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816408; cv=none; b=kN1Zqtn+uWZx4+Qo6nBdlvcOc29G2NdYOU6JpYexwDPGYXoik3R6dOtesMZ0g25y9Jdyp09ulYBwdCzZo7QDX6Eg53ngfGi0LON7zu0LH82XErCyCQoCnjAgFbWUfFMduu8NTqvNd6DB7yMmdN/jOLBxP2Gg5H6xtT3IcxL+asQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816408; c=relaxed/simple;
	bh=In/dF+ci0QqlrVOrO/4zfL7N4bAUEn47f3Iyur4OraM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4QtuSqcLajFTk3UzfcxXZFamS9RqTUxU7eqTUN/lSI0GcyN1jfexYw95wiugcDh9UBiuJsomYHETlOaQSJPa/rrk3rNM0LHuilbNzGcTM8kCD1wADNwSSMfT5rAy6ZYVOr+0Wake7I8oL/G63pYpsC1GjMkGaxpRWAH+g7qZ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvgtJRSy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvgtJRSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716816405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFyqh2QrUokan0PhOz8yHT4lGMp6ZHxtCoj8og+lztg=;
	b=TvgtJRSymHhXf6gqR1P23Ef3UX+Nwh/KKd/nGwLxxN0qv12CJiLEQ/Kg0mlGKoux2uo+Cx
	yPXPkArn6jkK5qYP6yB8K4VJwWQEb4V5KUNacN/rJGvUXVKw/hddg5eu67vEOyNipHqk8k
	k44t4v2ie5SDxkEtmqyUSHdor9r82GI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-T6deHiG9PQic2DqiBwK4SA-1; Mon, 27 May 2024 09:26:43 -0400
X-MC-Unique: T6deHiG9PQic2DqiBwK4SA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2bffbc8ad81so56350a91.2
        for <fstests@vger.kernel.org>; Mon, 27 May 2024 06:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816403; x=1717421203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFyqh2QrUokan0PhOz8yHT4lGMp6ZHxtCoj8og+lztg=;
        b=Fb9nZId594PZV0zFlgFyau2jhqhYDfyco6uwd0mC2Czpc077RsJh3lqhdJ6O5k+vXW
         PRudT4PfNOYa7A56w03DrHExz8kQL6lcOKA/8J0iKFoBh2XsaP8kpRezTnjh6+eW1Dod
         RwjP2rw4muXwxpudrfr8YZel9GdJY+chnWy9BB9WtSQb+qKtG4+KTHOGHQmp4xvUGuJr
         Clpxorzg8YcncCpQIzEj20pb6pxJOiNGkLvhVXtzHhRelKZr7YR4xtDSibhLhMM4mTII
         y0U92ZYokwSLhOXBaG715McK3NxwGcpAIsN4nYy0klI90yshNUK+guxB+8aXmFInuu2v
         YiZg==
X-Gm-Message-State: AOJu0YwiiCjS082OHAbsoj9HlAkCHhtsOif4ItQ+/9ElR/kBr1FQjtdC
	2MaVljuZHsbfvkVAsWJ9cEkoFHY5RMDsb7Kh3jJItJ5Rycb2VssrqBfsI2JAwqJImi90GjVFiMj
	f6wNHasK2k4lZhBvSyjeCcTtooAd3V+mty/9+QvmTY1dydp6LKmrE6Gs=
X-Received: by 2002:a17:90b:4d8e:b0:2bf:c489:47d7 with SMTP id 98e67ed59e1d1-2bfc4894870mr2536018a91.20.1716816402601;
        Mon, 27 May 2024 06:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwwiLrNeclNcmIAbH3nnjIFdIZEdE5nrl+XKO0Yxw7+/z4JkIUDa30TTDCzJjbSRXevogudQ==
X-Received: by 2002:a17:90b:4d8e:b0:2bf:c489:47d7 with SMTP id 98e67ed59e1d1-2bfc4894870mr2535994a91.20.1716816402022;
        Mon, 27 May 2024 06:26:42 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f613795sm6413429a91.31.2024.05.27.06.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:26:41 -0700 (PDT)
Date: Mon, 27 May 2024 21:26:37 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, djwong@kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 2/3] generic/436: round up bufsz to nearest filesystem
 blksz
Message-ID: <20240527132637.3ncfgfpun374ygib@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240527114834.167521-1-kernel@pankajraghav.com>
 <20240527114834.167521-3-kernel@pankajraghav.com>
 <20240527130111.hyoigq32xaxxpc5x@quentin>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527130111.hyoigq32xaxxpc5x@quentin>

On Mon, May 27, 2024 at 01:01:11PM +0000, Pankaj Raghav (Samsung) wrote:
> On Mon, May 27, 2024 at 01:48:33PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > SEEK_HOLE and SEEK_DATA work in filesystem block size granularity. So
> > while filling up the buffer for test 13 - 16, round up the bufsz to the
> > closest filesystem blksz.
> > 
> > As we only allowed blocksizes lower than the pagesize, this was never an
> > issue and it always aligned. Once we have blocksize > pagesize, this
> > assumption will break.
> > 
> > Fixes the test for LBS configuration.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Looks like I missed the RVB from Darrick [1].
> 
> @Zorro could you fix it up before you commit?

Sure, if there's not more review points, I'll merge it with this change.

Thanks，
Zorro

> 
> [1] https://lore.kernel.org/fstests/20240517155437.GK360908@frogsfrogsfrogs/
> > ---
> >  src/seek_sanity_test.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> > index 48b3ccc0..a61ed3da 100644
> > --- a/src/seek_sanity_test.c
> > +++ b/src/seek_sanity_test.c
> > @@ -541,7 +541,7 @@ static int test16(int fd, int testnum)
> >  {
> >  	int ret = 0;
> >  	char *buf = NULL;
> > -	int bufsz = sysconf(_SC_PAGE_SIZE);
> > +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE), alloc_size);
> >  	int filsz = 4 << 20;
> >  
> >  	if (!unwritten_extents) {
> > @@ -591,7 +591,7 @@ static int test15(int fd, int testnum)
> >  {
> >  	int ret = 0;
> >  	char *buf = NULL;
> > -	int bufsz = sysconf(_SC_PAGE_SIZE);
> > +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE), alloc_size);
> >  	int filsz = 4 << 20;
> >  
> >  	if (!unwritten_extents) {
> > @@ -643,7 +643,7 @@ static int test14(int fd, int testnum)
> >  {
> >  	int ret = 0;
> >  	char *buf = NULL;
> > -	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
> > +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
> >  	int filsz = 4 << 20;
> >  
> >  	if (!unwritten_extents) {
> > @@ -692,7 +692,7 @@ static int test13(int fd, int testnum)
> >  {
> >  	int ret = 0;
> >  	char *buf = NULL;
> > -	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
> > +	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
> >  	int filsz = 4 << 20;
> >  
> >  	if (!unwritten_extents) {
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Pankaj Raghav
> 

