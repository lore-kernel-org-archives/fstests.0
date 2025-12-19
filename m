Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA22E7F3E
	for <fstests@vger.kernel.org>; Fri, 19 Dec 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134405; cv=pass; b=pzbTVIMpE7lUIMXjiDsEI2oFVBoRipP0KRRIwQTVwZsjVYtf47pYmCcqkWiWRgaPUL/I28+87md8hk44Wn7Q8/1pcbPf4in7Hvpi8xhS/73TOJLFGeDlfIqspx6XpawE1Ryjq8mnEvIFtNxhbo6Nlt1SAAYmSlnOwGt8Nih4Mnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134405; c=relaxed/simple;
	bh=hDsnAgQTN88zaXjzezRZfy0sE1W++L3Yumln8u0o1AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLsxm6OcNg6im3GURg6XXRqGBUHV7DQFee0+eObOogRSBTRpKtEUZYbZr9WMRw2KywvdUZkyJHO+sVBQRX6BVtIIqiI8h4+1kgnCgIs48VAiX+yTVeqCRtCBZDb6FqTwTnAOIVlKph+kFYEmxkxdlECiNIJpKnTjNjhyX/xvqGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qF3lpoNU; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qF3lpoNU"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b66d427e9so5250a12.1
        for <fstests@vger.kernel.org>; Fri, 19 Dec 2025 00:53:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766134402; cv=none;
        d=google.com; s=arc-20240605;
        b=NbdUzTttjJmQ1V+0sPib+r3/FhHtouG7NGcdmZc8jDU73hkxX3qprngOxzSCt/V/PV
         Fpqg4IBT249ZqeCLcpHtuqsdBO+QuMRzs0NZTI1Oq6PKKIjOGxIUNBfBZogv83zwERrY
         0seXDvTCdjpAD+ed+oIJH2mkYL/swCTmAxEh3AfJmFbcftZC5NmOZWBooHvKGZb7RT3X
         EsovyVINPigjBbv54tFsRc5jrj+8HXlKkyc2wknezVFx0RPjN+3CK0e8YCb1YksQCls0
         wtiWEPdrxxxcen97+4WTbCsZHflQM6qVXZeInY/FqsyIJx+j37G/V/9+cHN4RkV11+lF
         fAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fs8T/bx/dvPsalE6IyzXiaKyBFs/NfE6tP6xBoAggoI=;
        fh=6FsLesO2U54KrQbRy3N81wKq9w8IqsXhGTEnfLvwMnw=;
        b=KpdTmU84GEzuX82fT177/JMJk+/G2IRruNl1HZ2b1YehCOyBB/RrEe1e+67XBK5iko
         HN3V/uAQJlsCngpH5rjzfsEhXfQ+GwP+BwwCO6v8B3N0Sxl+hrvCggGmwqNNN0qs1Qot
         6pNkHjWM+Z/zk8BasMGw069JZLFchyWBnuQV8eltl0gtHI6xETMhlRk9HatUAHCoYCMe
         3G6YqQE2ZOwJgfKXvWAvuc9I6r4aNLmbo5zxEFPpvzIqVS7KEJdNEUs/y4cwMmS0wfzl
         STY79iGFY72owndPXr3TBSR4cFm7iUU082wS1UwYxE2i7MnvjhR/a7hyeAvDMmDWMXyR
         YKHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766134402; x=1766739202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs8T/bx/dvPsalE6IyzXiaKyBFs/NfE6tP6xBoAggoI=;
        b=qF3lpoNUuSxLEcE4qrUGxU7/4rVzyW/VjdzmPjYtXds5P50OM41in+JzIth4h44mNI
         khtJ5i+ZqjvjOSyKKWSlxDOQ/Trp8SvBAz3EWUzakl3ckkHMx7sCn0Q7BopsiqyDd9pM
         cw0q0bnBU89xcfsDmMt7K1g9sgUUHWqB7yY1G+okIrqR6MfgEduRny6+kIs0tBlbww15
         r5mFzRj4LEfMkDXVgRwH8KdGSKp3LQrNuJcvPFpBStyTp9ps1RKRQR2pEu1AxZGqO2g0
         5SS0aoFpaR0NuuCwkC43XngcjIKqhkwvQ3nSejmNO9EERBhbypLGVVFz3HBgu1SxUbAN
         0k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766134402; x=1766739202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fs8T/bx/dvPsalE6IyzXiaKyBFs/NfE6tP6xBoAggoI=;
        b=dp0RTnxb+OF4ZRSI58tAZlnEsed0zMBYtjxOJLdVDrv8WMGiAWSdwzf73Ulf9mwYGY
         TVeSV04YabYWkIjdBUjvHBd3pVJzbKYN8sUxk7nIaJco6fouEIR7hvMHKH58cbsMe2gd
         U1JGZ/Pcim+fJ0O6mYFW6YHLlw0eJz8+cxowA5A3XkURaqGPJGXSQGnpDL24GgvQVIzt
         tkIHghZ8LDQhny3n8/J7tzFJKxtyC6tlkHJ3JswZ1lKHSmdcoUlP8WHoTbLTdTotuwUD
         R03EwrIoXJ4XSbqRTpUa/iozhVZ4alYVLNGssWrvful1nvVMRLp+n63u34RhcVq2DP68
         UWlw==
X-Forwarded-Encrypted: i=1; AJvYcCUUStu4YqRfwi/M5PLunf0VZXOf22f/bR1Z96GpHixMro8uD+JqLC847pmtzxywgFjCbQ7VC6JT@vger.kernel.org
X-Gm-Message-State: AOJu0YzgLxDnCM9++TM0dz5xLI6UaZD/dRA+e98ASlLrIrAfj5lM3b3p
	T6qDufQWnziEzvqqh0SHb1INmF+/4RGcbTxuAgl9M29cobSKAwqBrltuFfMTOnQe+bnT9aQ+ZK/
	lhu8VT6K1JUN/UvBxJRvSdYTFf+5M0kNFfD3vCSl1U5VYhpPutH/Oj/awNdc=
X-Gm-Gg: AY/fxX6/Vi0/7mScthG+hQp4eqSDrjRadGclfQL3rHrShnlYHJZRP5Eeu8ORWbD2GLh
	4ryX9sXDYLa3W1skzm4+MCseaQqfk/ha+bmY2oj4zHR7SrwsAq2tLRu0c1gT6St2QyOUWx7gqnl
	8Q0TpopE6kDerG+mN6xycu0GVnj4NKziiK87Vq6qfxuL1hu0vXesk6ViDPrFkqxK7UcVHr9hUhe
	yBRPjJjAdzeNgeOmeEafjFRAnxFUCkoJSUGCo0AK3VGIj3+yGc7mUzz8bgEr2JOoptsTIGmCZou
	O4WJLLXfW0eS6yZJKkhCKT0=
X-Google-Smtp-Source: AGHT+IHuq3d4KNN0YyYAniV+RPAme4gkyFjgPMmpMJeYKEriKWzrRS16Ut3ZIhRlPYydbLU+pSeNuVjrsmXnVjuRd+I=
X-Received: by 2002:a05:6402:289c:b0:64b:4a02:f726 with SMTP id
 4fb4d7f45d1cf-64ba219eacfmr11471a12.10.1766134401509; Fri, 19 Dec 2025
 00:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218071717.2573035-1-joannechien@google.com>
 <aUOuMmZnw3tij2nj@infradead.org> <CACQK4XDtWzoco7WgmF81dEYpF1rP3s+3AjemPL40ysojMztOtQ@mail.gmail.com>
 <aUTi5KPgn1fqezel@infradead.org>
In-Reply-To: <aUTi5KPgn1fqezel@infradead.org>
From: Joanne Chang <joannechien@google.com>
Date: Fri, 19 Dec 2025 16:53:04 +0800
X-Gm-Features: AQt7F2oJIHIkcmTVNq-CM0D_Pggo29w0ne08iqhRm5s3GY2QUVqSO82KqAeqqQg
Message-ID: <CACQK4XCmq2_nSJA7jLz+TWiTgyZpVwnZZmG-NbNOkB2JjrCSeA@mail.gmail.com>
Subject: Re: [PATCH v1] generic/735: disable for f2fs
To: Christoph Hellwig <hch@infradead.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 1:30=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
> On Thu, Dec 18, 2025 at 08:02:48PM +0800, Joanne Chang wrote:
> > Thank you for the feedback. I will implement a
> > _require_blocks_in_file helper in the next version. As far as I
> > know, there isn't a generic way to query the block number limit
> > across filesystems, so I plan to hardcode the known limit for
> > F2FS within the helper for now.
>
> Oh, the limits is not the file size per se, so the number of blocks?
> I.e. you can have a 64-bit i_size, but if the file isn't spare it
> eventually can't fill holes?  That really does seem like behavior
> applications would not not expect, aka a bug.

Thanks for the reply. To clarify, I meant testing the architectural
limit of blocks per file, not the current free blocks. Sorry for any
confusion in my previous reply.

The limit is indeed the maximum file size. However, since both the F2FS
file size limit and the test's requirements are calculated as
(block_number * block_size), I believe it is simpler to just test the
block number.

Best regards,
Joanne
