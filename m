Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792478024;
	b=PY0IbTIY85wbZAIGgMEp8JNqBZ72KKsh1MmtL3w/hiFyLr+13dR4ZySGzmfKQ3EfVnM3
	 zj27shUZUDEruQNfQlAYDlBGeXr3UZ02KK6xjbuE/o6q8vIljp4dJ5WXLm40JSQ4QJq5W
	 muIsz1Y0QzpTy57Y3KbQtxaqIx4h1J9UAq0RW0jziL4AwnCltoCqHpr3qxpOgzFCOOZXt
	 Jc+7arjUnxg+3oBrzIBZ/Wl2W5dFxIKQjkmBAPNyyJqUl3eos7saQheiur10aNKsOYIhX
	 3+o4xQW/7oBe/6tQcHAFKGNKeNrsz/FDdfGtN+k+hnLVtGuLUCaXLecmZ4b+LrqxbdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=exeTp1cAoNgGNBzHpnK0Fe4gV+c26CWlkIC+95vHT8w=;
	b=CEf8omFa/iArdBY2UYOZa/r5kMBOlYkjYCJHdbmqw8wB0EyogAvkBOqgE6Oai+d3Q3Qd
	 b0z8iWlz78/r5ehinga3Rzu086hsSvfefGL428XfDtmtqxpibco8oWI6xmIPxUTRBj7L1
	 bIIjA0rtO0iW+WLYWzLD+P+T6hNUoa3VzQjBomt1LgLvvJ1X2MhO9lVDrsc1MtcwLf4Dx
	 7xdMb0dMnIBob13bfc+xAvxWbB37T0C04FQIwSQWUMhgpT3kZnq6mg4WMZ6kJvgocjqiU
	 yMdug7pMsb+wtpEJaiAXUWAlHjikyENc4NlvRfRolHl5tZbSdi7Tl5Kz3gnO/aiNceQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=owltronix.com;
	spf=none smtp.mailfrom=owltronix.com;
	dkim=pass header.d=owltronix-com.20251104.gappssmtp.com header.i=@owltronix-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=aXnphUCd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56680606A31D
	for <fstests@vger.kernel.org>; Tue, 20 Oct 2026 06:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56680606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=owltronix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=owltronix-com.20251104.gappssmtp.com header.i=@owltronix-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=aXnphUCd
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a01933b584so20082585e9.0
        for <fstests@vger.kernel.org>; Mon, 19 Oct 2026 23:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792478023; cv=none;
        d=google.com; s=arc-20260327;
        b=qSxvOZeRq6ysMCOUgfGhkkJHTFkb/M4Ln0nZDC7iQ6XiSH0eE8h2HWBcMU2yNr/AaJ
         tqjn3LuEvBN/lpOoUeI0KtZO/K+r3lwJi2Rr4u3h3hvOvRz9u1v0/o534eV7FWZBdMb6
         RJDGuSvigEDfWoUhm8yUUVLz672JNn4kRasAjg2BOFUtD7P+6069xiQOc2MZx6OTVd65
         rjSPT2jfkgVnIOCaXbrVviiY4fiHKqVYcB32aRPbPTie+USOhKSVgsyNEJyYCgVTiJKg
         UjN3qBnPJh6PxwWeBI87nh1cESsTEkRSMG1K2Ni0JMUFaCrn73Q6WJucyM1SZ29ExIKe
         tk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=exeTp1cAoNgGNBzHpnK0Fe4gV+c26CWlkIC+95vHT8w=;
        fh=iRL6wzmh7sy4IXGA7ZsVWob0vAQ48/AYXzynqX2mBao=;
        b=sLfWXShkPyjw07/EFKNljyCp9RbHR2+GzPS86E8cXZ+kJfwrxIS0Zb8MA/TckM2FUO
         xNCpnmMwgJ5lR4sz+JeDtQzk2lR/QbV3k/1X+XvUTXQ9mEDGLu5IViKA0tSILo0MgFqP
         pLBguTs4uM2UdzUtwlWMDCh08ELwVKf7SF9+Z9/6mHdeTnWSN8GSVHbZ+d6RrBJZCQ6N
         ZFLFkIGG1e1q6HU/dZNF2Cg01c30VHtLkpGc69thtA5/djm3C0HtME4sADG+EiBtaQFv
         njieAFDIHFkdKLSs/pSq4xE6HUz9vUMrJzinotnTneuzaGtrYSLRYHEF7n3bv3/5/Hpn
         QNdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20251104.gappssmtp.com; s=20251104; t=1792478023; x=1793082823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=exeTp1cAoNgGNBzHpnK0Fe4gV+c26CWlkIC+95vHT8w=;
        b=aXnphUCd1OxmReadwWegZwBmMEXcQoL5UXzvHpS6C5j3EWlIRvjPWPNunlqO+IWQel
         TLjejB3aKqyeGJcs2XDFWRVHO0NShXeY4QCocXkRzsjqySq9g68Hcn5EFspP6iqw2DxJ
         pun+vmmO6V3eUuwc18zX56uanSkO/w++vt6zjQJScnjIj1LPa6sYimGT5H0t5kOz3str
         ByLPtoXIji412AHh53PuTjgh6Lf+BweNFvTBBdK/wZgci189jV6FJigATHzDga3AJlxM
         hW8D7sRhOEhR7g+d2s+j7Xh7APye/CBgRphiwifOaZypID1F/l077nZMfaosuEAy4f1u
         m+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478023; x=1793082823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=exeTp1cAoNgGNBzHpnK0Fe4gV+c26CWlkIC+95vHT8w=;
        b=NnvhCQFe4FL/W6cOzs/Rc+II5Tm5+ipIEnbWCbkeN4v15RK1JgKIXqiJyTHAjHYEuA
         byL38dZ4sToyeG5dwJpV72mKwn+0wJzbXFoAN7Owpvn6u45eYSfZ9pXNCa5epWBfeVbi
         0LfDeV9ZESDAZ4UOdhwCMyw/rcgLalNZ9fOPl/rXg8c2xEuSioG8+lPQFbal7XlJALGc
         M2pnn6iQeFdvrEESTh8cNO7VIHMKRHXSEbyw30om1AMyG6dmNNllFro6v022lv2mQH5R
         HPnwyD6+xTTH+vWqrKlmZi8PQeR4FvralHnZA8D4/DbacDJUna66wPXVMmOu6zx800Xn
         rHQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxK0ZHankoCXuJ08vqqUk02Z+Ui0hZqUdWq8JoigccT1/Ntc/JCXiO7xpXI8JUEcFuk6oa33gzo@vger.kernel.org
X-Gm-Message-State: AFq9FYJf5vl5a3JcrZnY4PLGSu4FBgFYb1R6aAYXknp2zeROLWlMqMKr
	lhOJMn8kNSR024r2AWtVMDajc9f2X5jnngcs714VMuLnNfNYfhla9QHUmnZH0VmTrLJKtidb6cr
	yPfUWkEkIs7nViVw5TIjMQI2b0ZCXiKIw/w1Pc6RP2g==
X-Gm-Gg: AYBFou2NkNoRsMdCspsaeYYWPEy4fY0n96Ak59KMd9QUutOcLzrudrVvE46NtrbUuur
	+w0kJ2RSLbI1eARkXrkQYKVjQ6uFOiOAWTQCWjjzYMN3POtXvyIzZ2RkP6VO7v6Rx97EfpgiwHP
	CTvgJHP4GKoHcXa1d2dR0sbigMJZ7MCcvrFUH1WSFzSZgQ9xyCsAQkyVqM8r5suA5VMjnEdACx3
	6cTbYNVm5MsJ1JW9h4V0D78RSegO9BnAnlSZhcQ2SaYY0m1lc7j+Y0UOeWX70x1XmHokry+mF4l
	fMYNz9631Tpkc0a9+3ZAlBxWgI4SvrogIuRdUE2eGlGE5huzeBZRbEVX
X-Received: by 2002:a05:600c:b99:b0:4a1:d36f:1ba0 with SMTP id
 5b1f17b1804b1-4a1d76227b4mr199950255e9.35.1792478022502; Mon, 19 Oct 2026
 23:33:42 -0700 (PDT)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016160037.GA107919@frogsfrogsfrogs>
In-Reply-To: <20261016160037.GA107919@frogsfrogsfrogs>
From: Hans Holmberg <hans@owltronix.com>
Date: Tue, 20 Oct 2026 08:33:30 +0200
X-Gm-Features: AclHuK_ADi3z0cS39x96qE3d4XzZpXIuupVRKpApcCWwiB08hyMIjCfxAVkNnMI
Message-ID: <CANr-nt1btFt4FqSgrsjMW5tRihyKcUKG-irW9su5AM943+1vzA@mail.gmail.com>
Subject: Re: Farewell!
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: xfs <linux-xfs@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, fuse-devel <fuse-devel@lists.linux.dev>, 
	fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for everything, Darrick!

It's been a pleasure. Hope to have you back one day!

Cheers,
Hans

On Fri, Oct 16, 2026 at 6:07=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> Hi everyone,
>
> After 14 years at Oracle and 23 years working on Linux, I've decided to
> take an extended break.  Today, October 16th, 2026, is my last day.
>
> I don't have any immediate plans to drop the djwong@kernel.org
> forwarding, though ultimately that's up to the sysadmins to decide.
>
> I have very much enjoyed working with you all, and I'm proud of what
> we've accomplished together.  Good luck!
>
> --Darrick
>
