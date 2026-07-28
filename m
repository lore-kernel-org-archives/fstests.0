Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177963B52E1
	for <fstests@vger.kernel.org>; Tue, 28 Jul 2026 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785217491; cv=pass; b=tY6MazO9A7gAQ18D93SjiXNpNQksyR/ydXt53siKGd83vrOOFsaUsESIv3aPsHT9zbCrNv9s+bTpXN08B6ln2+FHos+fHTkSk+Qbn2pxpbBgVrh8/zy58i2tphW8ccIKC37K/YYR4TBRWwaWGLJqZb/9hhSRclcK3dOcOV636/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785217491; c=relaxed/simple;
	bh=YfjN6gu+ln7t5y5mDONTsNJDbtGDekxXLrfrMU8/Ds4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CioXhClISyEelhB9BMOhMoDr/cHaEnVqI2MAqMlhGUsXaIRVZSrLFsKSC3X0KWwfdGF5XRgIxTJ3ygZM02h9n3lyuBLdSvnimSPEKKiqm3K56Ny1BgfUYmrURlVzfpHuR4CV4UoiSj5Bo6PUvs+mlOQIc5wvgP7L1lGfQPoj4sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fBjaNva3; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fBjaNva3"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so18019445e9.3
        for <fstests@vger.kernel.org>; Mon, 27 Jul 2026 22:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785217488; cv=none;
        d=google.com; s=arc-20260327;
        b=e2jyLcL1e+6a577RCqnPrcdxcl09HPZgiJ++YlfUiGHujKl5Vu4wZHjJKFP9BNemIe
         GPQYFHHsvn6JrLYGnECZwqDPKu2NN4c2tP+Bbg5TSl0tQ1Ackb9o5ft0OIMeSmAY5p/4
         pMfbjpcd8//YM1yd2pAmMqOtK3NoFSHRJvgvMAE7iGTdrlgq3iAhF9Fx3bBwZhCM+d+B
         ErGVWSwbQW+4Q7VA0gkimSQjZ6CVtR0pIZ+QRMn6qnIRhEkNmfNlNqwtdoFGzyOZaSBy
         1GfTxY6oWnbHWTSw257IDmCHiq4S/IIwvywdvcULVVkWABrRXLBVLekFfVlFEKSjSyTY
         zmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YfjN6gu+ln7t5y5mDONTsNJDbtGDekxXLrfrMU8/Ds4=;
        fh=oJtrD8uMMQjQhjN6rd2VwHKyiQaHDQfzwBl6fnA6Ohs=;
        b=VuxY7yd2iHVh+PX7Dt5XaRF3qm+AvDQXlTqe0GgRBYhk0N3eR05G+NbplcC9vZ4gOx
         osjL2wnPRpB27seKDAgiRmiTuExCkZkL8/K/hd3lzM5Jc23bUgY1skX+AsSF/Pfld6oy
         UMf7o+Kd3drfKXhGfzmRPfWgXkoBXK9Otf0yYJw+jRBpK+g4EpXRwVB3MT1UFz3UvgKg
         Cgo7UxYnh4UCSMT5sXek3Xnr2tiToR8wjapGiASWLvntoLYnCGApn0cg11s3K7X38wVH
         0Hqyqev7dY5RDSPly0g/0sWRrxMUK3YViYNOccSj8u1H3n0ZME3XYw+NSNOF+2HkFVy/
         cBbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785217488; x=1785822288; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YfjN6gu+ln7t5y5mDONTsNJDbtGDekxXLrfrMU8/Ds4=;
        b=fBjaNva39tUoIh3WdRtYTNHX6lXws0r73HuX15d2GPSulNVAVJug2chPtRkCxBctrT
         77fgXWVjRq4svwy/4Iy/mHq2Mf7BuTmIUSZgxS+pqU2tddt6Cz1jc+ba+k++HVdERP2u
         YTlyXEcjikO/XsTWJ+Ib7KoTgYlhV9JyoykvLCA+vLYLlDNa66LY8AA6t63oh39o+Lrm
         wDW/eKsE/q4VyshhT2rSJtcOjGvHaxZDnMcjzV0nygT/7ef6EezQbO67EtJgUo6U/DEU
         l2XoUeUA9dAonr3rbYVmbYUzoHKkN9KcrZ6/3wHbCjbDETMdv9MpHyAbC8TRmJQ3hoe9
         bWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785217488; x=1785822288;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YfjN6gu+ln7t5y5mDONTsNJDbtGDekxXLrfrMU8/Ds4=;
        b=BDss/W6/0GHt8kgybdc0UNZFQx6Cuxb8+/uF0uliFa6lr0K7Xj6Ejo9bVLHUfcUQdq
         hAs7pB7/bhVXe6ISBTcLwSTwcMuWKr+jxeyF9Xq5ti7Nn27lWJr3SpAN/i+hGt8qhnss
         ieekpbIFiVwZHedfwZnc+GjEF+dD1kIAcjBKTw4FoAqbdNHLT3uMg/HhmIidbK8w6Krj
         ECf/GRgqy29YEwq2gs/6tG+JzokWy/1+ggf4VAPassk9MikrCkLpHVB32ENKMxXDlJAI
         EVT2WC6mC2ZVm0yqGlH+udX531udHvu5tqZIisGsvNrgQgWLbvLFCPi+yhx40sXHlbFH
         6zAA==
X-Gm-Message-State: AOJu0YxDxLJf5rvnYpaBPlc+s3qVDmJjne5la5TU+VWsZs/DMgOh9OCi
	DzEZhZnXMPuE2AOgNHanG/CppDWWdI6veX6eXXcSS/JBRsKgRP29TR1Nrhii5jLr2TyGjDAPpQF
	Hp0bF52d0DizFQMOwoNBNBk9YE71FoCNmYLESIZpqaQ==
X-Gm-Gg: AR+sD10WFo1/mG+9baQtOFsYKwftR4BpCW5m3VoFEaR0UEyE6r0+ChLP7au+2iuPqOT
	TOQzp6dPoZrggDL14nDh2f2F1fCqKp16EAy3wSTkU9mNooe3LzXIH0QJvypRlaIZo5uV3h510ih
	t2IRmq2mx4yux/zgYobnlQUzMnwTP6v3SfD9Ik1JZW4WVmMzRSEa/HAmL9l1WyMA8h/qSM27Aii
	vlbYOdaqtZxUd/UcdGAN0WApx+tWt2QsBn0s0jTFQnRPU6xcdSjxnmMWZTDFGf0Nh21osUIE6Zx
	ZDE5lGFhQ7M6v8L6glqaFC+QcZEzIQBqE5UyCXwK9Ben7gwHF1MCmbxKuBg=
X-Received: by 2002:a05:600c:a012:b0:496:c18c:f9a2 with SMTP id
 5b1f17b1804b1-496c6586ad0mr8148725e9.34.1785217488357; Mon, 27 Jul 2026
 22:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724133328.1837318-1-neelx@suse.com> <amgfuk12imPN2XJe@infradead.org>
In-Reply-To: <amgfuk12imPN2XJe@infradead.org>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 28 Jul 2026 07:44:37 +0200
X-Gm-Features: AUfX_mweqQ4DC10RBxGq9-w14Z5dbzAU5cW-2aUZfLxC0EG3IWa7sp-qvz-yJvY
Message-ID: <CAPjX3Fd1KPswrsNe=BeDpkDwi8CmL9HNKcPScMsgGN16MDyVEQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] fstests: introduce fscrypt support for btrfs
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, zlang@redhat.com, djwong@kernel.org, 
	David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jul 2026 at 05:19, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Jul 24, 2026 at 03:33:16PM +0200, Daniel Vacek wrote:
> > This is a rebase and cleanup of older patches [0] from Sweet Tea and Josef
> > fixed to work with the recent kernel and btrfs-progs changes.
>
> I'm not sure if you post this just for reference or what the intent here
> is, especially with a cover letter like this that doesn't have much
> information.
>
> Before we doing anything for the btrfs-specific fscrypt changes in
> xfstests, those changes should be accepted upstream first.
>
> Maybe some thing like splitting tests might make sense without that,
> but then it should be posted separately.

Hi Christoph. Thanks for looking into this.

Yeah, I could have been more verbose, perhaps also using an RFC tag. I
wanted to get feedback and a review from a wider audience to see if
this is a viable direction. This is currently the base for my btrfs
fscrypt development testing.
Especially for upstream fscrypt changes, when sending those patches I
was asked about tests support. I understand to keep fstests OOT as
long as the kernel part is in development. But at the same time I'd
like to make fstests complement the kernel part and ensure they are
ready and available for everyone throughout the process. Kinda to
"bundle" them all the next iteration.

Would you suggest otherwise?

--nX
