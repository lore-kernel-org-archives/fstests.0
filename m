Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB05E7F
	for <fstests@vger.kernel.org>; Tue, 21 May 2024 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253582; cv=none; b=g3o9ZPA7nJe4PBxrk3JpnZBTdFAo9TFPm1tSBeJDWt63lf3Zet8DYf72XQAb61SUe9euXovqMhfTChbVF/kKxKaaO9mR2ttGPjE/zVQg4AF6zG0Quw8a7caZyHdjSfatc/U77sVXTNWzz1o5VUokZ5IymYgYdX3tbNbTvTPCPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253582; c=relaxed/simple;
	bh=sODGnfmKfl05kirINZM0ji46vr8FOdY8tSVDyJHhRbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QY+UmVKLY1sVTEbRJSMfIHrmkW1ZCKo3BR/dI7QH49Ryl53V5Ozrhk3iHA1GUcY2X95O+qBNUAi1xdD62+GYVggz/XMMGrvGxsuQpwOqDLtfY3RqUS6yB8j3/OYtSCYtbHhUhFMJ3EBXOiUtMrZBwtS9c0Wm4hmPInpqreggUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuqX0+Tr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuqX0+Tr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716253579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+IRLtr3CD5713sw58Oz9jeFDrRIoC1ExmWuiRLK+04=;
	b=AuqX0+TrAezCeBsyxRwRzWPEzXudF2uvSnAp4jv0i/07B9uerGkJEQ17nIopwvvu8Idyvc
	axwu6mq9tKZdUr0gxVeLScCp/wzVqHdqQ+apATaG0iSuDRLaUcu9MwgfIX8hCf7EzDFiHv
	gUMp5pB+310unTYpIfdE3tQtormZtQs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-oWfiDTK7MHKJfwlQLkIYFw-1; Mon, 20 May 2024 21:05:47 -0400
X-MC-Unique: oWfiDTK7MHKJfwlQLkIYFw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a59ad2436f8so714481966b.2
        for <fstests@vger.kernel.org>; Mon, 20 May 2024 18:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253546; x=1716858346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+IRLtr3CD5713sw58Oz9jeFDrRIoC1ExmWuiRLK+04=;
        b=AJhJECzjlaphDDrAY4DmwVNaPkZpN7OdVTk/hQ5z4dJ2OIMd4CJkUR/1uO9arWr+T9
         S/NjE4JGNT7bOscsf9s+k5M8Typ7Iwn+67Inz5JFHtcdATNfvAWUxeVN5YwT2qmX6TFj
         /KQJUhpow+LFE8to2S8GFotWLUbYtdbWf0Ma7zPGSsv0lWitcZldPyJykdnIbGWYuPEA
         8rm9tL8rFaUZ38f8k40+s660uzOf+4Nj8EnLD3Q84KmRSPHA8MvxFvGRnFnWby31CT7c
         mY6BM7qSVTMBjmvLSQmb9zhTIv/5xNaT5fP1Zq5ekUHzHHpNaITl5yfgOy7dchMba9CX
         mkSg==
X-Forwarded-Encrypted: i=1; AJvYcCXAOBC1lDGWCpnQDpphQKT3M/g5Xxs8z0HcOHR4c/FIR70dq34chlD1+RTZ2zmQni3vaXrDmamHkZ5jYgBC81KBWiCNAsFwAQ==
X-Gm-Message-State: AOJu0YysciD7l0gh7oHT2KMts7YV1n8QL4xaF6jJPI/h1HmQrAXN84pt
	LxSXuV18wNw+QxE/QuI6L/4nzQ8jhe7qwmPBrB8BkXykqLybHdXmpJ/r6yanm95w3Wn/Nr65YQG
	mUlSNdwuiXEHB+ccYZ3BykPZnCxYfX/9q1o45QgG90KSKgjSln5YjdfpNdy8x3t7ddX2gpfCOWU
	ozRxCWg5lTqlnrXjbVSKxoUDCtCBgd8A==
X-Received: by 2002:a17:906:eb52:b0:a5a:769d:1f8f with SMTP id a640c23a62f3a-a5a769d1fb5mr1326814166b.68.1716253546265;
        Mon, 20 May 2024 18:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmLA8Se8SsEJHpWJGihreHRU2FyfqBzUvAldKqKbqZ3YYcBppqSSpDm5brTkI9ODNGufLxUVJm562I8U/37oM=
X-Received: by 2002:a17:906:eb52:b0:a5a:769d:1f8f with SMTP id
 a640c23a62f3a-a5a769d1fb5mr1326813166b.68.1716253545613; Mon, 20 May 2024
 18:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGS2=Ypq9_X23syZw8tpybjc_hPk7dQGqdYNbpw0KKN1A1wbNA@mail.gmail.com>
 <ZktnrDCSpUYOk5xm@infradead.org>
In-Reply-To: <ZktnrDCSpUYOk5xm@infradead.org>
From: Guangwu Zhang <guazhang@redhat.com>
Date: Tue, 21 May 2024 09:05:34 +0800
Message-ID: <CAGS2=YqCD15RVtZ=NWVjPMa22H3wks1z6TSMVk7jmE_k1A-csg@mail.gmail.com>
Subject: Re: [bug report] Internal error isnullstartblock(got.br_startblock) a
 t line 6005 of file fs/xfs/libxfs/xfs_bmap.c.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, 
	fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

yes,
the branch header info.
commit 04d3822ddfd11fa2c9b449c977f340b57996ef3d
Merge: 59ef81807482 7b815817aa58
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri May 17 09:40:38 2024 -0600

    Merge branch 'block-6.10' into for-next

    * block-6.10:
      blk-mq: add helper for checking if one CPU is mapped to specified hct=
x

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2024=E5=B9=B45=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=80 23:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, May 20, 2024 at 07:48:13PM +0800, Guangwu Zhang wrote:
> > Hi,
> > I get a xfs error when run xfstests  generic/461 testing with
> > linux-block for-next branch.
> > looks it easy to reproduce with s390x arch.
>
> Just to clarify, you see this with the block for-next branch, but not
> with Linux 6.9 or current Linus tree?
>
>


--=20
Guangwu Zhang
Thanks

