Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBF3208
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 03:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737431561; cv=none; b=tntEeFGRpyF56Mm5ldBKBQ2/76sz0xQrVBub0PpwSGSpiDX8j1b9jGIk7e0vlfUE6feeUAfgasdYezeLs5oN037CCxtk//jmofxxtCsBKCra5/EPBs4oCwTlX/R3jjKGFazysWpNLw3uJlLGRQo65wzqX+P5IG3Wi8wY+05UCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737431561; c=relaxed/simple;
	bh=Op3refNe3zmAJxsEfIZXs3EvpBXAc1nxtoOag1mVq70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNoIiPOjWO5bRbIbgcxevXgvekaWPxbKU2Ft57GTHnmLenoQYNxWr412+Z+1v1/7W4Ogj/y1NkIPdTioxPPKo+ei73hbWwuhjw85u2MCIdTqbQScAqoM0xgIpxJ2DB91zyZHTkcwU7/YuRRosGTMfa4bDqzkf6qKyQ0vx42bG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=LzqUQjAq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LzqUQjAq"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f78a4ca5deso4342967a91.0
        for <fstests@vger.kernel.org>; Mon, 20 Jan 2025 19:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737431558; x=1738036358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Bkm76FL6Qr2OJ5O9V4YsHFL2MtzHY+iPQD24o8/L8Q=;
        b=LzqUQjAqQK/JBHv2bSPJNRUxjZzL6R81HHKuFsXQAVJEQeG9FRjFYLz0Acsk3olmRi
         EJtBALpIn0SBjWmvarxJMF3XPyIIwnhd1clppbA3RUfdRL9GMkbfRG+kr8TF7EsY56JO
         VQjWjCILsQNvBr/Leqjh5AbH9fdTvUWKtSEnXKyjmOfF/+nYtd4z+RLj51ePs32IUNhM
         XIizF+Ztx+znWl436SSFnHpLT6iiIeM9dCJA1Q4IgpSLQuHO8f9ufO+XxLf+wS7MaljZ
         oDvF/BETjn5tn/MHp7v8nnubG2NkRHhE2Bt7JAmo3OUaLuZjsfR3WEy8DkQ79PD6t72h
         spHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737431558; x=1738036358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Bkm76FL6Qr2OJ5O9V4YsHFL2MtzHY+iPQD24o8/L8Q=;
        b=ZEtab+29d/lg0Qx7xX3kj1+DIL/keS5yDKPpjqWcXkOoyhYfnsqXSas5xJLaVA9iz6
         abAqK+MWRi0AE/dJWKmla6T0hpKYNETcN6VKMBjJUaZyI2PLxZ5dOGkTUPwm1z3Wqc3s
         qgf3xoN7xAzfgQwh38B1kY9ZzQUzPfDhWoW0Ko2PTruWKIYUQkvBI12fOib0aTJ7CahS
         tgxgWVLRft7flxvZ3qDIMX6fJREVUj8Ek9f5380mydYhtaRhRAnCdFjRrKDlmJz6gx9q
         PwwlJWDYiR8hkkGPwc8degU4EB/2QnK/8CXyCDzX0wkEscUabhwakfcgqKKDAG7qu7ib
         TI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmua63B7lK/eQ8K/UayMk+IaDiJxVXf0xnRkAEpvs3fd9pciyug0IJtQ63ae8BWX9URtp43RGY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vQJcuigGI0UngACnOkYqSTU0MdRfCWaVG/FIXK53kMVKf3ha
	vIcdPkeihR0PZ0Q/j6+XaueAbnz5N6N3KwtMen1nKEYDBCk+G25ulYjf/Jk0lrnvkYzItl8NNMK
	L
X-Gm-Gg: ASbGnctvGNBf+SenFwM/KZBh0IywVU4MndQZ4yq/j1F1Za44K6lUy3JgST6SvXKigfY
	kaZeGOJOWvud3x+yWJ/l4gS6CLvj4gCxplKWJYkOtA7vCErTXmbhY5DazMUBZvrhlhlkkQEE5gB
	43kJhQyNcgD7OhgPoc/ppXrDTkDIjeruo/UVruJL1Z0rO+2pfOIggaLlVxVjDNAMqQZ5Dc7b8BI
	dVhUOYImskaOTcQLajdy3R9Mri8dSGgRxEHpnKKf5JEjrxGwST/y7TcBHuYUmuJYc8Z5fL/ZTD/
	bENb9E9hTkDmT5F3h1rjVs40CgLpUqMUPTw=
X-Google-Smtp-Source: AGHT+IFkq/B7XsSyAhp00U5Q84kequdJDfLGc8tWgUI1LhBoCrG4adcypDPWql0vCF1BcAHyLYCiaw==
X-Received: by 2002:a17:90b:5249:b0:2ee:af31:a7b3 with SMTP id 98e67ed59e1d1-2f782c4feebmr25088692a91.7.1737431558511;
        Mon, 20 Jan 2025 19:52:38 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c14ffaasm11656481a91.4.2025.01.20.19.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 19:52:38 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ta5Jb-00000008Vr9-17np;
	Tue, 21 Jan 2025 14:52:35 +1100
Date: Tue, 21 Jan 2025 14:52:35 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, hch@lst.de, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 09/23] unmount: resume logging of stdout and stderr for
 filtering
Message-ID: <Z48aA5-wMRNrXKER@dread.disaster.area>
References: <173706974044.1927324.7824600141282028094.stgit@frogsfrogsfrogs>
 <173706974213.1927324.1385565534988725161.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173706974213.1927324.1385565534988725161.stgit@frogsfrogsfrogs>

On Thu, Jan 16, 2025 at 03:27:31PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> There's a number of places where a test program calls a variant of
> _unmount but then pipes the output through a _filter script or
> something.  The new _unmount helper redirects stdout and stderr to
> seqres.full, which means that those error messages (some of which are
> encoded in the golden outputs) are suppressed.  This leads to test
> regressions in generic/050 and other places, so let's resume logging.

Huh. g/050 hasn't been failing in my test runs. Bizarre.

Anyway, change looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
