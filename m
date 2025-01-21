Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037251537C6
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737428791; cv=none; b=ieZoeRkQYGXLk105WiModjXPdPd8X8orOCsuO8CugsZ/csTiw6RERDkEwDWB4fbQ4MUXLlUhDkx7myB3Is5U2D2EBWSoH6ngnUy+tD8CLX+3bp+a226ega4sqxyAnaQqq9WhBv+6UN5ZdpfO6QvdifCn5mmAKXQesRrYfCbXO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737428791; c=relaxed/simple;
	bh=fTCOHwghxZwsItwfMkEMxqGU8jkWXJmqiB8w2QMIrgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jW/T6A8L9xuZLxsAx1dewL+5Z2qK04sO3foZ1FdWVZJOgX56AGPd1DaDD+5MAgVLEfxW6+GZWgneZqCdKcTVSt0PEdNDxBK4Cb1xO8WyuIRNo28AbMocPeBBBN4oZBh3XDPZzdNIf7uUT3WX6gNInf7+1Vsr3RXRe1Q3FptaiJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=sVt9fqEl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sVt9fqEl"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b1f05caso94052995ad.3
        for <fstests@vger.kernel.org>; Mon, 20 Jan 2025 19:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737428789; x=1738033589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI3aY4Vq2pZQ0VjDfrYHf67rBHg9IDKCbEXgpXPUjJA=;
        b=sVt9fqElvCK+RHMWgjsnx4+dconm3egEAWVFqceyxe89oDt8Zo5Sp1b010FaqcsCYu
         wLRZsdAiGDK3EKMEYMK9CRx80HRU5NjjcDgI6Aa00Nctz2j/7JzdS9OmXZPTA0+4O80R
         qWNXDeEd0Q1fdbuK9vE9lQ7MND2O31JAPBffdZCRLJYFh2Ot+3LlTnjhG9OU2OPqZ/CQ
         uLtFXZbizvVYR6LhHtHfrdz7niV8vz4pvkHH7Z2FsPmIOwtrOZRMlWNYnFjAk5Xe9C8j
         qB93GTAiClS8C+34FPRyqgxt4Qlwbo8dqTKlPWPynciEP160C3eO+xbxPs3tC0dIk1hw
         P0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737428789; x=1738033589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI3aY4Vq2pZQ0VjDfrYHf67rBHg9IDKCbEXgpXPUjJA=;
        b=Gn2ShSKOaOf9HWjVfoicY3/ruM7v4EnVf8MwOFr9KOLV48PRxbTWMzCUfNytQzc4PD
         njt1T+8d2x4JzEx9z/QZKOaW70F/xrebIG6QoCvpTTzyIdUdNidrAK75EdybycxGYu0L
         1VtyL9M9X3k+S0iRNJB6UujiPFOUtRFIk5t2fOd6KKs1Pb+dO5VHecqhbFWrUNTngGe7
         wZHMSb7UJotGztLlcYajC1b74FCOPPyu7KhEl2U1ccoI5wzvu4Su4hjIG6wXYE2p4XLR
         +VBsNZBhzBZJ7zYg1gFY/u2xpKI1/cBCtWpLuVWuWOQDg487kgeX9oOI8i23WZIhEL7G
         my2w==
X-Forwarded-Encrypted: i=1; AJvYcCU+iBOlj+t+RZg7f1oPlL5+6fLoySf4ALxu1PW9YOe4Tp+dhGcsJ3MFAYlM8rKkKboPiP7ecuP/@vger.kernel.org
X-Gm-Message-State: AOJu0YyIoPxjk7Skh845tUr281YwOrEVayH8uFcngNeOopXy+vfCQXmX
	sNvEd3grOdkua2cx0CE0WbJ6H1adG+uYiLTbrNKds6hryLGxuoTwlgcka07K8b8eri6v1Y1jMiQ
	a
X-Gm-Gg: ASbGncs+wMQKeiWBrLRqgmk0issXW1pPtPP1RUt5wRWSUOgl7+jCWoLlwNgQv1oyThT
	GvNbd/fsaYFyeILg9ocfqwtDQAraWPtdVx4XVvRLuVMOLceLdKtOXaYDx3CzjbPK9RxD1Vwsi2r
	bX73y4MqpOPE4v7Cz1z5uPynpZuxRm2uKmosOeIgM4j6Ri66p+QoN26yKYYfl7DSWMrMqwgMeWP
	rUyZ/khzD0wJnj4lgWVjdVrGul5bg0uWlY0ANJdvYWphIioh+kOpZ/ArFbPRWZ8pRdUJg469Cyg
	Jy6Hc24ZUWEUdPproIXiRy2fGemL2gm+zEs=
X-Google-Smtp-Source: AGHT+IErPG1DOtNBChTxF6hpTZqJbDbn63sjNQpRxuhYx5jT+hcgG7zBYpRIMdqaAhPVMlFVV3a09g==
X-Received: by 2002:a17:903:120b:b0:216:1cfa:2bbf with SMTP id d9443c01a7336-21c355deb5bmr262807545ad.35.1737428789255;
        Mon, 20 Jan 2025 19:06:29 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d402d40sm67061165ad.231.2025.01.20.19.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 19:06:28 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ta4aw-00000008V9Y-0hlV;
	Tue, 21 Jan 2025 14:06:26 +1100
Date: Tue, 21 Jan 2025 14:06:26 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, hch@lst.de, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/23] metadump: make non-local function variables more
 obvious
Message-ID: <Z48PMh0bFNtsLnnw@dread.disaster.area>
References: <173706974044.1927324.7824600141282028094.stgit@frogsfrogsfrogs>
 <173706974107.1927324.17123378052376946322.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173706974107.1927324.17123378052376946322.stgit@frogsfrogsfrogs>

On Thu, Jan 16, 2025 at 03:25:42PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In _xfs_verify_metadump_v2(), we want to set up some loop devices,
> record the names of those loop devices, and then leave the variables in
> the global namespace so that _xfs_cleanup_verify_metadump can dispose of
> them.
> 
> Elsewhere in fstests the convention for global variables is to put them
> in all caps to make it obvious that they're global and not local
> variables, so do that here too.

I did this because they are local to the file and nothing external
accesses them. So I converted them to be the same as all other
file-scope loop device names which are all lower case.

But it really doesn't matter at all, so if that's what you want
then:

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
