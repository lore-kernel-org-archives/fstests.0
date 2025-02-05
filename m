Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2449204C1A
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790389; cv=none; b=N30og9x3q93jk4DQzGBjkBXNObJYuY7oBvl6GTPkr41OsPqOTPkHcQOApyOyyC6IlsT8I5LuPuk6RPTU6vtOxjXG2zNiqMGE6JB1C+PfukHbiOhYId5adqFoZjeJguUYyVaX3tHc+EzDGRu1ruPziBk+e2Oxi5xK1IcB62RGMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790389; c=relaxed/simple;
	bh=P1ZpNDU8csXSCjRXyIThDMc2wgU5d0Wr/CkZdrCAw80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjnLw3rzMM1KTiAVhlfyMKc/kUidX7MDsK6QiU5wNjCgUUYg27q8mmD3r0vOUtMWdyq9dFQBzNyke7ouQ/9r+lZAh5XokdUiTg+bBmCJcE0a7SiE7fPOsoxOQ3z93zhpGVL1DAS6C4KbbULYR3hikR7VIeiuhF5+sKYVibxM0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=DMS1dzGE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="DMS1dzGE"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f1d4111d4so4247225ad.0
        for <fstests@vger.kernel.org>; Wed, 05 Feb 2025 13:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738790387; x=1739395187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/pVDuWjBwETpqMInJTuTHe9Fe51snjk7jG37C1nIjk=;
        b=DMS1dzGEvN/wZZvzsThIMpXC1JLhg7Y5fCM75/XmXKF7g3dcB+Zjot0joDaApB5j8G
         3xNU/kCwZIcUOdZjYfw7gJ9Hlno9+KlLg6pDuHMkRVbNEjYOhuLtZkCBD0VmMWzRbRkM
         RYeCCFJuuEPn+BeGjR6PNLkAttiGj2aF15tE3BLHYRxfycqivOZqpqO+yNXQHK8SdHc0
         rriS9Rz5lBaQf13nFnSdD88VMYEFNtCgcnxMooTtFXmqOUtax81edHVBnCXksdBAv7a+
         lfV9mg1VfF7X0B77ZsMwRCEhJZbr4YopBsOhx8E1IsUFateQpphD/h80Vd4wPgDFDMS9
         RFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790387; x=1739395187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/pVDuWjBwETpqMInJTuTHe9Fe51snjk7jG37C1nIjk=;
        b=Cmt/0KP5DyhxcN/dG0CIU7YIKaOjh4YMYVyh4xuiZP7ZKUa0qBjrGhbmStgPB9zyIT
         bwlSu7FYgdtC0viq+egwLKpC4sWuNSuIQBJnSkN9y3LyWr2xS7UaVAVKLXH777aIfcsf
         Xtfm5hVKoAQWz0dUCTAZtHefnVLj5SR84n70SRBtrtzlHc3Q7xFE6COmrHebVPhFvgIL
         GdNczPZ4W5IQ2l5z/j18qjI068rX6EoGBb5g1R/JqhWmvrZttH33OhIPV6UG8di1AQP3
         xswiJ90JIh63N8lDDVdvr59l9SlVAg+qDrLNiBfiNjV4OH+FBu1fnj8lHBqNxcP6b8Es
         i4+A==
X-Gm-Message-State: AOJu0Yxyqqag8F2w1ih7IgRXfRySBEAf+KOo92qFzFXM4UWNr2tTt1vA
	mCD4n9pl52iF+Fy5NlreOQz7SsCgNvaT4T1JwD2qGcOMBU06fK/ALYDvG5sAB1Zn/5ldxFhp1F0
	K
X-Gm-Gg: ASbGncukuZp3KRxSKQk4gYyPN4yfbQudch5oURUQfjeQ/eIFvoXt0Vpyvlvz8Rk8tR/
	CCDdzdystfQ/H8DTcSkumePAAmsSRSwLgA2j14e3LJOJxnxtlL2HhXMB/UuC8zVpa+VPyQ7PeYR
	MRrpojU93NoOHeo+Hz+kG1ceWrb5dM5OjvjiHmNFYsa62yf6FaCiJZvyc8JmhEfoXm6RF9u2QYX
	Yj+NrdOQ6kOmLaffapGaaTB2nmsoDdW9gQ0xnPmLDIECWuj/5qjquStFkuAifndqDC6VbNadTjO
	XIEdHYZOqiImm2+nba2NbVIeUGDppdI78m/kAPGMRY3uRU2J3Oxea4Bt
X-Google-Smtp-Source: AGHT+IHKr/jk+gmRxkD9y+arz/7q0dCEgcTTIYJ0tkdvep+6xV2PLpXlXYBeRMgW3wQGQGheTrdPZA==
X-Received: by 2002:a17:902:cf12:b0:21f:134f:22ad with SMTP id d9443c01a7336-21f17eba99cmr79494745ad.38.1738790386889;
        Wed, 05 Feb 2025 13:19:46 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32eba6fsm118599565ad.107.2025.02.05.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:19:46 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfmoB-0000000F5vT-3NJW;
	Thu, 06 Feb 2025 08:19:43 +1100
Date: Thu, 6 Feb 2025 08:19:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/5] fstests: common/rc: add sysfs argument
 verification helpers
Message-ID: <Z6PV7_WKzNJvbUCm@dread.disaster.area>
References: <cover.1738752716.git.anand.jain@oracle.com>
 <f11ddafa2622d364b099b68ffbe4aaf4100e6042.1738752716.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f11ddafa2622d364b099b68ffbe4aaf4100e6042.1738752716.git.anand.jain@oracle.com>

On Wed, Feb 05, 2025 at 07:06:38PM +0800, Anand Jain wrote:
> Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()` to verify
> whether a sysfs attribute rejects invalid input arguments during writes.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/rc | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)

Can we move all this sysfs specific stuff to a new common/sysfs
file? common/rc is already too large and there's more than enough
sysfs specific code here to justify it's own file...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
