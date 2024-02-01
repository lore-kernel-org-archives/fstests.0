Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A65F48C
	for <fstests@vger.kernel.org>; Thu,  1 Feb 2024 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799838; cv=none; b=VcWVesWJbsKxLoawqf4/noJvvClRBINzjgah+D0eKV93zgRGs3Wam7e5VZ/5vtMWgzWTWaopH0wg8wxEuv1sMbjifh1QnO7wNEG7OLMKlmD0jxPssu/BhMHX7sEuUwkLJcbS7RGNMQJBbB78Raf4cnfh3oZisPvkuFNzSUHplZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799838; c=relaxed/simple;
	bh=pxxTgIJTz9K7aIFtVClndmfx7TgyFrsDNwdyR5Llcng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZ9ChC/60tRJkDVX/f0VwdR6SdUbAsOnfoeTCGfvM9PRBaaVd3wyjXaA/Hw9wOKzNW0q21XnswCAvQesfoktxdvLlGjtTiYzK7qYoneVvcmnUZe2Hl4roUe004GDFzrt2NNF0KciXHLjMSUju/sRzDnXtITjansyMUms916b29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NV1nm1Sr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NV1nm1Sr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706799836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6HpAWNpDHGsf1BQTVsjCsUN+OeOJy6cYnxrx+iISmk=;
	b=NV1nm1Sr5EI9GxpBcicn2EIyBSa6w9QdYOmvmwT8bvNjryZLSkJLaKAvQnpuBMJAoLWmXs
	MXk1vC/K6YD4iOfGRUa2HCBkiSR3XdgbieGORgQ/HqJLlkjMSpWflXkvwlOenvs2ziovqR
	dj9bVnNFW7NtGwBDraM03NYlyPaiPfU=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-RtR539wAOXCN6mz7mw3j1A-1; Thu, 01 Feb 2024 10:03:55 -0500
X-MC-Unique: RtR539wAOXCN6mz7mw3j1A-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4bdb5b84504so385460e0c.1
        for <fstests@vger.kernel.org>; Thu, 01 Feb 2024 07:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799834; x=1707404634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6HpAWNpDHGsf1BQTVsjCsUN+OeOJy6cYnxrx+iISmk=;
        b=uNq/vs9ZR8lOXWm3KV1ryNG0gwr4+uQfFR+e3kekrU3RdpSdBUXuv31hsuafLW5/2j
         S4Mm6KXTyfiZXQKhH7wwS4AvA/UqYeCwX1Lfa0tUoq9J6kBilwOsHtPsBDIAcTU0pU8J
         NIrfOUovlDmsRma/oq6100gcHLyGfvjF+6vsnnevHqKb+B+IMUrsgZCLiU8h0FkvnArG
         IYacWrkPu/xkcK/nwMOOjNkI737YHKeN/3GawPDq1SKgF+u6/H0KdvVjHGmUHzHZn8Za
         xZjBFY9RHkC+EeIYe/pELQOHKalEvSDUovpEuSucMUCDk5pzVaIXXO7+Si69zr5nZ5wh
         0bCg==
X-Gm-Message-State: AOJu0YyQNYtuf0/XdP3Rn/iQ4vzbN5OVglQ01G7SinxCYhJLoKOgPTDQ
	wrnWluhpbNTnTyQUwUZegvB50A10L9SKMJgfHtF31PXKrWvKld706Ihxnq8bXIP4ZsrWoLGHqAO
	ZfmFA0LcZd+T4UwYDSGxaoepK72uIaGiDUPKMFH7xUXS9Rt8JXtufrbmuvlk6Z7YW7Xxe/Rugvb
	Exu5TB82ggfAjamLAUFsfZBuuq0cd2EphAR2hbhQ==
X-Received: by 2002:a05:6122:2310:b0:4bd:6861:97ea with SMTP id bq16-20020a056122231000b004bd686197eamr2411159vkb.0.1706799833938;
        Thu, 01 Feb 2024 07:03:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzlrbpMBjXBnLtAkLwmvEyCeX77OMzK4bMmXA6mBvwP78cmiTkUUw4j4hSy3rrXmbj7dlfxMfBTX4uAxUdb00=
X-Received: by 2002:a05:6122:2310:b0:4bd:6861:97ea with SMTP id
 bq16-20020a056122231000b004bd686197eamr2411137vkb.0.1706799833693; Thu, 01
 Feb 2024 07:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925201827.1703857-1-aahringo@redhat.com> <CAK-6q+hrsfCn+y3yjqnti9JUfSOhOWgiEtSioukL5H3dA6-_8A@mail.gmail.com>
In-Reply-To: <CAK-6q+hrsfCn+y3yjqnti9JUfSOhOWgiEtSioukL5H3dA6-_8A@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 1 Feb 2024 10:03:41 -0500
Message-ID: <CAK-6q+gGtd4eRo=FxM34UFWsSid2QVe=p8HjCSABwPouZo_oCw@mail.gmail.com>
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, gfs2@lists.linux.dev, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 2, 2023 at 10:37=E2=80=AFAM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Hi,
>
> On Mon, Sep 25, 2023 at 4:18=E2=80=AFPM Alexander Aring <aahringo@redhat.=
com> wrote:
> >
> > This patch adds fcntl corner cases that was being used to confirm issue=
s
> > on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> > implementation and in those corner cases issues was being found and
> > fixed.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> > changes since v2:
> > - move fcntl tests into one fcntl c file
> > - remove ofd and same owner tests, should be reflected by only one test
> > - simplify commit message (remove testname out of it)
> > - add error messages in fcntl.c to give more information if an error
> >   occur
>
> ping, any comments? Would for me nice to have these fcntl() tests
> upstream and have a starting point to add more tests regarding dlm
> plock implementation.
>
> Thanks.

ping?

- Alex

