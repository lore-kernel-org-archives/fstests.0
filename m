Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F6220681
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796019; cv=none; b=lZXyjJE5KUX8+88olGfshBmNagOLtKE7PJo8/UGiQTxB7yK9TqpCY1FEL3hTZONiZR2Low4Zs8v7I5SqaDDqjzSH2i2vcnS7Kzyng1P5aiSuWEpoB7y7r8lQAmYqYWy0FpGQxL3+lVvLdMRBu+RrTWMip80SDtGoshUnoaNE8io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796019; c=relaxed/simple;
	bh=sM5bvJ62NYaLyaar+WxjmtoFTQ96IkD035TIVbq6vhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fekGHASTJzYM/gCpfFV4DMkxZSKDqeCX5S4P0gMMSLtdpmBHpG4DpjJFzzaZY98leXnSJn5RKIWc7JEz8+ufwoxZpQ9hWI0o2I28LrFWWRMajrkn9qRxpxQoxzLi0Plz+9Mtr2zg0FfHdbFK24jj6czIzYc5j2UZRQ4yCf5tEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Pbr+jenN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Pbr+jenN"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3108d4a8c6dso225693a91.1
        for <fstests@vger.kernel.org>; Tue, 20 May 2025 19:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747796017; x=1748400817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EjNpA28qVU55PnhfZ1rdlkOFuUwtuOrrJ36neoN93AY=;
        b=Pbr+jenN6X/C+j7f6q66xotUE6YhBwcfrQRPXAA+R390OBX5v/xh1+Qi0NGvgIIOSX
         MfJsECjpVBa6jsgIzX1nAoZRGafM4DJ5ShUrq7OyQvqpA5wJ435vL+zABeAPs5nk8zvJ
         B4rOXXuRs3vrmmyMnffYR1uZtEl84MpXyLpW9EhHrU3SsBz+xvoDvLNk6hXQutdW00+o
         +nPodBqUNcj31U+VvL/DBXTeKDeZBiw19/OBXygtO5O8zdycdYrrxrJqnk+Ehak13Owy
         +cbkJ/JESIr9ZhUKYD07PA02a8YZhDnNGrhQLuT33LmLU7Qu5O9ScRFnsYAUbjqFhXw2
         2Dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747796017; x=1748400817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjNpA28qVU55PnhfZ1rdlkOFuUwtuOrrJ36neoN93AY=;
        b=AD/+erfnZxQ+156eH/5NtJu/TwREiC3G9cEBeSWoQAPyk2jdQKvoeQCGS/B22dXuid
         hCJ+wldIBhByIot9140QdZxeaUdJBa+nJCwfjL5uvzFTpzecbjCRIe4aphdVXpU95G4y
         HR9O+L61M41sz3eFq4T8DfisaQJlzUYd5rQr/d1ARavotwoIewI5CfaOHhqRRUxuEkIw
         dlZUnVNRMdVLY6RcJG3GyQznrSPrFAUw6NXA6QXTAdIjo/KoXeVldrUxFI2CHbDhFHoO
         2UcmHAS1KMj5cg5T31DdUx83hUEl7xO6oRLqbD00bfTCTQSItXlnGGsmdbM95rHKpecd
         vFrQ==
X-Gm-Message-State: AOJu0YxO/sugUAQviFsFfik5kOWaHnvCysvnkSMPlWfEJo4hLIGWfpqn
	FQ/P50eIVcxw6EZP5A1BspiiRy1veMvnOserhXvGgofqgX85M/fQIZOn0783KkQU7UYfyfX84SD
	QD/3l
X-Gm-Gg: ASbGncsZyXdsUSI46HUiKsEFbLKckZAOcOguzRn2WyrWZ97wf2q/pwAdKsI+kIEgBjd
	0czcEqqStQQfYG2nTIMr+bmJv+Z4JwkFXOdB1Ym/M96yNhLFu91RY+b/eJyK0SfD6MNsDKqxJGW
	2sMgB1zg99K/bKbuL9HAm7QWbJrn/EdDuD/F4UGjRuhMMmjSrsvOx4WrLjc0dAUW/vryzM9NYlZ
	t9lsCHedpILrOETeRUta7c38tjRLaVaJCJTXeqgQZU5fctk9DYF5WaMxepGUkvbZD8eHtI/jSL7
	wQsc2s+FPUvN0nnoZpMyORU45IoMgOWsmE29kyM62GSD4zWbSqm6nw0nWXwpCnPfF4sw/9F2zcV
	86e4SVU3+wuLiiNLXQqc+j0kOxnw=
X-Google-Smtp-Source: AGHT+IHUyWo2r1IcEb/rl05rNY65KWylA7X+XMy45kEhPIy0bI3BsBi+ekH9ZUaDH5sscxcym0Eohw==
X-Received: by 2002:a17:90b:524c:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-30e4dac99b4mr32101442a91.3.1747796016819;
        Tue, 20 May 2025 19:53:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f3651611bsm2727899a91.49.2025.05.20.19.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:53:36 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHZaG-000000068k9-3xrv;
	Wed, 21 May 2025 12:53:32 +1000
Date: Wed, 21 May 2025 12:53:32 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 04/28] check-parallel: report how many tests were _notrun
Message-ID: <aC1ALFZ_fI0_b6DU@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-5-david@fromorbit.com>
 <a6b7ba3c519e9db3f408b913dc18fc732cde1241.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6b7ba3c519e9db3f408b913dc18fc732cde1241.camel@gmail.com>

On Mon, May 05, 2025 at 03:28:10PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > We already count tests "run" and tests that failed, but there is no
> > indication of how many tests were _notrun. With tests actually
> > failing to run because of things like bugs in _scratch_mkfs_sized
> > being reported as "_notrun" instead of failing, visibility of
> > changing numbers of _notrun tests is needed.
> This looks okay to me. 2 questions below. Apart from that, this looks
> good to me.
> 
> Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> 
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  check-parallel | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/check-parallel b/check-parallel
> > index c85437252..d68d76e55 100755
> > --- a/check-parallel
> > +++ b/check-parallel
> > @@ -188,7 +188,10 @@ done;
> >  wait
> >  
> >  echo -n "Tests run: "
> > -grep Ran /mnt/xfs/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
> > +grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
> Nit: /mnt/xfs --> $basedir is not related to this change, right? Should
> we move it to a different commit/patch?

I don't see much point in separating it out into a different patch.
That makes more work for everyone and it's a simply, obvious fix to
reporting code this patch is adding to...

> Not related to this change - Can we change the above statement to
> something like it is done below for _notrun i.e 
> grep "Ran $basedir/*/log" | uniq | sed ... | wc - l
> in this way we can get rid of the sort command?

Don't think so - uniq only filters adjacent lines. You have to sort
the input to put all the duplicates together in the stream before
uniq will detect and remove them. I suspect that it is possible to
use 'sort -u' rather than 'sort | uniq' but I've always used the
latter because not all implementations of sort support the '-u'
option.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
