Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185CD17BB4
	for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708878219; cv=none; b=DPSo3Wc8jE/j09nkPYtmTJEeajsrFWj4zVq81zNT3vZ/QZS/1wtb8YiFfJ5JbaRfnV4NqXlNd4qJBs2q6IYcDc2fIkrQjUYBe68xroXmM1Unv9t607s+0HACSOnZMjwIdGJKXjf0upr91qWXSYYX/KDHNtkuxNYZmv59rI5XWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708878219; c=relaxed/simple;
	bh=LaigAbcADJ+dK0KzyX1kDd8eEpJpqVoPfgc/erPe1mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkIOll0ypk7vU3HCwpJ73kQ9bPhhdYuhND3EhARbittbsvyy0AYQ2xN2xw6Kg5RTcvt7YL/4hIxJVKOb2tHJkwYRpGHAbNf5YAWHpeawZC8C+oi0ZcqR29vuBTi6ylAzif6Nu/5I4dEDYdD9ns7lscx5jwtn7OD1LDQvht9GRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5A6bt1y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5A6bt1y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708878217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gEvjBAUJeAAT4LjTg60EE6mIK+bI32dp7aAGjL49dA4=;
	b=K5A6bt1yCs17MgxHXXR8ClkIgRcfJ6S10KqVUpdAAoroMzMaAfyU9sIiuO+99d3t0XQtNq
	fl2l4wtSkGMYrW+FU5hxX+bP75QdgJIZ0hqZ1sIsS4HQ77cLwGqrc48g20e4Bgh38TnDYa
	GFneuyYOJTXS8Po80vJXRtxOPzuZgA4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-NW279nfpNzG3noD4B42iLg-1; Sun, 25 Feb 2024 11:23:35 -0500
X-MC-Unique: NW279nfpNzG3noD4B42iLg-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5a04ee4c112so2008283eaf.3
        for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 08:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708878214; x=1709483014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEvjBAUJeAAT4LjTg60EE6mIK+bI32dp7aAGjL49dA4=;
        b=VgkVOXfrX3jA+LHZT9mfPKGJT3MufAtkcgyHF/m+0+eRebhDLjbyR8/x3ZsYFPUtAl
         EbsUEESLq64Pv1EA4odMR+u+3qGp9fhn26SNhNg1iJYSAzDa14JVQkt2WQbJ4KIERtPr
         /5zN3UuxbJtPpnNbN84IRYadCx5PYjtylCbnxFZDQpo2LEmyp/N6c5/wfhDtDLssGT0u
         wLn5E9S6Lho2DBnPLIc9puSNmze3g9srL8bBhrCDur9Y2ki7yhP/A2fxBCwJf56LxSxx
         C98Z7ckGMeikEUT02YeuswkcC5jz2n4zjB3lIxNXDyBQBkg6itfbogj8EMyaMxv2aa/0
         YkMg==
X-Forwarded-Encrypted: i=1; AJvYcCX8JCz7YotovhAIg7jOuyVu9SK0IYG0x0F+v7NMPKGmfivd++EAv6OpFz5rnTMFJp6YljimCqKabwiOoK0P297v18G4Tf9uAQ==
X-Gm-Message-State: AOJu0YxDBuKXzqS0i751myYl6Bj6tF04nvmmacMKZ8Q4wKKxENGuNU6u
	u7WIkvqKzXq7eRwVKqn6QKJPmmybMqkG8VEGrGW0Nx0chHcWYPifeg3k/IO/1H701IuH/BuuUG7
	Nrk49f93OwwiqI4aghE0st2Wm1MHXXMXbDC5/beXk5lhf8sa+j6bdLoZd4oPTua4umw==
X-Received: by 2002:a05:6358:89f:b0:17b:6171:adab with SMTP id m31-20020a056358089f00b0017b6171adabmr6105377rwj.1.1708878214728;
        Sun, 25 Feb 2024 08:23:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLWqbRFV/lo5uRx+niwsDYaf3gj/dBLpYEFSQ6YUzFAmNj+KTGCNSHzPLbH22v7CIDVz38gA==
X-Received: by 2002:a05:6358:89f:b0:17b:6171:adab with SMTP id m31-20020a056358089f00b0017b6171adabmr6105363rwj.1.1708878214412;
        Sun, 25 Feb 2024 08:23:34 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9-20020a631d09000000b005df58c83e89sm2523823pgd.84.2024.02.25.08.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:23:34 -0800 (PST)
Date: Mon, 26 Feb 2024 00:23:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: David Disseldorp <ddiss@suse.de>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH fstests] common/config: fix CANON_DEVS=yes when file does
 not exist
Message-ID: <20240225162329.ax3zvbs3c3fgrqcg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240214174209.3284958-1-mcgrof@kernel.org>
 <20240215145422.2e12bb9b@echidna>
 <Zc5O07ug7e4HVmKD@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc5O07ug7e4HVmKD@bombadil.infradead.org>

On Thu, Feb 15, 2024 at 09:50:11AM -0800, Luis Chamberlain wrote:
> On Thu, Feb 15, 2024 at 02:54:22PM +1100, David Disseldorp wrote:
> > On Wed, 14 Feb 2024 09:42:08 -0800, Luis Chamberlain wrote:
> > 
> > > CANON_DEVS=yes allows you to use symlinks for devices, so fstests
> > > resolves them back to the real backind device. The iteration for
> > > resolving the backind device works obviously if you have the file
> > 
> > s/backind/backing
> 
> Zorro, can you do the minor edit?

Sure, will do that.

> 
> > > present, but if one was not present there is a parsing error. Fix
> > > this parsing error introduced by a0c36009103b8 ("fstests: add helper
> > > to canonicalize devices used to enable persistent disks").
> > > 
> > > Fixes: a0c36009103b8 ("fstests: add helper to canonicalize devices used to enable persistent disks"
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Reviewed-by: David Disseldorp <ddiss@suse.de>
> 
> Thanks!
> 
>   Luis
> 

