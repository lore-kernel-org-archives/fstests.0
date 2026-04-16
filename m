Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219A2ED84A
	for <fstests@vger.kernel.org>; Thu, 16 Apr 2026 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354935; cv=none; b=PjjZW6Z+x37/SpiJTeoY46rBoEz9wkXjojHZk3hTZBb/8qmCoVWLjVc8PGMj3dcK2nYiaqXIFJXr6BlZuIOcOJAoS3x+GUkF9Bp3/Zb829yXL8JiZXTI8Q1JrQc+xcTGMYoPUVjben7u6h8oYWsrWfpKoku3t1RI34ST1SAoAyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354935; c=relaxed/simple;
	bh=heVWTHGVCiX2I8vXvVIMJcPy8ejJ4b2yKmKsalU7Reo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6Hnnn6Y0HhqfhN1z3VvRahyEsjLO7jI/dODCnMfNflUICC6FjOLtd6ACQGM13pKEfeA/nR0EvYXw2uhZTcUdBDO9JyB1o/5OWTjCB2oLjtlSgheKlclYRFzYS5tWvrbtshv/zzJqbERcycM2WlUoCLvpJ97BCKKvwBYTkFpsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tA3YK7oP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tA3YK7oP"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so8191213a91.3
        for <fstests@vger.kernel.org>; Thu, 16 Apr 2026 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776354934; x=1776959734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chO0qG8Bm9Pj7C9gKdTzSncNYRCISPnp8yWh/BT53sw=;
        b=tA3YK7oP+F5z0ytpj2IEEs8wCJK5cUnuV252b9SmqcNTvTNm7BEi8OmbqHbuWcUAbd
         RU9g+FE68KYK5Iav//5rC6i7f0DkbQxcSPm6IyDtnwgcKgqksc+zJM0ub0Szym0voOlG
         RNUUzOgQncC2iVwewy+iTG3/FISr0kTRcnFIgKGBhr7FB4d1C5gZmHS0A6yPB7+orVxJ
         EbkEKQGg1DC2yk+3IRMnOUrNc7kjY7CZDAyTxBk3uSuBFnOolvBuhmzWEMruIy8k42fI
         K335J5jtChVuwz6jbq8mS5RRaP7B4AjcrffcfXNnd7/c7Y3pjukdiEPNthkJJSSd7l+s
         dSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776354934; x=1776959734;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chO0qG8Bm9Pj7C9gKdTzSncNYRCISPnp8yWh/BT53sw=;
        b=JUhUb1u/kR5MBU047YXp4dOyHQMeaBAgDIUfM6Nsh6km4o4O71NJDDA0vPoAsxlemi
         YQLYme9qL/HzGZ56HFpv4Akkn+3QeWzcdTzAJIyezPgonKsA9+CiHfUgFU/mbEP4t/Cm
         fvdgCx8/Uc/AK6S3YqIUy5BCq3DhTNzYD9SUUAk9wZ8wBsc+O8o8/eF8844XPTIiNLN8
         OxiplmIAqKfvFAas9QbIj8n3EMGncO2efXw2HP3MRV80XYGSyuuT+OiczT0ko2sSkJbt
         OjqRN6V9mZxkGEqOJrXTvqLxozVknfGfp8hOD+9wPQyOyOV5bO5fHoJmcNP+HdMuWozN
         qkUA==
X-Forwarded-Encrypted: i=1; AFNElJ/DpYe9LMDFduZMwKpKwx0GQiPgX5h03WsnyphFnLU8aHs/dZq520v6T2iKwF6phuwncRu2gIL4@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPvjy0G5FTlevDGYyZwYg+yDLK5MZSU6fK4EXASb6PykGn8n2
	WBvcw4svxDpXnHMx+0iIXPNTKflQrJRuAfjjBnsfmQvudjSdxbyCMYJN
X-Gm-Gg: AeBDievb/WSdSTfJOToDb24mCMqaoo20SwRGxDUSwv2SMyq5sx6Leo8PBY1mf8C7ZDh
	K3eFL2c7+zdSIHOmmR5qDiamoMYd+qrloNKNhcd7NcLbQYc32FTvotf1dvPwDhyx6EbIagc7gBx
	DjlR3VyRkD8z4tXuDFEo9pnLAjD1hea2N0UFqlz3QNwrBaMYYX0tTGjLpgO5Ukj0xyCGjsyCYQh
	40IWI3cjV9K2BnAdrNAHDKa9n+CKZjhgwWlELfHcNvAQe8yNFwqfh9Heq3zCtAMR4S7YGE50AKE
	g0VubaARJjwbZSsNVOO3Bh9LRSMsvfwWOPERRxJxKc8miLsoo6ohuSwarbOylSBMEcYKuxw+CpP
	hs1bPympHcoTAkjm33gdDcsQqzRcoulN/VwRR2LTbMb0OALs36I9YWfwSE9J3PDZwSk63pae0Ey
	mRlafo5Mu6yOd3tXkIPil4Ab7mgUWINEI=
X-Received: by 2002:a17:90b:33ca:b0:35e:594a:5b6b with SMTP id 98e67ed59e1d1-3613dcfb87dmr12841a91.24.1776354933666;
        Thu, 16 Apr 2026 08:55:33 -0700 (PDT)
Received: from zlang-mailbox ([64.176.226.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132c89552sm2964279a91.1.2026.04.16.08.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 08:55:32 -0700 (PDT)
From: Zorro Lang <zorro.lang@gmail.com>
X-Google-Original-From: Zorro Lang <zlang@kernel.org>
Date: Thu, 16 Apr 2026 23:55:21 +0800
To: Theodore Tso <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	fdmanana@suse.com, ritesh.list@gmail.com, naohiro.aota@wdc.com, wqu@suse.com, 
	Disha Goel <disgoel@linux.ibm.com>, linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 4/6] generic/765: Ignore mkfs warning
Message-ID: <aeEGUqPcOO2xydDN@zlang-mailbox>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, fdmanana@suse.com, 
	ritesh.list@gmail.com, naohiro.aota@wdc.com, wqu@suse.com, 
	Disha Goel <disgoel@linux.ibm.com>, linux-ext4 <linux-ext4@vger.kernel.org>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <afee4fedcc9b3685df0e05800d82b88d27f977f8.1775802601.git.ojaswin@linux.ibm.com>
 <20260410165435.GU6212@frogsfrogsfrogs>
 <advRgjl1tG4PMc6V@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <adyxi7156VAbL-G1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20260413162120.GV6212@frogsfrogsfrogs>
 <20260413204215.GA5461@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413204215.GA5461@macsyma-wired.lan>

On Mon, Apr 13, 2026 at 04:42:15PM -0400, Theodore Tso wrote:
> > > > > > The output can get corrupted with warnings like below because clustersize
> > > > > > more than 16xbs is experimental:
> > > > > > 
> > > > > > + 16 times the block size is considered experimental
> > > > > > 
> > > > > > Hence pipe these to seqres.full to avoid false negatives.
> 
> You could also suppress the warnings using the -q option, for example:
> 
> mke2fs -Fq -t ext4 -O bigalloc,quota -b 4096 -C 131072 /tmp/foo.img 4G
> 
> > > Futher, mke2fs has multiple instances where we print warnings to stderr,
> > > should we go and fix all of them as well?
> > 
> > "stderr" meaning "standard error", I'd say that errors are anything that
> > prohibits the format from completing, and only errors should go there.
> 
> Sure, I'll accept those changes.  But adding -q will allow the test to
> pass using older versions of e2fsprogs, while still allowing stderr to
> go out the expected output.

Aha, good point! Thanks Ted :)

> 
> 					- Ted
> 
