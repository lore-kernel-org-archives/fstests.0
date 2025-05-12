Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82419CC3A
	for <fstests@vger.kernel.org>; Mon, 12 May 2025 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063190; cv=none; b=Ll7eLGgVY1DwQkkdeqioq2dwOHJf62FVhpQrpSL/aJAFu5i5VaGZpJOfdhM5UCLdSSuoHTbwl8cO9R3EqjUDQFwglfcaP6tjFiukjvvmWBKSeP+9oKFmhrKx8FnevWF0ja8q1Y5GDB96oKH41/14IZ7GRUljYkCc9XQFh/+XbxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063190; c=relaxed/simple;
	bh=GPMd8e71xdQjFaTqcfwqVWlukI/TBmsThEl/vi+CtbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kj3F6Fz6JKzVv2NRnudSZ6X8mFnMzJwXZT3zpRwLmYQuGLqHZ20dcNTXXoEnGtqfNV+tdk9jMgvtJrn725g47z2VZosFzgaRQqRv/TO0ksixQLxadn9xjdk2/gSlajtGylschQcezdUfXsqoaygcCyh48Z6Ln7SMHCK1xZbDC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfDAsE7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfDAsE7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3253C4CEE7;
	Mon, 12 May 2025 15:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747063190;
	bh=GPMd8e71xdQjFaTqcfwqVWlukI/TBmsThEl/vi+CtbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YfDAsE7qzRYlzfks4cdLsZJeEJ41pXn5D2L/dm19Mq6GhbAko5CtwGEl04Y8/usrN
	 QPGbfhZkA0VmtEtdnybtp+DWEerWkjWwY57Vz7Lxp2u1MNqjORkdEk3q9MTTmpwo9t
	 EsbZHgPMWC0TxwFhA5orQrmyBxbEJ8U/C6XtBKE7bgwh9EIpezjAyf5RsET/U/2WVl
	 a6Si1pRAMeJIXcRj2paw2DUISt7+sSMB8w0R8UsRuLjwsGAUU+I4nT5cNfq77ClEw7
	 1e8YO0XTO6nV0B/AJ4vAQvM17AZYSzUJ5ITO0KKbxF9BwvhH+5ZswP4fwtkjL03R8B
	 hYe2/Nb6HQ8Lg==
Date: Mon, 12 May 2025 08:19:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	Zorro Lang <zlang@redhat.com>
Cc: Leah Rumancik <leah.rumancik@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] selftest: add a test that flakes
Message-ID: <20250512151949.GR25667@frogsfrogsfrogs>
References: <20250510004256.451058-1-leah.rumancik@gmail.com>
 <434c560c632558cdc32b45f2aef54c68ca6c0baa.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434c560c632558cdc32b45f2aef54c68ca6c0baa.camel@gmail.com>

On Mon, May 12, 2025 at 07:32:15PM +0530, Nirjhar Roy (IBM) wrote:
> On Fri, 2025-05-09 at 17:42 -0700, Leah Rumancik wrote:
> > Add selftest/007 which should fail about half of the time.
> 
> I have already posted something similar[1] a couple of months back. It got an approval didn't get
> picked up. 
> [1] https://lore.kernel.org/all/20250113164639.GG1251194@frogsfrogsfrogs/

Aha, I /was/ thinking "Gee , haven't I reviewed this before?"

Zorro: any plans to merge
https://lore.kernel.org/all/03ba6c154c9e2cf3d68131b3af2ca12b96663d25.1736496620.git.nirjhar.roy.lists@gmail.com/a ?

--D

> --NR
> > 
> > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > ---
> >  tests/selftest/007     | 14 ++++++++++++++
> >  tests/selftest/007.out |  3 +++
> >  2 files changed, 17 insertions(+)
> >  create mode 100755 tests/selftest/007
> >  create mode 100644 tests/selftest/007.out
> > 
> > diff --git a/tests/selftest/007 b/tests/selftest/007
> > new file mode 100755
> > index 00000000..0e983b37
> > --- /dev/null
> > +++ b/tests/selftest/007
> > @@ -0,0 +1,14 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 007
> > +#
> > +# A test that flakes due to occasional output mismatch
> > +#
> > +. ./common/preamble
> > +_begin_fstest selftest
> > +
> > +echo "I am intentionally flaky"
> > +echo $((RANDOM % 2))
> > +status=0
> > +exit
> > diff --git a/tests/selftest/007.out b/tests/selftest/007.out
> > new file mode 100644
> > index 00000000..0b5e439a
> > --- /dev/null
> > +++ b/tests/selftest/007.out
> > @@ -0,0 +1,3 @@
> > +QA output created by 007
> > +I am intentionally flaky
> > +0
> 
> 
