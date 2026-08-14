Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF334E74B
	for <fstests@vger.kernel.org>; Fri, 14 Aug 2026 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699987; cv=pass; b=ArouXno23IPoAuaNva1oOstzLvWUdxoVfV0SqnVzbRkAeKZsTMV065XSxPdFuTS6N3V304E+QmtfnQuIydp6nq2TVgOOn1bfyehQ1GbgRU13WAX9NDGgoYhJZtJxb4oTlYJa0Wu+9PZfimlOQm4zGXvAj1CK/QOr9pIqnaJl/L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699987; c=relaxed/simple;
	bh=2tg4fEJnL1lMEjpZekXh+OyyfO1EP8Q55z7YDxLJTW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfSFaiilkTuvcj7SLwa2RJdrMR8CJsVn93Bmb7IIZ3/Vf2RUrGHL/SfwUtxXh5qvzOL++EY7v9QQOf8EkhBkeNMfdirrxG8GMyfAqYRNt/qN5djSXSbcNGfp0zI261/eON4dqepouzQkB3QsRohaNzmrZ+TPEfUqOuRsYsIulUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DQ3EnFhf; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DQ3EnFhf"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso1285230a12.3
        for <fstests@vger.kernel.org>; Fri, 14 Aug 2026 02:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786699984; cv=none;
        d=google.com; s=arc-20260327;
        b=IoHkydFdfSQAsm3fPJjSRaTwqu5kjIPOP3oP8L/2N11OHJUlAmBnHAvNTFQYP5nGB/
         XfGgcYdG7J+RSYEzCgISFSYZX5f6yljGI6Dr0YYdDy6S5uonoB9p8FFa+7p1GYiTBgBi
         YojDmKTG5ilIbsAt41v7AOtmOU3zPvYzQ2BzIvWcppZkUPuMYuRXW36vbS7YXkndGBv5
         vxr2CNgSvC/QJYuiyqZBEiHIEN1GUjI3cEnVUru25EugzhAvi274ovvFaGqqOgWfM85N
         pTRM8H3Dddw9Eeyxly1DzHV5TvS/LxhreDPAgZDj1vHSmmIRoOyahCTPGTZnD+7ht7CM
         ALxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8R22VAhkAPCzx4cclodRomwDLhoDCIW2GEyGjRDii1w=;
        fh=Vqdm9AgTMDLlTCVDsH9Q0C3l2qd2MTEsNn+QHGU3eb4=;
        b=nOTotl6uC+osUe02ThZc/LDDa3TTr8wRj7M5C4ppxDZrcRJPda8qVzSaelQbVbg1aR
         3uP2GI+KDvQhkZkqwjGxFpyGKImSWDTRKrbaEActV5d7zYOkhA1aqL+5lout8gdYYnZ+
         M2d+oejn9R0Un73qsSNHCtPAWqlijTBiiIbFh61sd8J09G+iNdCadAdepZC9WafzSESE
         hp2PgIM4bfU8gkyrxbJKwjD0vkg9D4GP7yzDZqV8sk9tqm/HZrIZtFStRFyd6Rp1yttV
         9lcZT7l2LUHqVsgJGhUAkcYzjfr2VDPkV2fXNbR/Bt1PYOPlqBdUMtS2Rl/ZR3YwHyW4
         ElOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786699984; x=1787304784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8R22VAhkAPCzx4cclodRomwDLhoDCIW2GEyGjRDii1w=;
        b=DQ3EnFhfZ5ZB1FGwqPcvB6z9NhnoDpifg5XDnnv5KJbk2NKdj6LyZ3URVT6dGiQ4im
         CxORIatsopUQdG+0+MTADv3Km6pPbLlIgI0ZE41rwyg2l9nYoDlPLKRo8PegUHDRK6ln
         xrPTBm14Ebt5iQFgeqN9pkCA3mmBcBKhhsi433VjDBPUFv/Wh9pTmzkoSdRNn8tR/+/V
         EuFCtQiYN/Sl3kzhZqsifSHUONXk7yC4FRSKci5okZnLPTqs10hGwxBDMWhuOsmOlZa+
         6H9U+FBkjO3DzqXjGB1uJYmH92fYFHgrQQeb7M+JGjZh6LxTFrZE+Uykx5Zc0IGYWhYq
         /+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786699984; x=1787304784;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8R22VAhkAPCzx4cclodRomwDLhoDCIW2GEyGjRDii1w=;
        b=UD27kNgJtLXizopLvHMg/bMJZe20Tybclu0N0n6Yni/UkptjV4vK7Y9VnXOToLxd8Z
         FBmneKSnmkVXQZrLE/6OgCJ+DLjNzFttbIc9h6jyyIwS2qc3bvfDRXNT+0CWjI8orpLj
         3wwBodzmhWqrv9L42uJgGVZrbKj2z/kGGtvxwg1QIcEFmcxmAZXgG1dOqjKejouZhe4A
         C/hoCTaY6Ie7OIN7yB9gGA1OzbEQy0GW0jcAH+jdRUwR/LXIb+PRgdUDkfgTGvfJZafa
         nQORY8q8WGuKCpLf8LEkJTVWjDRisMGw9ZLXssFx10JmkTxhNeC1a44tntMGhdHoLrWY
         t9vA==
X-Gm-Message-State: AOJu0YzSGaD15qN/Lq3FB8WYcXXQtdNKPrYHqydukO+UaPAGa5gM/3Uk
	GGMpG5jkaIPE/VHGufUkanpgYfYb2thl9WoosHxfBbkFgUZRgR+xh9AMfala5l2lx1Cf42BHCii
	iJiTUhzdBgkn4i5iS8PjZjaux5LA7qWGR2e/Vr6eS7Q==
X-Gm-Gg: AR+sD12TD6s9QTkC4Yd4X+w9WlMmKKVHU0Jdrxl1c5C8ac07HMI5dFFmMVnm+gGpgyG
	8MzF6lwCLRVus8B/7zfcymsqXc5oNQM7F2z/j7MnB/SYne8mayOWILmmQ/82TaeCN4Y9+RfvAI7
	8mZjvOV+YLJvJwEnCazvdB3Pm23DjPeELMbd3ntL9QfZpVT91AUEDxEzUrZQo+BcvTsiw7YMoH1
	7OHcLXGwp3lzAaQh1yGht1IDld51+bGxkzLSxNBVfOXUAcPiZr2bgfNYET01CFlrgHPMZpNJZhc
	GEjsgnKKohJiKZdsmQCeP9aVhpGylVmXxOawn0N69OMQkQ==
X-Received: by 2002:a05:6402:434c:b0:69e:8ad:5162 with SMTP id
 4fb4d7f45d1cf-6a38a8d7965mr2061107a12.1.1786699983634; Fri, 14 Aug 2026
 02:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629155812.GW6070@frogsfrogsfrogs> <20260701061413.10531-1-lan@suse.com>
 <20260701163446.GC6517@frogsfrogsfrogs> <CAHLNDm3bTGowGmp46GMbpJz8_Eew+sGsH173D0PnnFKt=fWB_A@mail.gmail.com>
 <20260813192746.GZ7398@frogsfrogsfrogs>
In-Reply-To: <20260813192746.GZ7398@frogsfrogsfrogs>
From: Long An <lan@suse.com>
Date: Fri, 14 Aug 2026 17:32:52 +0800
X-Gm-Features: AUfX_myTYH_uGx2gE-_hbPboZJpZ7dKPUY7tZKMRsVnPBg92yuktYLQ1jUdB54I
Message-ID: <CAHLNDm1ch4X4V6krcJiU8ciiXhd-6inX8zecAuVV+8CVtLwK=A@mail.gmail.com>
Subject: Re: [PATCH v2] common/rc: fix mount options quoting in _mount
To: zlang@kernel.org
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Zorro,

Friendly ping on this patch.
Any feedback would be appreciated.

Thanks,
An


On Fri, Aug 14, 2026 at 3:27=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Aug 14, 2026 at 12:32:43AM +0800, Long An wrote:
> > Hi Darrick,
> >
> > Thank you for your comments last month. Just following up on this patch=
. Is
> > there anything else needed from my side?
>
> Please talk to Zorro about that, he's the fstests maintainer.
>
> --D
>
> > Thanks,
> > An
> >
> > On Thu, Jul 2, 2026 at 12:34=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> >
> > > On Wed, Jul 01, 2026 at 02:14:07PM +0800, lan@suse.com wrote:
> > > > From: An Long <lan@suse.com>
> > > >
> > > > In commit 078f320 ("treewide: convert all $MOUNT_PROG to _mount"),
> > > > direct calls to $MOUNT_PROG were converted to call the helper funct=
ion
> > > > _mount.
> > > > However, the _mount helper was implemented using `$*` instead of `"=
$@"`.
> > > > This unquoted argument expansion triggers word splitting on any arg=
uments
> > > > containing spaces (such as the overlay mount options containing spa=
ces in
> > > > tests `overlay/083` and `overlay/086`), causing the mount to fail w=
ith
> > > > "mount: bad usage".
> > > > Fix this regression by using `"$@"` in the _mount helper, which cor=
rectly
> > > > preserves argument boundaries exactly as they were provided by the
> > > caller.
> > > >
> > > > Signed-off-by: An Long <lan@suse.com>
> > > > ---
> > > > v2: Revert the error log to "$*"
> > >
> > > Very good!
> > > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > >
> > > --D
> > >
> > > >  common/rc | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/common/rc b/common/rc
> > > > index 79189e7e..b9a07324 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -296,7 +296,7 @@ _has_dmesg_since_option()
> > > >
> > > >  _mount()
> > > >  {
> > > > -     $MOUNT_PROG $*
> > > > +     $MOUNT_PROG "$@"
> > > >       ret=3D$?
> > > >       if [ "$ret" -ne 0 ]; then
> > > >               echo "\"$MOUNT_PROG $*\" failed at $(date)" >>
> > > "$seqres.mountfail?"
> > > > --
> > > > 2.51.0
> > > >
> > > >
> > >
