Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3853BE
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714506; cv=none; b=m6KBPM8IgXd2aPdtI8xxMyZdKSp1FfSq11WnmSiJB0tL34L97TumPday51VjfquFAWvwyb4lmQ4jhPQGglkL3Lgz1oiCITViGjh0yB88RCsRANcI6V1ak59QZfVXDLGo0BU1tJZQH8yW3NVXRcIXbGfta295ttlCg/t7imkpyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714506; c=relaxed/simple;
	bh=uLQquXgmTssOR68eJsMIs4FDbJ6qba0cuODYGCF5aSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVwSeBrkg3Hq8Z0zQqrLDXE4V7gfkmVnI6434RuNHPNEPXejICZfXyDlg4WiU4/rDH3Pm0kzRsyD3Dj+hGUZfh9pHRsTPgprx9h2I5jyry50IR6NuZOLSdCpPT5OIRSAXPf/h6BrfIBBx3k7GzGq38Z+EbmV/aZIruD5MLHE3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=olIQVgtP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="olIQVgtP"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21661be2c2dso105763555ad.1
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738714502; x=1739319302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xla1eyZLhS5EmFBfiSNE0Sv70/LRGJRczxpfK7Flbr8=;
        b=olIQVgtPlGxl+YruE5kdMEvqrkEGWaL/9lKArVrxjFcBuynEOCy8f1AgL5nHCDFYR+
         MDREpcno65bvhDado+OabQ9h2G7aA2XI2mPQ9LX/ofydmy/00xCuWNi8smDx2XI8EVYF
         VW2I/2hKhdGV3D3Y1hoMpDowt8BCDKIIiDSRhJvNvUYUd4jZCmUVCxsjN3ts2v8kwO0v
         HJ50JKPB9ZJhJII/0CZk5gSSBtnCG+BdQJjMJV/Blyn+Ri80+pAdmU4r+nwtRfGho49/
         uPpzqOoXTCVGonEdGgL4DkUG4iKLxeBdbLuUzbnmIm4T5UaVJKLAk9StcX3bzpkE2eOJ
         YoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714502; x=1739319302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xla1eyZLhS5EmFBfiSNE0Sv70/LRGJRczxpfK7Flbr8=;
        b=r9hy5GVNgoo6rpKY0TtjFrzJZNazgbESMwiEynzaVf+urpeUSp7Iw17OKn5Qw2x5+T
         003EqwaEk/Xbo+H5zL3AsjATcGkaLSTdzNxPfJFWKl/A7Wy0ZhlMG0vQDbld/N5Nwj73
         +M1Ta/toIxZ8SRdU6yPGtATiz9iU/Uk5NVeUNmRhMf+6VKyizh5ZkvkIglgz+GCvgr1O
         RWTSB8MSJ8Cw8qXemFB3d/MXdh4At8DV4pvwJMkP7gPmFpZOMvy+rx+/RAr7F8+412bn
         5q3cWL5cuYGnuhACVH/4viQsa2AAnLdg9ISW19os/rHCEYXQqlGvsFi30a833oMj9y7z
         OBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXumymHYCjsZ7b0Zz01zdrI+dps+kw2ZyxsguDfkpL66ByFx1k2DzvyD9xmdtXvwdWrVbeS26qE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YPThy9atoQ6i7rcdnI0bX6k62XECB85WG2Li++/F5QST46Cx
	7gjhsmFkoi7/1BbSBkV4kGIKZSjeB1VWB5eN424fV7jUM0UnMl7TdSYhwbNKaLs=
X-Gm-Gg: ASbGncvICB0usfLleYW6TRUMjcyuCX+gCHyKAYFJd1mEgpO1v+b6XzBsD8BZG8J0JmW
	oNVgrscRNbNyjrmFEGaK6XQcql7NFINH2RTc0ch+sdFYlM90rnjx0Z/iy0jLptJqEu5vsp+Wznl
	MuPdI1WceTHHq/nlpk3Zle9f/X2ZxBSoS5Y0ikKnb7bUa9HvMGisOLdJJES8kCrb6dVJ2O1soNZ
	5CfBJKczwdg2s2TF6+xM0yXMIo9tI1mJ5M4m3+6gEA7u1BwQQS6gtKrDw6Yfy4E32qShrC+Kvsg
	sD1EkttLbk9WCTpSP44lGhpXFwUZQ+CVO6GR5+1lPPHjvwdE5niAxydY
X-Google-Smtp-Source: AGHT+IG0ZMWlZfOgtD5/49DBQQ8c4viEqaE/OcUlkg2Uk2pkVUFdphB5Zr5X2zfwoyulKwav1rtDHA==
X-Received: by 2002:a05:6a20:43ab:b0:1ed:a80e:932 with SMTP id adf61e73a8af0-1ede88ad49dmr1573766637.34.1738714502409;
        Tue, 04 Feb 2025 16:15:02 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6427abdsm11619259b3a.59.2025.02.04.16.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:15:01 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfT4F-0000000Eip8-27QZ;
	Wed, 05 Feb 2025 11:14:59 +1100
Date: Wed, 5 Feb 2025 11:14:59 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/34] common/rc: create a wrapper for the su command
Message-ID: <Z6Ktg3-oudF2wxJw@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406275.546134.6082485989827844416.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406275.546134.6082485989827844416.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:25:09PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a _su wrapper around the su command so that the next patch can
> fix all the pkill isolation code so that this test can only kill
> processes started for this test.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
