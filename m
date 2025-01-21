Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17415852F
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 03:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737428868; cv=none; b=XlT2zK25DQTEgDK1va6T4MqV6JdwMvfQtsfQGAYYmuGQo/HQ0utIvEHERupmt46031ObvPz30c0/hpXOarq0wvfLCgMPn3nc9AMUqGpxPMBJTTWZu//gU88U57qn3iGTcTtOqZ4DUMRyQUc5szFC/lPJ0T96mZQPaeN3htqQ6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737428868; c=relaxed/simple;
	bh=IjlDQfxtiQVJshX4wXvuAvrMx77lhm95qcMClmjBiDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnGTFCNa0BBDokXTCiKve7dNmrfbB2I7XOW7b/EtRpvFV4IZQWvWN7+BTZhyClJZCiZGxl0xHD7QP+1u/4wpTPkx5VrZXIiQoijYF+f07XIZ/Ow4c3tP5UmHixuPsuq10Ih0tqXv+Mj9N4KsLqhBgVTCZUQvj+T8smaQg+fLMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=I9DO33pc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="I9DO33pc"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so6507142a91.1
        for <fstests@vger.kernel.org>; Mon, 20 Jan 2025 19:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737428866; x=1738033666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hLH9RAv+PPTcoZMSX37ngbTEd5kOaW60Tl1D7RHZ+aA=;
        b=I9DO33pc9ECuhDXYFOzFPBF3xIon4rCLh5I7FXHEQK0Ufha2sSTqNxHUebT9URvWJP
         CUJuEBisUozrIsfhpnXMgMW7U8qhYZCK8ZVipEowdA+ENQKOhNfloid1wHifgrehae3w
         qo6ARSl8eMKB+y5nR/nOC/hVBBfff85MtgPo8zDGQ8fR2kCAbAFWc/wQAOYNf3ggo5iX
         TBV0h4iB3MK54YVXwtrfPLvM+bErhwYIip6gT/xY3TT4/kLgD7mRi6DJCNB5vskqQlId
         o0QNaySG+R/Kk9buKBcExnmGUmUWTcpY3BobNMkvTsleP3GlsGzUvPU18PZFFnyjbZ+b
         JZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737428866; x=1738033666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLH9RAv+PPTcoZMSX37ngbTEd5kOaW60Tl1D7RHZ+aA=;
        b=eEyQ5J0QBWkwNPkoJ5eTsT68rwdI1UFrRnS4a0GZBbDPRJcd/oA1cI9POd070uE54e
         ilZr/QSx7bZmWIRAUXETQCJwvb/WkDwxiISjayOD4MpFg9AauJYALrI4yOd9E9en//lN
         lVlH0uuzsmHmWfM4fcp3H2NQ4g3S9qK2idYGIsgxnMd5T5Ny3Ez7Hxwl8ziNTrsflEzR
         bcdoO3a/f4EHyxBenKLnzfIYbVvfhrXeZ1OQVeZc3QZN6BZMuRky0//mL4yHpYyEjoCP
         0ndOVBlfOw7ARhfDx24c79EmH5WqN6Z1lo6yZdIOBFSOv28UeSsnDOy+msteibFT2Jc4
         UYuA==
X-Forwarded-Encrypted: i=1; AJvYcCXckGAyIZCFHt6fSPeTh7HaiHd69JtUb8qTVCGGEAnvt4G5eyawloC0ou2/2r+5hHbVn/L/GboM@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/DTZK9J1Bu8tYa0bepQq22mb+gedpxYEw6QUITkGunbgqTET
	Inb9dF3Au0TG4x3mozO95FePcOkHTuyLJdl6gQib5haJAbKVCRAX4FEleLaQVkk=
X-Gm-Gg: ASbGncv9xxk+DICYAYsoIScNxCIlwfnW0QnZljvJ/9AbyOx5LVo+DLyi61ynP7ASYVv
	Tl18as17drYIimF0qokvetq1mB9AjuI7FCOsMCRc4a/P7Gi/pUU0pLrHVfr9sMfnpjDlQ1mKTj6
	snwdYQLr6P0oyKJfkcNaO0KRY/LN+QN+Z7KS1urgvh2Mg+4I8tdXpL7LyNOT3S1hzSW+eGSXjQC
	i90iV9sh3Y+LpEomQGofuchLVRBxQD6Fzf9DRmUWDfJZWGT1VhPCPkI5Y8tIZcImTz9nqieK7W8
	LXTr10PgkJ/4zFd1/NYi2pr1155wbhCJM+w=
X-Google-Smtp-Source: AGHT+IF13jNl6vhCyls2i9XtFI/8eagSd5sBdsn2VMvWVDLROf7o4cxLGGgXEyX6kzF2zni+4/WbgQ==
X-Received: by 2002:a17:90b:3a08:b0:2ee:dcf6:1c77 with SMTP id 98e67ed59e1d1-2f782c9cb1emr24150522a91.16.1737428865964;
        Mon, 20 Jan 2025 19:07:45 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7762acd92sm8448579a91.44.2025.01.20.19.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 19:07:45 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ta4cB-00000008VAN-1IhW;
	Tue, 21 Jan 2025 14:07:43 +1100
Date: Tue, 21 Jan 2025 14:07:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, hch@lst.de, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 03/23] metadump: fix cleanup for v1 metadump testing
Message-ID: <Z48Pf_6AvrXIzTyM@dread.disaster.area>
References: <173706974044.1927324.7824600141282028094.stgit@frogsfrogsfrogs>
 <173706974122.1927324.15053204612789959097.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173706974122.1927324.15053204612789959097.stgit@frogsfrogsfrogs>

On Thu, Jan 16, 2025 at 03:25:57PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In commit ce79de11337e38, the metadump v2 tests were updated to leave
> the names of loop devices in some global variables so that the cleanup
> method can find them and remove the loop devices.  Inexplicably, the
> metadump v1 test function was not upgraded.  Do so now.

Probably because the xfsprogs version I was using defaulted to v2
formats and so I didn't notice I hadn't converted the v1 format
code.

> Cc: <fstests@vger.kernel.org> # v2024.12.08
> Fixes: ce79de11337e38 ("fstests: clean up loop device instantiation")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/metadump |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
