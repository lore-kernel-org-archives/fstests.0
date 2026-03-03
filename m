Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D347DD76
	for <fstests@vger.kernel.org>; Tue,  3 Mar 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549776; cv=pass; b=gA1tbetZHrjX3F2pyWe7ClPPKH7FPTJijiCwAUYSFgCX1Fzn4E6BTEIcXCijwIKqg+t9dn3gSWWvLhdEs04ZVmck9iE3CvN/Cda/z2puWBBt66PG2ljtxMQY1iB1ZrtuEetiKp9YJ5FIus1YZ2AEsEs7nk3Xaa5UDFrLRD2ynOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549776; c=relaxed/simple;
	bh=5QoujqJkWgms6jqzEiHsaG7e0wdOWQp96Pzu/VCA4rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLrYfdWSDJkDgnxcLdmO2GU+ZcUnAsNILwEsXhqlBtYJUZy4St31sqvDQCTUyFN6AFvPzXcYl4PaF/QD1wGK2EYVg9CkABCMQbYd2FF1wUfqrea7bVjBX5UT+icVtgGWa1LurWV9YEnL2/Jh6IuxD1kzgE+uOKkei/xJK+yWYHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfIHgG9h; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfIHgG9h"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b886fc047d5so947698666b.3
        for <fstests@vger.kernel.org>; Tue, 03 Mar 2026 06:56:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772549773; cv=none;
        d=google.com; s=arc-20240605;
        b=eJ5mscTN+tOIo/mIQVx0wq2UFwdQyqDZP3NV3UltC7gr299K+Sg0AHcfgsw7gWt+2X
         sUEsCCDdUOu9D06qxRTEv7oxt1szpTPPWtYGzCVTaRnPwla8eCXvWrMTTYv8jkdLwyhD
         5TcZah5Tscfna/rSHDGTiqUUtkotfkTI0xigpV+mlARaQWerI8WxxAek/4Nh3dgcim3O
         8ex1hhx5pcUGZPDH/bIFX/kgSCg23vrkgYv06JQS4Y7Zf5BYAd8F+JZx1ha2mjEHLgws
         s2Gg/NLRdD2QBEDXi1qBnPXaMae2I992HoMd8BtwiFHEBYx+xRd9q3WZ1PyZdFfCPKAg
         5U7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=udta42pxnBlFqxC1s4Qd1kLUvohusAt+5rXvzlylPvw=;
        fh=Y2v12Mnx0KwaLOk9OPvtt0DMOrqLZeXDjhIevQEJssM=;
        b=eWEzITInm5Zmmch6VPNMEchYMjECON2fIzl1JVy65kyJ55AZJ3on3X4n3dSxSlzFB+
         t/iOsDnIIx/TcuXpGKy0Nxd30jApHUkvicybrlr+ssokrwkA7POHaaaAzI32YA3ukm0r
         Nluto4pQV/ZofpN11//+phdVd0Qg/N7DEVBjgj4HSQg6Hpw+stHpcBSbZRwnC1Tc+tJ9
         gtRYuq/iLscWghVC4CXWvvtLZUyz3SRvh1XsGRnr/DBX3QhU5BKWo9YSZH6uNrV20pPz
         E542YaiQjWogCKBMFceuIRQAdIh1yiJypQZRKogrz4jTm6ORI6mceNWYNPWYwUD+d1QG
         zMHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772549773; x=1773154573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udta42pxnBlFqxC1s4Qd1kLUvohusAt+5rXvzlylPvw=;
        b=PfIHgG9hoaNHWSQc9BC3S25gqfPqDUvt5S6PuctIb6fwWpXcbC7JFsQIBhee0CCvFL
         11Y01HQsEbDWxuT9+61Fw2SuVkFUQTk0TBU8OSIkw00HdDpYAZC25w+EB3hlKuveJtxj
         17S6P13N06cDDc+E+mLu5QFZtFhYxr1vf9ujvT1Jhpu3kQZOwHYsg7RieyLxBtuX8KL2
         hDySVqTDbUPZPgS/NEB/TLAFkfUK89KjOZ9MhoBFg6ZIu2LzuGjOdBP01Q6QyROE95He
         42d3vIfntBkJEAikpwSLJlhwE+IWgWgG0cPIJzc3qDMmTZOEDi7OYAAtdUwHZnW9voks
         W5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772549773; x=1773154573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=udta42pxnBlFqxC1s4Qd1kLUvohusAt+5rXvzlylPvw=;
        b=hq5WJGxNZZ5F/C7NdsiK1lVfP3yTy7UjnPBZ23/wFCWa21vL0qFti3XaFCa2lU0ZPY
         v3etvP15aJ0J/wyAaOfmxTrWEDGKugHbT25gjJ2pwMn6bQVJSMKRmTFYYaalbPKa18G1
         Gy5pCFm6ImSRJ959uprbXMU/Njmd0xX5TQQrL2IwKWcxIkpxIIrrMJITZHE3i5dXU45W
         +I7SLYTPL2iImcBuaIaKiEh7+0gRy5P3DrDq4kUu7hN3u8wL62nmlL5dFEekrqdRPWy2
         gmw0/5lEpRzNH1fcxylCa2/QnA+aZaXORgfRWMlHGiV/DouY+KCP9e7NQ8JL2zD0usTI
         E0IA==
X-Forwarded-Encrypted: i=1; AJvYcCVlGu10ovmfYxc1lja9+dr7jqjhAOy8IVRLkYG+BBGZ0ucsolcIYNhpnOc1xwL8bgmZjoZuNFCB@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzjs7iKCq+94QpSa3YobSoJDo2nlbgf8mASyhOvRHDRSxqVm0
	Y9DLuFGYB/9sBbqpvQLVeoCZE7wPsE3ch66i5A2vMZIlqOYjNVeABrm5zCQf6tCu6EbZNlUIrGY
	sZebB7w0BBGIjF/6OkGH4nSpTyzg2KMM=
X-Gm-Gg: ATEYQzzkY/91DdE7924jnPraNUdecnmk6fdaVar5n7xmDhhwc4MyW/yJVBp51R9kCae
	X+RcIVSDyXMErqyXJ+xV8o2xZvIwuVQAVTmjqgk6kt3Ze7RS2OrE/QNjD4eHaEJLdF9tzduk42d
	w4LoHYlrcO891Qqqpf72L+oKF169RJgYumdCchSrWfyukX8oNAliZkTSAgbRdCEiq92e2woNVEV
	hVVyFYnI+280UQxqOdPCyziUNVh67p/H1bXBWJnshL0r64x2ZnzF+cH9chZQEg8niTD2n6OJPiV
	ExXY/P0Lix1wafaxpEC3XbAYLq1dygsGL5rTobaItw==
X-Received: by 2002:a17:907:1c90:b0:b93:892a:e82b with SMTP id
 a640c23a62f3a-b93892ae9f8mr888062766b.51.1772549772848; Tue, 03 Mar 2026
 06:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs>
 <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
 <CAOQ4uxgmYNWCs18+WU9-7QDkhp0f_xX6nvKiyDhS8gZzfUXXXA@mail.gmail.com> <aab1Z7J-m97VfFvS@infradead.org>
In-Reply-To: <aab1Z7J-m97VfFvS@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 15:56:01 +0100
X-Gm-Features: AaiRm50Dm2AD3hFSZjiomm2u0pnUT4PvlIZrYEt7j6TT094HiewpP9Ly0nyguXc
Message-ID: <CAOQ4uxiruBkn=454AoxQuatK3CUve95Jkn=wBzU9hDkWWbFGPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com, linux-fsdevel@vger.kernel.org, 
	hch@lst.de, gabriel@krisman.be, jack@suse.cz, fstests@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 3:51=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Tue, Mar 03, 2026 at 10:21:04AM +0100, Amir Goldstein wrote:
> > On Tue, Mar 3, 2026 at 1:40=E2=80=AFAM Darrick J. Wong <djwong@kernel.o=
rg> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Test the fsnotify filesystem error reporting.
> >
> > For the record, I feel that I need to say to all the people whom we pus=
hed back
> > on fanotify tests in fstests until there was a good enough reason to do=
 so,
> > that this seems like a good reason to do so ;)
>
> Who pushed backed on that?  Because IMHO hiding stuff in ltp is a sure
> way it doesn't get exercisesd regularly?
>

Jan and myself pushed back on adding generic fanotify tests to fstest
because we already have most fanotify tests in LTP.

LTP is run by many testers on many boxes and many release
kernels and we are happy with this project to host tests for the
subsystem that we maintain.

Thanks,
Amir.
