Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9BB3A0E99
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337572; cv=pass; b=en4Zf6tMD+pcHCnBQN/SQ/3GEQjadBmvqpGnqi43wXLvEi9aLR2bTtFkjuf542jy4aDTqmw2UkZHIaEk+P9WQvdrG3luEyeD37/4BMG6Oq9CndCUHI015m6fa4L8UzvAh1nvAJ4L4deiO06fEMN3KSMDd/betT6Xge99PWIb97o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337572; c=relaxed/simple;
	bh=18m0kRZmf6MlU62CpUnHUbGhhrK1KxYBWnnR092MWJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkdPjZMPLWAMCt+NNxGfPREV0o6bzCH/ZQKXQ4J5kfFE1YHl/DurE7sbS7toKmvsts07EufcS19WHi+vWXtj8n8c6dWaS1sUxKwLo9jYj2TAyB74GQfKhs0YQ9BarhPlJPRF4t9zmK/mjrVWJKNLNE1I5s/cH2oppVQbzaqwy+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps52ZK4G; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps52ZK4G"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so1031878a12.2
        for <fstests@vger.kernel.org>; Wed, 02 Sep 2026 01:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788337569; cv=none;
        d=google.com; s=arc-20260327;
        b=e/kfnqj1NPvKo6L7g+hvVBC3knLwh/PJ2bVeyJg4DbTYI3NL3uhzNQM7R9PWHj/mab
         GtSZOhYc4SUMCqbGLOzkG16S6Mg5GB/KW2NC7JjJvXJAefjqjSwPOfGOfXabmyCNJQ5S
         1h3D0/H+zdBbwj3n5SHUkI7/e0YLaaiQLaBNiLG4yh5t8gquaMchl/nwcX3S1Fqs6Je5
         GPhqvuNlrOTD6xJKArI/MTfhh2qIZVD1KhDQDB3CA4hwPfP8b+Z5X3Bueq2DPw6oY5eb
         cpAFl5N0mSYjtebzNzYRj1ZPrJUtW+UDLxM3tMe0X2CZiBmB/3QJyw3wm6s95EFyL/lI
         bUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0eczbwjeDgTfTo8E/jMH3HqYNa1P/k0/V0rEwa8jamw=;
        fh=a+YStTnwWt0ISVNiRQuiRbHHpuvFIwT/L5MKBrlM+Ac=;
        b=UAYWPFm4ZcS4qTx06j1Fv6N+WtQHHrnCLefbMU1Y7rjzix5V+IUIP2KR3uX3k06Tzp
         XarWAmbd+asn2j2f+6FMhlET+39bR/dtNB2YpVYa6vOkNg9SkvsPMYlJMDX9hwW5fnjd
         mNTtPUxhG/4KvGjVpiWdkYh0eS8P992vjhJQrAQJWUGNiPXBiF1Yj6mVTk85UaeLav22
         /abxHkYT58J7Ims7fior5INg4ascjqzrWj7IOLvYlezFtKG8z1seQS0kBJG/iIYZ34jC
         Gh8AM1St9QfSIUDq4oFApBsy6WGfXLLbzGf1eWdPj+hnZCb4BGfKcbqHVH9NzMgQaRgq
         4CvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788337569; x=1788942369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0eczbwjeDgTfTo8E/jMH3HqYNa1P/k0/V0rEwa8jamw=;
        b=Ps52ZK4GjTuuaA9yhnsvmG8euoVd6aJosws46pRmZAQEaqXQ1avg9TL2+lujljEsUG
         YGRySL/5901Scdin6yFzv4IY60ZdXmYCSdMyTDjHwG4xX49YQEq0QwcQDNdmwlMPr418
         8d/i6MEYhNGsRFroX06zpbhwHBb3AZckt3g2fLLO4CkeaWIrTQf0amrqCgn7EvtMP4ND
         TiaURKEXjQRbxS3mi1yReQhRuUvMuM1qRhEdm9QqaRwLZOGiH7WbCs75AwHhRdc6OH1d
         mdKmPXrKARJ4G5c21/iW2bsEID5hM05vfRib0bgnCrSwoJzK9wt9MynBkzEOxmJxOQJD
         afqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788337569; x=1788942369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0eczbwjeDgTfTo8E/jMH3HqYNa1P/k0/V0rEwa8jamw=;
        b=KReTXuPCZRPdH51wAPPP/Vk1Za+ipy2MgcuPYHkWgf9Gp03racF/tOwRsOypo1Yck6
         wjXczxpBFhQhL1eLep2ekvTK1dwZucznI++LRZ7uaLlNRfRyFTqtQE6YFj/tF2QycbtY
         YkeMKvoNFBnOfKF+ts7khoUZQmtDmhCORZwtMdEznIR3Sv6QU0c3uUnru3lMrzMEsDlL
         6vIpBCAWXL0JOjjZlnOZeo8Y0OMfWF4teDD+JcPtfHwi9uZhiWrT4qH+O4dfsyaWmOwg
         5hu2NejTu2Iv7PyMg9H7aceaz49U9gD1KdZQxd/bglVlplrO+FRp7OCUevHMLH6EXled
         ea1g==
X-Forwarded-Encrypted: i=1; AKwUvBzJMCaGJ54rbcv2dzD03xtIhC7LDlowgUSEntRgr7LhBNyv0hcZd5mv1D10l6UfeCkNJATXkuy8@vger.kernel.org
X-Gm-Message-State: AFuF++mKsQdXBTr3o5aY3S4z2qJ7QrxEgu6kZWyvnio8G6iLhf8Zog0b
	6pCl/rNi8ktNCNGmr2X/6oEDpZxIBxlGZuB1xtkOl20QEmU6fbTN4SN2V5qrsaEOqvii6+y836f
	V414NqoAR8oLYMxC0pavCUPQK72bUZEZJBuU3Q6E=
X-Gm-Gg: AYBFou1X/2p7840mLifsvTqj00LyfCY+KF0zsnAC252UBqUHvdIYIhWR+4JNG7Y4yy/
	/kCKDf70JPn+vm/zbmljr+Yj3FLV2nIHAfP5So8/3Q7brD7f6C5EJwVVe7EqbylBkQ6llctNwS0
	0RYViUJpkHeYl78v3FjitysMQzMsB8Xb2UJ76iVuQeWDrJilJIQT+hMyk6ehNJopOTjUFGbKMcJ
	qxpFGdpOHc0KJwDwS14YrYyfueNrovvV2L5nv71BlwuH1Gw2x6SngPN9S58EyKpKa0D+1PBtlwQ
	yvFguHJ2jw8h7bvX6s1RfB6sRDgaKqoCEPvX9Ig4o50GEg==
X-Received: by 2002:a05:6402:440b:b0:6a5:f9ab:bdfd with SMTP id
 4fb4d7f45d1cf-6a6817d4555mr2318992a12.0.1788337568940; Wed, 02 Sep 2026
 01:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901132438.759-1-prabhakar.pujeri@dell.com>
 <ape4hyfwsv5LrYxB@zlang-mailbox> <20260902073507.5074-1-prabhakar.pujeri@dell.com>
In-Reply-To: <20260902073507.5074-1-prabhakar.pujeri@dell.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Sep 2026 10:25:57 +0200
X-Gm-Features: AcwNN1XLGgAON-P3OIfSkTy_E2k-15GdqCzq9mG85IZV3dwPkw5Tn7MT9lpCzII
Message-ID: <CAOQ4uxjBc5CfCpjrq8Ut4xHHaenKicTxBCbNuQkBFuu-Mz9=EQ@mail.gmail.com>
Subject: Re: [PATCH v2] overlay/081: add missing _require_scratch check
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 9:35=E2=80=AFAM Prabhakar Pujeri
<prabhakar.pujeri@dell.com> wrote:
>
> On Wed, Sep 02, 2026 at 01:51:08PM +0800, Zorro Lang wrote:
> > As you're fixing this patch, I'm wondering if we need a _require_* help=
er to
> > make sure the mount options *uuid=3Dnull/auto/on* is supported by curre=
nt system?
> > Due to the comment says "mount options uuid=3Dnull/auto/on introduced i=
n kernel
> > v6.6" :)
>
> Thanks for looking.  That case is already covered a few lines below the
> change, at the first use of the uuid=3D option (line 40):
>
>         _overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o uuid=
=3Dnull \
>                 2>/dev/null || \
>                 _notrun "Overlayfs does not support unique fsid feature"
>
> overlayfs rejects unknown mount options with EINVAL, so on kernels older
> than v6.6 that probe mount fails and the test skips with the _notrun
> reason instead of failing.  The uuid=3D options are also exercised only b=
y
> this test (it is the sole user of uuid=3Dnull/on/auto in the tree), so a
> dedicated _require_* helper would have exactly one call site.  Happy to
> factor it out anyway if you would rather have an explicit requirement.
>

*IF* we would want this, I would not recommend a dedicated require_
for uuid feature.

I would recommend teaching _require_scratch_overlay_features/
_check_overlay_feature to deal with mount options (e.g. uuid=3Don)
which do not have a module parameter to tune the default.

So if /sys/module/overlay/parameters/uuid does not exist, instead of
assuming it is not supported, assume that it defaults to off.

I am not saying this is worth the trouble, which is probably why I took the
easy lane and added the local _notrun condition adhoc in the test.

Overlayfs enum mount options that can be tested with the generic
features helper: redirect_dir, index, nfs_export, metacopy

Overlayfs enum mount options that cannot be tested with the
generic features helper because they do not have a corresponding
module param of same name:
uuid, xino, verity, fsync

verity - has a dedicated helper because it has special conditions.
fsync - test 087 has _require_scratch_shutdown_and_syncfs
            which is technically enough to test support for -o volatile
uuid - can benefit from generalization of features helper
xino - all these tests 041, 043, 044, 067, 070, 071 practically open
          code the suggested improvement of the generic helper

So for the uuid test alone it might not be worth it, but unless I am mistak=
en
for all the xino tests, this would be a nice cleanup/improvement.

But of course, this should not block this trivial and correct fix patch.

Thanks,
Amir.
