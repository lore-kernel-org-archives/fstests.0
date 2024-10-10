Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629101925A2
	for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532013; cv=none; b=twYAgvauFHzcd2m/ZxLh6KfuzyjGxZuWCt6VWuoGU9/mfG5hVTmMqdMxsnHdG+I0IFypy8Hrqc8JHYkig7kW+5Kf8Wq9fDuybnQl/LNoQsUwhAhlWZkvSNwwAnSCpnDIZnCZD59XmYZQpDoJYf5j7MHDKKmKSfTaG2AToJnmrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532013; c=relaxed/simple;
	bh=sPUjoxRMY+wUajUpCb4vMW+kK7OUObVAeyy1X54iY0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bztPrAqDEVJK7XS8+DWeIt7K0tloQtnvvogZR2JO1ol7fLya3KHTzK5mkwM8vFB/LvjV0d4gDfNDIPsk0ZzEgGvuQWhp6NKAPTFfGX5tS6GYi34kNGXhirD1C85KCwMf+fEm3a/Q+HTAPfG8V4zMM20tA2Z+DmRI6nJOZe44GoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C/iPWe0V; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C/iPWe0V"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so174572f8f.2
        for <fstests@vger.kernel.org>; Wed, 09 Oct 2024 20:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728532010; x=1729136810; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPUjoxRMY+wUajUpCb4vMW+kK7OUObVAeyy1X54iY0g=;
        b=C/iPWe0Vr/oM8HA+wp0GMqi5CzJd+G0TimHrPXMPvgbJT6fueV8dGVX4jO9uVk8k06
         RYrYsbph+U72Qw9OujuCcec2n1JXyhcfi9nxmCH5KTa7gBhS1MEfzuYxwhqAo0cFpra4
         bnBYlQbWZeh/SHCfYK8YfuG80rr8GjeggiwaWQlpCvZ7RePhMC5LjTkVCQbqwCGDJIVj
         6ySDfVIkd8MARsoK9wpEk8BPnPvcsveNRkTWFkEgSpJxa3BqUA7CIsQFbmDzP3pWCUdw
         k6e5nH90k2g8bY6XYa3OGyrVvdXvrjgMnnp1Y40BVK6D9ukWFT1rNgPMiMPn3DqwmOub
         h6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728532010; x=1729136810;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPUjoxRMY+wUajUpCb4vMW+kK7OUObVAeyy1X54iY0g=;
        b=sJlqpxA5kQbZg3EYJpVteWoTErX1wx2Hlw8UzXHX5RgtL7qzy18BsHD/xLt2d6C8+j
         +d3sbJdRB5DOK0+UULtoeMbK/O4eKP1n8aZtuXHOBeXa+A3AIxlBV5uWmcwdU7wt7fJ4
         ttQUGCUSPc8kTfy5mHvrRplp9IY1swtZ87CcXZBX57v7YmE2AVG3T06V+ZJ+jx1rtS2Q
         V8ILmJeF8M/a0foF4Kb5hBJxXT5rErqHjHHl9LnkOL02o9EJ3zIrA8Mr7m9WX/TedclH
         jOUlAHiVf1uV4+4gwMCtHk4FQs/mPrKZZBJ3p6ooEPgglJHDrYT2L/1cbPPznGeUAtyH
         e1cg==
X-Gm-Message-State: AOJu0YyoTH/QUpwLuY4NrboNjHYEFS7mI+Mlb9WJzvvKWC8b26lGfvAk
	iSrP90cDemPca+HSkPtObFZXZ4VtOeSRpD0/Co/HMueuFH/N7dnygnpRNJUTuiQ=
X-Google-Smtp-Source: AGHT+IENBOsDHKaaEzHXI5ohB5APwv5P/GLZBD9ojUDZ/dsKqkYOvk2w7w//8ImK5MhLQAt9UlhthA==
X-Received: by 2002:a05:6000:1a4f:b0:37d:397a:5a05 with SMTP id ffacd0b85a97d-37d3ab1c11bmr3422772f8f.54.1728532009674;
        Wed, 09 Oct 2024 20:46:49 -0700 (PDT)
Received: from [10.202.112.42] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab10398sm171854b3a.218.2024.10.09.20.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 20:46:49 -0700 (PDT)
Message-ID: <facac6fce8974ec31e8bfd0fd9d9484652fc858a.camel@suse.com>
Subject: Re: [PATCH v2] generic/746: install two necessary files
From: An Long <lan@suse.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Date: Thu, 10 Oct 2024 11:46:54 +0800
In-Reply-To: <20241009163800.GM21840@frogsfrogsfrogs>
References: <878d46618e9851f7a019f675716630f9517f4e02.camel@suse.com>
	 <20241009163800.GM21840@frogsfrogsfrogs>
Autocrypt: addr=lan@suse.com; prefer-encrypt=mutual; keydata=mQENBFvqfKcBCADKdcrLxNKpkBPfxZwVu1Q3ADpyWdnXZfyQOIO+1Z/WSDeXgr70HUhk/zu81WoO5WyXMK3N1dcS4KrOdNOmDp0H4G5hR+BIkgbIJpo4ekYWVdrAMT8oJgX5EgSIeuDdn2ZJ7K0EDLX9M7969gaw2nHWgBzj/ALGFdCE8zYkZAfPrwN80M5Xl+NBvOrTMypW78WOg5NdGd3E4jjgbKreHFdc9/Bmp2XKQKhjClelfM5aThhsM9wljzWdX1frN2AoAomHKuxKJGvZf30eHoXAs/ikHM4cvoUcY/8H8VgJO3mQMYEFWJR6qSbnfdy3T9Ns/Xy5QGj/XmATwhDg3BMBwvEZABEBAAG0FkFuIExvbmcgPGxhbkBzdXNlLmNvbT6JAU4EEwEIADgWIQSGtWkd+xUNZVZsuhNmwA3KtD5SBgUCW+p8pwIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBmwA3KtD5SBuAwCACDifSf/raZ05H/0l2xAjZo9JFrWib391QLNbDYFi+Nm7nJ3ATse33ibLheOP0hJ07bsZo7uKNio8DIHDZ5CsTMd21ZvvJlNGT+l9BQV/OLRExCTcK9CpLcHoEI3M1niqL42QjVZPkKcjSwbTCa8mySNmIl64K0YTq1HnuWxShTHNlLBBkId9OMEnztgp9Ke4g+SxcU2+058v8ZTnM5wUp6fMsQelsfigJJfRqHbpy6Fap3XIY+1gKuNVIdyKWXovxtwd++fADyZVh/Zh5IKgp/1HyWE9g0MG6TUzJ+LV57jOrIJJbzl39HUp+5mFBI+RSHiJjoBZAQ7diUzT7+ns+0uQENBFvqfKcBCADCPC4telre7E8pAZITzcVsl1BP3PoMAaow4gh1SOO44J34GHJS7CRqpt4YfbPBEVmFZQiJEhb0GL2KH
 qg7J8hO7J9fmpEiCe1Vv+cK8DSxygXXL0fltVkQlgOjFlzYks+tv g58qti7uykoyavLPSu7yuGvDtzIxB3lXwUnvmS0X8MTBFIdK0s4vJOu/2cDIAnYCNdypZ8H44XtYZVDdB9r4E253y35Nd1QDjJFu/8BQxQXK5sReIYl5fRtz+4TzZQPxWt3/j62RmjY5elPEBTd2q4K6reqRuIwDBXjTWjEKylx9yw47nMH7TzIrXpSWLG08+F8Cb9KhUJysBN4tJY1ABEBAAGJATYEGAEIACAWIQSGtWkd+xUNZVZsuhNmwA3KtD5SBgUCW+p8pwIbDAAKCRBmwA3KtD5SBlJuCACzhZDj5+zuuqYMl07AiV5BqOkGmjghybACLtHjMZDbFOmxnvt7GOfTdf7ug1YguQQI6xIssqzGvXTJVgIfTP38dOSAssrYp78VyFtcAZMiN25GxOOqYlpwhKH1PAr04Ylizz/EZlbfCQ8XCFuTziZ7HwEyjTkvs5XUYJObEhj2Sv9ebhwm3vTZv0VTb8+BpxyQuuGYYakbH94D5Ne5gAC6FaCevXdeqjSCTzV6NZ5seldc3FogQ+TB+riX4G4SA4Nq36Xt4hpAoDoZhh25KsH/9Kq65+eyYKsCnpY+N3f4SAEf5NEODmGF9eKC0K8XcjhXGcpDmnae2tUnjWnjLBXO
Organization: SUSE QE LSG, QE 2, Beijing
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 09:38 -0700, Darrick J. Wong wrote:
> On Wed, Oct 09, 2024 at 11:56:16PM +0800, An Long wrote:
> > parse-dev-tree.awk and parse-extent-tree.awk are used by
> > generic/746.
> > We need to make sure them are installed, otherwise generic/746 will
> > have problems if fstests is installed via "make install".
> > ---
>=20
> Needs a SoB tag.
Added. I used -S instead of -s. Sorry for mistake.
>=20
> --D
>=20
> > =C2=A0src/Makefile | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/src/Makefile b/src/Makefile
> > index 3097c29e..a0396332 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -38,7 +38,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize
> > preallo_rw_pattern_reader \
> >=20
> > =C2=A0EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread=
.sh
> > \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 soak_duration.awk
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 soak_duration.awk parse-dev-tree.awk parse-extent-
> > tree.awk
> >=20
> > =C2=A0SUBDIRS =3D log-writes perf
> >=20
> > --=20
> > 2.43.0
> >=20
> >=20

--=20
An Long <lan@suse.com>
SUSE QE LSG, QE 2, Beijing
