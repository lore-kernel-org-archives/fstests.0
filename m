Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE62A322768
	for <fstests@vger.kernel.org>; Fri,  6 Mar 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808961; cv=none; b=XONppipzUDfhSztDeGUcwYlguoGnuBF5btvux8R6XrR5D1uKGGPTCe3KPNELnz7XXVAY3hKwbWCIi7z+VoyYSOawYofroAWjc2JUnLnObdoRGW0xsIXu1umj/usrvXEmvxjdqgDcbNQ8e+q7Xxv+dhDJvK1PPvBFwLzWz9r5cjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808961; c=relaxed/simple;
	bh=aVl5Zkfm845Up2tgXtaQ2s3MGIl6I7L20/OprGe/lPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c04/IdsF3c5t/1KOPw1U2r6m9rNPCRQ7pjxy9xR16t+LtfH7uNwj23ythwHCd3XzBAAg+azG98oNd0mNLLaeu9Aop6/Wd+3o4GzUvCiN0DAS0htr43bJ5Dtu4OXZilB0hjSDY9icAZXP3tskUDZ+ytK8+O6ofaObbM1eKapSQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGREv9Gw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGREv9Gw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E27C2BC9E
	for <fstests@vger.kernel.org>; Fri,  6 Mar 2026 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772808961;
	bh=aVl5Zkfm845Up2tgXtaQ2s3MGIl6I7L20/OprGe/lPo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WGREv9GwfThV+pV2iYhUXMspe/zxG5mWI4JGmDVtozXtrPgwibteqvjv2I6MJ/S1F
	 XzhHmsU604WkQqgAeMg7ziOdqEKTAM7lClLj3w3G1TbKMAV8IH5bPProqTy9veg5Fm
	 jBEEfYUsILavm1Vr51lyHygPNpD7TaL1nbM4bqGAvEXcqqnjgsD9nSobAY+M2rUAS0
	 qjqrIUNx/imyIRSNErAqe0fN7Yfp7KTtgm22ZBbumQBzACA55rJgUwfObcWWLfQ8lT
	 BWurO46v7AA8iBWKbv1WXAz0+87d8TtbUWfxhHvbvTsrSPkntN/y/GE8ineqchZhaC
	 URS7VDRnmWO5g==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8d7f22d405so1375421966b.0
        for <fstests@vger.kernel.org>; Fri, 06 Mar 2026 06:56:01 -0800 (PST)
X-Gm-Message-State: AOJu0YztSw4BtA+kaEmXNpcawVfqrRKhOZw+7haZl6jJ1DOhaD6d3LVc
	0WD3AmPsGRPgvnYAJG+Xfd7gKnIVM36iz+h83/2YMCWtwsxG316N9HzHruknLlN3ZX96XNgHVmX
	RBpEFdr4JM6F5efVYQkbf14PQRuVtzsg=
X-Received: by 2002:a17:907:6e8a:b0:b88:716a:e4ae with SMTP id
 a640c23a62f3a-b942dfc9f67mr151533566b.61.1772808960280; Fri, 06 Mar 2026
 06:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1e2690efeb8570651894567d80511144424fb5e.1772106022.git.fdmanana@suse.com>
 <aarmPHmLnGtvhUcO@infradead.org>
In-Reply-To: <aarmPHmLnGtvhUcO@infradead.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 6 Mar 2026 14:55:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5r5_FuTSUM_5TqFGFPSZ4qC=qG49_JuLpUfzFCa=8YyQ@mail.gmail.com>
X-Gm-Features: AaiRm50HXeNGzp7FTrY-MoS_w-nAVvy1G-S0F27vExRZn5JtgIaSagVqKWJ-LRM
Message-ID: <CAL3q7H5r5_FuTSUM_5TqFGFPSZ4qC=qG49_JuLpUfzFCa=8YyQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test create a bunch of files with name hash collision
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 2:35=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Thu, Feb 26, 2026 at 02:34:37PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that if we create a high number of files with a name that results =
in
> > a hash collision, the filesystem is not turned to RO due to a transacti=
on
> > abort. This could be exploited by malicious users to disrupt a system.
>
> Umm, file systems must handle an unlimited number of name collisions.
> While going read-only is of course really bad, just rejecting them
> can also pretty easily break things.

I don't think in practice we get a large enough number of names with a
crc32c hash collision in btrfs.
Never heard yet of any users reporting problems with that.

The fix related to this test is more to prevent a bad intentioned user
from turning the fs into read-only mode (this is actually a regression
introduced a few years ago).

Adding support for an unlimited number of collisions is simply not
easily doable, it would require an on-disk format change (new key
type, item, etc, update btrfs-progs, etc).
The motivation for that is very low, as I'm not aware of users ever complai=
ning.

>
> Also it seems like part of this test is generic, and only the subvolume
> creation part is btrfs-specific?

Specifying a 4K leaf size at mkfs, all the comments, and verifying
that we can't create a file beyond the limit, are also btrfs specific.

>
