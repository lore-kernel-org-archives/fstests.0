Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7A343DA49
	for <fstests@vger.kernel.org>; Tue, 31 Mar 2026 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987877; cv=none; b=sm5Huy93xQPF/eyAeYXpwJoB8QPpmqZuAKiboRYim1p/tk3VOKa4ckFDpyQhTeIaHeQSrX6wlWaAwFnJCATz6odwJJ27H9Gn2WuBkAsh/4m9LqZlFtEb09rBhGaIM/MYoBnxmbyejUTvzYNWEe5pTdCte1+sLxi5j1mtVXcpeyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987877; c=relaxed/simple;
	bh=zqu+TizdgKifaoVrB5mYc5tEHhZJBiskMql7hRyw/O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8nPWFGbssnzzM7OlAXWTB6D412dA46eNi979XZRfCOwOFt7YNHaNTlzV1rqRd0NP2MdVipynYeFmXrNVvKJcM/Cwpk3ZfUjpSZigIiAPVLxfBRin/WFOc+FjMQ9Dw1Vz3pw5U7a7HP/murc6DzWfmBIl47mhQMQt5LuZMee6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5SfQ7mF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSksvPOe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5SfQ7mF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSksvPOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774987875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bi7WCOV+a0S3JMe/Pc/c/xn4EF1RwytjfIN5ej3N9WQ=;
	b=i5SfQ7mFsy8lR8kxn8RDepGYfDZIFrcvCbXhdzU84QglCOr6JUtoYVBtuPN6iSsfaK1vkv
	hhXyvTnoQeZOnrWc6iOM2K3hddj6bXTiu2qjEJJ69iZO/NLXhxLOtK1/5NuNVhPOE12B+a
	XSolL4myu5XiZzXqfD+BzRbZIM8CCO4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-3UCapCxhMnWdJOv1E9uKWw-1; Tue, 31 Mar 2026 16:11:12 -0400
X-MC-Unique: 3UCapCxhMnWdJOv1E9uKWw-1
X-Mimecast-MFC-AGG-ID: 3UCapCxhMnWdJOv1E9uKWw_1774987872
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b0b339b8dbso81105835ad.0
        for <fstests@vger.kernel.org>; Tue, 31 Mar 2026 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774987872; x=1775592672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bi7WCOV+a0S3JMe/Pc/c/xn4EF1RwytjfIN5ej3N9WQ=;
        b=gSksvPOeFODyxlSDlN0V+e7xlX1uNo5vHIOfose45JplrIbUU/ocHCIKFd+17gY+pl
         pmbvf7pejjR4Im+eDZwPxHdJLKZrAkM79gIKt87JPlLJX89DcxetyMidWdYYNea2FX+J
         ajvtpO3YWZWfyhjCO6b63hYDanDqQGGzydY6Tl0uggNmO67qvhtpy9Df75qeAvHLz3zd
         FRQakYbD46SHsnj3B3Ot7+11o4jjLCVOkZ/cx9LEFhSE8v64Y/lq9IlCLROcsgJGmLqb
         RTfFS+RF4BHgmdEwQ1utqJOdgZCUpngLiGVXPCeiN1qumkVtx6fzwg9z814h4snO1Jpo
         Opgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774987872; x=1775592672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bi7WCOV+a0S3JMe/Pc/c/xn4EF1RwytjfIN5ej3N9WQ=;
        b=NGCuBR7IkwC6iqYwb28BqvXIrzw/ZK7D6bpG5gplzEYGz48ZuZ2OsRt06etCTJtd89
         IDqCHjDeu26m38oWzTEpxsdZC65jBpnLqQMneJh0qepE1Kb6akw/ISdcMxDHhAenhW1U
         FtnsPIjo5rO+Y7XZwnge3u0m9sI09ktqCYE0XWsizF7d+ihwPG1m46P6StIzh/cNedOq
         dybDhrbsQHQq0DFX9H93mNlFjMdbceVVS2sQe6mJ7/NKV7XrpDhI+9xd6f6RXvWTuZqv
         9OUzWAQ6emJNoIbCt7deHoCCsAvTVAj0QKQvV8CK+1tpxW4oruCIlhpT5NGO8gLfNp+H
         UX7A==
X-Forwarded-Encrypted: i=1; AJvYcCXx9rl+RFe6qEoJajQHnqOxJaAsPiKphO+mCrJIFlWsMRrHPpvxK/YZ0k17oOkQIBMXVJIpZGDl@vger.kernel.org
X-Gm-Message-State: AOJu0YyAeLvrlHv9TSTytFxJsszcdJCRqaY/Krl9RZcN0vDnNydVIM6o
	xZrGOIpUrBQjnl1FgwsgyQU65ctXgUNDisHrSLmINHyNrEkrBTCMmXzsdlIyAR8xBeOo5LC/2Jj
	8nxvVZt9yRGDdIiL4qhR1EvHre87ph4xnP7hp3PlkbzNEgL53bQMW8HbQI0I=
X-Gm-Gg: ATEYQzz5FIlP5LFHcCkf6lMWwmdkf3QIXz01f/6c77tmtXuEUKVo1U3rULf+6uZq+Pv
	N5ET+ujCrV9PVBuro1R1c1IWJ/Yq+Sw/VCdCj1JDqU2pVtjF7BqYs/FNcWmlEKEp6i8SaeV/91r
	DtInXsqfMcYDlU/TNOT2zvrIYWtEl3fxMoTQSnf+72MKgaNR3sz3pux5Hy0okNhR8O9Phf/Jewu
	PA2Xs/2/U6O3Gqp8ycLCw4Q7MQtPHBgVdFqVsVkNPceLg5aenFmsj71E5gAZOvp6Ml5AfjnJEV9
	6nB6oiwFpgs1kQgRW1W1AAJD2vkNBYBNH5JdYvb67BBZ7MRbVw5OwSSx/umtJ331SCr4Z5HR7uV
	hiQAZqiEua+ji1ghNrw==
X-Received: by 2002:a17:902:ef06:b0:2ae:803e:6c0d with SMTP id d9443c01a7336-2b269ad16camr4920545ad.19.1774987871574;
        Tue, 31 Mar 2026 13:11:11 -0700 (PDT)
X-Received: by 2002:a17:902:ef06:b0:2ae:803e:6c0d with SMTP id d9443c01a7336-2b269ad16camr4920415ad.19.1774987871115;
        Tue, 31 Mar 2026 13:11:11 -0700 (PDT)
Received: from doltdoltdolt ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c3a4esm155054955ad.78.2026.03.31.13.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 13:11:10 -0700 (PDT)
Date: Wed, 1 Apr 2026 04:11:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chao Yu <chao@kernel.org>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] common/rc: support f2fs in _require_fanotify_ioerrors()
Message-ID: <20260331201105.xxjmqfne4rckc26b@doltdoltdolt>
References: <20260324025656.493776-1-chao@kernel.org>
 <acN4PWKHvk_33VB7@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acN4PWKHvk_33VB7@infradead.org>

On Tue, Mar 24, 2026 at 10:53:01PM -0700, Christoph Hellwig wrote:
> On Tue, Mar 24, 2026 at 10:56:55AM +0800, Chao Yu wrote:
> > This patch allows to run generic/791 on f2fs.
> 
> When was this introduced?  This doesn't currently exist in mainline,

Hi Christoph,

g/791 and _require_fanotify_ioerrors was introduced in v2026.03.20.

Thanks,
Zorro

> and it would probably help to run your fserror implementation past
> Darrick and fsdevel for review.
> 
> 

