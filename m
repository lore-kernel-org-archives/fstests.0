Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FFF440E
	for <fstests@vger.kernel.org>; Mon, 19 Feb 2024 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313898; cv=none; b=ChtO4Qpd+8UDgdqJuOAayXhljQ9l8RNgnXf28aGfgKgF71P0f0x5HRIbvIFqhfsEuPikr/C0mkg6Bj2xv3oEQziDe94Mw+RpXd7R/UhfTKoBWvCOv9SdYGMWOr08FyCCtOarK5edpn5xTx+6HW/T+6oNkto2upSLkfghdbjYC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313898; c=relaxed/simple;
	bh=dv6zeaFrRvbAqGuha6VsK0ygAyWi2WBXbRGFN+cxJJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf3eI3p+GD2L/mYgyZdLmlJqmhNIvPuXtfU9ecMSolTsSgUIEyuH7w9Ezdz0Y1DeBBqR5K2TDhJ3lyH3HRmFvO6adHrs7qJFpnEZ2PRKWPLsefBXYLuFflzArVQMOSAYAA7mY6uhRUhKa4+UN02nhjCJDRksgUGB7+ozyUOyodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=oYFUEVPB; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="oYFUEVPB"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-299b92948a6so46657a91.3
        for <fstests@vger.kernel.org>; Sun, 18 Feb 2024 19:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708313896; x=1708918696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snkAwXlGmKMGPxH6OPqiR7B5ATkC+pV6nS/zNfbY9Vc=;
        b=oYFUEVPBgH5Vigt/fsajt37Tyqp0QSQVlYm+YL/w+nxqVJWmtuzXhpZl8mopYiqiXa
         ih/YU4mDqKQp7kUsiO3WpTsa1u2Q2nQwO+vLsGFqJkQZ00qrHsDj1k+jcoNEl9HjDarY
         q0MlNq8KEl5Jq13+bnS5HT5zjzgAf+RAPkveYRyJhJu2lrIkz2Hi+QKD5dWEq1PY2LQw
         w21+Q/tKZ2Xa9+zfS7dhwDSwOlmdWqRz5OY1rKLd/Un0QOUm8cI8yWjbJU7FO2EOFmI2
         +JNqsP50/ctpTc+n4MxANfTA1+u94+QXXid57UjAVWkHtHfdbM75GtJiX9v6sx0BgzRX
         SKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708313896; x=1708918696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snkAwXlGmKMGPxH6OPqiR7B5ATkC+pV6nS/zNfbY9Vc=;
        b=mQiwjqgCrmaTIamXm+G3OHSmL88mkzEgig8KeoHX/o7tx1cNnNudUQUeUTstQEqPAD
         5sZFWq2i6Lqd4PbRrSVojaXx6UElDXX5ti7mc0SFh9K6lD1bMCltwEqmSG3pvg4JtJmI
         OCqgLh7ashPpsSnM96dislKICQNEZRmx7w8saLZcclgHAhh20hbcrME2M4qbnShc/Zcp
         pdyx4QeB8Qnf8AblsPEebeAOS/rRSNuSBtQLN5+FUruhlXI5w1qgJsh1pYufoiIaVOlv
         sLGUbkUQ84enyVOx8hUV6ftgZU4UszirBsB/BO1VZKhcnNmf+SbMeokhxhAZLr1g1RjX
         WYUg==
X-Gm-Message-State: AOJu0YzAV/4gu3UU/p93bk1GzvzLN4rPOpsNAreSO7txf+lmAaBd+VHs
	6zI7n+F1nmw0TyHhGLUXrUwqE0f6isuu7dESyFTVMM2QIt9uL2vRC6Zo1sEQAsAmgKCkibc27D3
	G
X-Google-Smtp-Source: AGHT+IFD58ZsKpdgAYSoAuHc6zxmZ42otJO9CrU80mux2WyOXUdV/N1NvIgiKkl34xRS9rvGCNiplg==
X-Received: by 2002:a17:90b:2306:b0:299:489f:a126 with SMTP id mt6-20020a17090b230600b00299489fa126mr3293858pjb.41.1708313896144;
        Sun, 18 Feb 2024 19:38:16 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id c24-20020a17090ad91800b0029948cb4367sm3954944pjv.23.2024.02.18.19.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 19:38:15 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rbuTs-008S7J-2H;
	Mon, 19 Feb 2024 14:38:12 +1100
Date: Mon, 19 Feb 2024 14:38:12 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, anand.jain@oracle.com, aalbersh@redhat.com,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kdevops@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 2/3] check: add support for --list-group-tests
Message-ID: <ZdLNJD5pYaK84w3r@dread.disaster.area>
References: <20240216181859.788521-1-mcgrof@kernel.org>
 <20240216181859.788521-3-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216181859.788521-3-mcgrof@kernel.org>

On Fri, Feb 16, 2024 at 10:18:58AM -0800, Luis Chamberlain wrote:
> Since the prior commit adds the ability to list groups but is used
> only when we use --start-after, let's add an option which leverages this
> to also allow us to easily query which tests are part of the groups
> specified.
> 
> This can be used for dynamic test configuration suites such as kdevops
> which may want to take advantage of this information to deterministically
> determine if a test falls part of a specific group.
> Demo:
> 
> root@demo-xfs-reflink /var/lib/xfstests # ./check --list-group-tests -g soak
> 
> generic/019 generic/388 generic/475 generic/476 generic/521 generic/522 generic/616 generic/617 generic/642 generic/648 generic/650 xfs/285 xfs/517 xfs/560 xfs/561 xfs/562 xfs/565 xfs/570 xfs/571 xfs/572 xfs/573 xfs/574 xfs/575 xfs/576 xfs/577 xfs/578 xfs/579 xfs/580 xfs/581 xfs/582 xfs/583 xfs/584 xfs/585 xfs/586 xfs/587 xfs/588 xfs/589 xfs/590 xfs/591 xfs/592 xfs/593 xfs/594 xfs/595 xfs/727 xfs/729 xfs/800

So how is this different to ./check -n -g soak?

'-n' is supposed to show you want tests are going to be run
without actually running them, so why can't you use that?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
