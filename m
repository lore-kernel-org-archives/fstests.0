Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA837104C
	for <fstests@vger.kernel.org>; Tue, 25 Aug 2026 04:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632425; cv=pass; b=CNVBdHUfX6Bw2jTqePqKJzyew96WI999JyXyb9axYjBc642x2ysP2DRfJQIB3r4pNs0ukaufYkU7DUzSgNxZ2na1QhMUadTqLAxijHJ+TPkwquY27zne3FJlYrm3S7MNdaZoh9ZG5CITSvEbNw1Fig3qUQK5Pi47m0HC+H2OCwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632425; c=relaxed/simple;
	bh=e+osiZcBJ3sLLAHAZGxgZhXdryo0hK/w9CiDknz8ak0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdU42S9TK16MH/NVa+vihJtWuUJ3WZofsIg2QQ2bf4/OfsMeUkNarrC4+W3qecg/3HA2ADXMi7Oei6q5ZMs46cE8bTPz3o54qBAvA112o4eQXEHnTfFccXugb3VocX8tfB+Di15raROjZpZdjdxGegIW5vmQ4RpPnxQEZ3XPtbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HS/I0MCA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mbI4OUJN; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HS/I0MCA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mbI4OUJN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787632422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNLWhoPiot0p46n1wa3ItL3xPOPS9PnaLj8Zp5RO204=;
	b=HS/I0MCABP1wbw3wpZbpoJEly7MUNpcckl6fwymOPfZxfFuzISLBOY4eKMOFJw/1RMaDpQ
	LNaQKD4rm8USgl94yt3AE91UX8lpDDfJ3gswmAcmmzGDIljUld4bOg6sUyUIhP4KKfL5aw
	5S+VX2Hnq1tSe9fkvYc1I0/TMUkB/Oo=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-HWlRFfhwNCOgpYmw_9UIPQ-1; Tue, 25 Aug 2026 00:33:41 -0400
X-MC-Unique: HWlRFfhwNCOgpYmw_9UIPQ-1
X-Mimecast-MFC-AGG-ID: HWlRFfhwNCOgpYmw_9UIPQ_1787632421
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66c73057f18so12315388d50.3
        for <fstests@vger.kernel.org>; Mon, 24 Aug 2026 21:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787632421; cv=none;
        d=google.com; s=arc-20260327;
        b=M3N1OGPeO2LIFhZxgP3KvnexRaJP4Hs+9M+rGEGLUq+OMlvros3IdoMPJJF5QrEL5w
         /eql3ieEs182ed2Syl+BeB5Ts9SXR/3HrE7xN7p6ViSQ83oyfBa7UDv2DZUHChhFjN6a
         hxnXTsWFfinWbQVkqzxExyk3VZkFWRiZ+rxFR6j8GBuxfL7boXZLKkEuppCRjMzRk5Y7
         lH/GII4j8mVJlIgYRGESPSpPucc9j+wqJOL0WFAINYkDqvOwijQ7NrSoC3ieKMmOcVDY
         qreJ0N/0ZX6dsxK6hMIlgYR1tPitbSIv0KrnFfChgzFw5+Zi1wUbD24SAF++XXPzhkFP
         BvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PNLWhoPiot0p46n1wa3ItL3xPOPS9PnaLj8Zp5RO204=;
        fh=2JdxTqi7wYMTc87yKjsSq5KElNRLHKQGmIH1rgRK8vI=;
        b=IS/cTZDz9/IzVWKE48hArAT5AWGEt5JmXHAL+OZ705VFs+S8sBybEJRusgHh02HpL1
         fqDXEnUU8YP+1tau39mePdfK/7doljyjc4R9hkaUb46Ae2tBa3QBbSEyJL+vnp6mZr34
         XlM3oQ8Bty55X5iXwuI83HzNgW7q2NI6dlLiGLZWSiXGT9+sPCv0aET0RzEu89FFAvUZ
         RnJUHBtyVn/Q9mFL6VWivHTn7qdoZ8XRlVPdbZLTwT34zGq0GaTtoITfocuu3vP6Anzf
         keOqk+SAm0P8m/kopCuWJu0XFxASh4G8LZ3ULt+Jg9nVm6NLLWiDWKEP/2sP0wQPECzQ
         ANaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787632421; x=1788237221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PNLWhoPiot0p46n1wa3ItL3xPOPS9PnaLj8Zp5RO204=;
        b=mbI4OUJNhjcghlehzmUpv2+7+cY9xMwjd4dFLYAmrfMsQj8LRxu+bbR70rVw9itCgI
         5DHJistlfCOr+leLKf4blyOrx7iNYmjJN3OTFhBVrOAXIHLfXO35i8k18PuxDwetrX7O
         eQLveluutBFIzJBF3HZx9xhgzciyHFzCWLMzpOEO6cy0M2s5UV3kdL9BRYJu0q9mLJfB
         +LguSl+6NcL+TtAka7DDRXsmVtwr/6Djn3QxFyf6mv1UdH/uFKSHX4XlMBF1SqxwG3eH
         Pv4wdt0Ka3qilh5mZ1gJbdMa1xOi5m2VhpQVoLZNhwV3bWcl7cNjvKOCjrzws4YOylxN
         t6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787632421; x=1788237221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PNLWhoPiot0p46n1wa3ItL3xPOPS9PnaLj8Zp5RO204=;
        b=nA85fznKEtz80t1A0qUoVWHaryxhzZMTEFMjmkXLlCx96l8aXEMV1jN3zzSVQ2ioL9
         DgXCJ0Un7aRn8GcbiYG180/HRETiRQmGgiazHSxVD+bWOUn9c7bLpIKnNLw0mKkUhAMQ
         bGYEuHY3JYgeg0U0xpcpk/s9MWiuVGt+lyMA6mHveYz6T9+aOUQ+jciQ+OCWG4NKyWts
         oBoR+WDoLj1aJnhX6Odv0W+Ayx4YZWZDovjfCMEr1VGZo8IrwoBhHg+BlsbxTS+WbBLL
         594Iv6BBpjpM+dV84z5w0oqlyRq9ltIYJ/oqsezWAYHQGRHcHQ2Y8P+Am+wDXGC7SvKG
         qMzg==
X-Gm-Message-State: AFuF++kotd8l/T06irTR95DyKRCwUyM/PZjcoykMYOyLhjkou0Kl4LiL
	pc6ip17i4qJv5eFeCxsJFzhl6Vf0MsYU7ZXbpgq7zpIzxzp8PQJQGHT6JjT/b/a2Xt/JDqcjU3R
	uYOpGrfO9p0LV2cFX9z3xD4tZQXUT9dPsmsDZROOw52nL5gpDQCQeU4eiwVz2goTWuvyvVStcWT
	QpcHG4DutqHYb+FaotujLKhViaR1uSfckl5g==
X-Gm-Gg: AR+sD13FDyZ6JBmR1kLmzL8rs89K1WlWsV39ci4xHttsuPqn/e6leibLfvYh1sWNVI7
	uwjk0jYY39x/g/s5cjQdpe5BPfdu0eXVV7zRsdQGYyz4fIvOqG1wpTjwDSf2fdJK39Hb51elI1z
	7gTzpZju2TfU4uQCswT52fH3fRBR54Ph5RMhDdhLtg9kcXLLpiJe/YgPCr2f4=
X-Received: by 2002:a53:ac9d:0:b0:66c:9f99:9133 with SMTP id 956f58d0204a3-66cf21bc69cmr8753548d50.29.1787632420784;
        Mon, 24 Aug 2026 21:33:40 -0700 (PDT)
X-Received: by 2002:a53:ac9d:0:b0:66c:9f99:9133 with SMTP id
 956f58d0204a3-66cf21bc69cmr8753539d50.29.1787632420380; Mon, 24 Aug 2026
 21:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824065604.43478-1-msinguru@redhat.com> <20260824161137.GO839663@frogsfrogsfrogs>
In-Reply-To: <20260824161137.GO839663@frogsfrogsfrogs>
From: Manognya Singuru <msinguru@redhat.com>
Date: Tue, 25 Aug 2026 10:03:28 +0530
X-Gm-Features: AcwNN1Vh17dGJN09mwYQU3rydPMQnY7lHm5NmEdnXFJS15xMbTGctpqnTykj7Uw
Message-ID: <CAOq9M7dmaJ4JzuS=_wkfLG8wmw_aswiW7Z01wJ3oo64uAwwZmw@mail.gmail.com>
Subject: Re: [PATCH] common/xfs: filter mkfs.xfs stripe geometry warning
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 9:41=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Aug 24, 2026 at 12:26:04PM +0530, Manognya Singuru wrote:
> > mkfs.xfs prints a warning when creating small filesystems on devices
> > that advertise stripe geometry:
> >
> > mkfs.xfs: small data volume, ignoring data volume stripe unit XXX and
> > stripe width XXX
> >
> > This warning causes several XFS tests to fail their golden output
> > comparison when SCRATCH_DEV has striped device geometry such as
> > scsi_debug devices.
> >
> > Filter the warning in _try_scratch_mkfs_xfs() instead of
> > updating individual test expected outputs, as the filesystem is created
> > successfully and the warning does not indicate a failure.
> >
> > Signed-off-by: Manognya Singuru <msinguru@redhat.com>
> > ---
> > Tested with xfs/015, xfs/030, xfs/041, xfs/042, xfs/075, xfs/104,
> > xfs/109, xfs/168 and xfs/177.
> >
> > Output for xfs/030 before the filter:
> > QA output created by 030
> > ...
> > +mkfs.xfs: small data volume, ignoring data volume stripe unit 64 and
>
> How big is this volume?  I'm guessing less than a gigabyte or two?
>

Yes, It is 1 gigabyte.


> > stripe width 64
> > ...
> > Ran: xfs/030
> > Failures: xfs/030
> > Failed 1 of 1 tests
> >
> > Output for xfs/030 after adding the filter:
> > xfs/030             15s
> > Ran: xfs/030
> > Passed all 1 tests
> >
> >  common/xfs | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/common/xfs b/common/xfs
> > index 81add208..98981e62 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -157,7 +157,8 @@ _try_scratch_mkfs_xfs()
> >       local mkfs_cmd=3D"`_scratch_mkfs_xfs_opts`"
> >       local mkfs_filter=3D"sed -e '/less than device physical sector/d'=
 \
> >                              -e '/switching to logical sector/d' \
> > -                            -e '/Default configuration/d'"
> > +                            -e '/Default configuration/d' \
> > +                            -e '/small data volume, ignoring data volu=
me stripe unit/d'"
>
> But yeah, that's not output that we care about.

Yes, many tests fail due to these extra lines in the output.

> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> --D
>
> >       local tmp=3D`mktemp -u`
> >       local mkfs_status
> >
> > --
> > 2.54.0
> >
> >
>

