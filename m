Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72638831
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737428605; cv=none; b=R1c1evv7AeX8q3TS5eI6nYrduTV0afu+eyAl7ox6+v2dSM2txZAuiYwli0pqn6yK3OhT4ZHqvztzmcGzSWAV7QRyvWDvHF+ubQbb88g3Dw8a5toFNyPTcldNKGCoL6MBEIBSgeHQIeVJudXp524CuZWd75wkBwLQN+7uZjS3pAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737428605; c=relaxed/simple;
	bh=BbV5jKqLTJiO31UvKt0PaPhLhOoWJ9c0y25/aH/XKDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTnG8G/zRDGJOq+db/oBSkLvf9/6C9wxDo/oKiS8NNL/Tw5WvWfe55NCoR1v2rQqbh5PFbwu3TglDzfB4621LfZenNoOxFa01ffjAA8QHQZnq3Ge8BzK225M+NHEpE9RMrUKeKwqY0rcfntE/jM7jPiDM0tDTYNFu7HCWar0JBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=nnDzdSgE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nnDzdSgE"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso6634179a91.1
        for <fstests@vger.kernel.org>; Mon, 20 Jan 2025 19:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737428602; x=1738033402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FcQopt018mcfh1i0WWwxMAtuDKTEJV4gm7uMMtqwyY=;
        b=nnDzdSgEU2wVJy1dZMR0j9ZCKFMR91dof9+ltSCNiO0+nFaj/aXQWq0N8aLNiYpiGO
         JuZVkwMgIyZEBv3xb2NJulQcnG3pZmZYacRfZ/M5YCGRN4nAH+jGIyhRJnhLsbVvRyiP
         T7/j1FHzg+LJoMAGaGWr6lTOcpcJ1cYtzJHOJFO5/8cpYty34K0W44qFDEnRdq5qvfUl
         Yeq5ITMq/jbB7/L1awiSiBYFR4cfe9qez68ypLPrxza8WFc6dpf32vqWErJ8TDiiXePp
         UR5tyGaTFfzhyR1yJ5nXctBNmIwYPymH+6MX2o1Kc+euriEG3ZYChzyXw0+xEifBXAgJ
         h+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737428602; x=1738033402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FcQopt018mcfh1i0WWwxMAtuDKTEJV4gm7uMMtqwyY=;
        b=paEQDZ7BZszQZCth832gYy/m8iMac7bVF9tg0qRfQqgVy1nE5p1YmB5aa2NV8cSgEX
         VH4FOTTnXa5gPD3rO7SqH0cRoZxr/XzH9C/ayBLE2TNh2Hm/V685gZ+O4kiCb6nCgGw1
         0On2CzUC3k119efCbs/j8sCM8y/hUFtiyca6OEBY3BTGdevTwGmAMpX/hp7RuisjJ5f/
         y63orX5OliB2FMyfYbx2iTxAsjzdi819J14srOcUpaVGUw7T1IFoIIUBX5GIzYMF4CcK
         t8k6dDomO9MmsBvAWf1MgAm4tiOgXucGCsIlTY0hTqFIpJKvRCy0csBU2MAfqYj1b/no
         hr9w==
X-Forwarded-Encrypted: i=1; AJvYcCXgoMn3Y7pJcBT80xkkZKcUUi5U2tFei5jVF6f+QR4NEwIf/c6ONfvE+0oPbdWZGKX0zt/HmQM3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IrpkHc0IWYvJDg+6k2YJti6wR/hkj/Dakwx6ikZycML8wT0f
	dRPbVYFejOSkcoC847rRaquVcyC4cCZvB925ea2GzKd/HrFMGLB6rFcriFfSRfo=
X-Gm-Gg: ASbGncu1xuPNV0CJeRIfG+T4C60qV0iBInnFuKuuVbvITFeDN9AjV5DPq2UUHKWrOtr
	ggegKXa2pckgreKP3Raim7I/eXklW/ZiKsiNOQ2oMA58CfWD2cvxG+VFCkyxSB1G53CEv3Pv4Tn
	keI1wmaWP0QqTiYBmdmgRBv0eq2klJ84P4zGQqy1Y5NuiLN99J5GOKUqxgVrq/Qf+V/CevXD8d3
	fD5S6zlXB1bcm9FsWx/wCPndwfBJ6MB5mlf4VvePbuW7RN7pNUwTswKnaBJjnx9VWjRvoq3UlZ7
	03q+GyLpCGHFy+y61AOMxG5Uu3SE9jpjZdk=
X-Google-Smtp-Source: AGHT+IHiR7lkT1DaLOjXsW+1Wi28WUK1LbP5cmcv2BcbCU928X2RotwIEqRkNUypdWQFkQOt17CQWA==
X-Received: by 2002:a17:90b:2809:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-2f782c92bd9mr24402036a91.10.1737428601984;
        Mon, 20 Jan 2025 19:03:21 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77615720asm8510148a91.19.2025.01.20.19.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 19:03:21 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ta4Xu-00000008V7W-291p;
	Tue, 21 Jan 2025 14:03:18 +1100
Date: Tue, 21 Jan 2025 14:03:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, hch@lst.de, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/23] generic/476: fix fsstress process management
Message-ID: <Z48OdujL9TQA9sdC@dread.disaster.area>
References: <173706974044.1927324.7824600141282028094.stgit@frogsfrogsfrogs>
 <173706974091.1927324.4002591248645301199.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173706974091.1927324.4002591248645301199.stgit@frogsfrogsfrogs>

On Thu, Jan 16, 2025 at 03:25:26PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> generic/476 never used to run fsstress in the background, but
> 8973af00ec212f made it do that.  This is incorrect, because now 476 runs
> for three seconds (i.e. long enough to fall out the bottom of the test
> and end up in _cleanup), ignoring any SOAK_DURATION/TIME_FACTOR
> settings.
> 
> Cc: <fstests@vger.kernel.org> # v2024.12.08
> Fixes: 8973af00ec212f ("fstests: cleanup fsstress process management")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/476 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
