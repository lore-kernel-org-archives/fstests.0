Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2418C930
	for <fstests@vger.kernel.org>; Mon, 24 Mar 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852662; cv=none; b=cuhUNeRU8Stm47LDX5ybXl+XgNjCW0GNwHNLCnyiWQHN5e6UrM1U/wrxs9yQNeD90QPRXk7ZyrZg5DsCdkUnmisgC65DAjPCnj7d6/uI2Va6pGNtuwHQ6GF2FbTqwpaC3nY/luSKylW6yJLqQs7RH9AwjAAOSev+KWwlNfWa//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852662; c=relaxed/simple;
	bh=aJcpuW0z0AKOWYMROSRv3JYOl++znNMht6B6rCASdDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQuNbc625XONki9pdOupZxsKwGRd2RByErv/oXT+0jowqpcMBR/3qJ3H4GLs4w53NsabLcZmu3SQcL0sv+WQhIBt3McLLhzmgV/GoHcPLpYtvs0J/iCKcTlMJKpDmgk6Tja2kpSwvrho/z+meRWnSAKMC1mWF1wpKgKX0nH1swo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2QyP6pD0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2QyP6pD0"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso8696381a91.0
        for <fstests@vger.kernel.org>; Mon, 24 Mar 2025 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742852660; x=1743457460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8FBkUNIow0bf2ocASktG0kiYySGaZId7EyqjeOaXay4=;
        b=2QyP6pD0mBnp2XCIgRzdHk+7Zo6Il+ZLHOUOxA5A+dUEpACn0ISxt9vjXEKGzpE5sw
         m0a+pX8vTZUkbWDKPBYnQseHj6W3/zXQtqBq9slBlW37S5blhCx0sMle4lnJqXS81pwb
         AfLPgJUMee1G1onFnq7BwcP9ZZZkNVNHqgJOjwimtLlQIiKTwzL41uHG3zVVB9wE83VE
         3vcjsaxZuXO0MpFIaEn/5LQdM8upChgxgU4uBnWfs21O0H+upqZK2BXqBqdfXEBWz0fx
         x3+utwVswk5h3GYU5tCQevmBuUGLps++e0JRSNj/RchZjg+cFbZvuMWFZoBxSmwyXDUx
         HUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742852660; x=1743457460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FBkUNIow0bf2ocASktG0kiYySGaZId7EyqjeOaXay4=;
        b=iD+3Kde7YhCCvrXHHUXJ0/3yDcDgE6o5El38DTgbRTtvyZ2SrTjW2bDl0uKMU2z/IO
         Lh2jypKhtnG2xRPD25WWPhF3N8qHaZP5UCOm4jWS3V+0wfBKhgMm6NJR/qsjcs282Zis
         bFoqg/BNWBNeS/hS8J9K53FdC/1ovmsgaLe9XBJofILRC7zQwNXACmH9Za/UZlsX7RCB
         +WcZjl4x9GvcA9fQPoQEPlnEuYI1cYLMcKSBRdb6rEJMjOjT9Tsm1xv6Y26Jfe6lNGGl
         KGlYkinEaFFWHzJ9q4NjFihAa8MC3kRIIsOFvBXy4GRTLpS1jlwrtfekUYWcijtpfBzA
         4C9A==
X-Gm-Message-State: AOJu0Ywv0gYJpUO/WvqK9i6/7S2GEQMjd033GMpxwiY5Zj1KogCVKd4T
	0luOr1h6uTYqZ1acOVSsjdflBYVkpIdSzoqPKdBWHfwzuhwEh4zTf8POOpyYWw8h1QRatBoqOzV
	B
X-Gm-Gg: ASbGncsRKD0PWZUG7/wBRdOHSJ4Gh97jNNQXp39SCAU4qXK5SxFm+UBhbY04wvZiLay
	v7fK4l1j0UKPEtAg77EF3kohjKFXefLUiO/kt/217kXsp2wb9K2+eAG2kIIeJYl9AyHnypYDZUw
	tvxxvUejxGPb5OnxjQbO6DNc79voT5O4Epeobfh62+FCTWTTqwb9rQBP0ku4AjkEKdDzC0mwSUt
	rNcRYuGTwQAmmSMaqpLXzsXxFGY6crNjKu6QDwGVoxjRHCwJDqWu8VYq6qHhuccH4B+v8RZjBE6
	Kko8o7nY6rTJDNRodJVWBJsPlfzU+JpZlEHQ64k+Cl1AFXvXV7ABtexwcsLL6oaqfVgMPhiM2Iu
	rIdmj43kPRZ5IAP+PStGi
X-Google-Smtp-Source: AGHT+IGsjpa5ykAZmnteyEL7UpgCdRG27sNazlpoDWagsvtR6ldTJcJrxpcuN6YneDRB6lzPULi1MA==
X-Received: by 2002:a17:90b:54c7:b0:2fe:93be:7c9d with SMTP id 98e67ed59e1d1-3030ec2a985mr24199495a91.7.1742852659678;
        Mon, 24 Mar 2025 14:44:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf636029sm12821632a91.42.2025.03.24.14.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:44:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1twpah-0000000HRPx-30VY;
	Tue, 25 Mar 2025 08:44:15 +1100
Date: Tue, 25 Mar 2025 08:44:15 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 0/2] revert "setsid" and "privatens" test ways from check
Message-ID: <Z-HSL4Gnmjpff67b@dread.disaster.area>
References: <20250320192812.782380-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320192812.782380-1-zlang@kernel.org>

On Fri, Mar 21, 2025 at 03:28:10AM +0800, Zorro Lang wrote:
> To isolate check-parallel from traditional check, let's revert "setsid" and
> "privatens" test ways from check at first, due to "check" doesn't need them.
> This also helps to avoid some regression issues or behavior changes.
> 
> The run_setsid and related things are removed totally, the privatens is removed
> from check too, but the run_privatens script is retained for check-parallel.
> Later, check-parallel will run in private name space way, won't affect the
> check running.
> 
> More details refer to two patches. And please feel free to tell me if I miss
> something.

Looks fine to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
