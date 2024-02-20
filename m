Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1D152DF8
	for <fstests@vger.kernel.org>; Tue, 20 Feb 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466744; cv=none; b=f1imypjvrG5rA6nerevxEMJ2FPFmLFAwsMBNe/YLZ7vNnztWPwjgFhU3eFKvaWfgp6LzdeyAee/i9YmAtQZyaPeTS84fpx+/paByYG9NZyEQlvAWhB0WBScR9YVTGU3RwA9/7f6zTniYmbhgnjJ9d0N0NIBtsEtEHCm1o04n7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466744; c=relaxed/simple;
	bh=75lg/qgBc/1j5MphW+ZyZV+N/b+e3l+xbuclvUi/Usk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+5nXekOKkedxay/NRqOllqMzKWkcl7fNHoh+NJHtSrWOmdPXtfEP0ToS0x7cOj821EJzGU4KFsRse36YZyM2phAV8RyihQb5Bu9t//6z/zspV8FyF6Sm2bm5+s0PmHVjMS87amquvEloogPMpMWPk2zi75kwCcLWPEsd4oP/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XPVG6Jov; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XPVG6Jov"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso6051340276.1
        for <fstests@vger.kernel.org>; Tue, 20 Feb 2024 14:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1708466741; x=1709071541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2G51AsG1bsr7uNPjzTnaLkotIbnpZerEq4UgFBBh8Y=;
        b=XPVG6JovKC9CY+2GSudesJR7CxWcxo/zPRICCCAXvK9kIKY8YbEvrcr5I73XkD4Mo1
         He672605Qs2pfVjyTlbiJeFjz1Kzkb6uwnGUdMpk484OEcianEDi6tOxjipfl2BQYP8r
         BKlVwjebKWlE6hPW0s3sxHURiZRVU/r5OnJHuktJnYry9Fn33yQ/j4vFmgt2kixiFap+
         lID5GgmZEnR4hb18zZ2MnZXh+UtnApjYtRk+pEw8e3RkT7LNVcp0C0upzcEOxgMOgsJl
         Jn52R3ugynKDSwMq0xV4zkF4IbmX/dQnwezzN7XBYmbpAKkQsB+lPgkHJNlyyDY/8dqN
         Lqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708466741; x=1709071541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2G51AsG1bsr7uNPjzTnaLkotIbnpZerEq4UgFBBh8Y=;
        b=P+pprV6RV1idCHKmz1jFS4VGGS1BkKn7oCciHEgU2Hz9zhwclNQDMnRDfEEZRgzOtw
         4cxT6r626wEqVqV5DPIZNPDcfaDsijp+Qhzu55rcOZ7jIOCtSRoJ2dIwN0HeIViFZjfx
         VK2ipeSADgQZ5ahsvEQ0I/Zl+lDPC6ruuNGT24KumnTwvC3LdKeNZ916dyE63GQLGQz0
         O7j3dbFnDlIR0gfflegE/NLYPn8OnPY/tbKHtG8Gzig2TKWyiYu4Zp9CWs14ZxaZJgB/
         JjsrI9hPMGzsxUAPV29ojIqeiDsVPYyaVY6vlnh/rb+1tb7xINyBLezLqIOk+D0fh5y+
         2VkQ==
X-Gm-Message-State: AOJu0YwEYxk0KjzQEHnV2NjU/zksMZ5HNXp/0BR0gankiTluWFgDfVk1
	buG2r0NNEKTdPh+DKpPVKS9q9g/NpMSBOeUBxU4nWEzyUjbnMjiPe0ys978SDtcKp+1tIAq8Hlb
	M
X-Google-Smtp-Source: AGHT+IFQefU52rW3ziQGRz3HvFf4dJ6Y8GbBr7zStkqZDySZmn+wNkoA3854WKjBfwe3a5vPfkOPWw==
X-Received: by 2002:a25:4155:0:b0:dcc:e854:d453 with SMTP id o82-20020a254155000000b00dcce854d453mr6794480yba.1.1708466740883;
        Tue, 20 Feb 2024 14:05:40 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v192-20020a252fc9000000b00dc74efa1bb4sm2191779ybv.13.2024.02.20.14.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:05:40 -0800 (PST)
Date: Tue, 20 Feb 2024 17:05:39 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test incremental send on sparse file with
 trailing hole
Message-ID: <20240220220539.GA1024959@perftesting>
References: <fdf9b90760477ef48547efa1a5eecf273deaa09b.1708261420.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf9b90760477ef48547efa1a5eecf273deaa09b.1708261420.git.fdmanana@suse.com>

On Mon, Feb 19, 2024 at 12:01:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send does not issue unnecessary writes for a
> sparse file that got one new extent between its previous extent and the
> file's size.
> 
> This exercises a fix by the following patch:
> 
>   "btrfs: send: don't issue unnecessary zero writes for trailing hole"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Made sure it ran with the patches applied and all of our CI test variations,
also reviewed the code obviously, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
