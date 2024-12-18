Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07C1FCFD2
	for <fstests@vger.kernel.org>; Wed, 18 Dec 2024 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560795; cv=none; b=E0r2afMtHue/Wm2AA5/Z18DcGMsj37V+BrdrwAby9kGNVN8abZ6joq8/hc/7s2QEZAch4PGsiKrc3u5PWGkLv0AbPqtOljxxlCHypqaCAiKsIf1k6GxWGeYKd2+o9dW63Ktz73G7XxzLaQRefWX8rnIhFN6B+5hCNoSDOUh/Htw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560795; c=relaxed/simple;
	bh=FQeQDfC9C1nQunvLjLm8ScNn98IMfre3AvaP8THBMTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QH8gFSBvLIzrGTOznuWHGO4H6mq3ZeWDMSf+iWd/Dl9zH6qbltqFlQucAJ8/IHkUGPG8KoBlCmX/03LwgeJhEeAfgC5Zr19bF5r5WFElUT+OmCDBTnMC1E+p+fojzFxxQT8DB7wGWx8AU3GxAa6xr2z1Q1fnM7bw3zvIcpnIq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QO1XUo24; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QO1XUo24"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725f4025e25so153720b3a.1
        for <fstests@vger.kernel.org>; Wed, 18 Dec 2024 14:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1734560793; x=1735165593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ouYqBu9YVkqt5kXZfQkc20dcTkyktt/b1pOwmwN7EM=;
        b=QO1XUo24imfnJKzlvMIXkUDShPAaZzzfOvw4kJRGcNaQ0mLQk6ojeGucH99y2W2PoJ
         oHtEo6ZTHHtdXhGWX9WvA6XG5Z46uB+jm/DoOnvcXf8ukh84A5rsbhivz+QV2E+HsqU0
         iBXGtklSdH7/u8V2yP+T8+NxZR0as1VYZd9S6zTwtDDKFqIe3tdpURRn7zn6Qx1Wv4i/
         eEC5HC5zVb9QNLxNqu9k08PqLWooKEmHK5o4Immu1CmWuBu7R/3+HVL9j3S1PiaqVX0+
         tWDEUHjXF/AbpzhA6KaYu4uCPaVvQ60C3Th7inCF20V/+3+VrBCF8sXilE0BCiksPiXh
         3cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734560793; x=1735165593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ouYqBu9YVkqt5kXZfQkc20dcTkyktt/b1pOwmwN7EM=;
        b=LV7JXSi3BvXi7KD1NiTN1KPzJ9dCTwx0TFbDBWyIFNnQn1vUGMDA+KCEJKZU2gEjwJ
         lbUOTW7wC1KnG4hiiaF6s4iogCC5/TngdIC78d9ZiqBMzgpyYFbl0ZpOVG7LlsjDoedO
         v3EG6YBHQj7QnQhc1zM/TgGVEAOFV3l1Q7mkHwbc/YPAmEzT8iCBiwkV31+sHpoLPX5Z
         fLPxnV5d0o94YaIOlYOH0W5kCYSdEKYocVV1t1VfctcNRsTBEe9aMrbtbnwemKj34pXL
         pWJnZEUAuYPTWLZmvldPA+oj2mR2Ii0tHS5xpxsZYzIfep5LNl5DMSbSNYTroCG5Hvr0
         6vRQ==
X-Gm-Message-State: AOJu0YzbekbdvJ1cdUNpc+RrvcF3y4RQeHajTe/egYROIZvJ/MXYTUSN
	HDE0VIo+koQS6zHJST40bXnwdOZDGRx3QQnsJ84YY45dpsTKuFnwQTE7iHLn2MB/tA/s0iupPbB
	7
X-Gm-Gg: ASbGncv9hwVauxH6RxlQbidKl3GNVAmXVROtbxx3E0r7WVUCK21674EsbZsvn3vWEig
	7rfqqbJKfLUlOtGZw2IhgcHbY4t5NGUeYot/mQaFRRiXwcb4X9ecIl5C/z/spqZpYhjHz6lzg09
	m61ZVo4TB8pohV/Y9/CrWrlYA4YJrfPm05ciwJjG9NOBdxCq0NzySOru59wCsJhAiamfS+nzCc2
	n1mOqxlaAf4DznU+M4v0IDdp3JcAS1z1SY3Wc3qEAkZ2aDhaftL0EV9sOVY3B2r4piYs38/puRJ
	ufbWNm6ABRzrO8PANBU=
X-Google-Smtp-Source: AGHT+IENh09+/tHZ0D+XQC8lRBxlq7ZrLfiPjpS5VCElDQMa7lYgknMYfXvqYKZxcP9mtJqH7K1/jw==
X-Received: by 2002:a17:90b:4d11:b0:2ea:3f34:f190 with SMTP id 98e67ed59e1d1-2f2e93889a9mr6080136a91.25.1734560793334;
        Wed, 18 Dec 2024 14:26:33 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62cd95sm2131871a91.19.2024.12.18.14.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 14:26:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tO2Uw-0000000CQlH-0Do5;
	Thu, 19 Dec 2024 09:26:30 +1100
Date: Thu, 19 Dec 2024 09:26:30 +1100
From: Dave Chinner <david@fromorbit.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix recent regressions from for_next
Message-ID: <Z2NMFrZMbz0vb8oI@dread.disaster.area>
References: <20241215051242.3340572-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215051242.3340572-1-tytso@mit.edu>

On Sun, Dec 15, 2024 at 12:12:40AM -0500, Theodore Ts'o wrote:
> I don't think I saw an announcement for the most recent for_next
> update, but I just happened to pull it and try it out, and found the
> following regressions.  Fortunately they were easy fixes.
> 
> Theodore Ts'o (2):
>   generic/135: don't try to rm $SCRATCH_MNT/*
>   generic/530: only use xfs-specific mkfs options when testing on xfs
> 
>  tests/generic/135 | 2 --
>  tests/generic/530 | 6 +++++-
>  2 files changed, 5 insertions(+), 3 deletions(-)

Fixes look good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
