Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B39175D47
	for <fstests@vger.kernel.org>; Wed, 22 Jan 2025 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526103; cv=none; b=rKTCOCpZ74iw+aJUjIhoHRm3pqTa7mWjo4t4lhMA1NBG+KHy5OAhBaLkjdLcgL38znfUY9soIc0U7wGuORVbnGRoobpCQVx46qBMs4iL4XNMjSAhm0c+yQlJ5LDksWQiLBexSPJWXD+eQgGtiF2aitkaOSS3f1ucmbYDNlGpAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526103; c=relaxed/simple;
	bh=cQOe3nXGKxwa03Com2Yo1ruYoaCH9BEUj0RooxWz5mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+8eW45KoJ62zgVXRU3zUGkSIznujB+yT7HkcT6Zw3c1kDrPkxsjjZJpcd/tyHaf/tsva+KXoGEfYxzixYYR+PI57orSzsjs1HMmiG0FCLxFUcUTTs0CEpWM/q7hCBpZnLiO5DLxsLCP7cOTuQ8Re2jEVwc8J9LjQLNEwVYDlTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=DH0p7t5D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="DH0p7t5D"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2166651f752so150591925ad.3
        for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 22:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737526101; x=1738130901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9PPmxYKawN84Zrla169U/qiFm4IJPFUiw6/SVFccUY=;
        b=DH0p7t5DTmHucO9Om5xfZzMGLiK5drLRCGDxLPpUGx/2Ibg+4X5t+cpi703Vmo+/oJ
         PRVMfIZ9GpA6u7L1vf/Nhh1mJhKjKaHPuy6lk/ze9UMa9aUdffF8otbbDc4gfHvm+Vjf
         0hzkIoG0KY6X0yJjYkvQkBe0uJsb2drm2GG44zPspjYFntzPugG06C4N4BqDDOIb9/yB
         wwp1hQKS3B8xr85YTyHzquIkqhumqzindEB0tHoLb+7fO/Mu7PPHB+uy0cEjpX2keUkG
         DtpWkGxMGqd2cB5dUEYxQ9S04eqX3Dj6jwiNidiAlCi4Ga6IUipeEtabbaFt60dtdAvd
         mBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737526101; x=1738130901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9PPmxYKawN84Zrla169U/qiFm4IJPFUiw6/SVFccUY=;
        b=LZo4J6KNH6gaPw5t4mgsU8any/iRmBrRyutweEZYGMcpLmb53W2SuUZsfY4cpkJafa
         lm85bAKXgoYSsf3avLgphxVCDcqsjax3+iUefAvFnWUOkWVORNMcyX27wNSLqTzhHUWk
         FvrVqSYAWOsmdH7slYsHG2NRhRIrAMg+EF0Qrx1fhcrN29tBufy50aTPP/3gycwm+KsV
         odgQaI8JUB+KwLBmroH+xNeGljQ+9YhhnpL8/MA3PslKmJ0wlKUKCtx3CUuypf4IS7oC
         8IJL7YndAbGTnxu57Fg08ffFcwe4zBLFz7lDoEDvJfbuXbCeospO1nDhd8R1FUj06+2k
         2z7w==
X-Forwarded-Encrypted: i=1; AJvYcCX4crAGX8e8Jagufzf67/jNxHEBDYHxDpwxOOz+n5f3hJqq2NLWKLYP/mN+ZUH8X5vvJB7BFTux@vger.kernel.org
X-Gm-Message-State: AOJu0YxDgwOnXLJEm1JPuArmLHkgas7fwwiCZ0eTvjDeb0kbKd8+KD1q
	HaQkVZh7DJMi4GlETCmRH/CLwct5RuJW+d46cpK+EPo8ur+TfwHTH+Nw7WdVfzk=
X-Gm-Gg: ASbGnct4LEIxRpeJW3UwzwRVdHQVCcJLTF62oaS0GCqZTv5JCTudOvKBEY/fqlDjfDZ
	RfabF9DaalBd2RMvzEw0B87HQqHIJBW1I1lXneCw5H2R1AtBExiXkbHhqODxHI6ZworccM0mNy8
	o5QQQg7ibKUh3KzWgvQk8rKoSOGZHde40tnbfYZbgf6VTFss+a0M5ZhYxgVkUYUu0K51Cxc2h1P
	SK4ewPOzLCezdLt7JZVjHN8YsiJKmtRJ+qIvcq2GsgihDvtetKVAwB7WxLt5hzCHEUjtCad79sE
	6CThIzb3EZDJuKKb7PRVn9H+Ofn96uTTpL7B6qbRgl/HwA==
X-Google-Smtp-Source: AGHT+IGXKFZz3j2qUqUrGo0iD44ewBXliPcEvdRgYvtV9aL062aB8F0vgX/4jqc8jy4OARlbR+0WUg==
X-Received: by 2002:a17:902:f544:b0:215:e98c:c5bc with SMTP id d9443c01a7336-21c3563a33cmr355643705ad.48.1737526100764;
        Tue, 21 Jan 2025 22:08:20 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceba906sm87713805ad.91.2025.01.21.22.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 22:08:20 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1taTuT-00000008yMf-2ZHd;
	Wed, 22 Jan 2025 17:08:17 +1100
Date: Wed, 22 Jan 2025 17:08:17 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, hch@lst.de, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 08/23] common: fix pkill by running test program in a
 separate session
Message-ID: <Z5CLUbj4qbXCBGAD@dread.disaster.area>
References: <173706974044.1927324.7824600141282028094.stgit@frogsfrogsfrogs>
 <173706974197.1927324.9208284704325894988.stgit@frogsfrogsfrogs>
 <Z48UWiVlRmaBe3cY@dread.disaster.area>
 <20250122042400.GX1611770@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122042400.GX1611770@frogsfrogsfrogs>

On Tue, Jan 21, 2025 at 08:24:00PM -0800, Darrick J. Wong wrote:
> On Tue, Jan 21, 2025 at 02:28:26PM +1100, Dave Chinner wrote:
> > On Thu, Jan 16, 2025 at 03:27:15PM -0800, Darrick J. Wong wrote:
> > > c) Putting test subprocesses in a systemd sub-scope and telling systemd
> > > to kill the sub-scope could work because ./check can already use it to
> > > ensure that all child processes of a test are killed.  However, this is
> > > an *optional* feature, which means that we'd have to require systemd.
> > 
> > ... requiring systemd was somewhat of a show-stopper for testing
> > older distros.
> 
> Isn't RHEL7 the oldest one at this point?  And it does systemd.  At this
> point the only reason I didn't go full systemd is out of consideration
> for Devuan, since they probably need QA.

I have no idea what is out there in distro land vs what fstests
"supports". All I know is that there are distros out there that
don't use systemd.

It feels like poor form to prevent generic filesystem QA
infrastructure from running on those distros by making an avoidable
choice to tie the infrastructure exclusively to systemd-based
functionality....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
