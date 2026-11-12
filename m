Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504790;
	b=IMGY6XoJ1MK0O6KfUPf4/tUNNgQY4hmMZWi0peQ3sPpwtew3vVRawAHbL3/qbfptXEHg
	 AUNoRHzHGBlTe04b9rTR5auVuAXW4kvFD8z5rWu+u8eTdvTtOGQXNc1ff2dyDDXTIqr5d
	 41dVF72oOeQQRBacIxZMWXN8sW4GjD87ccGF5Usm9i3qedt9RiLA7qLEoeAFA6Cx0mlT/
	 mg0VHTjSbFUtbMVzazlL2dPcgsN6C7jsLWFGpdHTPwSjYJy8j1uhX0BU5QNLB5mwjd2lT
	 MSBFIUHpLC5AAZbLlGfOQTwW1L8vIXlkS1eGvmOIVORH2WXQQQKfnUer4RGg7jE/Zhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5eyhuI7FzhekfX+xV3Iq1NylLu+7L5LKRe2f31Y/j3M=;
	b=ZIicuEXHHv1aPhLkR9IFVYC+8Ehp+GRn8uHrCcLkil00PWAPiRiYiI2+G/p3LcoQm3oT
	 80jLvJnxjsy35PZsTYn6L2dDas7hXXEnj3gClE/XphZ3FY4h6IOP9Y9I/+5HdROhHvfm3
	 IHmYCwz1Uec08atn92iaajN2UYb5XBfos/bgwFkZr4L3N8XOMuuwtxsvvVJfJDx7/y3Yf
	 eicVkR1uW6sW3pvI002hlkMW8k2m+LiGrUmGLV49vB65yH/aCezY5eajjuDODMuHeXlLe
	 QYCtknipdpvFiUvOVoPZc6Ctc96OAHzaCU/uOOFbt/EdY+JGAp9Jn3BBGXbHgX+n/hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=gOc9aebS;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142560A262D
	for <fstests@vger.kernel.org>; Thu, 12 Nov 2026 17:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7142560A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=gOc9aebS
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f3c616c84so420807785a.1
        for <fstests@vger.kernel.org>; Thu, 12 Nov 2026 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794504788; x=1795109588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5eyhuI7FzhekfX+xV3Iq1NylLu+7L5LKRe2f31Y/j3M=;
        b=gOc9aebS94R9Z2z+F3JlD4FtBL5rSRjWPa3k3fS/+u01SyRKfF4MunWEzfG1FfevNY
         Pp+IZHc7ma9YY0rw3vCJ5oXDvLLe2D+WwydDoSqvl7SS8V359Es1jbMKaI9LMEaBm1LD
         C4DVjsq/r033GO2WkLkhphgIS66X/RaSCerVaysfSaai3cY3LRkGPIezK0bv9sBXsHBe
         afX3tk/586JF/SAWCfG4GuL793vMJUqooU9wAzE/5OhBA8mh2pQzufuYgCzO0EbG4iRz
         Wv+Ml06U9XqNKWd1c8FNP6rmP01wwppYcfqcNjOeVklswe3kBesjPWFbivGKGSBCBBS/
         2qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504788; x=1795109588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5eyhuI7FzhekfX+xV3Iq1NylLu+7L5LKRe2f31Y/j3M=;
        b=ZZVeepA8z9Cro2MKQAxMs2KnFr8LFC89jpg7aL3pFyoPf1SlfJKSWQSGYHH3KYaNoS
         puH1oHsFw6MtyzbOS5FpF4HkEzdvv4qGTWgzjHR1THmYDWnMSeGesHI4jSH4qLPgM+Ny
         tX+rdQ1g4OPHQrEO5ymDUAMptLMW9icgjXFX3ZmwQi9HYvJpHHrqnD1TgEKhojiCwYRd
         goFYrhmylZeJsF0w373L6vetvjW2XnI2frct/DAbHK+3Dta/CsU2xpcqAGYUtRreDvoO
         TMpSMo932+BKvkXu9DvfThyh4+h3l4E2UUrU9P4xw7XPDWuWcCMS32o+uNjY58nsqiFU
         mz2Q==
X-Gm-Message-State: APuU4Z9ijYuUdc30wnbeDdGHXjkbX6CNisRAtFYEGtw+0fDSjFMeA98V
	fIfdJtsl0yDOKXb78Hc2+EdiiVnb+HtbEjLnx6qHXLKBppunck1KiptauZ8tADEh/0sgJbHQoBY
	nfPl7Kw==
X-Gm-Gg: AYBFou1UAVTwyn5sPvW7MhEOtR59G3wQ15oPVnGylRBFdRdvWu5RyZ1OfXT3IoFX7zy
	KTd+NbhdnblCI/A7pZ5W0jNXXpYc9IWMEFgn6tVUxtovm1p3mIaNRr4lgg1HcbvwlUdTjKI24iO
	25vjrAq4Y4BwiGW30d7ETNYORUCZvgERv91mQ5rpDD7Pj7GGiGI4Pck6kzGMsbavEKUbEdqHmbO
	ouu/HbbP3TXgUd+z0hVkGkC051ICGKwtWVrFeuBxkO2omiw9NlbQ3ytvC+yRKYHa5tNhf2p1XVU
	rTM6AGoGPJ46QdXvEJmoR+uJV0k2hV2cqnjXL7pcuJS8FDksARW8rTdWZeuH382llNaXlyoS3J4
	YdI/xG3rgFoZqXetI7gt/3QR3LwcHB2Kyg1elskbcEvkdHpZmw7C2I4T4gJimbW7flc5ngaoa5c
	pnz+gIS5CiT8CBTno3mXz+jf05os9UMVmavLvw/solzzrDyc0mrWySkCxwcwvwawoMACwOqWr53
	mGy1cBjSNJw74VgcIUIp6/yv+USfDvsN4Ty5BZm71tfcfR7eyjP76hUNzYYcPEz3FY9FXTJdqv/
	8whQWvxvw330g3IL8df2j/b77a9sBQyCz6pU+/O5Zp/3t/vVVFqA
X-Received: by 2002:a05:620a:4048:b0:93e:7192:191c with SMTP id af79cd13be357-9494bb97d00mr12510885a.17.1794504788307;
        Thu, 12 Nov 2026 09:33:08 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73a65fsm767293285a.12.2026.11.12.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:33:08 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org,
	Zorro Lang <zlang@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: test that statfs does not report negative free blocks
Date: Thu, 12 Nov 2026 12:33:03 -0500
Message-ID: <20261112173303.979651-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112155331.GA32171@lst.de>
References: <20261112155331.GA32171@lst.de>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 12, 2026 at 04:53:31PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 12, 2026 at 10:49:17AM -0500, Hengyu Liang wrote:
> > +# Only the data device counters are checked.
> > +_disable_scratch_realtime
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount
> > +_require_xfs_scratch_non_zoned
> 
> Why do you need _require_xfs_scratch_non_zoned?  If this test is always
> working on the data volume due to disable_scratch_realtime above,
> a zoned vs non-zoned RT volume shouldn't matter unless I'm missing
> something.

I copied it from xfs/306. _disable_scratch_realtime only unsets
SCRATCH_RTDEV and removes "-r zoned=1" from MKFS_OPTIONS. When
SCRATCH_DEV itself is a zoned device, mkfs still creates an internal
zoned RT section, and the root directory has rtinherit set, so the
files are created on the RT section. I tried this on a zoned null_blk
device without the check: all the fallocate calls fail with EOPNOTSUPP,
statfs on the mount point reports the RT counters, and the test fails
with and without the fix.

> Otherwise this looks good to me, thanks a lot!

Thanks for the review!
