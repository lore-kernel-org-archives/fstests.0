Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52633F362
	for <fstests@vger.kernel.org>; Mon, 23 Feb 2026 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871111; cv=none; b=A/1IDOlwxI6V8yP4F7BThvE9D12AgHXTcLE5FwniuFb/RUtnsm1JiozqCGbmgHChsYSGNyr2rcQlE4rbZWZUzN+Mq2myuxNizbb8WnbBvJoPyUUSsNHPWz6tok4KAI5pNwd8rrtS+0xj+hU92A/lcIh8dDAqARZYOO/KKfdJa1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871111; c=relaxed/simple;
	bh=/EWm0pKBviMXdkqzEFKnhQPgOVbIqiISyVyohCEv9cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gshZdA/DUI8zFkAgynbYo1WZbn3Bqc5np0Fs1wERjCx/vmE1rBuVzGmcxPfR0RR8pF9WoIRv3yORLROKqPyQ3MN2m1+MUhbjYPDEOVKzgHtu/I/y+wMVeFEPQBvZXCZGh47kEeDGriNCvLK0EQ55sWBV6hDTDi4oiooFWTA+BV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0XGnMsK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHuc/koR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0XGnMsK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHuc/koR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771871109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXT5f9mZlEhUbznTe2SCQroAE1pOqmhBrzIVjFLcgGY=;
	b=N0XGnMsKjdABkuQZsp9KE9mDSm7YhBM+WXJFR6i3Gr5qxe6MNLW7Hka3AsjhmgPHRrsmqU
	YtEbfA1Sudu8c4BJOeZ+MM1NVD2puYVL7hmOmb0OKeAlH4SWP2W4Mxc8k1R393ynHl8JO6
	CKD58BBZhEZqWQwPZWN7QKlCAvCCbls=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-u5K0cqB7P3KS7TNrkYK3mg-1; Mon, 23 Feb 2026 13:25:08 -0500
X-MC-Unique: u5K0cqB7P3KS7TNrkYK3mg-1
X-Mimecast-MFC-AGG-ID: u5K0cqB7P3KS7TNrkYK3mg_1771871107
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836bf1a920so48715055e9.3
        for <fstests@vger.kernel.org>; Mon, 23 Feb 2026 10:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771871107; x=1772475907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXT5f9mZlEhUbznTe2SCQroAE1pOqmhBrzIVjFLcgGY=;
        b=LHuc/koR6dLrduC0P361KsU77lxJHlyBhwSnPTU4PS9bTeO9At/nZzF7niqZcWkZuF
         gLAmT4USX75J4TTIzThB7m/hxVgV6X5sSa9Qp6oJRAYgk9NOhla4/yCIXkfIiZM7Kgpe
         FkvhDVceMsJRto4I+SJvlDStqalhJJF4U5lVEJrh46FjnYBzepvT9CwMWADh4hYDcLdw
         X+8whMR6hDglqkgN1N3MebgVwdT6q1lZFxJK/ckX48nU3Xo/9RyY461ko28vJnWgPGAq
         AEqLYyGKcMAIOg5yWVcX0sVWtpH7aCBEK3Cl+Lu+c50c7mVR1s1g1LNpqCaOwYiman8Y
         hkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871107; x=1772475907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXT5f9mZlEhUbznTe2SCQroAE1pOqmhBrzIVjFLcgGY=;
        b=WnWbFFvFGSJt6cls8u5HkntAIDLtS0A8RQ3tZA5OXBxNHjFRfEPtIxsvtqPUt4dmLF
         XRdWwnNCCbwx8dT7Nrr9DXNQ3eOCSD1vv206b7Y7+U2zsTSJvV2SSXfuNI25q1JElJgt
         VcfW//236oiBgEKWMOsP0egGDSsbdSy3bK0URif2VQtV0gjyEpMaWq7aCtAUWX+3zyZV
         SZuMDE+4p1Kg4tI/y4eU3PR35fmkYLmF3vDj7+MRh06dNcjEQ5oixyG7TKOWGKwuL1y0
         msNiTaNBJD9z5EGG4Fd9sl+UR1M7Ra6AnTfYnvdt+kQbAUWdOJrIVKlxeGnmWYhgaCfK
         KlSw==
X-Forwarded-Encrypted: i=1; AJvYcCX/jSEZIP8sWlbs+2jqOfkFRCAYdjTGKRJrroH/axYcBSeIVTdou+5YNRLfEQVLw9h273a4xQzO@vger.kernel.org
X-Gm-Message-State: AOJu0YxcIavYGUxQg87RjnlP9N7mh0mfcuPfO9w5srfLaY7/d2Vj7p8e
	40s8MZEtpDNysz33RAQdahVGMOWfONdFopHRsk96HGQ6UqrnAqS1fiwZfucGevJ2F1LoZawrYcT
	8Af0k4X2ZbcG8cDoEmur4TUI2hLycbyfig/HsqC527p4Zhl3Gmzmds7Usog==
X-Gm-Gg: AZuq6aK4HSHT1t58IwoV+UV92stwK2BxSRk2Z2I7451CGmuqgQgasiWUi2oL+hEVQfd
	59ONVqouxZCF3hi4xU6zgdnCYGq5hROhpFh7W4vChWhwF3zkZt56mHFQZg9ZpluDAV1ToV8dNnH
	GU0GzM+BshDF4LW4dDRJu1aNkw+9KUGVqAi/1uQcFehe9CgHbKh7sMtUsWuKcbcAirgc8RJ/Uu5
	Irk9u8MQ8Fx5YFUpRTVK5r++1FR0sx41vLK8bfWHcw4qcvT4jFt7lCH7rdwHvJLubTbHSbegaMY
	AliAj4xRcZ4nQ90Y8h4vetqUBk6ilUOBjrpKq80haEKCvJ57wilMCe7vwRFtv/iwP5l1w+OqVB7
	Y6nuG1FDac4U=
X-Received: by 2002:a05:600d:8446:20b0:480:1b65:b744 with SMTP id 5b1f17b1804b1-483a963785fmr110956765e9.28.1771871106717;
        Mon, 23 Feb 2026 10:25:06 -0800 (PST)
X-Received: by 2002:a05:600d:8446:20b0:480:1b65:b744 with SMTP id 5b1f17b1804b1-483a963785fmr110956415e9.28.1771871106204;
        Mon, 23 Feb 2026 10:25:06 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cbfc96sm192309275e9.15.2026.02.23.10.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:25:05 -0800 (PST)
Date: Mon, 23 Feb 2026 19:25:05 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, fstests@vger.kernel.org, 
	fsverity@lists.linux.dev, ebiggers@kernel.org
Subject: Re: [PATCH] generi/579: handle quoted cmp output
Message-ID: <yoly62o7qoacichhdhjjym6mkanzr4fumhf74azbtffnc4sm6c@bkcye3xmyt5m>
References: <20260219152524.1770469-1-aalbersh@kernel.org>
 <20260220170417.sbykhwr53sah2s7g@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220170417.sbykhwr53sah2s7g@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On 2026-02-21 01:04:17, Zorro Lang wrote:
> On Thu, Feb 19, 2026 at 04:25:22PM +0100, Andrey Albershteyn wrote:
> > diffutils updated cmp with more consistent quoting in commit:
> > 
> > 	69ae797392bd cmp,diff,diff3,sdiff: quote more consistently
> 
> Sigh... changing the default output of core commands again.
> 
> > 
> > This causes generic/579 to fail from time to time due to grep not
> > catching these errors. Remove quote to work with new and old version of
> > cmp.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  tests/generic/579 | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tests/generic/579 b/tests/generic/579
> > index d5fab4892e9a..19ffd4954db2 100755
> > --- a/tests/generic/579
> > +++ b/tests/generic/579
> > @@ -71,6 +71,7 @@ for ((proc = 0; proc < nproc_reader; proc++)); do
> >  			# match, regardless of whether verity has been enabled
> >  			# or not yet (or is currently being enabled).
> >  			cmp $orig_file $fsv_file |& _filter_scratch | \
> > +				sed "s/'//g" | \
> 
> Thanks for finding this bug. So the output of cmp isn't consistent between the
> old and new versions, which is going to break later cases (base on cmp) on old
> or new diffutils version. We usually handle this by wrapping it in a _cmp function
> to keep the behavior consistent, refer to how we handled common/attr:_getfattr().
> 
> If no more review points, I can merge this patch to fix this issue at first.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
Thanks!
 
> I'm not sure if we need further updates on diff command, we can revisit this
> if any bugs are reported.

I was running -g auto and -g quick with new diffutils, haven't seen
any other failures.

-- 
- Andrey

