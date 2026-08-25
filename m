Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC0471433
	for <fstests@vger.kernel.org>; Tue, 25 Aug 2026 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665715; cv=pass; b=TEJdSWcwSWEZ4bViL7Hgpcq16LE9FbVDAhW5nbpmVsogWuhJf6Lbf2Qiq+6TMeMQyEPj0hRMOGk2yCJjmuPnWxXWWxEoqgcTbsHEHObjXY8Z78gaOBsH7fLUJMcJVZSkU4xI2DFYWMCAOjn5YjwrIaRxrJtv0vGDmrD4Oapl1ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665715; c=relaxed/simple;
	bh=Qn8hGdKefsfS8R5f6jIx2uhrqXnuDR8BiIvYQJAq+Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=evq0X3gANVWoG92wJXeToMrv+vzE2N8v3XxOjlB8F3WDm2tUXt6zFy5JRh9tMVzrmxyN600z3KlGcqAN2R/hOadR4/BwyBtF8UqEEK5MnZ61+EN69L9aWsApXdP8fbzEwNTnoOw589rnYmLE9/soMC4Gx6jNolrR9EzS256Jyuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io; spf=pass smtp.mailfrom=brauner.io; dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b=NLBFW2UO; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brauner.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="NLBFW2UO"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso8130063a12.0
        for <fstests@vger.kernel.org>; Tue, 25 Aug 2026 06:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787665711; cv=none;
        d=google.com; s=arc-20260327;
        b=tAJ83rCn5lhG4NvKGU89l4qbjIEUBic3XoA0+Q7fEA5WSkvs/lSCiq1MBuoYsj5xp3
         2wc5evPLnESFftRimBDmqFGjm1Qsg7OKQMDq72WF4zj4dWwBuAB/I3WssRRcKR6DyiY9
         vkkww0yKQlUrRvBOI4GwW62tNtvCmoh/sOaxpRkqRDdThVBHCNTr1kof8X73eWowJF6E
         vKjVAWjAJI/zFkRG7oT7VMO3nQtMuvodRBuuCUMBjEfxIbVsc7jIHllOMRQIiH/3hNh1
         NAKzlNsDN3ZE7rbPXiZy1/pF094uNMoBBghOIXujMbzzHcK/nF288G12nimBexjXWw+Q
         eU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qcMWS8qQDHuNPyZjJ5lPBghxTb9PMbQNjniSXXwPu+c=;
        fh=apYGCnO+Tzhwc2gWU2N/+12UbQb8ynxNBb+TBaONnKc=;
        b=ndXObEUI6E1nt4TB/BnIhiDpb310UTy3zChgEdp3C2ha1zC/G3me6y7as1nPPoXUW7
         Vl58mYDMvsMzZb3aB3GsO9AeDe59Hn0mZKZomzN6Tjr1bUqtKKldMoF7J+CFmsazY5sD
         ds8zh/5vRoKUqXRTyy+/SrqxjmwqhXP86y3y57yvAby2MqvntncYZcuaLl2Rdlv/tD+h
         m+j9tde6ZZD/UZd9BbMmJRuzzqlvyfQOY61jCvEl7LSQfD/6xiEPQ3jUWOSOg5GdfYko
         yhCGR+usbzjOSq7igpCjeOLzLjojgRiMRdsCocRpUWFUvrFBQTTSHnoZl4KbQ8oXt4WW
         HdLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google; t=1787665711; x=1788270511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qcMWS8qQDHuNPyZjJ5lPBghxTb9PMbQNjniSXXwPu+c=;
        b=NLBFW2UO/WpHWOB5TTNA0/lZI8xm9zw49ZZevSSa+zZke9PhTrcwVCxNvS1hBAyKh1
         ac+T3cxkVmnU50g/8Gy0tktiylnvwS4Y9dCozeJUvjEUeqxVtCvbRMMekXQNudpyS0kB
         6xB5YuLHNqRQlDxw3oNnDIbVdgFdEw5vAGnkUxaHMg/18APIcWcZmG1mFhxPDsBsbq1u
         Vgr6o612HiSljwERpkiFZBqYAwRQhE2+QJWOfTsvhbb5iI31++GZPaaRS1GCVjuNsP0k
         5qvyWrSjObDgl3dRqSVQqjg5nLZaqAoF11wvUlnIP9jdzGco3tht1NN7xRttGj1iVGXs
         S5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787665711; x=1788270511;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qcMWS8qQDHuNPyZjJ5lPBghxTb9PMbQNjniSXXwPu+c=;
        b=j/XfystwEYgMDfwJUPD78ZdjFnCMjqecprlOqW3dzrG51NVN+tmYIbYG6+DsdhVAMb
         CyAgAoXXfyRNqzOOUbSVTfNqLQvIUTscRS9hl0QP1JzUPn0+X2Gbx4aFcFXkKCv47ihz
         2wNaLKKNJc6GoB9vWECFKMvZet2wQvNEV+dUo9PjGujFgWaT35jLNsvYPAKK47WFsOrv
         d5+aklA+QlL74xBJqf+NCK8U1DHosJOZXTxbu8usWQSF0WCmIdKpxO+IXtsSRvx48odS
         VmaH7FN8RH0nGnJv48a2eha2WUUpBF+1IKVZ7mhjDz6FcJi6Q7ALYnkQ5HEbc1qacDo8
         r5Jg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2acpz5JUd/zr4LfbxPYbKKuyrfLB4lTrIBRhdrYzcJFshuuJKwh61mjUyH2f48u9jzyAco2eV@vger.kernel.org
X-Gm-Message-State: AFuF++laqbtrCY59pLo8ItWjkya7IuxAucZtJ+LLdUeyy2iopLvwHuTs
	B9Y3lA/RMFtRdhoujQ8i533cEG+dfdljh2PbdD7ZwmYEQ+8SizJjph7SupWTXjQoTcwfbbhyV/3
	+wl2/18hRJ3zT6k+KQdqrCCJvBMfU607Q7yK9BPAP8w==
X-Gm-Gg: AR+sD10euM6Ywy/9KHQTSpbeD+woM0bOQopEx7DBN++65mYa9Kkofdw+x77iQS5TPRD
	ujcnSq1oH6tpTeF8bHHyZa7eTGk58HfnDPICuEsziaiMX64RqJU7xsyBZ8UsDbvrmIWcv0+RJIe
	lcNhbruOZ19cg0ixXEIpY6jjnIvRKu7WxbVfJIosDPdqIrvcZnL+hHmh5R7td8rsUp0CgS5/SO7
	r8CAukQcQROuY9uqlbWDi/cpzCgURblR0HCd7KxYVcKFu89osO+HvgmVm2uU+uD4Cu6Ww+sZgNN
	9lpaLQV2vaSKVKo98IMu6uTYGWm9DoQS++DmRa9Dd/BtHffnRw==
X-Received: by 2002:a05:6402:a51c:20b0:6a5:c4ae:43d4 with SMTP id
 4fb4d7f45d1cf-6a5c4ae4c2amr5434197a12.3.1787665710776; Tue, 25 Aug 2026
 06:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731090253.1665192-1-wozizhi@huaweicloud.com>
 <f705ea52-36da-4fdb-a41e-a67a10830919@huaweicloud.com> <anoyQqDV_ga7ttCg@zlang-mailbox>
 <20260812-kurzarbeit-unabdingbar-mutter-e31cef822206@brauner> <anyG3P9CnAt0ZXUV@zlang-mailbox>
In-Reply-To: <anyG3P9CnAt0ZXUV@zlang-mailbox>
From: Christian Brauner <christian@brauner.io>
Date: Tue, 25 Aug 2026 15:48:18 +0200
X-Gm-Features: AcwNN1WMYWftHUWK62a9CW4gLyU5AbQIpdBWRkzGXg6u8YsRj0mwEUepcA2BDpE
Message-ID: <CAHrFyr6Ub=nVr8hctzdqTd01mApKriw9_1MUBvtUWb+WX15HUw@mail.gmail.com>
Subject: Re: [PATCH] idmapped-mounts: probe O_TMPFILE support with the
 caller's mapped id
To: Christian Brauner <brauner@kernel.org>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 6:43=E2=80=AFPM Zorro Lang <zlang@kernel.org> wrote=
:
>
> On Wed, Aug 12, 2026 at 11:58:15AM +0200, Christian Brauner wrote:
> > On Tue, Aug 11, 2026 at 04:40:18AM +0800, Zorro Lang wrote:
> > > On Thu, Aug 06, 2026 at 02:11:55PM +0800, Zizhi Wo wrote:
> > > > friendly ping...
> > >
> > > Hi Zizhi, actually I'm waiting for the fix from vfs list.
> > >
> > > Hi Christian,
> > >
> > > Could you please take a look at this issue? Quite a few people have s=
ubmitted
> > > patches trying to fix this test issue. Given that you are the authori=
ty on
> > > this topic and previously sent a patchset [1] to fix this kind of iss=
ue, I think
> > > accepting your patch would be the best approach to stay aligned with =
upstream
> > > VFS. Christoph also metioned that [2] last time. I don't want to make=
 this issue
> > > fixing any more complicated. Could you please provide your review poi=
nt or
> > > rebase your fix on the latest fstests for-next branch, we'll review i=
t ASAP.
> >
> > Just seeing this now.
> > Please accept my patch which is a lot simpler imho. Thanks!
>
> Hi Christian,
>
> Before merging your patch, fstests has merged below commit:
>
>   [1cca2bc0d7a9] fstests: vfstest: skip rejected tmpfile creation
>
> I think we can revert this commit, then merge yours currently.
>
>
> Your patchset below contains 2 patches:
>   https://lore.kernel.org/fstests/20260615-overlay-idmapped-vfstest-v1-0-=
c6b3b2228092@kernel.org/
>
> Patch 1/2 has been acked and contains fix we want I think, so I'll
> merge it first. The patch 2/2 remains under review, so I'll leave
> that one for you update later. Does this make sense to you?

Yes, thanks!
