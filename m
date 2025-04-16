Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D03148830
	for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779758; cv=none; b=soxdcA8yc2zWhAEBOt1Y31woJsWQj3Ap5UMQkz+b6FltEcVyR13hpx1ZG5drQttcP5m4wiSnisvVxZEtgWKjgRHBMYSu4nq0pAWtgeren6rPGn1IKn6vIjZsIZiCS/amEBGHk3WvabZEu3d2JHfGhWT9tiSErxOH1gO2g/2H8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779758; c=relaxed/simple;
	bh=9oxlFvjwY29lWinAzE+6WdLCl/ugyvGCUTcuqnq++xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODJ7aSfUUGhehA1rUkRvnDexnZf4PkOZ5SfgeS/sXAhi/IKPATjTG5kn6QCuDte+AEXbS+PtdiPNGW4pZii+Suq98kdnhWoqi6++0corJjKOlW1cMpXIioRp9U8yaDlBjNVuWDOCipevLTJNY0ooILNk7bqcLJfkwXA8pyYR6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=LehSVY8X; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LehSVY8X"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7376dd56f60so4317123b3a.3
        for <fstests@vger.kernel.org>; Tue, 15 Apr 2025 22:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744779756; x=1745384556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQwRCsFxhYU0f9dtRKCSUjLf46o930dlr7rW2dkxJ5g=;
        b=LehSVY8Xg/FCMjkuhWL3B/ODsVhjtD56wVQbGU9xMrSWJVkzD3bozJ4w9OVDDB8vk7
         1/nO/NOXpJ3z9DCkJAHyvNVbuur12n+5tDuGlsMHWFFO3xEV2QzhP8pmg1XF2anT1k1t
         yQ9dg+g7FDSU4J/pwLWT2NyXAYcFX+MyWMjVKkxupa17PtSppVsz107QfYJPZ9kjTSCl
         ouasYt2e7kc8r5Qkd14KnidZtnUp7qM2A1ApqIHP+AogZiqxytVmLN0m0frcf/ni3Sob
         uIrxlqKQnNLYlYLoZFMJGtZqyMx1W98ZkpXAd8dLL7thiDqT5E+QRG1TwqVn0DIFzBSo
         LKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744779756; x=1745384556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQwRCsFxhYU0f9dtRKCSUjLf46o930dlr7rW2dkxJ5g=;
        b=YcrAJz94eY9NAoRsFevecYNa7Sh5PZ/O8nY3UWL5AXsYrs4uUwlnThxiSBN0ya9IUm
         6spDSmqVeKG3ngtdKDSJYnqCVLGkUf+0T2DI5lqyTFl1Tc4o/GoXtZnhwthqaCZoToOt
         aW5wxuBZnJyxEPqmcXBnO0HtCsKaDJkwBsJNr55FnQ1OqZbNZb7YV/b868pHceDZ+foS
         TOzRvovQNImd15+DGAYBA9QTXRnM8LHMEbDP1Ywxr6NWYw6Vi6tLJwsAjqfhAOxDLfVg
         7Y5MKofBlTIdyxTGTyy9YaCC+5HJ81wtvStYhi4dcAqvaajjUC8gMbXpkqY8Mb0hVjNO
         UTrw==
X-Forwarded-Encrypted: i=1; AJvYcCWNJA6UvGNxkSoEbFTQoPqPt+8ai46jS15gjKlJmYpp+sISSNJ7UjwMUBulg4Wae7PZDV94K1rR@vger.kernel.org
X-Gm-Message-State: AOJu0Yysz5s/Ynsgz6MrOJGuroFqR/f3TdiOUqXIf/MmSRDuXQGEwumT
	x3g49lLcil6+r7u8oxWcv+fwKmSlAFRbiz/rzm/3ZdxQsS5W6aFcZ2IGRo/18/qGjhNGPMCCVd1
	M
X-Gm-Gg: ASbGncsFq+FhglsRKhlI2gCum5g36QlcW9T+zDswxQ2NR3KQ0K0yIZGCU0JKE3Nd2Oc
	wnNmr9EaGLBQs7+nK/uByobTizbsLMg3v3mFqLqxz0G7YEym8ZGXWmjZs4vkUoNbAHnU0MBn50D
	5MVCmkM3678/Mk/MtSgOM//nyH+yQLVlVOr3SQK3RQFg07TbhvvzTbxgZAqH12PKAOporrV5k5l
	zYBKrQL/9X/xrMwknkJnPLM3TpQDJt4F+crIY6PXMOXqUQbui/mqiBSLXkt31L1We5R/cTrntmE
	++RaziB+A77swlhxB6akqwma7jSjwPqztBYztjBLdDcHLnAQTmHLUpxG8Nx0jmGo3QwbVVU3Kuu
	K35I=
X-Google-Smtp-Source: AGHT+IGGxQ6DNnEYHL1oFzXX/o+xzzz30fP3L8lYAS1xM9DtqUClNv64u8ArIBAFnvaQ+XpdDJGJTg==
X-Received: by 2002:a05:6300:4041:b0:1ee:ce5b:853d with SMTP id adf61e73a8af0-203b40026d6mr438997637.39.1744779755873;
        Tue, 15 Apr 2025 22:02:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b22205b94sm425017a12.51.2025.04.15.22.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 22:02:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u4uuu-00000009B1f-3KJt;
	Wed, 16 Apr 2025 15:02:32 +1000
Date: Wed, 16 Apr 2025 15:02:32 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, dchinner@redhat.com, fstests@vger.kernel.org
Subject: Re: [PATCH, RFC] rename check-parallel to parallel-check
Message-ID: <Z_856KJvJSn2n0q6@dread.disaster.area>
References: <20250410075731.3800342-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410075731.3800342-1-hch@lst.de>

On Thu, Apr 10, 2025 at 09:57:26AM +0200, Christoph Hellwig wrote:
> Having two files that start with check is really annoying for tab
> completion.  Rename the new check-parallel helper to parallel-check.
> Or maybe pcheck might be a better name?

I don't care about the name, but I do care about how we change it.
changing it in the upstream repo will mean I have to do a major
rebase of my patch stack, so if we are going to do this, I'll put it
in my stack where it causes me the least issues.

> Or just fork off from
> check with a --parallel option?

No, that just makes things really difficult with handling CLI
parameters, default env variable values, etc.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
