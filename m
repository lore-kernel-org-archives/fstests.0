Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D195138A
	for <fstests@vger.kernel.org>; Tue,  2 Apr 2024 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069809; cv=none; b=RF/h20OMC2+Iw8Fd2isvsZg8tgbnPVPzGXhBJRnThnIrW0hx1hhTwUPk/kYSeJsR7V2SKMyMaHRlD8g2LRjCV2lFHtQbcgAB+W7P+5XpQRYljqK9w6JS3ftfOe+O6fhxJuUQlCBOl4qA/MtviFU8Y+lGiEJYRaX8Vgr9QHG8ao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069809; c=relaxed/simple;
	bh=HpuQ5eF7YCIbnWpTR/xnTijyyZTAnePPG+eVonC58dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YC5T3W+Z6zYGRguuY5rYMBcItXY/Ix5Up6FEfYZqiVMIycJXEgwjWuVCfZcvZ6Y7NRIq0kUIOfhhnNfPM5P2rERzvfG0GQkkBL6dieVDYyYIUy034CWXOCTmAtVz+TaV09tk4IYV5gGWGW9PBl3k3vVKSd0g9PN8WlZYL+4hipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdSc2u7A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdSc2u7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712069807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coSlOwk5kpLH2uC/uJWOwN8i8ItnZLeDftarxZf/2Ps=;
	b=MdSc2u7AhJPCAYlhOQeRYvHv6qD1uvehWLvFel4TNgf/uYMWnBEjQxJ+RnaH+BMf65lDwp
	hyUI0fsAKK1gjURBrNgmc6MH787qeHFkgYOAhCMzS6CUYGZ2USVPUx6fqsi5Y84+Lmm0EF
	ZdAklthWVVuDjyF59aRopQdj3YOkQoM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-_OA3JS3pOJajIkHE-bpehQ-1; Tue, 02 Apr 2024 10:56:45 -0400
X-MC-Unique: _OA3JS3pOJajIkHE-bpehQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d49fa5dfadso44927131fa.0
        for <fstests@vger.kernel.org>; Tue, 02 Apr 2024 07:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712069804; x=1712674604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coSlOwk5kpLH2uC/uJWOwN8i8ItnZLeDftarxZf/2Ps=;
        b=OQVrp2y9TuophBaW0mGlN1gXgPbr6AGmHWwtUhemGaxb8/sx0QIAHAzN/3EyrqE6d5
         FleQYboHE3uKtrO0Dbh4z1l6Bh/brk96p1jqy+7jsq+/82VQ1f6kkyEHJFAB5dgkzBGZ
         frwG67DGJ4Hb2yV7xmWiSyKZ9/NPPhM0Q/xKW9hwQiCsbgTPZMKyrvTzAniy54HEICRa
         kMK9TvXOTBWsTn44zKFV8TQt0Mgnau816plW3Pl/DkV0P3UuXCCtY6E60IIvuP5uCvfQ
         POW7VHHicBaWdcNiHSJOCIseRL1Z8HFg6R/9VUai1mKpRFsXrxqH7z+YdwudhwfMilf8
         H/Mw==
X-Gm-Message-State: AOJu0Yz537UB610LWh32LdZSptYC1hENEzwYBNYXWSD9Te515s2Rn9j0
	2Rw8dJnYDhcpucVzjve1v1eXLDUQ7W1xyBrpkOtcnKF3yaaidAHZAp/IRWgVbOA2t0vPBQk4urc
	W3Brmddi0LY+45howZB+y2Npp0ipD0Yj8w/QpkoAC2a0yMcYi4lyIRxZa1110NrCM2SLP79OcDP
	GeTI2J9DuC0oIXJHwhKapR2dHhU0ZjwQ==
X-Received: by 2002:a05:651c:2d1:b0:2d4:6786:e8 with SMTP id f17-20020a05651c02d100b002d4678600e8mr6956614ljo.12.1712069804457;
        Tue, 02 Apr 2024 07:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjNsKKbgMJVMEfgEd8p3p4dPgkT0ABeq3D5wcXXCczSNd5fv1qDmNVsl2OW910bUhNrcis85N3DPdxWCch048=
X-Received: by 2002:a05:651c:2d1:b0:2d4:6786:e8 with SMTP id
 f17-20020a05651c02d100b002d4678600e8mr6956603ljo.12.1712069804131; Tue, 02
 Apr 2024 07:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925201827.1703857-1-aahringo@redhat.com> <20240330072500.qs73uzweykk3npsq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240330072500.qs73uzweykk3npsq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 2 Apr 2024 10:56:32 -0400
Message-ID: <CAK-6q+h9Oy1A3ZSR=d52ckijVZbAi4zufnE0KkLhMfMi+kY-Dg@mail.gmail.com>
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, gfs2@lists.linux.dev, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 30, 2024 at 3:25=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Mon, Sep 25, 2023 at 04:18:27PM -0400, Alexander Aring wrote:
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
> Any update? :) It's still in "patches-in-queue" branch.

I still have it on my list to work on this.

Thanks for all the recommendations for another version. I hope I can
provide an update soon. What is about the CIFS issue, we will ignore
it for now? From my understanding it is an issue in CIFS but probably
rare to hit and not easy to fix for now.

(report after hang) I can look if we can add an alarm() type
interruption, but this only work if the filesystem really implements
that fcntl(..., F_SETLKW, ...) is interruptible which should be the
case, otherwise it would be another exception why the test is know to
be failing.

Thanks.

- Alex

