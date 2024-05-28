Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEC170820
	for <fstests@vger.kernel.org>; Tue, 28 May 2024 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917055; cv=none; b=q9HASwn11/k4Sk5wGgJ/kziO4RgDG1xCktgve1O/ZZ0//dYVzEjb0FWIgmP3mU9jJm+NmyK2if+szkAyh/sLdV7PH6IPVHPu1Sn0wlmIp6XqsUU+o17kF5JWwovesyikuQPlgjPDvYPOAwJ/IRHMANfQcmh1t7ZJU/O8MW14zOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917055; c=relaxed/simple;
	bh=s/PO+zPQrBVJU44eI8Wd69/XIh0qb8qT2DXF1mPyW40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUuHELgQNQzUcqMUXg1PcUp4yx94ILK2ZEV+LdrqQs0EN7BHdeQuJ7D5YeO0q8fIC7Fgwr99YlktPvwgnkBzmDdSY5ezhOdTWW4oKTWmYYfR6UMCWA9NNvEjiJ5Ooi2Fnm+odNcAw2h42ScZym5NTBoFeCRTLzqhRQVIJkfE2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=BHn3oYID; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="BHn3oYID"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f449f09476so84675ad.1
        for <fstests@vger.kernel.org>; Tue, 28 May 2024 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1716917053; x=1717521853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CZjqJQ/Mb7o64C5tkt8/Op/QX1fV/25kjWf0uv6TYNw=;
        b=BHn3oYIDrd05WMy5d6cIUTDpBrcriLpW03pGsvOl3ZPK8xBnHTUp0UiweZiR7d5Ryu
         M7Xl/Fx5kQ5U9RvJ/8yup91wG/9vyy4KpfEIY6wK21cZ3h8vhq1kkNlVFDMLzrXd7tDC
         TxZQhaQUKs61pLFzERsy7HftGHMc079PB2iTAdFBzXi+Egx4eavJZc5grriQbqOJATyx
         rONKoX6jugWzWtVAInPcgKDJ9/XdluxAfc3o0hh/3OW3tdGc8pF3FI9VIIjBlXE16OM9
         5qgSS3LXXnu16H62zfHfh6LTjFc7wH6RWTEw0LV+NKNySEwDZvYdVHmUyQ1ihMHWPFt0
         YNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716917053; x=1717521853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZjqJQ/Mb7o64C5tkt8/Op/QX1fV/25kjWf0uv6TYNw=;
        b=ZNu58mWtLltf28nCa/dQdOluxNagNvfExCRqRuoVGOHO/l3lvyUbo0ESr80Ky/RqMT
         0hE8eBeJv/nakiEu8mPCORtwKMeZ9/ZRJ3/THWPs2c5mHyeGAVKPZC15Z96IsYKXurdM
         9Z9vduDcKlrdSrslcvIRJMpj1cto05PT1+przGFL8bkDjCKYsK20/8U4DIblvyuyiV4N
         9ly8Ys3gWbJahVy4DYwxp/lsr8LTe7ULZ5SJ9nV7ahst9h3vIbIv7BkjPbGQ2DLmrV1d
         s8puEWP+wLGdkSGbXsLeksv3JkeoZYDV6qcXj9ql7JaC0xXego4trqz8EltYr0r36Zav
         9w+w==
X-Gm-Message-State: AOJu0YwDGR2E45ElLrouzBd97v96tR4Kgnmpu+mKgq4DB6gQCWQcQcVp
	yp4AkdY3ALdAQz76WcqENFFxWzKmR64ZG3aARwZEL41U6XxQJCUCGonG8+c4GtA=
X-Google-Smtp-Source: AGHT+IGm/4zE9ucOze0cttuV/3FeHI4wbEtq8NQ5UCQN9s/mpX3oTHooKqYx1emrgqk09Us6AG7IRw==
X-Received: by 2002:a17:903:41c6:b0:1eb:6cfe:7423 with SMTP id d9443c01a7336-1f4481794e1mr186893675ad.19.1716917053351;
        Tue, 28 May 2024 10:24:13 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:400::5:4121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4d6fe4775sm12252195ad.257.2024.05.28.10.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 10:24:12 -0700 (PDT)
Date: Tue, 28 May 2024 10:24:11 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH fstests v3] generic: test Btrfs fsync vs. size-extending
 prealloc write crash
Message-ID: <ZlYTO9FNeYjsFTr6@telecaster.dhcp.thefacebook.com>
References: <8c91247dd109bb94e8df36f2812274b5de2a7183.1716916346.git.osandov@osandov.com>
 <CAL3q7H5z_eYpx8e-J7xPzZMqCxv2xwq9H7ga=8EZdLk7gnT-jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5z_eYpx8e-J7xPzZMqCxv2xwq9H7ga=8EZdLk7gnT-jQ@mail.gmail.com>

On Tue, May 28, 2024 at 06:21:23PM +0100, Filipe Manana wrote:
> On Tue, May 28, 2024 at 6:13 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > This is a regression test for a Btrfs bug, but there's nothing
> > Btrfs-specific about it. Since it's a race, we just try to make the race
> > happen in a loop and pass if it doesn't crash after all of our attempts.
> >
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> > ---
> > Changes from v2 [1]:
> >
> > - Rebased on for-next.
> > - Added _require_odirect.
> > - Added FSTYP check to _fixed_by_kernel_commit.
> > - Added Filipe's Reviewed-by.
> 
> It's missing actually, so I replied with it :)
> 
> Thanks.

Oops, I missed a git command somewhere :) thanks!
