Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A31F1BD50C
	for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558075; cv=none; b=OY1h3dLSiryTO8A9sP14OMo6FTLH6LdFQ6sxruZJhIfd3IzKbyA4wlo9cULBEdu4dinQgWKCgVecoyw9Wk5GL2N1FQMnX7t4fT7MEUuAjkZS0ejDEpvLU5P0SABVv7KM4RnEJHVvYwqkYxD4r2BiPYCfXoT+JdyWOZyhGOnHzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558075; c=relaxed/simple;
	bh=IrLio1TP/tKHgLDSL0voI/Wh0eSCsauzXrCbIfAKOQ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QV7+ussIPCx2saIHvWB852hsDikN+djmbKTxuAg+flIapPb9tdMi29s84tQ6bNfGgBZk1YZ2uxp0/Pl/4jZqkZEabc5C9Uuop6HLKeC2HXdPt06GY0XARNXgpCb8ThUdbq5dyediACOgfShAEXnUt95Mmw0b3UJ7gq4wPzuX0g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q0Fmj7RH; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q0Fmj7RH"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2facaa16826so7037381fa.0
        for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728558071; x=1729162871; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IrLio1TP/tKHgLDSL0voI/Wh0eSCsauzXrCbIfAKOQ8=;
        b=Q0Fmj7RHcEOs5f0VCyoXCvrSVAyQ007vpmtHhSG5T7GSLkwKAS0t/a0U6S5cHH/qDE
         DDnnICTpkmAGk1BZzyMuK/7sgL4gD8+UnBs7dc7WPQk0jEcrOykNbviyh6srVManEpBg
         PsDCD4ug8VruQ7cYFOztyUKMJTdwbh2h0Pc07w5m7LaMDoU7xqroK4kc6dC2u4vTS1eK
         NZObXAcBJCynGoqtEo5+i2Nzi59XIzmCSsR+wQDoLtO0htS2kKgkVQyY2UAldQ5uqXbo
         FS9mLRPjXIjHZy/Kwrn4RTIDZeVCtM/KIi7SiI3FCPfZ2odEDtZeJyZHws31yZo/bRcJ
         7iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728558071; x=1729162871;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrLio1TP/tKHgLDSL0voI/Wh0eSCsauzXrCbIfAKOQ8=;
        b=JR3PFeEQz8wmhwy2kMR47cpEeI+40EcK9OWQxeF93va1nWdXCSV8YCptTwc6HSNDNl
         IEad3W/iHzxERn4wyK5iE0ZCmIzkj+UEdZA980rvrTC2mxmGoMnjl0DznxnXkuvYLgl/
         AWNYnxQMioKBwLPA+Xyz82EJ7eR8tcVbsGkoUAqvuJPmK/SN+YdPQHD3oZxeGlRu7KJn
         +xBKw2c1IHMMZjsh590+DgNuAwZhZb3TC4uFOhC5FW0599z0TQc0u74GO8q606AxLLnO
         oooSDKXjQSIH/6yaE7OmtoPCri9gqibKocLfg4Bu5qV4ArpfS+D1NEQtLXl7U0HkBC99
         Sd6A==
X-Gm-Message-State: AOJu0YxjSo8uvaOGsC3HEgtBI7HTOWhCwZEiXqAbPKN7wyf3FjXCIIHu
	ZsUpjznNeXRyv/4/v+03RIVDbVSPtILwg2vStqz9QghbWjItMXvfaS5GDh02XmA=
X-Google-Smtp-Source: AGHT+IFYOdhWgmOagdU/mv938/73COuWmLEaqm0+ysrZSoRzy2imE2rN6z3p/yEI9dEQfrKzMcHD7Q==
X-Received: by 2002:a2e:a58c:0:b0:2fa:d67a:ada3 with SMTP id 38308e7fff4ca-2fb1872fc99mr38107611fa.12.1728558071022;
        Thu, 10 Oct 2024 04:01:11 -0700 (PDT)
Received: from [10.202.112.42] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c212e9csm7553505ad.188.2024.10.10.04.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:01:10 -0700 (PDT)
Message-ID: <7598cd96388b0eb87b111e30f1157d37f5ec03cf.camel@suse.com>
Subject: Re: [PATCH v3] generic/746: install two necessary files
From: An Long <lan@suse.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Date: Thu, 10 Oct 2024 19:01:15 +0800
In-Reply-To: <20241010094423.mnyaf5bljmeylxri@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <aaf23db45854222bbcfa470b25812e42a2ab9eda.camel@suse.com>
	 <20241010094423.mnyaf5bljmeylxri@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

On Thu, 2024-10-10 at 17:44 +0800, Zorro Lang wrote:
> On Thu, Oct 10, 2024 at 11:40:20AM +0800, An Long wrote:
> > parse-dev-tree.awk and parse-extent-tree.awk are used by
> > generic/746.
> > We need to make sure them are installed, otherwise generic/746 will
> > have problems if fstests is installed via "make install".
> >=20
> > Signed-off-by: An Long <lan@suse.com>
> > ---
>=20
> There might be something (format) wrong when you generated or sent
> this
> patch, I can't merge it directly, the `git am` shows:
>=20
> =C2=A0 Applying: generic/746: install two necessary files
> =C2=A0 error: corrupt patch at line 18
> =C2=A0 Patch failed at 0001 generic/746: install two necessary files
> =C2=A0 hint: Use 'git am --show-current-patch=3Ddiff' to see the failed
> patch
> =C2=A0 hint: When you have resolved this problem, run "git am --continue"=
.
> =C2=A0 hint: If you prefer to skip this patch, run "git am --skip"
> instead.
> =C2=A0 hint: To restore the original branch and stop patching, run "git a=
m
> --abort".
> =C2=A0 hint: Disable this message with "git config advice.mergeConflict
> false"
>=20
> Anyway, this change is simple enough, so I've maken this change
> manually
> (with author=3D$you), so don't need to send one more version, just
> remind it.
>=20
> Thanks,
> Zorro
Thank you, Lang! I've double checked, there is a "=3D20"(space) in the
end of mail. However, I'll ensure the format is correct next time.
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
>=20

--=20
An Long <lan@suse.com>
SUSE QE LSG, QE 2, Beijing
