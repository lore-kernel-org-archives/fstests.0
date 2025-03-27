Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F60F1CAA95
	for <fstests@vger.kernel.org>; Thu, 27 Mar 2025 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743106971; cv=none; b=e7OoMdzKfqkvS3Q6W9RE14holTnz2lXxlmx3JDngS6VgfTRamPVknYiDqDD0vNpOXZ7DUa+PeP01qiJMAxXY6nt1HFsJrpBjOV7n+gJnCvIbLRivgGoBw1ogElGfO5g5xoCD1ZaTwReHvLdgF6Z2weN/r4J1ul91hoEvoKUvRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743106971; c=relaxed/simple;
	bh=hWsoNvNHVfFmyq/J/uqEJxexZfkLwaAkkAF8jkhLaLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W67SuTvkupryqavQTfMZvRbFlAZUhn0o2vXLtNSH3IACefpQf7QV2/rmzr/vSkaEidON8/B2pI7rSNFcm+B2KtkKhzFxSFrr62TPfqxz4hjbm68OUinBtrsDF9uh+1GHtToF72WG0hhVbr1iuwrqlsmyISQM4zCbvRwfNjOfX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Yh1gb2Zn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Yh1gb2Zn"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224191d92e4so30150145ad.3
        for <fstests@vger.kernel.org>; Thu, 27 Mar 2025 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743106969; x=1743711769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f36YSwLPJ313+jNbvLdd5CTUY7LI4BTt4o8yr4k9tM4=;
        b=Yh1gb2ZnrNy735DzwOlU3+UeOzHLxvl1Wb5ane4aqeOfcHK66mfgwm6jRq8g2Mci0y
         fsB9O//bu8gMK8wWck8pnjXMGbPfcQ71l0U06OGY9365oRHu+cFGp8Hs2SFJV0cGH+Wg
         CDz6uZOsl0eSnBhvaqlVjvRRSQq0sxLTT6F2AU34L+nr1iL0eeHy6RAfYbE3h2KxbQyR
         50hI1DWM+pVstGaVg6bgMDOwwTHBL8wKjNRX3so/g2BOSOGvkiU4Pm2cvQOWy4aWi36S
         AqkWKThqJOw8L0IhrglTZlymMVwRrT2uNXnH2GE6cVenjw7AOYYDlq484S1/wvVEJt6T
         YRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743106969; x=1743711769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f36YSwLPJ313+jNbvLdd5CTUY7LI4BTt4o8yr4k9tM4=;
        b=PCYuIZ2ZWOyV0vyawJwy4Y3sK3GtW4X0Fxt7ecyDEBWCB/rI95TGD7eOfco40k1gCy
         U2hIIrLb6lTuNBSsigRE33UjuIDsMeAnwKqLnjKr8fme6JIBSnU8X+fj/hlhWIvO7AK4
         Uso4WYZA2rq3W79SPdspbqrl1W6OVWJgybns/E51e876G1zH9Ouv9rtIGMrGoUbj31kZ
         pNfwyIJuqutstKzqwssC8pXvfWpzMRL6ERWZdRznPc9oqGV2LoFkIrgzRQjgXDzGT4MB
         yDF0VE8w6DqxvUbj+s/9cvLOGgODToFSMqCUsKPrjUfnPyh6UPYGDMDSCVeabjDbRARM
         bTQw==
X-Forwarded-Encrypted: i=1; AJvYcCVK780GbBBR4rBWut43xuPo8yMNMaidlQ5CvfqxPOEsF54+Bqe3c0wrPKneH8D+EhK8sKJweESX@vger.kernel.org
X-Gm-Message-State: AOJu0YwxZHxuLTW7Wr1+lreAW3i401eRYRccRr5gk2tS5sB62ML0NOZv
	xLA6gkxADUhZWCPCmlyEnOxrLivDeJX/xMuurrSw5STH+/Z4463wlFGagjpqJeY=
X-Gm-Gg: ASbGncvGVlKpDZ6NBjib5NFW9RQEOCyi5M9kxAKSPY/HkWtn664skZfqigmBWXoJSmj
	Gv4i5kWyaL02EpB4MAbklgYNoEedLTBBvKKz1pRL1nKjGpgK7RLSUzcj9TYsyC3MAFeFgEQh9ta
	/sGS5mgQ6RTBRjAgKtydPbf7UzsOStg/z3uazTTBs3LK4OcRMcTXlmqFN0AlWPhRauJ2RalHCQt
	PCgrBOb/eT4H9/5IeWE0xRumsNLNnS6QCxZKuBb1Uueho9ATi2ct6tCHtL2mFaS0CHn8OXs2pLo
	i9r+IGUAETmteKkTYTe7k2a09Y19ZYd079YHZRlsg5FtsuHeZSGG1W5oyi8MViIU8B2cF268g85
	UrSvMYqNXgI85HwNfew==
X-Google-Smtp-Source: AGHT+IE04slap1s8okAKEtulK560I8Pk5y4yI9BiST5ZRxIXZ4EDqBdpcK7KvdffOC2kSZ2m8M/JJw==
X-Received: by 2002:a17:90a:c2cd:b0:301:1bce:c252 with SMTP id 98e67ed59e1d1-303a8d81d2bmr7055953a91.27.1743106969072;
        Thu, 27 Mar 2025 13:22:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dff0529sm2964573a91.16.2025.03.27.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 13:22:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1txtkT-000000016eh-2SQ3;
	Fri, 28 Mar 2025 07:22:45 +1100
Date: Fri, 28 Mar 2025 07:22:45 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>, patches@lists.linux.dev,
	fstests@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	oliver.sang@intel.com, hannes@cmpxchg.org, willy@infradead.org,
	apopple@nvidia.com, brauner@kernel.org, hare@suse.de,
	oe-lkp@lists.linux.dev, lkp@intel.com, john.g.garry@oracle.com,
	p.raghav@samsung.com, da.gomez@samsung.com, dave@stgolabs.net,
	riel@surriel.com, krisman@suse.de, boris@bur.io,
	jackmanb@google.com, gost.dev@samsung.com
Subject: Re: [PATCH] generic/764: fsstress + migrate_pages() test
Message-ID: <Z-WzlUN6fSciApiC@dread.disaster.area>
References: <20250326185101.2237319-1-mcgrof@kernel.org>
 <pociwdgfqbzw4mjass6u6wcnvmqlh3ddqzoeoiwiyqs64pl6yu@5ad7ne7rgwe2>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pociwdgfqbzw4mjass6u6wcnvmqlh3ddqzoeoiwiyqs64pl6yu@5ad7ne7rgwe2>

On Thu, Mar 27, 2025 at 12:53:30PM +0100, Jan Kara wrote:
> On Wed 26-03-25 11:50:55, Luis Chamberlain wrote:
> > 0-day reported a page migration kernel warning with folios which happen
> > to be buffer-heads [0]. I'm having a terribly hard time reproducing the bug
> > and so I wrote this test to force page migration filesystems.
> > 
> > It turns out we have have no tests for page migration on fstests or ltp,
> > and its no surprise, other than compaction covered by generic/750 there
> > is no easy way to trigger page migration right now unless you have a
> > numa system.
> > 
> > We should evaluate if we want to help stress test page migration
> > artificially by later implementing a way to do page migration on simple
> > systems to an artificial target.
> > 
> > So far, this doesn't trigger any kernel splats, not even warnings for me.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Link: https://lore.kernel.org/r/202503101536.27099c77-lkp@intel.com # [0]
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> So when I was testing page migration in the past MM guys advised me to use
> THP compaction as a way to trigger page migration. You can manually
> trigger compaction by:
> 
> echo 1 >/proc/sys/vm/compact_memory

Right, that's what generic/750 does. IT runs fsstress and every 5
seconds runs memory compaction in the background.

> So you first mess with the page cache a bit to fragment memory and then
> call the above to try to compact it back...

Which is effectively what g/750 tries to exercise.

When it's run by check-parallel, compaction ends up doing a lot
more work over a much wider range of tests...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
