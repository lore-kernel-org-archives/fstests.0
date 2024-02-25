Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F317551
	for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708884126; cv=none; b=OnAFkPCZbGzbGGHOdNf7aA87bOo+kbDe9skscEkTs/n3U12RFp/bhc0s/n8I035iG73fDHM4DeE5bo8ujnHI3BG5b+hEFlZ5ZuBhMpmhfTK4jQhRFS++vkTJ5s/RgfWG0PrAN0/GmPB9gAXEqS4Mm8eWPNc5IOt8VGZUUZkwUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708884126; c=relaxed/simple;
	bh=Z3Vg0Ox8NEcmYXfOGM5YS6LP243YNSNH31/BN56EVl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9WCp8oqE3d+zMZ4D1xFPwS2tzeW6GrWKNITJ/N8+WI/8gUmdKvUey1g8HsCOyboLONjzj71Wxhd5P9m7n6hf/wh/vnIWUjnuVimBuMUIMdLe+T/A6ZdmWGIb/N8yd6plawDX05fHt0NVbKuiI30bHhZdccmw9Uuxf9qqmgOYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhGPKLQB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhGPKLQB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a51754c9so647685e9.3
        for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 10:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708884123; x=1709488923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K25xY4evHGr2vemHU7LteAuwba5OQfrDW2F0+zcbI+g=;
        b=hhGPKLQBVnDhI1DeXReCzHTokGbTTVOCFcywHcHHQ9MIPH3QchpvWt+ZOnsIpicppj
         C9J9l1tE5qs0Hr9q6wCXQR8N6O6JkCS2XUtrGNZPEvY9s3aJA1Jgs9YMgyrwu+VJ1WIt
         E6jSuo7+jbywa1lPJNtAmlmUL78txfY4YShMz/DrD+yt56dTIRyAQFxygbj5jVtqpNOW
         GvJIgDYsfBH2qtKCGb51ouwGjSYbDIcXTyg7aN3ttIsujyQYezBHigM44B/bnOsQbQ9b
         11o+rjRzZJHZMNpuOSUWIlrdgIxPWK2WQEaylkUBdRMjC7gtG/2z6KJhzwPhVLemnm9z
         0fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708884123; x=1709488923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K25xY4evHGr2vemHU7LteAuwba5OQfrDW2F0+zcbI+g=;
        b=efWZlfB/w1fZwbvPVCXef/WevrQeMusz+UBSHo1ptVQD8qcMJ4p1Royz4Ze1pWlOHF
         9YoBwABOFQ6mrVJ6BuQuPM0eFX8R4vtLS5E+H+w+fCYsDT2ArDv2nUieWJJnNhZ0df0Q
         KArkiwnsbFYangvPgox96IQdWKCrjlvQP+IRAfJg8fK8ZYXfwlrGz0pIU472uHHC4HXr
         8kGAIZdLtXvi22dX+Y+7JJ0MusHihir1RRG54/xlh1FZbuEsURN69OsBSrDTmB/XxOpX
         mIqHO4S70lgkNNeFaga8HId5VWR1wtJsAHRT5YTvxE82TPId79dX33IjH/W2AfPAOK1x
         vUdA==
X-Gm-Message-State: AOJu0YzlGZjj4RxkcWFKEeppdU1uoWOjYr8loCteIj0xCuXW9okDDzOD
	0om476/w+EXeGk157zQnQGBbxM+8ErW8EfYQLN+WAszmYr9CkNTTaZ9bHQ7d8mRhaKqkke7/lpP
	WwFfNBIFPlxs6FSuvgGrvWUPLOHw4ywpnMtE=
X-Google-Smtp-Source: AGHT+IGp9I3MzFnSckDij9uaZvHbhOOok3FxekDIEMWwNsQnk5yY48qnoqLmY5QMrRmwXOg+UEllXq3z5xB5MGKYOHA=
X-Received: by 2002:adf:e543:0:b0:33d:6c9f:39d6 with SMTP id
 z3-20020adfe543000000b0033d6c9f39d6mr3238801wrm.40.1708884122859; Sun, 25 Feb
 2024 10:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208225241.644701-1-martin.jansa@gmail.com> <20240225163042.rrb6djrhbs6e2fk5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240225163042.rrb6djrhbs6e2fk5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Sun, 25 Feb 2024 19:01:48 +0100
Message-ID: <CA+chaQdFJkmc540nzz0PKJLtXMGg4yCfHYkMZaxCooCZ6PdaLw@mail.gmail.com>
Subject: Re: [PATCH] tests/*/Makefile: make sure group.list DIRT exists before install
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 5:35=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Thu, Feb 08, 2024 at 11:52:41PM +0100, Martin Jansa wrote:
> > * sometimes make install was failing with:
> >   cp: cannot stat 'group.list': No such file or directory
> >   and bunch of non-fatal messages:
> >   mv: failed to preserve ownership for 'group.list': Invalid argument
>
> I'm wondering ... isn't that expected?
>
> Why not let "make install" fail directly, if there's not a completed "mak=
e" ?
> Isn't that more familiar?

It might if it fails reliably, but in OpenEmbedded builds where I was
seeing this in some CI builds it failed in about 1% of the builds, which is
enough to make the failure annoying and if this is meant to be expected
behavior than not failing reliably, for context see:
https://git.openembedded.org/meta-openembedded/commit/?id=3De8a1c9823b7e55d=
d2ca7f19a3fd3a05ae676bfe2

so here it calls make in do_compile task (defined in autotools-brokensep),
then make install in do_install task and do_install was failing
_sometimes_, and I haven't seen single failure since this change was
applied.

I'm not very familiar with xfstests, I wasn't even building it
intentionally (it's just part of one CI job which builds everything
available), so I might be missing something.

Regards,
