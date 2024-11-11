Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4C53389
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338729; cv=none; b=NyW0kaIaef45svbjAEbKHSLyZAocb/azz7cEjZkADloZMIWDQ8wpg6n4STI1J9WswPWDuNjlkj++jtNF6J36MI/B+sEJrBHmfGgK0f4sCf3+idrnp9EI4HG5/tCqMc1v3xpd+z8JzhamaeGvO7RC47S8jx7rAxWcvLBwRsOqm1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338729; c=relaxed/simple;
	bh=w1gsGMSTeFmgKZVtoNHA/56CEZWWQergphRwkdjTmAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a078YSDYE9VzXWKTZCzYSRRrpE5m0SbBRAYTluEQSVYIg7XeHWDPR/zarT0q3rToA5MH6clYp6PSFun3160oPyGKsKrPlvhMdYYc/t/AumTJ95Fau5xKWANT7KUq4vst+BoDdEcF+tm4Jau5XA7342busr1QL6Jr9GPbODBldkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Q1QGecdn; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Q1QGecdn"
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 57D0D3F185
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731338726;
	bh=QL3XjmSt0fXf6QyOofF2w0EPPa+BYfn/ilLlbtnEEYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Q1QGecdnU+jfoOq6UmhTNTvEvs6xsS5P1CbbiHkfFaUFlJ61jc6WxYa9JBIMkc/Nw
	 CrLfSTmyWzqpkKB0QxoiCxDXol2QA6dwge4qa/UABAo4AVht6IYY7EJjKkqjim7GOX
	 H2evMdmQ4oM1Z5tZyyFg9mHpcy2xP/jJLxsQSiYGbF19j39qg4MGaK8gET3wmtVTNj
	 X5yOp/ZeAHmNl721ze+F8Mnbxw3Z+tuXm/2p6e73xQxEMNjBKCOaq0t7FtqxCutLsr
	 IU8yZ5tlXsig16HE4AMgnYpVAIttIiqextWRhbWakw69uYvYv+S46OnZM9cMQsqDsR
	 lx26GA4OnrYlA==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5eb59e38e9aso3103255eaf.2
        for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 07:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731338725; x=1731943525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL3XjmSt0fXf6QyOofF2w0EPPa+BYfn/ilLlbtnEEYs=;
        b=QWGTDABbWY25KFvZR0HK1oi3Aweg/mktfOxJ092lE6gKsDebcYLkXvBG80OJZEGD7L
         lOwV02plSwqLEDXScltNck1hA91+8SeY7REu0zhl6azkhQj2kby2wlZVPMClLYpKUdsJ
         KDa2fQMwKJHZL7Pqnu2+kLDdKaaJfYSQTQAtAcp7+lZUdLQ87UFjCHA/fUUX8hjVlGpl
         CGkPQMebtMDt8hy4NZameBqDtJAUhAlz3gIR0Mci3Qgn0NK4EuF5USn4V1ABjRmfsnZ0
         Xij39GzfJeSWcPfiZJFKQM2GSZd54LtBUuRFDHwH7ay/g00GVkurWUNKFvGgRZhyLk5a
         ekdQ==
X-Gm-Message-State: AOJu0Yy1fWU2T6tqBD3gZYTGZi6z3cH/bAfi/6bB/3VuQzjvhVXp80wN
	wzww5h0qGWBTxEI4x67pSHSy5qj3wEJlqlmQJSFhBqm3iTPjQ0aZo26JZ58UmM6XsRySOa5+5P8
	9fYntSoQ0i0M7ZEu2nrbymxksS+w2Pwgsxt9jFaCC8qvFSGCnILDYs/SD8Zf0aSu9li3mIy1K0C
	zagDroAeJZv9WWc4rtM0qnvBZO8277Tf4WZiMn8GB8kg32PQ==
X-Received: by 2002:a05:6359:4282:b0:1c3:8d57:ea8b with SMTP id e5c5f4694b2df-1c641f37808mr458433855d.16.1731338725237;
        Mon, 11 Nov 2024 07:25:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcKQb7kbezzQqfsOGb2kZkBq0m0eTyj0NcM1dGKGpDevi56LPNvZMRrPtoU4GQWpUhNpPvPAwsKfVB4oqrHz8=
X-Received: by 2002:a05:6359:4282:b0:1c3:8d57:ea8b with SMTP id
 e5c5f4694b2df-1c641f37808mr458431255d.16.1731338724944; Mon, 11 Nov 2024
 07:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108134817.128078-1-aleksandr.mikhalitsyn@canonical.com> <d137f247-97c0-4a42-b4ed-ae84ad8e727a@huawei.com>
In-Reply-To: <d137f247-97c0-4a42-b4ed-ae84ad8e727a@huawei.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 11 Nov 2024 16:25:13 +0100
Message-ID: <CAEivzxc-=zsDk_dy7LnTUNzHqVTqm5vW9_3TBaCRrnmZJTxu5g@mail.gmail.com>
Subject: Re: [PATCH] ext4/032: add a new testcase in online resize tests
To: Baokun Li <libaokun1@huawei.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz, 
	tytso@mit.edu, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 4:32=E2=80=AFAM Baokun Li <libaokun1@huawei.com> wro=
te:
>
> Hi Alexander,
>
> Thanks for the patch.
>
> On 2024/11/8 21:48, Alexander Mikhalitsyn wrote:
> > Add a new testcase for [1] commit in ext4 online resize testsuite.
> >
> > Link: https://lore.kernel.org/linux-ext4/20240927133329.1015041-1-libao=
kun@huaweicloud.com [1]
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >   tests/ext4/032 | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/tests/ext4/032 b/tests/ext4/032
> > index 6bc3b61b..77d592f4 100755
> > --- a/tests/ext4/032
> > +++ b/tests/ext4/032
> > @@ -97,6 +97,10 @@ mkdir -p $IMG_MNT || _fail "cannot create loopback m=
ount point"
> >   # Check if online resizing with bigalloc is supported by the kernel
> >   ext4_online_resize 4096 8192 1
> >
> > +_fixed_by_kernel_commit 6121258c2b33 \
> > +     "ext4: fix off by one issue in alloc_flex_gd()"
> > +ext4_online_resize $(c2b 6400) $(c2b 786432)
> > +

Hi Baokun,

> I think this test would be better placed in the loop below. Then add some
> comments describing the scenario being tested.

Have done. Thanks!

>
> There are two current scenarios for off by one:
>   * The above test is to expand from the first block group of a flex_bg t=
o
>     the next flex_bg;
>   * Another scenario is to expand from the first block group of a flex_bg
>     to the last block group of this flex_bg. For example,
>       `ext4_online_resize $(c2b 6400) $(c2b 524288)`

This test does not fail for me when I test without "ext4: fix off by
one issue in alloc_flex_gd()" fix, so I decided not to take it.

>
> In addition, we need to modify the tests/ext4/032.out or the use cases
> will fail due to inconsistent output.

Of course, my bad, I forgot to add this file to the commit... stupid mistak=
e.

I have fixed it in v2:
https://lore.kernel.org/fstests/20241111152100.152924-1-aleksandr.mikhalits=
yn@canonical.com/T/#u

Kind regards,
Alex

>
>
> Regards,
> Baokun
> >   ## We perform resizing to various multiples of block group sizes to
> >   ## ensure that we cover maximum edge cases in the kernel code.
> >   for CLUSTER_SIZ in 4096 16384 65536; do
>
>
