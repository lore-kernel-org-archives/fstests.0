Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0B114900F
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737435945; cv=none; b=f68EBY2fwuhXuHsQGTMRDf5N8xJwRVtQEbk5B9Em0MoF/AKTiuoA3+I9WTsmH6dmAVEcH5Pt4eQjrRrsgtgucV/CgdI+kP/r4BxHzxpR3S31yRVuQ7y2/H3Dk01Nbg6Q+iYMu4OH9AbObh4XSxF36M1TM2bF6RrJY+MgidTPfdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737435945; c=relaxed/simple;
	bh=9AgjCU94iKFSziUK02zntvNLKKOMcZeTw0AdftAwmLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oe3Dfb5izUp1IfDxHRh57xcfVflLzU5aUI9DYG/eIONHHWPReyKHmffvFrYqWdedIOETe1HemjTpW3McqQluD371DrXW3McbMfHkgUynCTWxOLioDxKAqDggSw7J0G+VhIQ7zM6k/AIrshwe9/B46hPrAgP5jNnEOqtbMCXzN2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=UOkPRzBU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="UOkPRzBU"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216281bc30fso117979145ad.0
        for <fstests@vger.kernel.org>; Mon, 20 Jan 2025 21:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737435940; x=1738040740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3GiVAFs1hWZcRMN8J8SkS1g40L+McR+ktoC2/c+Pxw=;
        b=UOkPRzBUAok0hJLSNpIoAGxKyxoWQ2O2UYW+w5skf7+wovQlVE4ZySsyJ3cpgFmtZW
         ozq73rq0FffCnAL9URrymgrpYydIztrAzJQfHysWj2KZwHbAnNq4RWQ1tFMD64PAH7r6
         fwlLpVfkEQR5rP/srtdCBD4iXqDiRQ6VlId2EYcQEFofjS0wFjh0Yw0eXxlzzokd74J2
         ivLJ2QnybClRIdgz+TJmBE4YbaiT0lMHaR2uxMGpxoVhSBfQdF3HWjga2zWYSD0Us5Lu
         8VRIq41KpofD11Nr1ao6TckP8LrNUKbt9GyKIIjB4pq51nKyuZqWO+Y8vBbdi8wBqhdQ
         pG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737435940; x=1738040740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3GiVAFs1hWZcRMN8J8SkS1g40L+McR+ktoC2/c+Pxw=;
        b=hj3UBnow6kHPbVWhKRN1sSNyY4N08c8jva2hQTWPEaf/wV21054HvhTF+zEHzaVpPJ
         0osPha1Cjo/kb13SgZAf0Q3MEpOgpRyxf6uF8cyb5V2PUpomHHeP3NEwY63y/wWjvD/H
         lC6z+9JRV4dpjZwtDvN1kb4py8djzJg23SfN8vvTQUgxtwDYdxZYSGg6rYa8scd61epm
         8JvtFtGrck74ACQiWKEtq5o2h4qLFSrz3QUkQJmZtsRKMpanTkbSZwEcKU6fSYU+qLId
         EK43Spzxm/xHqYdSZ3f+MtPIDSQUnnFCfG3pG44kIKWjWYPcq9zyygQ3P1Nl1mDX5q9U
         yqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF4RSN5M+ELuJKyW5gb1ySsN4BwPI1DlfJavdqHEc1Q/QjlHlxQMpsxayOWala4NVpDD7+CsJu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0BkwKOSu0g315XyCS/f/UBpSCxehHNQf4R+gqrxeoxanOk4VV
	1UlmVEGFcsKopu44ISwAWIZoz80USs/aHeXlWz7KQT9PKFBzZJDL284lwS1DBDk=
X-Gm-Gg: ASbGncv2PGTo+taleh1wb6YFMf7NfZysH/eqcK2N0XQY+zVrEXxXpc5V0BOrYF2RUKQ
	aZ4RS2AIqzncF3xaVmx5n+eefjFpmLdbkJx2nzWG/F9JdsaJ6jr//61eJAPL05BO1K5m4+PJ9eJ
	8QO9DULlLo29/S11ZIlfkVKm2mBBWviaBQrTF98ew9asrp59G/GfAlFvSUZZgteryHJ0YYRb4so
	bDuwckQ5mkboc+T3L3JweE3c3MntYiXYO3/fVhzrk57UGSo1omj8jQfajLJPRURqso61DWbv2OQ
	cMKvgOpROMnjYjHYhf2yUNC/5PTC3ByoQXw=
X-Google-Smtp-Source: AGHT+IF901/HmLl1mKMPqNtTPkup7hlmBd227QT6jLMAxRnhGeJjMPyWLCJ+0vlu8chunsP0YBBTpg==
X-Received: by 2002:a17:902:d4d2:b0:215:94eb:adb6 with SMTP id d9443c01a7336-21c3563c51amr240971375ad.40.1737435940762;
        Mon, 20 Jan 2025 21:05:40 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d42cb7csm69074285ad.259.2025.01.20.21.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 21:05:40 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ta6SI-00000008XJI-0O6T;
	Tue, 21 Jan 2025 16:05:38 +1100
Date: Tue, 21 Jan 2025 16:05:38 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, hch@lst.de, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 19/23] common/rc: don't copy fsstress to $TEST_DIR
Message-ID: <Z48rIh_I5PTrwJrh@dread.disaster.area>
References: <173706974044.1927324.7824600141282028094.stgit@frogsfrogsfrogs>
 <173706974363.1927324.3221404706023084828.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173706974363.1927324.3221404706023084828.stgit@frogsfrogsfrogs>

On Thu, Jan 16, 2025 at 03:30:07PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Now that we can pkill only processes that were started by this test, we
> don't need to copy the fsstress binary to $TEST_DIR to avoid killing the
> wrong program instances.  This avoids a whole slew of ETXTBSY problems
> with scrub stress tests that run multiple copies of fsstress in the
> background.
> 
> Revert most of the changes to generic/270, because it wants to do
> something fancy with the fsstress binary, so it needs to control the
> process directly.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Change looks fine, though this should be a lot further up near the
top of the patchset so that the change to g/482 and the revert here
is not necessary at all.

With that reordering done:

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
